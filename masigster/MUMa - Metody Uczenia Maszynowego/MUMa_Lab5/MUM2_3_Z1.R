# Generowanie regul asocjacyjnych

# Zaimportowac zbi�r danych groceries,csv

library(arules)

groceries <- read.transactions("http://jolej.linuxpl.info/groceries.csv", sep = ",")

# Zbi�r danych sklada sie z 9835 transakcji odnotowanych w ciagu miesiaca w malym sklepie 
# spozywczym.
# Ma podobna strukture co przedstawione wczesniej dane z belgijskiego supermarketu
# z dwoma podstawowymi r�znicami. Pierwsza jest to, ze w odr�znieniu od zbioru danych
# z supermarketu, w kt�rym elementy byly oddzielone bialymi znakami, elementy
# w tym zbiorze danych sa rozdzielone przecinkiem. Druga r�znica polega na tym,
# ze elementy w tym zbiorze danych nie zostaly zanonimizowane. Tym razem widac,
# jaki produkt reprezentuje kazdy z element�w. 
# 
# Zadamie polega na wygenerowaniu regul
# asocjacyjnych, kt�re opisuja interesujace wzorce zakupowe w danych.