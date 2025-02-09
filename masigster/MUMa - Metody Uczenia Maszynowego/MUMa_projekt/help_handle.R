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
wine_cv <- train(qualiy ~ ., data = wine, method = "rf", trControl = train_control)
print(wine_cv)


### Walidacja krzyzowa losowa
train_control_random <- trainControl(method = "boot", number = 50)
wine_random_cv <- train(quality ~ ., data = wine, method = "rf", trControl = train_control_random)
print(wine_random_cv)





























install.packages("ROCR")
install.packages("xgboost")

install.packages("dummies")

# Sprawdzenie danych na obecność NaN/NA
summary(wine)
 
# Identyfikacja kolumn z NaN/Inf
apply(wine, 2, function(x) any(is.na(x) | is.nan(x) | is.infinite(x)))

# Sprawdzenie ile jest brakujacych wartosci
print(sort(colSums(is.na(wine)), decreasing = TRUE))
rows_with_na <- wine[rowSums(is.na(wine)) > 0, ]
print(rows_with_na)
print(nrow(rows_with_na))

nrow(wine_train)
length(wine_train_labels)

levels(wine_test_labels)
levels(wine_train_labels)

levels(wine_test_labels) == levels(wine_train_labels)

levels(wine_pred)

any(wine == 0)

columns_with_zeros <- sapply(wine, function(col) any(col == 0))
names(columns_with_zeros[columns_with_zeros])



any(Wesbrook == 0)

columns_with_zeros <- sapply(Wesbrook, function(col) any(col == 0))
names(columns_with_zeros[columns_with_zeros])

levels(wine_test_labels) <- levels(wine_train_labels)


students_train_labels <- factor(students_train_labels, levels = c("Class0", "Class1"))
train_labels <- factor(train_labels, levels = c(0, 1), labels = c("Class0", "Class1"))



wine_train_labels <- factor(wine_train_labels, levels = c("c0", "c1", "c2", "c3", "c5", "c6"))


wine_train_labels <- factor(wine_train_labels, levels = c(0, 1/6, 2/6, 3/6, 4/6, 5/6, 1), labels = c("q0", "q1", "q2", "q3", "q4", "q5", "q6"))

wine_test_labels <- factor(wine_test_labels, levels = c(0, 1/6, 2/6, 3/6, 4/6, 5/6, 1), labels = c("q0", "q1", "q2", "q3", "q4", "q5", "q6"))


table(wine$quality)


wine$quality <- wine$quality > 5



levels(wine_pred)

levels(wine_test$quality)

glimpse(wine_test)

head(wine_test)

table(wine_test$quality)




# Ensure that wine_test$quality is a factor
wine_test$quality <- factor(wine_test$quality)

# Convert predictions to a factor with the same levels as wine_test$quality
wine_pred <- factor(wine_pred, levels = levels(wine_test$quality))

# Now, run confusionMatrix
confusionMatrix(wine_pred, wine_test$quality)







levels(wine_pred_p[, TRUE])
levels(wine_test$quality)


dim(wine_train)
str(wine_train)



colnames(wine_train) <- make.names(colnames(wine_train))

sum(is.na(wine_train$fixed.acidity))

wine_train <- na.omit(wine_train)  # To remove rows with NA

colnames(wine_train) == make.names(colnames(wine_train))




colnames(wine)


colnames(wine) <- gsub(" ", "_", colnames(wine))











