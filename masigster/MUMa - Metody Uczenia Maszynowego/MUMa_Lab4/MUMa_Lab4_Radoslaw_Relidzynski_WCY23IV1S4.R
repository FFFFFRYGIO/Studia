# Zimportowanie bibliotek
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

# Zaimportowanie zbioru danych z podaniem typów kolumn do zmiennej srodowiskowej "Wesbrook"
Wesbrook <- read_csv('http://jolej.linuxpl.info/Wesbrook.csv', col_types = "ifncfffffffffcffffinnnnnnnfnnnn")

# Wyswietlenie podgladu danych przechowywanych w obiekcie "Wesbrook"
glimpse(Wesbrook)

#################
# TRESC ZADANIA #
#################

# Dla 6 modeli przy ich wykorzystaniu zbudowac i sparametryzowac model klasyfikacyjny:
# 1. K-najblizszych sasiadow
# 2. Naiwnego klasyfikatora Bayesa
# 3. Drzew klasyfikacyjnych
# 4. Lasow Losowych (Random Forest)
# 5. Algorytmu XGBoost
# 6. Metody SVM

# Dla kazdego z modeli wykonac ewaluacje z wykorzystaniem:
# - macierzy pomylek
# - krzywej ROC
# - wspolczynnika AUC

# Dla kazdego z modeli wykonac walidacje krzyzowa k-krotna oraz losowa

# Sformuowac wnioski

########################
# Przygotowanie danych #
########################

# Sprawdzenie ile jest brakujacych wartosci
print(sort(colSums(is.na(Wesbrook)), decreasing = TRUE))
rows_with_na <- Wesbrook[rowSums(is.na(Wesbrook)) > 0, ]
print(rows_with_na)
print(nrow(rows_with_na))

# Usuniecie kolumny DEPT1 - to powielenie kolumny FACULTY1
Wesbrook <- Wesbrook %>% select(-DEPT1)

# Usuniecie kolumny INDUPDT - zbedna dana
Wesbrook <- Wesbrook %>% select(-INDUPDT)

# Usuniecie kolumny EA - zbedna dana
Wesbrook <- Wesbrook %>% select(-EA)

# Usuniecie kolumny BIGBLOCK - nikt nie wzial udzialu w tym programie
Wesbrook <- Wesbrook %>% select(-BIGBLOCK)

# Usuniecie rekordow, ktore maja GRADYR1 jako NA
Wesbrook <- Wesbrook %>%
  filter(!is.na(GRADYR1))

# Sprawdzenie wartosci dla kolumny MARITAL wraz z brakujacymi wartosciami
print(table(Wesbrook$MARITAL, useNA = "ifany"))

# Dla braku statusu malzenskiego przypisac wartosc "S"
Wesbrook$MARITAL[is.na(Wesbrook$MARITAL)] <- "S"

# Dla braku kodu przedmiotu MAJOR1 przypisac wartosc "TBS" - to be specified
Wesbrook$MAJOR1 <- factor(Wesbrook$MAJOR1, levels = c(levels(Wesbrook$MAJOR1), "TBS"))
Wesbrook$MAJOR1[is.na(Wesbrook$MAJOR1)] <- "TBS"

# Ustawienie brakujacych wartosci sredniego dochodu AVE_INC jako srednia ze wszystkich wartosci
Wesbrook$AVE_INC[is.na(Wesbrook$AVE_INC)] <- mean(Wesbrook$AVE_INC, na.rm = TRUE)

# Ustawienie brakujacych wartosci odchylenia standardowego SD_INC jako srednia ze wszystkich wartosci
Wesbrook$SD_INC[is.na(Wesbrook$SD_INC)] <- mean(Wesbrook$SD_INC, na.rm = TRUE)

# Usuniecie pozostalych rekordow z brakujacymi wartosciami
Wesbrook <- Wesbrook %>% drop_na()

# Ponowsne sprawdzenie ile jest brakujacych wartosci
print(sort(colSums(is.na(Wesbrook)), decreasing = TRUE))
rows_with_na <- Wesbrook[rowSums(is.na(Wesbrook)) > 0, ]
print(rows_with_na)
print(nrow(rows_with_na))

