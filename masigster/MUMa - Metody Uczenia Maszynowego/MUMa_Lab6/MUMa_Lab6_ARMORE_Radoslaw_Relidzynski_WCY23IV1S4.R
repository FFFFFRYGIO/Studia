#################################################################
#################################################################
# Rozwiązanie zadania laboratoryjnego przy pomocy pakietu AMORE #
#################################################################
#################################################################

# Załadowanie bibliotek
library(tidyverse)
library(AMORE)
library(pROC)
library(caret)

########################
# Przygotowanie danych #
########################

# Usuniecie obiektow dla czystego startu modelu
rm(list = ls())

# Wczytanie danych
wesbrook <- read_csv('http://jolej.linuxpl.info/Wesbrook.csv', col_types = "ifncfffffffffcffffinnnnnnnfnnnn")

# Sprawdzenie ile jest brakujacych wartosci
print(sort(colSums(is.na(wesbrook)), decreasing = TRUE))
rows_with_na <- wesbrook[rowSums(is.na(wesbrook)) > 0, ]
print(rows_with_na)
print(nrow(rows_with_na))

# Usuniecie kolumny INDUPDT - zbedna dana
wesbrook <- wesbrook %>% select(-INDUPDT)

# Usuniecie kolumny EA - zbedna dana
wesbrook <- wesbrook %>% select(-EA)

# Usuniecie kolumny BIGBLOCK - nikt nie wzial udzialu w tym programie
wesbrook <- wesbrook %>% select(-BIGBLOCK)

# Sprawdzenie wartosci dla kolumny MARITAL wraz z brakujacymi wartosciami
print(table(wesbrook$MARITAL, useNA = "ifany"))

# Dla braku statusu malzenskiego przypisac wartosc "S" ("single")
wesbrook$MARITAL[is.na(wesbrook$MARITAL)] <- "S"

# Ustawienie brakujacych wartosci sredniego dochodu AVE_INC jako srednia ze wszystkich wartosci
wesbrook$AVE_INC[is.na(wesbrook$AVE_INC)] <- mean(wesbrook$AVE_INC, na.rm = TRUE)

# Ustawienie brakujacych wartosci odchylenia standardowego SD_INC jako srednia ze wszystkich wartosci
wesbrook$SD_INC[is.na(wesbrook$SD_INC)] <- mean(wesbrook$SD_INC, na.rm = TRUE)

# Inputacja innych brakujących danych
wesbrook <- wesbrook %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>%
  mutate(across(where(is.factor), ~ ifelse(is.na(.), levels(.)[which.max(table(.))], .)))

# Przekształcenie zmiennej WESBROOK na binarną (0 = "F", 1 = "Y")
wesbrook$WESBROOK <- ifelse(wesbrook$WESBROOK == 2, 1, 0)

# Usuniecie pozostalych rekordow z brakujacymi wartosciami
wesbrook <- wesbrook %>% drop_na()

# Konwersja wszystkich kolumn na numeryczne
wesbrook <- wesbrook %>%
  mutate(across(everything(), ~ as.numeric(as.factor(.))))

# Funkcja normalizujaca metoda min - max
normalize <- function(x) {
  if (min(x) == max(x)) {
    return(rep(0, length(x)))
  } else {
    return((x - min(x)) / (max(x) - min(x)))
  }
}

wesbrook <- wesbrook %>%
  mutate(across(where(is.numeric), normalize))

# Podział na zbiór treningowy i walidacyjny
set.seed(1234)
sample_index <- sample(1:nrow(wesbrook), size = 0.8 * nrow(wesbrook))
wesbrook_train <- wesbrook[sample_index, ]
wesbrook_test <- wesbrook[-sample_index, ]

# Przygotowanie macierzy wejściowych (WE) i wyjściowych (WY)
WE <- as.matrix(wesbrook_train[, -which(colnames(wesbrook_train) == "WESBROOK")])  # Wszystkie cechy oprócz WESBROOK
WY <- as.vector(as.numeric(wesbrook_train$WESBROOK))  # Wartości docelowe

VAL_WE <- as.matrix(wesbrook_test[, -which(colnames(wesbrook_test) == "WESBROOK")])  # Walidacyjne cechy
VAL_WY <- as.vector(as.numeric(wesbrook_test$WESBROOK))  # Walidacyjne wartości docelowe


########################################
# Tworzenie i uczenie sieci neuronowej #
########################################

