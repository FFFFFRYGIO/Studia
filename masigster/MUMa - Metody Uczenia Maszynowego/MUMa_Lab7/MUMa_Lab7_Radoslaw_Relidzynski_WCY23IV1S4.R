# Zimportowanie bibliotek
library(arules)
library(tidyverse)
library(kohonen)

# Stałe ziarno losowości
set.seed(1234)

# Zaimportowanie zbioru
groceries <- read.transactions("http://jolej.linuxpl.info/groceries.csv", sep = ",")

# Eksploracja transakcji za pomocą SOM
# Przekształcamy transackje na macierz binarną i zamieniamy TRUE/FALSE na 1/0
groceries_matrix <- 1 * as(groceries, "matrix")

# Utworzenie siatki SOM – 10x10 węzłów topologia heksagonalna
groceries_grid <- somgrid(xdim = 10, ydim = 10, topo = "hexagonal")

################################################################################
# Trenowanie modelu SOM na macierzy numerycznej
# rlen - ilosc iteracji
# alpha - współczynnik szybkosci uczenia
groceries_som <- som(groceries_matrix, grid = groceries_grid, rlen = 100, alpha = c(0.05, 0.01))
################################################################################

# Wizualizacje modelu SOM
plot(groceries_som, type="changes")
plot(groceries_som, type = "count")
plot(groceries_som, type = "mapping")
plot(groceries_som, type = "dist.neighbours")
plot(groceries_som, type = "codes")

# Klasteryzacja hierarchiczna węzłów SOM 
groups = 6
som_codes <- groceries_som$codes[[1]]
hc_groceries <- hclust(dist(som_codes))
clusters_groceries <- cutree(hc_groceries, k = groups)

# Wizualizacja klastrów na mapie SOM
plot(groceries_som, type = "codes", bgcol = rainbow(3)[clusters_groceries])

# Zaznaczenie na wykresie klastrów boundaries
add.cluster.boundaries(groceries_som, clusters_groceries)


# budowa modelu nadzorowanego - I spos?b

# Definicja zmiennej docelowej - obecność produktu "whole milk"
milk <- factor(ifelse(groceries_matrix[, "whole milk"] == 1, "Milk", "NoMilk"))

# Definiowanie parametrów siatki SOM (tutaj 10x10 komórek, topologia heksagonalna)
groceries_grid <- somgrid(xdim = 10, ydim = 10, topo = "hexagonal")

################################################################################
# Budowa modelu SOM (xyf: wykorzystanie danych predyktorowych i etykiety)
groceries_som1 <- xyf(groceries_matrix, milk, grid = groceries_grid, rlen = 100, alpha = c(0.05, 0.01))
summary(groceries_som1)
################################################################################

# Klasteryzacja hierarchiczna kodów (wektory reprezentujące neurony)
groups <- 2  # ponieważ mamy dwie klasy: Milk i NoMilk
groceries_hc <- cutree(hclust(dist(groceries_som1$codes[[1]])), groups)

# Wykres kodów z nałożonymi grupami
plot(groceries_som1, type = "codes", bgcol = rainbow(groups)[groceries_hc])

# Predykcja etykiet dla danych wejściowych
som_predictions <- predict(groceries_som1)

# Tabela porównująca oryginalne etykiety i przewidziane wartości
table(milk, factor(som_predictions$predictions[[2]]))


# budowa modelu nadzorowanego - II sposob

# Przygotowanie listy danych: pierwszy element - predyktory, drugi - etykieta
groceries_matrix_list <- list(groceries_matrix, milk)

################################################################################
# Budowa modelu SOM za pomocą funkcji supersom
groceries_som2 <- supersom(groceries_matrix_list, grid = groceries_grid, rlen = 100, alpha = c(0.05, 0.01))
summary(groceries_som2)
################################################################################

# Klasteryzacja hierarchiczna na podstawie kodów (pierwszy element listy kodów)
groceries_hc2 <- cutree(hclust(dist(groceries_som2$codes[[1]])), groups)

# Wykres kodów z zaznaczeniem grup
plot(groceries_som2, type = "codes", bgcol = rainbow(groups)[groceries_hc2])

# Predykcja etykiet
som_predictions2 <- predict(groceries_som2)

# Porównanie etykiet oryginalnych z przewidywanymi
table(milk, factor(som_predictions2$predictions[[2]]))


# Podział danych na zbiór uczący (70%) i testowy (30%)
idx_n <- sample(1:nrow(groceries_matrix), size = round(0.7 * nrow(groceries_matrix)))
train <- groceries_matrix[idx_n, ]
test  <- groceries_matrix[-idx_n, ]

# Obliczamy wariancję dla każdej kolumny i wybieramy te, które mają wariancję > 0
nonzero_cols <- apply(train, 2, function(x) sd(x) > 0)
train_nonzero <- train[, nonzero_cols]

# Model nienadzorowany - uczenie SOM

# Standaryzacja zmiennych dla zbioru uczącego
train.sc <- scale(train)

# Definiowanie siatki SOM (5x5, topologia heksagonalna)
som_grid <- somgrid(xdim = 5, ydim = 5, topo = "hexagonal")

################################################################################
# Uczenie modelu SOM na zbiorze uczącym - model nienadzorowany
som.groceries <- som(train.sc,
                     grid = som_grid,
                     rlen = 200,
                     alpha = c(0.05, 0.01),
                     keep.data = TRUE)
################################################################################


# Klasteryzacja hierarchiczna kodów neuronów
set_cluster <- 3  # liczba grup (klastrów)

# Obliczamy hierarchiczną klasteryzację na podstawie kodów neuronów (pierwszy zestaw kodów)
som.groceries.hc <- cutree(hclust(dist(som.groceries$codes[[1]])), set_cluster)

# Przypisanie klastra do każdej obserwacji na podstawie przypisanego neuronu
train_cluster <- as.factor(as.vector(som.groceries.hc[som.groceries$unit.classif]))

# Konwersja etykiet na macierz dummy (one-of-K encoding)
y_train <- classvec2classmat(train_cluster)

# Model nadzorowany - uczenie supersom

# Przygotowanie zbioru uczącego: lista zawierająca predyktory oraz etykiety (klastry)
train.l.sc <- list(x = train.sc, y = train_cluster)

# Definiowanie nowej siatki (tutaj taka sama 5x5, topologia heksagonalna)
mygrid <- somgrid(5, 5, "hexagonal")

################################################################################
# Uczenie modelu nadzorowanego za pomocą supersom
som.groceries.l <- supersom(train.l.sc, grid = mygrid, maxNA.fraction = 0.5)
################################################################################

# Predykcja dla zbioru testowego

# Standaryzacja zbioru testowego (skalujemy osobno)
test.sc <- scale(test)
test.l.sc <- list(x = as.matrix(test.sc))

# Predykcja klastrów dla zbioru testowego
test.pred <- predict(som.groceries.l, newdata = test.l.sc)

# Do wygodnej analizy przekształcamy wyniki na data.frame
train_final <- data.frame(train, cluster = train_cluster)
test_final  <- data.frame(test, cluster = test.pred$predictions$y)

# Analiza podsumowań dla poszczególnych klastrów - zbiór uczący
by(train_final, train_final$cluster, summary)

# Analiza podsumowań dla poszczególnych klastrów - zbiór testowy
by(test_final, test_final$cluster, summary)