# Zapisanie kopii zbioru dla jego przywracania
Wesbrook_backup <- Wesbrook

##################################
# 1. K-najblizszych sasiadow     #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu modelu
rm(list = setdiff(ls(), "Wesbrook_backup"))

# Przywrocenie zbioru z kopii
Wesbrook <- Wesbrook_backup

### Normalizacja zmiennych numerycznych

# Funkcja normalizujaca metoda min - max
normalize <- function(x) {
  if (min(x) == max(x)) {
    return(rep(0, length(x)))
  } else {
    return((x - min(x)) / (max(x) - min(x)))
  }
}

# Zastosowanie funkcji normalizujacej dla kazdej zmiennej numerycznej
Wesbrook <- Wesbrook %>%
  mutate(across(where(is.numeric), normalize))

### Kodowanie zero jedynkowe zmiennych typu factor

# Zmiana obiektu z tibble na data.frame
Wesbrook <- data.frame(Wesbrook)

# Wydzielenie ze zbioru zmiennej objasnianej
Wesbrook_labels <- Wesbrook %>% select(WESBROOK)
Wesbrook <- Wesbrook %>% select(-WESBROOK)

# Podglad etykiet zmiennych
colnames(Wesbrook)

# Utworzenie ramki danych
Wesbrook<-as.data.frame(Wesbrook)

# Utworzenie zmiennych sztucznych dla zmiennych czynnikowych
factor_columns <- names(Wesbrook)[sapply(Wesbrook, is.factor)]
Wesbrook <- dummy.data.frame(data = Wesbrook, factor_columns, sep = "_")

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(Wesbrook), round(nrow(Wesbrook) * .75), replace = FALSE)
wesbrook_train <- Wesbrook[sample_index,]
wesbrook_test <- Wesbrook[-sample_index,]

# Powt?rzenie operacji dla zmiennej objasnianej heartDisease
wesbrook_train_labels <- as.factor(Wesbrook_labels[sample_index,])
wesbrook_test_labels <- as.factor(Wesbrook_labels[-sample_index,])

# Wymuszenie takich samych poziomów dla obu zbiorów etykiet
# Dla zmiennej numerycznej objasniajacej poziomy moga sie roznic przez rozne
# kombinacje w kategoriach, brakujace w zbiorze testowym lub rozny ich porzadek 
# levels(wesbrook_test_labels) <- levels(wesbrook_train_labels)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Deklaracja wartosci k
k <- 15

### Budowa modelu KNN za pomoca funkcji knn() z pakietu class
wesbrook_pred1 <-
  knn(
    train = wesbrook_train,
    test = wesbrook_test,
    cl = wesbrook_train_labels,
    k = k
  )

# Podejrzenie pierwszych 6 elementów modelu
head(wesbrook_pred1)

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wesbrook_pred1, wesbrook_test_labels)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Trening modelu KNN
knn_model <- train(
  x = wesbrook_train, 
  y = wesbrook_train_labels, 
  method = "knn", 
  trControl = trainControl(method = "cv", number = 10),
  tuneGrid = expand.grid(k = k)  # Określenie wartości k
)

wesbrook_pred_p <- predict(knn_model, wesbrook_test, type = "prob")