# Definicja sieci neuronowej
net <- newff(
  n.neurons = c(ncol(WE), 20, 1),  # Struktura sieci
  learning.rate.global = 0.001,  # Współczynnik szybkości uczenia
  momentum.global = 0.5,  # Współczynnik momentum
  error.criterium = "TAO", Stao = NA,  # Sposób liczenia błędu
  hidden.layer = "tansig",  # Funkcja aktywacji dla warstw ukrytych
  output.layer = "purelin",  # Funkcja aktywacji warstwy wyjściowej
  method = "ADAPTgdwm"  # Algorytm uczenia sieci
)

# Trenowanie sieci
result <- AMORE::train(
  net, WE, WY, VAL_WE, VAL_WY,  # Dane uczenia
  error.criterium = "LMS",  # Kryterium błędu "LMS" - "Least Mean Squares"
  show.step = 40,  # Co ile epok wyświetlać postęp
  n.shows = 20  # Maksymalna liczba raportów do wyświetlenia
)


######################################
# Analiza nauczonej sieci neuronowej #
######################################

# Krzywa uczenia
matplot(result$Merror, pch=21:23, type="o", xlim=c(1, 20), ylim=range(result$Merror), col=1:2)
legend("topright", legend=c("Train", "Test"), pch=21:22, col=1:2)

# Predykcja dla danych walidacyjnych
predictions <- sim(result$net, VAL_WE)
predictions_binary <- as.numeric(predictions > 0.5)  # Konwersja na wartości binarne

# Macierz konfusji, dokładność
confusionMatrix(factor(predictions_binary), factor(VAL_WY))

# Obliczanie krzywej ROC
roc_curve <- roc(factor(VAL_WY), predictions)

# Wyznaczenie AUC
auc_value <- auc(roc_curve)
auc_value

# Rysowanie krzywej ROC
plot(roc_curve, main = "ROC Curve AMORE")


################################################################
################################################################
# Rozwiązanie zadania laboratoryjnego przy pomocy pakietu nnet #
################################################################
################################################################

# Załadowanie bibliotek
library(tidyverse)
library(nnet)
library(pROC)
library(caret)

########################
# Przygotowanie danych #
########################

# Usuniecie obiektow dla czystego startu modelu
rm(list = ls())

# Wczytanie danych
wesbrook <- read_csv('http://jolej.linuxpl.info/Wesbrook.csv', col_types = "ifncfffffffffcffffinnnnnnnfnnnn")

# Sprawdzenie ile jest brakujacych wartosci
print(sort(colSums(is.na(wesbrook)), decreasing = TRUE))
rows_with_na <- wesbrook[rowSums(is.na(wesbrook)) > 0, ]
print(rows_with_na)
print(nrow(rows_with_na))

# Usuniecie kolumny INDUPDT - zbedna dana
wesbrook <- wesbrook %>% select(-INDUPDT)

# Usuniecie kolumny EA - zbedna dana
wesbrook <- wesbrook %>% select(-EA)

# Usuniecie kolumny BIGBLOCK - nikt nie wzial udzialu w tym programie
wesbrook <- wesbrook %>% select(-BIGBLOCK)

# Sprawdzenie wartosci dla kolumny MARITAL wraz z brakujacymi wartosciami
print(table(wesbrook$MARITAL, useNA = "ifany"))

# Dla braku statusu malzenskiego przypisac wartosc "S" ("single")
wesbrook$MARITAL[is.na(wesbrook$MARITAL)] <- "S"

# Ustawienie brakujacych wartosci sredniego dochodu AVE_INC jako srednia ze wszystkich wartosci
wesbrook$AVE_INC[is.na(wesbrook$AVE_INC)] <- mean(wesbrook$AVE_INC, na.rm = TRUE)

# Ustawienie brakujacych wartosci odchylenia standardowego SD_INC jako srednia ze wszystkich wartosci
wesbrook$SD_INC[is.na(wesbrook$SD_INC)] <- mean(wesbrook$SD_INC, na.rm = TRUE)

# Inputacja innych brakujących danych
wesbrook <- wesbrook %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>%
  mutate(across(where(is.factor), ~ ifelse(is.na(.), levels(.)[which.max(table(.))], .)))

# Przekształcenie zmiennej WESBROOK na binarną (0 = "F", 1 = "Y")
wesbrook$WESBROOK <- ifelse(wesbrook$WESBROOK == 2, 1, 0)

# Usuniecie pozostalych rekordow z brakujacymi wartosciami
wesbrook <- wesbrook %>% drop_na()

# Konwersja wszystkich kolumn na numeryczne
wesbrook <- wesbrook %>%
  mutate(across(everything(), ~ as.numeric(as.factor(.))))

