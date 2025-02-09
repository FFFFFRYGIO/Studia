# Generowanie regul asocjacyjnych

# Zaimportowac zbiór danych groceries,csv

library(arules)

groceries <- read.transactions("http://jolej.linuxpl.info/groceries.csv", sep = ",")

# Zbiór danych sklada sie z 9835 transakcji odnotowanych w ciagu miesiaca w malym sklepie 
# spozywczym.
# Ma podobna strukture co przedstawione wczesniej dane z belgijskiego supermarketu
# z dwoma podstawowymi róznicami. Pierwsza jest to, ze w odróznieniu od zbioru danych
# z supermarketu, w którym elementy byly oddzielone bialymi znakami, elementy
# w tym zbiorze danych sa rozdzielone przecinkiem. Druga róznica polega na tym,
# ze elementy w tym zbiorze danych nie zostaly zanonimizowane. Tym razem widac,
# jaki produkt reprezentuje kazdy z elementów. 
# 
# Zadamie polega na wygenerowaniu regul
# asocjacyjnych, które opisuja interesujace wzorce zakupowe w danych.