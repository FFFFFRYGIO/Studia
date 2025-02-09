# Załadowanie bibliotek
library(tidyverse)
# - KNN
library(class)
library(caret)
# - Bayes
library(ROCR)
library(e1071)
# - Drzewa klasyfikacyjne
library(rpart)
library(rpart.plot)
library(tree)
# - Drzewa losowe
library(randomForest)
# - XGBoost
library(xgboost)
# - SVM

# Zaladowanie pakietu dummies
library(dummies)

# Define the URL and download the zip file
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"
red_file <- "winequality-red.csv"
white_file <- "winequality-white.csv"

# Download the files
download.file(url, red_file)
download.file(gsub("red", "white", url), white_file)

# Pobranie zbioru z dodaniem informacji o kolorze wina
wine_red <- read_delim('wine+quality/winequality-red.csv', delim = ';') %>%
 mutate(is_red = 1)
wine_white <- read_delim('wine+quality/winequality-white.csv', delim = ';') %>%
 mutate(is_red = 0)

# Połączenie zbiorów wzdłuż wierszy
wine <- bind_rows(wine_red, wine_white)

# Zmiana nazw kolumn, zastąpienie spacji znakiem "_"
colnames(wine) <- gsub(" ", "_", colnames(wine))

# Zamiana wartości numerycznej factor
wine$quality <- factor(ifelse(wine$quality > 5, 'good', 'bad'))

# Sprawdzenie struktury danych
glimpse(wine)

# Podejrzenie początku danych
head(wine)

# Zapisanie kopii zbioru dla jego przywracania
wine_backup <- wine


##################################
# 1. K-najblizszych sasiadow     #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu modelu
rm(list = setdiff(ls(), "wine_backup"))

# Przywrocenie zbioru z kopii
wine <- wine_backup

### Normalizacja zmiennych numerycznych

# Funkcja normalizujaca metoda min - max
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}


# Zastosowanie funkcji normalizujacej dla kazdej zmiennej numerycznej
wine <- wine %>%
  mutate(across(where(is.numeric), normalize))

### Kodowanie zero jedynkowe zmiennych typu factor

# Zmiana obiektu z tibble na data.frame
wine <- data.frame(wine)

# Wydzielenie ze zbioru zmiennej objasnianej
wine_labels <- wine %>% select(quality)
wine <- wine %>% select(-quality)

# Podglad etykiet zmiennych
colnames(wine)

# Utworzenie ramki danych
wine <- as.data.frame(wine)

# Utworzenie zmiennych sztucznych dla zmiennych czynnikowych
factor_columns <- names(wine)[sapply(wine, is.factor)]
wine <- dummy.data.frame(data = wine, factor_columns, sep = "_")

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(wine), round(nrow(wine) * .75), replace = FALSE)
wine_train <- wine[sample_index,]
wine_test <- wine[-sample_index,]

# Powtorzenie operacji dla zmiennej objasnianej heartDisease
wine_train_labels <- as.factor(wine_labels[sample_index,])
wine_test_labels <- as.factor(wine_labels[-sample_index,])

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Deklaracja wartosci k
k <- 15

### Budowa modelu KNN za pomoca funkcji knn() z pakietu class
wine_pred <-
  knn(
    train = wine_train,
    test = wine_test,
    cl = wine_train_labels,
    k = k
  )

# Podejrzenie pierwszych 6 elementów modelu
head(wine_pred)

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wine_pred, wine_test_labels)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Trening modelu KNN
knn_model <- train(
  x = wine_train, 
  y = wine_train_labels, 
  method = "knn", 
  trControl = trainControl(method = "cv", number = 10),
  tuneGrid = expand.grid(k = k)  # Określenie wartości k
)

wine_pred_p <- predict(knn_model, wine_test, type = "prob")