# Funkcja normalizujaca metoda min - max
normalize <- function(x) {
  if (min(x) == max(x)) {
    return(rep(0, length(x)))
  } else {
    return((x - min(x)) / (max(x) - min(x)))
  }
}

wesbrook <- wesbrook %>%
  mutate(across(where(is.numeric), normalize))

# Podział na zbiór treningowy i walidacyjny
set.seed(1234)
sample_index <- sample(1:nrow(wesbrook), size = 0.8 * nrow(wesbrook))
wesbrook_train <- wesbrook[sample_index, ]
wesbrook_test <- wesbrook[-sample_index, ]

# Przygotowanie macierzy wejściowych (WE) i wyjściowych (WY)
WE <- as.matrix(wesbrook_train[, -which(colnames(wesbrook_train) == "WESBROOK")])  # Wszystkie cechy oprócz WESBROOK
WY <- as.vector(as.numeric(wesbrook_train$WESBROOK))  # Wartości docelowe

VAL_WE <- as.matrix(wesbrook_test[, -which(colnames(wesbrook_test) == "WESBROOK")])  # Walidacyjne cechy
VAL_WY <- as.vector(as.numeric(wesbrook_test$WESBROOK))  # Walidacyjne wartości docelowe


########################################
# Tworzenie i uczenie sieci neuronowej #
########################################

# Tworzenie i trenowanie modelu
model <- nnet(
  x = WE,
  y = WY,
  size = 15,  # Liczba neuronów w warstwie ukrytej
  linout = FALSE,  # Klasyfikacja binarna
  softmax = FALSE,
  maxit = 200,
  decay = 0.01
)
# Tworzenie i trenowanie modelu
model <- nnet(
  x = WE,  # Dane wejściowe
  y = WY,  # Dane wyjściowe
  size = 30,  # Liczba neuronów w warstwie ukrytej
  linout = FALSE,  # Czy używać regresji liniowej?
  softmax = FALSE,  # Czy używać funkcji softmax do normalizacji wyjść?
  maxit = 200,  # Maksymalna liczba iteracji algorytmu optymalizacyjnego
  decay = 0.01  # Współczynnik regularizacji (zapobiega przeuczeniu)
)


######################################
# Analiza nauczonej sieci neuronowej #
######################################

# Predykcja dla danych walidacyjnych
predictions <- predict(model, VAL_WE, type = "raw")
predictions_binary <- as.numeric(predictions > 0.5)  # Konwersja na wartości binarne

# Macierz konfusji, dokładność
confusionMatrix(factor(predictions_binary), factor(VAL_WY))

# Obliczanie krzywej ROC
roc_curve <- roc(factor(VAL_WY), predictions)

# Wyznaczenie AUC
auc_value <- auc(roc_curve)
auc_value

# Rysowanie krzywej ROC
plot(roc_curve, main = "ROC Curve nnet")

#################################################################
#################################################################
# Rozwiązanie zadania laboratoryjnego przy pomocy pakietu RSNNS #
#################################################################
#################################################################

# Załadowanie bibliotek
library(tidyverse)
library(RSNNS)
library(pROC)
library(caret)

########################
# Przygotowanie danych #
########################

# Usuniecie obiektow dla czystego startu modelu
rm(list = ls())

# Wczytanie danych
wesbrook <- read_csv('http://jolej.linuxpl.info/Wesbrook.csv', col_types = "ifncfffffffffcffffinnnnnnnfnnnn")

# Sprawdzenie ile jest brakujacych wartosci
print(sort(colSums(is.na(wesbrook)), decreasing = TRUE))
rows_with_na <- wesbrook[rowSums(is.na(wesbrook)) > 0, ]
print(rows_with_na)
print(nrow(rows_with_na))

# Usuniecie kolumny INDUPDT - zbedna dana
wesbrook <- wesbrook %>% select(-INDUPDT)

# Usuniecie kolumny EA - zbedna dana
wesbrook <- wesbrook %>% select(-EA)

# Usuniecie kolumny BIGBLOCK - nikt nie wzial udzialu w tym programie
wesbrook <- wesbrook %>% select(-BIGBLOCK)

# Sprawdzenie wartosci dla kolumny MARITAL wraz z brakujacymi wartosciami
print(table(wesbrook$MARITAL, useNA = "ifany"))

# Dla braku statusu malzenskiego przypisac wartosc "S" ("single")
wesbrook$MARITAL[is.na(wesbrook$MARITAL)] <- "S"

# Ustawienie brakujacych wartosci sredniego dochodu AVE_INC jako srednia ze wszystkich wartosci
wesbrook$AVE_INC[is.na(wesbrook$AVE_INC)] <- mean(wesbrook$AVE_INC, na.rm = TRUE)

