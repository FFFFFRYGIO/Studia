# Klasteryzacja metoda k-srednich

library(tidyverse)

# zaczytanie zbioru danych mallcustomers.csv dotyczacych klient�w galerii handlowej
mallcustomers <- read_csv("http://jolej.linuxpl.info/mallcustomers.csv")

# Rekord kazdego klienta sklada sie z unikatowego identyfikatora
# (CustomerID), plci (Gender), wieku (Age), rocznej pensji (Income) oraz oceny
# wydatk�w, od 1 do 100, przypisanej w zaleznosci od nawyk�w zakupowych klienta
# i kilku innych czynnik�w (SpendingScore). 
# 
# 
# Zadamie polega na  segmentacji klient�w w oparciu o zmienne Income i SpendingScore.

# UWAGA
# cecha Income jest przechowywana w postaci ciagu znakowego.
# funkcji str_replace_all() z pakietu stringr do zastapienie podciag�w ciagiem pustym ("")


