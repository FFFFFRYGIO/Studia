#########################################
# Treść zadania laboratoryjnego część 1 #
#########################################

# Generowanie regul asocjacyjnych

# Zaimportowac zbi?r danych groceries,csv

# Zbi?r danych sklada sie z 9835 transakcji odnotowanych w ciagu miesiaca w malym sklepie 
# spozywczym.
# Ma podobna strukture co przedstawione wczesniej dane z belgijskiego supermarketu
# z dwoma podstawowymi r?znicami. Pierwsza jest to, ze w odr?znieniu od zbioru danych
# z supermarketu, w kt?rym elementy byly oddzielone bialymi znakami, elementy
# w tym zbiorze danych sa rozdzielone przecinkiem. Druga r?znica polega na tym,
# ze elementy w tym zbiorze danych nie zostaly zanonimizowane. Tym razem widac,
# jaki produkt reprezentuje kazdy z element?w. 
# 
# Zadamie polega na wygenerowaniu regul
# asocjacyjnych, kt?re opisuja interesujace wzorce zakupowe w danych.

###############################################
# Rozwiązanie zadania laboratoryjnego część 1 #
###############################################

library(arules)
library(tidyverse)

groceries <- read.transactions("http://jolej.linuxpl.info/groceries.csv", sep = ",")


# Wyświetlenie ogólnego podsumowania
summary(groceries)

# Zbior danych zawiera 9835 transakcji (wierszy) i 169 unikatowych elementow (kolumn). 

# Gestosc zbioru danych wynosi 0.02609146.
# Jest bardzo rzadki, ale mniej rzadki niż zbiór supermart
# Oznacza to, że w pojedynczych transakcjach znajduje się średnio więcej produktów

# 3 najczęściej kupowane produkty:
# - whole milk (mleko pełnotłuste) – w 2513 transakcjach (ponad 25% wszystkich transakcji)
# - other vegetables (inne warzywa nie wymienione jako niezależne produkty) – w 1903 transakcjach  
# - rolls/buns (bułki) – w 1809 transakcjach  

# W ramach podsumowania długości transakcji widać, że:
# - najwięcej było jednoelementowych (2159)
# - największa transakcja miała 32 elementy (była taka tylko jedna)
# - im większa długośc transakcji tym rzadsze wystąpienie tej długości
# - średnia długość transakcji to 4,409


# Wyświetlenie listy 5 pierwszych transakcji
inspect(groceries[1:10], linebreak = FALSE)

# 4 z wyświetlonych transakcji posiadają element "whole milk"
# 2 z wyświetlanych transakcji posaida element "other vegetables"
# 3 z wyświetlanych transakcji posaida element "rolls/buns"
# Ten zestaw transakcji potwierdza dużą występowalność tych 3 elementów w zbiorze


# Wypisanie czestotliwosci (wsparcia) elementu
itemFrequency(groceries[ ,"whole milk"])
itemFrequency(groceries[ ,"other vegetables"])
itemFrequency(groceries[ ,"rolls/buns"])

# Funkcja zwraca procent transakcji,w których dany produkt się pojawia


# Tworzenie obiektu tibble 
groceries_frequency <- 
  tibble(
    Items = names(itemFrequency(groceries)),
    Frequency = itemFrequency(groceries)
  )

# Obiekt zawiera czestotliwosc wystąpienia wszystkich elementów w zbiorze


# Wypisanie pierwszych wierszy obiektu
head(groceries_frequency, n = 3)

# Wypisanie 3 najczęściej kupowanych produktów
groceries_frequency %>%
  arrange(desc(Frequency)) %>%
  slice(1:3)

# Częstotliwość elementu "whole milk": 0.256
# Częstotliwość elementu "other vegetables": 0.193
# Częstotliwość elementu "rolls/buns": 0.184
# Ponownie widać, że są to najczęściej występujące elementy


### Ustalanie parametrów modelu

# Minimalny próg wsparcia
# Interesują nas wzorce, które pojawiają się przynajmniej 1 raz dziennie.
# Załóżmy, że dane były zbierane przez 5 miesięcy, a każdy miesiąc miał 30 dni.
# Oznacza to, że wzorzec powinien pojawiać się w co najmniej 1 * 150 = 150 transakcjach.
# Wiemy, że zbiór danych zawiera 9835 transakcji, więc minimalne wsparcie będzie:
# 150 / 9835 ≈ 0.0153

# Wyznaczanie progu ufności.
# Aby reguła została uwzględniona, poprzednik i następnik muszą występować razem 
# w przynajmniej połowie przypadków. Dlatego próg ufności ustawiamy na 0.5.

# Aby wyeliminować reguły mające mniej niż dwa elementy, minimalna długość reguły została ustawiona na 2.

# Tworzenie modelu z regułami
groceries_rules <- apriori(
  groceries,
  parameter = list(
    support = 0.0153,
    confidence = 0.5,
    minlen = 2
  )
)

# Wyświetlenie podsumowania modelu
summary(groceries_rules)

# Dwie pierwsze sekcje wyników informują, że zgodnie z ustawionymi progami wygenerowano 
# określoną liczbę reguł. Widać również podział reguł według ich długości.
# Kolejna sekcja wyników podaje podsumowanie statystyczne wsparcia, ufności, 
# przyrostu (lift) oraz liczby wystąpień każdej reguły w zbiorze danych.