# Ustawienie brakujacych wartosci odchylenia standardowego SD_INC jako srednia ze wszystkich wartosci
wesbrook$SD_INC[is.na(wesbrook$SD_INC)] <- mean(wesbrook$SD_INC, na.rm = TRUE)

# Inputacja innych brakujących danych
wesbrook <- wesbrook %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>%
  mutate(across(where(is.factor), ~ ifelse(is.na(.), levels(.)[which.max(table(.))], .)))

# Przekształcenie zmiennej WESBROOK na binarną (0 = "F", 1 = "Y")
wesbrook$WESBROOK <- ifelse(wesbrook$WESBROOK == 2, 1, 0)

# Usuniecie pozostalych rekordow z brakujacymi wartosciami
wesbrook <- wesbrook %>% drop_na()

# Konwersja wszystkich kolumn na numeryczne
wesbrook <- wesbrook %>%
  mutate(across(everything(), ~ as.numeric(as.factor(.))))

# Funkcja normalizujaca metoda min - max
normalize <- function(x) {
  if (min(x) == max(x)) {
    return(rep(0, length(x)))
  } else {
    return((x - min(x)) / (max(x) - min(x)))
  }
}

wesbrook <- wesbrook %>%
  mutate(across(where(is.numeric), normalize))

# Podział na zbiór treningowy i walidacyjny
set.seed(1234)
sample_index <- sample(1:nrow(wesbrook), size = 0.8 * nrow(wesbrook))
wesbrook_train <- wesbrook[sample_index, ]
wesbrook_test <- wesbrook[-sample_index, ]

# Przygotowanie macierzy wejściowych (WE) i wyjściowych (WY)
WE <- as.matrix(wesbrook_train[, -which(colnames(wesbrook_train) == "WESBROOK")])  # Wszystkie cechy oprócz WESBROOK
WY <- as.vector(as.numeric(wesbrook_train$WESBROOK))  # Wartości docelowe

VAL_WE <- as.matrix(wesbrook_test[, -which(colnames(wesbrook_test) == "WESBROOK")])  # Walidacyjne cechy
VAL_WY <- as.vector(as.numeric(wesbrook_test$WESBROOK))  # Walidacyjne wartości docelowe

########################################
# Tworzenie i uczenie sieci neuronowej #
########################################

# Tworzenie i trenowanie modelu
model <- mlp(
  x = WE,  # Dane wejściowe
  y = WY,  # Dane wyjściowe
  size = 30,  # Liczba neuronów w warstwie ukrytej
  maxit = 200,  # Maksymalna liczba iteracji
  initFunc = "Randomize_Weights",  # Funkcja inicjalizacji wag (tutaj losowa)
  initFuncParams = c(-0.3, 0.3),  # Zakres wartości początkowych dla wag
  learnFunc = "Std_Backpropagation",  # Funkcja uczenia
  learnFuncParams = c(0.01, 0.7),  # Parametry learning rate i momentum
  updateFunc = "Topological_Order",  # Kolejność aktualizacji wag
  hiddenActFunc = "Act_Logistic",  # Funkcja aktywacji w warstwach ukrytych
  shufflePatterns = TRUE  # Mieszanie wzorców przy uczeniu
)

######################################
# Analiza nauczonej sieci neuronowej #
######################################

# Predykcja dla danych walidacyjnych
predictions <- predict(model, VAL_WE, type = "raw")
predictions_binary <- as.numeric(predictions > 0.5)  # Konwersja na wartości binarne

# Macierz konfusji, dokładność
confusionMatrix(factor(predictions_binary), factor(VAL_WY))

# Obliczanie krzywej ROC
roc_curve <- roc(factor(VAL_WY), predictions)

# Wyznaczenie AUC
auc_value <- auc(roc_curve)
auc_value

# Rysowanie krzywej ROC
plot(roc_curve, main = "ROC Curve RSNNS")



#####################################################################
#####################################################################
# Rozwiązanie zadania laboratoryjnego przy pomocy pakietu neuralnet #
#####################################################################
#####################################################################

# Załadowanie bibliotek
library(tidyverse)
library(neuralnet)
library(pROC)
library(caret)

########################
# Przygotowanie danych #
########################

# Wczytanie danych
wesbrook <- read_csv('http://jolej.linuxpl.info/Wesbrook.csv', col_types = "ifncfffffffffcffffinnnnnnnfnnnn")

# Sprawdzenie ile jest brakujacych wartosci
print(sort(colSums(is.na(wesbrook)), decreasing = TRUE))
rows_with_na <- wesbrook[rowSums(is.na(wesbrook)) > 0, ]
print(rows_with_na)
print(nrow(rows_with_na))

