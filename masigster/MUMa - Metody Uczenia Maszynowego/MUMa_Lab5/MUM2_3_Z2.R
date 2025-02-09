# Klasteryzacja metoda k-srednich

library(tidyverse)

# zaczytanie zbioru danych mallcustomers.csv dotyczacych klientów galerii handlowej
mallcustomers <- read_csv("http://jolej.linuxpl.info/mallcustomers.csv")

# Rekord kazdego klienta sklada sie z unikatowego identyfikatora
# (CustomerID), plci (Gender), wieku (Age), rocznej pensji (Income) oraz oceny
# wydatków, od 1 do 100, przypisanej w zaleznosci od nawyków zakupowych klienta
# i kilku innych czynników (SpendingScore). 
# 
# 
# Zadamie polega na  segmentacji klientów w oparciu o zmienne Income i SpendingScore.

# UWAGA
# cecha Income jest przechowywana w postaci ciagu znakowego.
# funkcji str_replace_all() z pakietu stringr do zastapienie podciagów ciagiem pustym ("")