roc_pred <-
  prediction(
    predictions = wesbrook_pred_p[, "Y"],
    labels = wesbrook_test_labels
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Obliczanie pola pod krzywa ROC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wesbrook_auc <- unlist(slot(auc_perf,"y.values"))
wesbrook_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
knn_cv <- train(
  x = wesbrook_train, 
  y = wesbrook_train_labels, 
  method = "knn", 
  trControl = trainControl(method = "cv", number = 10)
)
print(knn_cv)

### Walidacja krzyzowa losowa
knn_boot <- train(
  x = wesbrook_train, 
  y = wesbrook_train_labels, 
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
rm(list = setdiff(ls(), "Wesbrook_backup"))

# Przywrocenie zbioru z kopii
Wesbrook <- Wesbrook_backup

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(Wesbrook), round(nrow(Wesbrook) * .75), replace = FALSE)
wesbrook_train <- Wesbrook[sample_index,]
wesbrook_test <- Wesbrook[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(Wesbrook, WESBROOK))),2)
round(prop.table(table(select(wesbrook_train, WESBROOK))),2)
round(prop.table(table(select(wesbrook_test, WESBROOK))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

### Budowa modelu za pomoca funkcji naiveBayes() z pakietu e1071
wesbrook_mod <- naiveBayes(WESBROOK ~ ., data = wesbrook_train, laplace = 1)
wesbrook_mod

# Podstawienie danych testowych do modelu

wesbrook_pred <- predict(wesbrook_mod, wesbrook_test, type = "class")
head(wesbrook_pred)

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wesbrook_pred, wesbrook_test$WESBROOK)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

wesbrook_pred_p <- predict(wesbrook_mod, wesbrook_test, type = "raw")

roc_pred <-
  prediction(
    predictions = wesbrook_pred_p[, "Y"],
    labels = wesbrook_test$WESBROOK
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wesbrook_auc <- unlist(slot(auc_perf,"y.values"))
wesbrook_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
train_control <- trainControl(method = "cv", number = 10)
wesbrook_cv <- train(WESBROOK ~ ., data = Wesbrook, method = "naive_bayes", trControl = train_control)
print(wesbrook_cv)

### Walidacja krzyzowa losowa
n_iterations <- 10
results <- vector("list", n_iterations)

for (i in 1:n_iterations) {
  # Losowy podział danych na zbiór treningowy i testowy
  train_index <- createDataPartition(Wesbrook$WESBROOK, p = 0.75, list = FALSE)
  wesbrook_train <- Wesbrook[train_index,]
  wesbrook_test <- Wesbrook[-train_index,]
  
  # Budowa modelu
  wesbrook_mod <- naiveBayes(WESBROOK ~ ., data = wesbrook_train, laplace = 1)
  
  # Predykcja
  wesbrook_pred <- predict(wesbrook_mod, wesbrook_test, type = "class")
  
  # Obliczenie macierzy pomyłek
  cm <- confusionMatrix(wesbrook_pred, wesbrook_test$WESBROOK)
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
rm(list = setdiff(ls(), "Wesbrook_backup"))

# Przywrocenie zbioru z kopii
Wesbrook <- Wesbrook_backup

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(Wesbrook), round(nrow(Wesbrook) * .75), replace = FALSE)
wesbrook_train <- Wesbrook[sample_index,]
wesbrook_test <- Wesbrook[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(Wesbrook, WESBROOK))),2)
round(prop.table(table(select(wesbrook_train, WESBROOK))),2)
round(prop.table(table(select(wesbrook_test, WESBROOK))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Budowa modelu za pomoca funkcji rpart() z pakietu rpart ze wspolczynnikiem cp=0.02
wesbrook_mod <-
  rpart(
    WESBROOK ~ .,
    method = "class",
    data = wesbrook_train,
    cp = 0.02
  )

# Wygenerowanie wykresu drzewa
rpart.plot(wesbrook_mod)

# Wygenerowanie wykresu bledu w zaleznosci od wspolczynnika cp
plotcp(wesbrook_mod)

# Podstawienie do modelu wartosci ze zbioru testowego
wesbrook_pred <- predict(wesbrook_mod, wesbrook_test, type = "class")

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wesbrook_pred, wesbrook_test$WESBROOK)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Predykcja wartosci prawdopodobienstw
wesbrook_pred_p <- predict(wesbrook_mod, wesbrook_test, type = "prob")
head(wesbrook_pred_p)

roc_pred <-
  prediction(
    predictions = wesbrook_pred_p[, "Y"],
    labels = wesbrook_test$WESBROOK
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wesbrook_auc <- unlist(slot(auc_perf,"y.values"))
wesbrook_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
cv_model <- train(
  WESBROOK ~ ., 
  data = Wesbrook, 
  method = "rpart", 
  trControl = trainControl(method = "cv", number = 10)
)
print(cv_model)

### Walidacja krzyzowa losowa
random_cv_model <- train(
  WESBROOK ~ ., 
  data = Wesbrook, 
  method = "rpart", 
  trControl = trainControl(method = "boot", number = 100)  # 100 iteracji bootstrappingu
)
print(random_cv_model)

##################################
# 4. Lasy Losowe (Random Forest) #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu nastepnego modelu
rm(list = setdiff(ls(), "Wesbrook_backup"))

# Przywrocenie zbioru z kopii
Wesbrook <- Wesbrook_backup

# Usuniecie kolumn GRADYR1 oraz MAJOR1 - posiadaja za duzo kategorii
Wesbrook <- Wesbrook %>% select(-GRADYR1)
Wesbrook <- Wesbrook %>% select(-MAJOR1)

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(Wesbrook), round(nrow(Wesbrook) * .75), replace = FALSE)
wesbrook_train <- Wesbrook[sample_index,]
wesbrook_test <- Wesbrook[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(Wesbrook, WESBROOK))),2)
round(prop.table(table(select(wesbrook_train, WESBROOK))),2)
round(prop.table(table(select(wesbrook_test, WESBROOK))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Budowa modelu za pomoca funkcji randomForest() z pakietu randomForest
wesbrook_mod <- randomForest(WESBROOK ~ ., data = wesbrook_train, ntrees=100)

wesbrook_pred <- predict(wesbrook_mod, wesbrook_test, type = "class")

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wesbrook_pred, wesbrook_test$WESBROOK)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Predykcja wartosci prawdopodobienstw
wesbrook_pred_p <- predict(wesbrook_mod, wesbrook_test, type = "prob")
head(wesbrook_pred_p)

roc_pred <-
  prediction(
    predictions = wesbrook_pred_p[, "Y"],
    labels = wesbrook_test$WESBROOK
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wesbrook_auc <- unlist(slot(auc_perf,"y.values"))
wesbrook_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
train_control <- trainControl(method = "cv", number = 5)
wesbrook_cv <- train(WESBROOK ~ ., data = Wesbrook, method = "rf", trControl = train_control)
print(wesbrook_cv)


### Walidacja krzyzowa losowa
train_control_random <- trainControl(method = "boot", number = 50)
wesbrook_random_cv <- train(WESBROOK ~ ., data = Wesbrook, method = "rf", trControl = train_control_random)
print(wesbrook_random_cv)

##################################
# 5. Algorytm XGBoost            #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu nastepnego modelu
rm(list = setdiff(ls(), "Wesbrook_backup"))

# Przywrocenie zbioru z kopii
Wesbrook <- Wesbrook_backup

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(Wesbrook), round(nrow(Wesbrook) * .75), replace = FALSE)
wesbrook_train <- Wesbrook[sample_index,]
wesbrook_test <- Wesbrook[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(Wesbrook, WESBROOK))),2)
round(prop.table(table(select(wesbrook_train, WESBROOK))),2)
round(prop.table(table(select(wesbrook_test, WESBROOK))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Budowa modelu za pomoca funkcji randomForest() z pakietu randomForest

modelLookup("xgbTree")

wesbrook_mod <- train(
  WESBROOK ~ .,
  data = wesbrook_train,
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

wesbrook_pred <- predict(wesbrook_mod, wesbrook_test, type = "raw")

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wesbrook_pred, wesbrook_test$WESBROOK)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Predykcja wartosci prawdopodobienstw
wesbrook_pred_p <- predict(wesbrook_mod, wesbrook_test, type = "prob")
head(wesbrook_pred_p)

roc_pred <-
  prediction(
    predictions = wesbrook_pred_p[, "Y"],
    labels = wesbrook_test$WESBROOK
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wesbrook_auc <- unlist(slot(auc_perf,"y.values"))
wesbrook_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
cv_control <- trainControl(method = "cv", number = 10)
wesbrook_mod_cv <- train(
  WESBROOK ~ .,
  data = wesbrook_train,
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
print(wesbrook_mod_cv)

### Walidacja krzyzowa losowa
random_control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
wesbrook_mod_random <- train(
  WESBROOK ~ .,
  data = wesbrook_train,
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
print(wesbrook_mod_random)

##################################
# 6. Metoda SVM                  #
##################################

# -------------------- #
# Przygotowanie danych #
# -------------------- #

# Usuniecie obiektow dla czystego startu nastepnego modelu
rm(list = setdiff(ls(), "Wesbrook_backup"))

# Przywrocenie zbioru z kopii
Wesbrook <- Wesbrook_backup

###  Podzial zbioru na treningowy i testowy w proporcjach 75% do 25%

set.seed(1234)
sample_index <-
  sample(nrow(Wesbrook), round(nrow(Wesbrook) * .75), replace = FALSE)
wesbrook_train <- Wesbrook[sample_index,]
wesbrook_test <- Wesbrook[-sample_index,]

# Sprawdzenie proporcji klas dla wszystkich trzech zbiorow
round(prop.table(table(select(Wesbrook, WESBROOK))),2)
round(prop.table(table(select(wesbrook_train, WESBROOK))),2)
round(prop.table(table(select(wesbrook_test, WESBROOK))),2)

# ---------------- #
# Tworzenie modelu #
# ---------------- #

# Budowa modelu za pomoca funkcji randomForest() z pakietu randomForest
wesbrook_mod <- svm(WESBROOK ~ ., data = wesbrook_train, probability=TRUE)
print(wesbrook_mod)

wesbrook_pred <- predict(wesbrook_mod, wesbrook_test, type = "class")

# ---------------- #
# Ewaluacja modelu #
# ---------------- #

### 1. Ewaluacja z wykorzystaniem macierzy pomylek
confusionMatrix(wesbrook_pred, wesbrook_test$WESBROOK)

### 2. Ewaluacja z wykorzystaniem krzywej ROC

# Predykcja wartosci , wazne aby ustawic parametry : 
# decision.values = TRUE, probability = TRUE
wesbrook_pred <- predict(wesbrook_mod, wesbrook_test, decision.values = TRUE, probability = TRUE)

# Wyodrebnianie prawdopodobienstw
attr(wesbrook_pred, "probabilities")[1:4,]

wesbrook_pred_p <- attr(wesbrook_pred, "probabilities")

roc_pred <-
  prediction(
    predictions = wesbrook_pred_p[, "Y"],
    labels = wesbrook_test$WESBROOK
  )

roc_perf <- performance(roc_pred, measure = "tpr", x.measure = "fpr")

plot(roc_perf, main = "ROC Curve", col = "red", lwd = 3)
abline(a = 0, b = 1, lwd = 3, lty = 2, col = 1)

### 3. Ewaluacja z wykorzystaniem wspolczynnika AUC

# Wygenerowanie obiektu wydajnosci z parametrem measure = "auc"
auc_perf <- performance(roc_pred, measure = "auc")

# Wydobycie wartosci y.values ze slotu z obiektu auc_perf
wesbrook_auc <- unlist(slot(auc_perf,"y.values"))
wesbrook_auc

# ---------------- #
# Walidacja modelu #
# ---------------- #

### Walidacja krzyzowa k-krotna
ctrl <- trainControl(method = "cv", number = 10)
wesbrook_cv_mod <- train(WESBROOK ~ ., data = wesbrook_train, method = "svmRadial", trControl = ctrl, probability = TRUE)
print(wesbrook_cv_mod)

### Walidacja krzyzowa losowa
ctrl_random <- trainControl(method = "LGOCV", number = 10)
wesbrook_random_mod <- train(WESBROOK ~ ., data = wesbrook_train, method = "svmRadial", trControl = ctrl_random, probability = TRUE)
print(wesbrook_random_mod)

###########
# WNIOSKI #
###########

### 1. K-najblizszych sąsiadów

# Dokładność (macierz pomylek): 70%
# Krzywwa ROC:
# - Powyżej linii losowości - zdolnośc klasyfikowania lepsza niż losowa
# - Brak pełnego wygięcia do górnego lewego rogu - model nie jest idealny
# Dokładność (walidacja k-krotna): 74%
# Dokładność (walidacja losowa): 72%

# Podsumowanie: model ma umiarkowaną skuteczność


### 2. Naiwny klasyfikator Bayesa

# Dokładność (macierz pomylek): 83%
# Krzywwa ROC:
# - Powyżej linii losowości - zdolnośc klasyfikowania lepsza niż losowa
# - Mocniejsze wygięcie do górnego lewego rogu - model nie jest idealny, ale jest dość dobry
# Dokładność (walidacja k-krotna): 55%
# Dokładność (walidacja losowa): 87%

# Podsumowanie: odel ma umiarkowanie dobrą skuteczność, walidacja k-krotna była zbyt krótka


### 3. Drzew klasyfikacyjnych

# Dokładność (macierz pomylek): 94%
# Krzywwa ROC:
# - Powyżej linii losowości - zdolnośc klasyfikowania lepsza niż losowa
# - Bardzo ostre wygięcie do górnego lewego rogo - bardzo dobry model
# Dokładność (walidacja k-krotna): 94%
# Dokładność (walidacja losowa): 94%

# Podsumowanie: model jest bardzo dobry, osiaga duza skutecznosc odpowiedzi


### 4. Lasow Losowych (Random Forest)

# Dokładność (macierz pomylek): 94%
# Krzywwa ROC:
# - Powyżej linii losowości - zdolnośc klasyfikowania lepsza niż losowa
# - Bardzo ostre wygięcie do górnego lewego rogo - dobry model
# Dokładność (walidacja k-krotna): 92%
# Dokładność (walidacja losowa): 93%

# Podsumowanie: model jest bardzo dobry, osiaga duza skutecznosc odpowiedzi


### 5. Algorytmu XGBoost

# Dokładność (macierz pomylek): 94%
# Krzywwa ROC:
# - Powyżej linii losowości - zdolnośc klasyfikowania lepsza niż losowa
# - Bardzo ostre wygięcie do górnego lewego rogo - dobry model
# Dokładność (walidacja k-krotna): 94%
# Dokładność (walidacja losowa): 94%

# Podsumowanie: model jest bardzo dobry, osiaga duza skutecznosc odpowiedzi


### 6. Metody SVM

# Dokładność (macierz pomylek): 79%
# Krzywwa ROC:
# - Powyżej linii losowości - zdolnośc klasyfikowania lepsza niż losowa
# - Brak pełnego wygięcia do górnego lewego rogu - model jest umiarkowanie dobry
# Dokładność (walidacja k-krotna): 70%
# Dokładność (walidacja losowa): 70%

# Podsumowanie: model jest umiarkowanie dobry


### Podsumowanie ćwiczenia

# W ramach ćwiczenia udało się stworzyć 6 różnych modeli klasyfikacyjnych.
# Modele K-najbliższych sąsiadów (KNN) oraz Metody SVN osiągnęły mniejszą
# skuteczność niż pozostałe, ponieważ KNN sprawdza się lepiej dla małych
# zbiorów danych, a SVN dla dobrze zbalansowanych. Modele Random Forest oraz
# XGBoost mają lepszą zdolność generalizacji oraz odporność na problem
# niezbalansowanych danych.Naiwny klasyfikator Bayesa miał przeciętną skuteczność
# w porównaniu z pozostałymi modelami, wynika to tego, że jest to prosty model z
# prostymi założeniami. Drzewa klasyfikacyjne mają bardzo precyzyjny wzrost
# skuteczności oraz również osiągnął dużą skuteczność.

# Do analizy modeli wykorzystano skuteczne narzędzia statystyczne takie jak wykres
# krzywej ROC, współczynnik AUC oraz macierz pomyłek. Pozwoliły one na precyzyjną
# ewaluację modeli. Dodatkowo udało się skutecznie przeprowadzić walidację krzyżową
# k-krotną oraz losową, których wyniki potwierdziły poprawność ewaluacji modelu.