# Usuniecie kolumny INDUPDT - zbedna dana
wesbrook <- wesbrook %>% select(-INDUPDT)

# Usuniecie kolumny EA - zbedna dana
wesbrook <- wesbrook %>% select(-EA)

# Usuniecie kolumny BIGBLOCK - nikt nie wzial udzialu w tym programie
wesbrook <- wesbrook %>% select(-BIGBLOCK)

# Sprawdzenie wartosci dla kolumny MARITAL wraz z brakujacymi wartosciami
print(table(wesbrook$MARITAL, useNA = "ifany"))

# Dla braku statusu malzenskiego przypisac wartosc "S" ("single")
wesbrook$MARITAL[is.na(wesbrook$MARITAL)] <- "S"

# Ustawienie brakujacych wartosci sredniego dochodu AVE_INC jako srednia ze wszystkich wartosci
wesbrook$AVE_INC[is.na(wesbrook$AVE_INC)] <- mean(wesbrook$AVE_INC, na.rm = TRUE)

# Ustawienie brakujacych wartosci odchylenia standardowego SD_INC jako srednia ze wszystkich wartosci
wesbrook$SD_INC[is.na(wesbrook$SD_INC)] <- mean(wesbrook$SD_INC, na.rm = TRUE)

# Inputacja innych brakujących danych
wesbrook <- wesbrook %>%
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .))) %>%
  mutate(across(where(is.factor), ~ ifelse(is.na(.), levels(.)[which.max(table(.))], .)))

# Przekształcenie zmiennej WESBROOK na binarną (0 = "F", 1 = "Y")
wesbrook$WESBROOK <- ifelse(wesbrook$WESBROOK == 2, 1, 0)

# Usuniecie pozostalych rekordow z brakujacymi wartosciami
wesbrook <- wesbrook %>% drop_na()

# Konwersja wszystkich kolumn na numeryczne
wesbrook <- wesbrook %>%
  mutate(across(everything(), ~ as.numeric(as.factor(.))))

# Funkcja normalizujaca metoda min - max
normalize <- function(x) {
  if (min(x) == max(x)) {
    return(rep(0, length(x)))
  } else {
    return((x - min(x)) / (max(x) - min(x)))
  }
}

wesbrook <- wesbrook %>%
  mutate(across(where(is.numeric), normalize))

# Podział na zbiór treningowy i walidacyjny
set.seed(1234)
sample_index <- sample(1:nrow(wesbrook), size = 0.8 * nrow(wesbrook))
wesbrook_train <- wesbrook[sample_index, ]
wesbrook_test <- wesbrook[-sample_index, ]

# Przygotowanie macierzy wejściowych (WE) i wyjściowych (WY)
WE <- as.matrix(wesbrook_train[, -which(colnames(wesbrook_train) == "WESBROOK")])  # Wszystkie cechy oprócz WESBROOK
WY <- as.vector(as.numeric(wesbrook_train$WESBROOK))  # Wartości docelowe

VAL_WE <- as.matrix(wesbrook_test[, -which(colnames(wesbrook_test) == "WESBROOK")])  # Walidacyjne cechy
VAL_WY <- as.vector(as.numeric(wesbrook_test$WESBROOK))  # Walidacyjne wartości docelowe

########################################
# Tworzenie i uczenie sieci neuronowej #
########################################

# Tworzenie formuły modelu
formula <- as.formula(paste("WESBROOK ~", paste(colnames(WE), collapse = " + ")))

# Tworzenie i trenowanie modelu
model <- neuralnet(
  formula,  # Formuła modelu
  data = wesbrook_train,  # Dane treningowe
  hidden = c(30),  # Liczba neuronów w warstwie ukrytej
  linear.output = FALSE,  # Czy używać wyjścia liniowego?
  stepmax = 1e6  # Maksymalna liczba kroków uczenia
)

######################################
# Analiza nauczonej sieci neuronowej #
######################################

# Predykcja dla danych walidacyjnych
predictions <- predict(model, VAL_WE, type = "raw")
predictions_binary <- as.numeric(predictions > 0.5)  # Konwersja na wartości binarne

# Macierz konfusji, dokładność
confusionMatrix(factor(predictions_binary), factor(VAL_WY))

# Obliczanie krzywej ROC
roc_curve <- roc(factor(VAL_WY), predictions)

# Wyznaczenie AUC
auc_value <- auc(roc_curve)
auc_value

# Rysowanie krzywej ROC
plot(roc_curve, main = "ROC Curve neuralnet")