# Wyświetlenie reguły
inspect(groceries_rules[1])

# Opis rezultatu:
# lhs (left-hand side) - Lewa strona reguły – produkty, które są już w koszyku klienta.
# rhs (right-hand side) -	Prawa strona reguły – produkt, którego zakup jest przewidywany.
# support (wsparcie) - częstotliwość występowania transkacji.
# confidence (ufność) - Ufność, że jeśli wystąpi lhs to wystąpi rhs
# coverage - pokazuje, jak często kombinacja pojawia się w transakcjach.
# lift (przyrost) -	Ile razy częściej reguła aplikuje się względem losowej transakcji
# count -	Liczba transakcji, w których ta reguła występuje.


# Wynik działania (wygenerowano jedną regułę):

#     lhs                           rhs          support    confidence coverage   lift     count
# [1] {other vegetables, yogurt} => {whole milk} 0.02226741 0.5128806  0.04341637 2.007235 219 

# Analiza rezultatu dla reguły:
# lhs – reguła dotyczy transakcji zawierających {other vegetables, yogurt}
# rhs – dla wystąpienia lhs ({other vegetables, yogurt}) przewidywane jest kupienie {whole milk}
# support - reguła występuje w ~2.23% wszystkich transakcji. Oznacza to, że spośród wszystkich zakupów w zbiorze, 2.23% zawiera zarówno {other vegetables, yogurt, whole milk}.
# confidence - gdy klient kupił "other vegetables" i "yogurt", w 51.29% przypadków dokonał również zakupu "whole milk".
# coverage - w 4.34% przypadków w bazie danych klienci kupili te {other vegetables, yogurt} razem.
# lift - klienci, którzy kupili "other vegetables" i "yogurt", są 2 razy bardziej skłonni do zakupu "whole milk" niż losowy klient.
# count -	w 219 przypadkach spośród wszystkich transakcji klienci kupili "other vegetables", "yogurt" i "whole milk".



#########################################
# Treść zadania laboratoryjnego część 2 #
#########################################

# Klasteryzacja metoda k-srednich

# zaczytanie zbioru danych mallcustomers.csv dotyczacych klient?w galerii handlowej

# Rekord kazdego klienta sklada sie z unikatowego identyfikatora
# (CustomerID), plci (Gender), wieku (Age), rocznej pensji (Income) oraz oceny
# wydatk?w, od 1 do 100, przypisanej w zaleznosci od nawyk?w zakupowych klienta
# i kilku innych czynnik?w (SpendingScore). 
# 
# 
# Zadamie polega na  segmentacji klient?w w oparciu o zmienne Income i SpendingScore.

# UWAGA
# cecha Income jest przechowywana w postaci ciagu znakowego.
# funkcji str_replace_all() z pakietu stringr do zastapienie podciag?w ciagiem pustym ("")

###############################################
# Rozwiązanie zadania laboratoryjnego część 2 #
###############################################

library(tidyverse)

mallcustomers <- read_csv("http://jolej.linuxpl.info/mallcustomers.csv", col_types="cfnnn")

# Zamiana zmiennej "Gender" na zmienne logiczne
library(fastDummies)
mallcustomers <- dummy_cols(mallcustomers, select_columns = "Gender", remove_selected_columns = TRUE)

# Podglad zbioru danych
glimpse(mallcustomers)

# Wyświetlenie podsumowania dla zmiennych Income i SpendingScore
mallcustomers %>%
  select(Income, SpendingScore) %>%
  summary()

# Cechy maja inne zakresy wartosci dlatego powinny zostac znormalizowane
mallcustomers_scaled <- mallcustomers %>%
  select(Income, SpendingScore) %>%
  scale()

# Wyświetlenie podsumowania dla zmiennych Income i SpendingScore po znormalizowaniu
mallcustomers_scaled %>%
  summary()

# Sprawdzenie jaką liczbę poziomów klasteryzacji zastosować
library(factoextra)
fviz_nbclust(mallcustomers_scaled, kmeans, method = "silhouette")
# Największa ąsrednia jest dla 6

### Klasteryzacja za pomoca funkcji kmeans()

library(stats)

set.seed(1234)

k_6 <- kmeans(mallcustomers_scaled, centers=6, nstart = 25)

# Liczba obserwacji w kazdym z klastrow
k_6$size

# Srodki kazdego z klastr?w
k_6$centers

# Wizualizacja klasteryzacji za pomoca funkcji fviz_cluster() z pakietu factoextra
fviz_cluster(k_6, data = mallcustomers_scaled, repel = TRUE,
             ggtheme = theme_minimal()) + theme(text = element_text(size = 14))

# Generowanie srednich wartosci dla kazdego z wybranych atrybutow
mallcustomers %>%
  mutate(cluster = k_6$cluster) %>%
  select(cluster,
         Gender_Male,
         Gender_Female,
         Age,
         Income,
         SpendingScore) %>%
  group_by(cluster) %>%
  summarise_all("mean") %>%
  arrange(Age)

# WNIOSKI:
# - im młodsze osoby tym większy SpendingScore
# - najmłodsi i najstarsi mają skrajnie różny SpendingScore
# - najmłodszi i najstarsi mają najniższe docohdy
# - największy średni income ma klaster 2
# - największy średni wieki ma klaster 1
# - największy średni SpendingScore ma klaster 6
# - w klastrze drugim jako jedynym istnieje przewaga kobiet i mężczyzn