roc_pred <-
  prediction(
    predictions = wine_pred_p[, 2],
    labels = wine_test_labels
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Obliczanie pola pod krzywa ROC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wine_auc <- unlist(slot(auc_perf,"y.values"))
wine_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
knn_cv <- train(
  x = wine_train, 
  y = wine_train_labels, 
  method = "knn", 
  trControl = trainControl(method = "cv", number = 10)
)
print(knn_cv)

### Walidacja krzyzowa losowa
knn_boot <- train(
  x = wine_train, 
  y = wine_train_labels, 
  method = "knn", 
  trControl = trainControl(method = "boot", number = 100)
)
print(knn_boot)


##################################
# 2. Naiwny klasyfikator Bayesa  #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu modelu
rm(list = setdiff(ls(), "wine_backup"))

# Przywrocenie zbioru z kopii
wine <- wine_backup

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(wine), round(nrow(wine) * .75), replace = FALSE)
wine_train <- wine[sample_index,]
wine_test <- wine[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(wine, quality))),2)
round(prop.table(table(select(wine_train, quality))),2)
round(prop.table(table(select(wine_test, quality))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

### Budowa modelu za pomoca funkcji naiveBayes() z pakietu e1071
wine_mod <- naiveBayes(quality ~ ., data = wine_train, laplace = 1)
wine_mod

# Podstawienie danych testowych do modelu

wine_pred <- predict(wine_mod, wine_test, type = "class")
head(wine_pred)

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wine_pred, wine_test$quality)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

wine_pred_p <- predict(wine_mod, wine_test, type = "raw")

roc_pred <-
  prediction(
    predictions = wine_pred_p[, "good"],
    labels = wine_test$quality
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wine_auc <- unlist(slot(auc_perf,"y.values"))
wine_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
train_control <- trainControl(method = "cv", number = 10)
wine_cv <- train(factor(quality) ~ ., data = wine, method = "naive_bayes", trControl = train_control)
print(wine_cv)

### Walidacja krzyzowa losowa
n_iterations <- 10
results <- vector("list", n_iterations)

for (i in 1:n_iterations) {
  # Losowy podział danych na zbiór treningowy i testowy
  train_index <- createDataPartition(wine$quality, p = 0.75, list = FALSE)
  wine_train <- wine[train_index,]
  wine_test <- wine[-train_index,]
  
  # Budowa modelu
  wine_mod <- naiveBayes(quality ~ ., data = wine_train, laplace = 1)
  
  # Predykcja
  wine_pred <- predict(wine_mod, wine_test, type = "class")
  
  # Obliczenie macierzy pomyłek
  cm <- confusionMatrix(wine_pred, wine_test$quality)
  results[[i]] <- cm$overall["Accuracy"]
}

# Średnia dokładność po 10 iteracjach
mean_accuracy <- mean(unlist(results))
print(mean_accuracy)


##################################
# 3. Drzewa klasyfikacyjne       #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu nastepnego modelu
rm(list = setdiff(ls(), "wine_backup"))

# Przywrocenie zbioru z kopii
wine <- wine_backup

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(wine), round(nrow(wine) * .75), replace = FALSE)
wine_train <- wine[sample_index,]
wine_test <- wine[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(wine, quality))),2)
round(prop.table(table(select(wine_train, quality))),2)
round(prop.table(table(select(wine_test, quality))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Budowa modelu za pomoca funkcji rpart() z pakietu rpart ze wspolczynnikiem cp=0.02
wine_mod <-
  rpart(
    quality ~ .,
    method = "class",
    data = wine_train,
    cp = 0.02
  )

# Wygenerowanie wykresu drzewa
rpart.plot(wine_mod)

# Wygenerowanie wykresu bledu w zaleznosci od wspolczynnika cp
plotcp(wine_mod)

# Podstawienie do modelu wartosci ze zbioru testowego
wine_pred <- predict(wine_mod, wine_test, type = "class")

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wine_pred, wine_test$quality)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Predykcja wartosci prawdopodobienstw
wine_pred_p <- predict(wine_mod, wine_test, type = "prob")
head(wine_pred_p)

roc_pred <-
  prediction(
    predictions = wine_pred_p[, "good"],
    labels = wine_test$quality
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wine_auc <- unlist(slot(auc_perf,"y.values"))
wine_auc


##################################
# 4. Lasy Losowe (Random Forest) #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu nastepnego modelu
rm(list = setdiff(ls(), "wine_backup"))

# Przywrocenie zbioru z kopii
wine <- wine_backup

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(wine), round(nrow(wine) * .75), replace = FALSE)
wine_train <- wine[sample_index,]
wine_test <- wine[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(wine, quality))),2)
round(prop.table(table(select(wine_train, quality))),2)
round(prop.table(table(select(wine_test, quality))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Budowa modelu za pomoca funkcji randomForest() z pakietu randomForest
wine_mod <- randomForest(quality ~ ., data = wine_train, ntrees=100)

wine_pred <- predict(wine_mod, wine_test, type = "class")

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wine_pred, wine_test$quality)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Predykcja wartosci prawdopodobienstw
wine_pred_p <- predict(wine_mod, wine_test, type = "prob")
head(wine_pred_p)

roc_pred <-
  prediction(
    predictions = wine_pred_p[, "good"],
    labels = wine_test$quality
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wine_auc <- unlist(slot(auc_perf, "y.values"))
wine_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
train_control <- trainControl(method = "cv", number = 5)
wine_cv <- train(quality ~ ., data = wine, method = "rf", trControl = train_control)
print(wine_cv)


### Walidacja krzyzowa losowa
train_control_random <- trainControl(method = "boot", number = 50)
wine_random_cv <- train(quality ~ ., data = wine, method = "rf", trControl = train_control_random)
print(wine_random_cv)


##################################
# 5. Algorytm XGBoost            #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu nastepnego modelu
rm(list = setdiff(ls(), "wine_backup"))

# Przywrocenie zbioru z kopii
wine <- wine_backup

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(wine), round(nrow(wine) * .75), replace = FALSE)
wine_train <- wine[sample_index,]
wine_test <- wine[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(wine, quality))),2)
round(prop.table(table(select(wine_train, quality))),2)
round(prop.table(table(select(wine_test, quality))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Budowa modelu za pomoca funkcji randomForest() z pakietu randomForest

modelLookup("xgbTree")

wine_mod <- train(
  quality ~ .,
  data = wine_train,
  metric = "Accuracy",
  method = "xgbTree",
  trControl = trainControl(method = "none"),
  tuneGrid = expand.grid(
    nrounds = 100,
    max_depth = 6,
    eta = 0.3,
    gamma = 0.01,
    colsample_bytree = 1,
    min_child_weight = 1,
    subsample = 1
  )
)

wine_pred <- predict(wine_mod, wine_test, type = "raw")

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wine_pred, wine_test$quality)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Predykcja wartosci prawdopodobienstw
wine_pred_p <- predict(wine_mod, wine_test, type = "prob")
head(wine_pred_p)

roc_pred <-
  prediction(
    predictions = wine_pred_p[, "good"],
    labels = wine_test$quality
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wine_auc <- unlist(slot(auc_perf,"y.values"))
wine_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
cv_control <- trainControl(method = "cv", number = 10)
wine_mod_cv <- train(
  quality ~ .,
  data = wine_train,
  method = "xgbTree",
  metric = "Accuracy",
  trControl = cv_control,
  tuneGrid = expand.grid(
    nrounds = 100,
    max_depth = 6,
    eta = 0.3,
    gamma = 0.01,
    colsample_bytree = 1,
    min_child_weight = 1,
    subsample = 1
  )
)
print(wine_mod_cv)

### Walidacja krzyzowa losowa
random_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
wine_mod_random <- train(
  quality ~ .,
  data = wine_train,
  method = "xgbTree",
  metric = "Accuracy",
  trControl = random_control,
  tuneGrid = expand.grid(
    nrounds = 100,
    max_depth = 6,
    eta = 0.3,
    gamma = 0.01,
    colsample_bytree = 1,
    min_child_weight = 1,
    subsample = 1
  )
)
print(wine_mod_random)


##################################
# 6. Metoda SVM                  #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu nastepnego modelu
rm(list = setdiff(ls(), "wine_backup"))

# Przywrocenie zbioru z kopii
wine <- wine_backup

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(wine), round(nrow(wine) * .75), replace = FALSE)
wine_train <- wine[sample_index,]
wine_test <- wine[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(wine, quality))),2)
round(prop.table(table(select(wine_train, quality))),2)
round(prop.table(table(select(wine_test, quality))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Budowa modelu za pomoca funkcji randomForest() z pakietu randomForest
wine_mod <- svm(quality ~ ., data = wine_train, probability=TRUE)
print(wine_mod)

wine_pred <- predict(wine_mod, wine_test, type = "class")

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wine_pred, wine_test$quality)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Predykcja wartosci , wazne aby ustawic parametry : 
# decision.values = TRUE, probability = TRUE
wine_pred <- predict(wine_mod, wine_test, decision.values = TRUE, probability = TRUE)

# Wyodrebnianie prawdopodobienstw
attr(wine_pred, "probabilities")[1:4,]

wine_pred_p <- attr(wine_pred, "probabilities")

roc_pred <-
  prediction(
    predictions = wine_pred_p[, "good"],
    labels = wine_test$quality
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wine_auc <- unlist(slot(auc_perf,"y.values"))
wine_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
ctrl <- trainControl(method = "cv", number = 10)
wine_cv_mod <- train(quality ~ ., data = wine_train, method = "svmRadial", trControl = ctrl, probability = TRUE)
print(wine_cv_mod)

### Walidacja krzyzowa losowa
ctrl_random <- trainControl(method = "LGOCV", number = 10)
wine_random_mod <- train(quality ~ ., data = wine_train, method = "svmRadial", trControl = ctrl_random, probability = TRUE)
print(wine_random_mod)
