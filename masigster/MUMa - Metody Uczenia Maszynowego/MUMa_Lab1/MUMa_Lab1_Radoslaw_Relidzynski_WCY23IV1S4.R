#################################
# TRESC ZADANIA LABORATORYJNEGO #
#################################

# Prosze zaimportowac , dokonac wstepnej analizy i przygotowac do obróbki zni?r
# Wesbrook znajdujacy sie pod adresem http://jolej.linuxpl.info/Wesbrook.csv
# W tym celu nalezy:

# 1. Zaimportowac zbiór danych z odpowiednimi typami zmiennych z uzyciem funkcji read_csv()
# 2. Dokonac wstepnej analizy zbioru z wykorzystaniem statystyk opisowych
# 3. Dokonac analizy istotnosci zmiennych , utworzyc nowy zbi?r Wesbrook2 zawierajacy tylko 
# istotne zmienne.
# 4. Wykonac wizualna analize danych, w ramach analizy wizualnej rozklad zmiennych numerycznych 
# przedstawic na jednym wykresie macierzowym uzywajac histogram?w
# 5. Przygotowac dane do analizy w tym celu:
#  - dokonac imputacji brakujacych wartosci
#  - normalizacji zmiennych numerycznych metoda z-score i min-max
#  - wykonac kodowanie zero jedynkowe (wprowadzic zmienne sztuczne) dla zmiennej MARTIAL
#  - wykonac probkowanie warstwowe dzielac zbior na treningowy i walidacyjny w proporcji 
#  80 % do 20% wedlug zmiennej WESBROOK

#######################################
#######################################
# ROZWIAZANIE ZADANIA LABORATORYJNEGO #
#######################################
#######################################

# Instalacja bilbiotek
# install.packages("tidyverse")
# install.packages("GGally")

# Zimportowanie bibliotek
library(tidyverse)
library(GGally)

# W razie potrzeby nalezy wykorzystac ta przykladowa instrukcje do instalacji biblioteki:
# install.packages("GGally")


#############################################################################################
# 1. Zaimportować zbior danych z odpowiednimi typami zmiennych z uzyciem funkcji read_csv() #
#############################################################################################


# Zaimportowanie zbioru danych z podaniem typów kolumn do zmiennej srodowiskowej "Wesbrook"
Wesbrook <- read_csv('http://jolej.linuxpl.info/Wesbrook.csv', col_types = "ifncfffffffffcffffinnnnnnnfnnnn")

# Wyswietlenie podgladu danych przechowywanych w obiekcie "Wesbrook"
glimpse(Wesbrook)


###########################################################################
# 2. Dokonac wstepnej analizy zbioru z wykorzystaniem statystyk opisowych #
###########################################################################


# Wyswietlenie statystyk opisowych dla poszczegolnych zmiennych
summary(Wesbrook)
# Dane sa zroznicowane, wartosci dla zmiennych kategorii sa zroznicowane, a
# dla zmiennych numerycznych patrzac na ich parametry
# min, max, srednia oraz mediane rowniez szeroki zakres wartosci

# Wyswietlenie wszystkich wartosci zmiennej czynnikowej "CHILD"
# Są tylko 2 wartości: "Y" oraz "N"
table(select(Wesbrook, CHILD))

# Wyswietlenie udzialu procentowego zmiennej czynnikowej "CHILD"
prop.table(table(select(Wesbrook, CHILD)))

# Wyswietlenie wszystkich wartosci zmiennej czynnikowej "EA"
# Występuje zazwyczaj raz, czasami się powtarza
table(select(Wesbrook, EA))

# Wyswietlenie udzialu procentowego zmiennej czynnikowej "EA"
prop.table(table(select(Wesbrook, EA)))

# Sumuje sie do 1 (100%)
sum(prop.table(table(select(Wesbrook, EA))))

# Wyswietlenie statystyk dla zmiennej czynnikowej  "MARITAL"
# Jest ich 955 (cases in table) i odnosi się do 1 zmiennej (factors) - "MARITAL" 
Wesbrook %>%
  select(MARITAL) %>%
  table() %>%
  summary()

# Wyswietlenie statystyk dla zmiennej czynnikowej  "MARITAL", ale tylko
# dla wierszy, ktore mają wartość "CHILD" ustawiona na "Y"
# Jest ich 46 (cases in table) i odnosi się do 1 zmiennej (factors) - "MARITAL" 
Wesbrook %>%
  filter(CHILD == "Y") %>%
  select(MARITAL) %>%
  table() %>%
  summary()

# Wyswietlenie wszystkich wartosci zmiennej czynnikowej "MARITAL"
Wesbrook %>%
  select(MARITAL) %>%
  table()

# Wyswietlenie wszystkich wartosci zmiennej czynnikowej "MARITAL", ale tylko
# dla wierszy, ktore mają wartość "CHILD" ustawiona na "Y"
Wesbrook %>%
  filter(CHILD == "Y") %>%
  select(MARITAL) %>%
  table()

# Wyswietlenie udzialu procentowego zmiennej czynnikowej "MARITAL", ale tylko
# dla wierszy, ktore mają wartość "CHILD" ustawiona na "Y"
Wesbrook %>%
  filter(CHILD == "Y") %>%
  select(MARITAL) %>%
  table() %>%
  prop.table()

# Wyswietlenie srednich dochodow dla regionow majacy kod zaczynajacy sie od "59"
Wesbrook %>%
  filter(startsWith(as.character(EA), "59")) %>%
  summarise(avg_income = mean(AVE_INC, na.rm = TRUE))


#############################################################################################
# 3. Dokonac analizy istotnosci zmiennych , utworzyc nowy zbior Wesbrook2 zawierajacy tylko #
# istotne zmienne.                                                                          #
#############################################################################################


# Lista nieistotnych zmiennych:
# 1. ID - sluzy tylko do identyfikacji wierszy
# 2. BIGBLOCK - posiada same wartosci "N", zaden nie bierze udziału w programie BIGBLOCK
# 3. MAJOR1 - znaczna wiekszosc wierszy nie ma przypisanej wartosci
# 4. MOV_DWEL - prawie wszystkie wartosci sa bliskie zeru

# Stworzenie nowego zbioru Wesbrook2 pomijajacy nieistotne zmienne ze zbioru Wesbrook
Wesbrook2 <- select(Wesbrook, -ID, -MAJOR1, -MOV_DWEL)


#################################################################################################
# 4. Wykonac wizualna analize danych, w ramach analizy wizualnej rozklad zmiennych numerycznych #
# przedstawic na jednym wykresie macierzowym uzywajac histogramow                               #
#################################################################################################


# Filtracja i wybranie tylko zmiennych numerycznych z zbioru Wesbrook2
Wesbrook2_numeric <- Wesbrook2 %>% select_if(is.numeric)

# Tworzenie z wykorzystaniem biblioteki GGally wykresu macierzowego z histogramami dla każdej zmiennej numerycznej
ggpairs(Wesbrook2_numeric, 
        diag = list(continuous = "barDiag"),
        lower = list(continuous = "blank"),
        upper = list(continuous = "blank"),
        title = "Macierz histogramów zmiennych numerycznych zbioru Wesbrook")

# Tworzenie histogramów z uzyciem facet_wrap do wyswitlenia ich na calym widoku
ggplot(
  Wesbrook2_numeric %>%
    pivot_longer(cols = everything(), names_to = "Variable", values_to = "Value"),
  aes(x = Value)
  ) +
  labs(title = "Histogramy zmiennych numerycznych zbioru Wesbrook") +
  geom_histogram() +
  facet_wrap(~ Variable, scales = "free")


##########################################################################################
# 5. Przygotowac dane do analizy w tym celu:                                             #
#  - dokonac imputacji brakujacych wartosci                                              #
#  - normalizacji zmiennych numerycznych metoda z-score i min-max                        #
#  - wykonac kodowanie zero jedynkowe (wprowadzic zmienne sztuczne) dla zmiennej MARTIAL #
#  - wykonac probkowanie warstwowe dzielac zbior na treningowy i walidacyjny w proporcji #
#  80 % do 20% wedlug zmiennej WESBROOK                                                  #
##########################################################################################


# tworzenie kopii zbioru wesbrook
Wesbrook_prepare <- Wesbrook


#  - dokonac imputacji brakujacych wartosci


# sprawdzenie liczby brakujacych wartosci dla zbioru Wesbrook
colSums(is.na(Wesbrook))

# Wykonanie imputacji dla zmiennej numerycznej "FRSTYEAR" za pomocą mediany
# mutate(FRSTYEAR, (...)) -> dokonaj imputacji dla zmiennej "FRSTYEAR"
# ~ifelse(is.na(.), (...), .) -> jesli jest pusty (is.na(.)) to przypisz mu wartosc, jesli nie to pozostaw taka jaka jest
# mean(., na.rm = TRUE) -> obliczanie sredniej arytmetycznej (mean) dla niepustych (na.rm = TRUE) wartosci
Wesbrook_prepare <- Wesbrook_prepare %>%
  mutate(FRSTYEAR = ifelse(is.na(FRSTYEAR), median(FRSTYEAR, na.rm = TRUE), FRSTYEAR))

# Wykonanie imputacji dla pozostalych zmiennych numerycznych za pomocą sredniej arytmetycznej
# mutate_if(is.numeric, (...)) -> dokonaj imputacji jesli zmienna ma wartosc numeryczna (is.numeric)
# ~ifelse(is.na(.), (...), .) -> jesli jest pusty (is.na(.)) to przypisz mu wartosc, jesli nie to pozostaw taka jaka jest
# mean(., na.rm = TRUE) -> obliczanie sredniej arytmetycznej (mean) dla niepustych (na.rm = TRUE) wartosci
Wesbrook_prepare <- Wesbrook_prepare %>%
  mutate_if(is.numeric, ~ifelse(is.na(.), mean(., na.rm = TRUE), .))

# Wykonanie imputacji dla zmiennych kategorii za pomocą najczesciej wystepujacej wartosci
# mutate_if(is.factor, (...)) -> dokonaj imputacji jesli zmienna jest zmienna kategorii (is.factor)
# ~ifelse(is.na(.), (...), .) -> jesli jest pusty (is.na(.)) to przypisz mu wartosc, jesli nie to pozostaw taka jaka jest
# names(...) -> wyznaczenie nazwy kategorii o największej liczbie wystąpień
# which.max(...) -> wyznaczenie indeksu najczęściej występującej wartości w tej tabeli.
# table(.) -> utworzenie tabeli częstości, zliczającej liczbę wystąpień każdej kategorii w danej kolumnie.
# as.character() -> konwersja indeksu najwczesciej wystepujacej zmiennej do postaci znakowej, aby moc ja przypisac
Wesbrook_prepare <- Wesbrook_prepare %>%
  mutate_if(is.factor, ~ifelse(is.na(.), as.character(names(which.max(table(.)))), as.character(.)))

# Wykonanie imputacji dla zmiennej "INDUPDT" wstawiajac w jej miejsce dzisiejsza date
Wesbrook_prepare <- Wesbrook_prepare %>%
  mutate(INDUPDT = ifelse(is.na(INDUPDT), Sys.Date(), INDUPDT))

# Wykonanie imputacji dla zmiennej "EA" wstawiajac region domyslny "12345678"
Wesbrook_prepare <- Wesbrook_prepare %>%
  mutate(EA = ifelse(is.na(EA), "12345678", EA))

# sprawdzenie liczby brakujacych wartosci po ich ich wypelnieniu, kazda kolumna powinna miec 0 brakujacych wartosci
colSums(is.na(Wesbrook_prepare))


#  - normalizacji zmiennych numerycznych metoda z-score i min-max


# Standaryzacja (z-score) zmiennej numerycznej "AVE_INC"
# oblicza srednia oraz odchylenie standardowe, a nastepnie wstawia wynik tej
# operacji: wartosc_znormalizowana = (wartosc - srednia) / odchylenie
Wesbrook_prepare <- Wesbrook_prepare %>%
  mutate(AVE_INC, scale)

# Skalowanie min-max zmiennej numerycznej "TOTLGIVE"
# oblicza wartosc minimalna oraz maksymalna, a nastepnie wstawia wynik tej
# operacji: wartosc_znormalizowana = (wartosc - min) / (max - min)
Wesbrook_prepare <- Wesbrook_prepare %>%
  mutate(TOTLGIVE = (TOTLGIVE - min(TOTLGIVE)) / (max(TOTLGIVE) - min(TOTLGIVE)))


#  - wykonac kodowanie zero jedynkowe (wprowadzic zmienne sztuczne) dla zmiennej MARTIAL
# "one-hot encoding"

# Tworzenie matrycy ze zmiennymi logicznymi dla kazdej wartosci zmiennej "MARITAL"
# model.matrix -> utworzenie macierzy projektowej z zadanej formuly
# ~ MARITAL -> tworzenie macierzy na podstawie zmiennej "MARITAL"
# - 1 -> zadna kolumna nie bedzie traktowana jako odniesienie, dzieki czemu kazda wartosc bedzie miala osobna kolumne
# data = Wesbrook_prepare -> wskazanie na zrodlo danych do utworzenia kolumn
marital_vars <- model.matrix(~ MARITAL - 1, data = Wesbrook_prepare)

# Zmiana nazw kolumn z formatu zmiennawartosc na zmienna_wartosc
# colnames -> pobranie biezacych nazw kolumn
# paste(..., ..., sep = "_") - laczy lancuchy znakow wstawiajac miedzy nimi znaki z argumentu "sep"
# sub("MARITAL", "", colnames(marital_vars)) -> usuwa tekst "MARITAL" z nazwy kolumny
colnames(marital_vars) <- paste("MARITAL", sub("MARITAL", "", colnames(marital_vars)), sep = "_")

# Dodanie kolumn do zbioru
# cbind -> laczy zbiory kolumnowo tak, ze Wesbrook_prepare otrzyma wartosci logiczne w ramach kolumn od marital_vars 
Wesbrook_prepare <- cbind(Wesbrook_prepare, marital_vars)

# * Wersja alternatywna (prostrza), reczne dodanie kolumny dla kazdej wartosci po poprzednim sprawdzeniu jakie wystepuja
# table(select(Wesbrook, MARITAL))  #   M   W   S   D   G 
# Wesbrook_prepare <- Wesbrook_prepare %>%
#   mutate(
#     MARITAL_D = if_else(MARITAL == "D", 1, 0),
#     MARITAL_G = if_else(MARITAL == "G", 1, 0),
#     MARITAL_M = if_else(MARITAL == "M", 1, 0),
#     MARITAL_S = if_else(MARITAL == "S", 1, 0),
#     MARITAL_W = if_else(MARITAL == "W", 1, 0)
#   )


#  - wykonac probkowanie warstwowe dzielac zbior na treningowy i walidacyjny w proporcji
#  80 % do 20% wedlug zmiennej WESBROOK

# Ustalanie ziarna dla powtarzalnosci wynikow
set.seed(123) 

# Tworzenie losowego zbioru treningowego (80%)
# createDataPartition -> utworzenie podzialu warstwowego na podstawie zadanej kolumny
# Wesbrook_prepare$WESBROOK -> zbior danych do podzialu warstwowego
# p = 0.8 -> proporcja podzialu (80%)
# list = FALSE -> funcja nie zwraca listy, tylko indeksy do utworzenia zbioru
train_indexes <- createDataPartition(Wesbrook_prepare$WESBROOK, p = 0.8, list = FALSE)

# Tworzenie zbioru treningowego na podstawie zebranej listy indeksow
train_data <- Wesbrook_prepare[train_indexes, ]

# Tworzenie zbioru walidacyjnego na podstawie dopelnienia zbioru treningowego
validation_data <- Wesbrook_prepare[-train_indices, ]


##################
# KONIEC ZADANIA #
##################

set.seed(1234)
sample_set <- sample.split(Wesbrook2$WESBROOK, SplitRatio = 0.8)
Wesbrook_learning <- subset(Wesbrook2, sample_set == TRUE)
Wesbrook_testing <- subset(Wesbrook2, sample_set == FALSE)

# Ustalanie ziarna dla powtarzalnosci wynikow
set.seed(1234) 

# Tworzenie zbioru treningowego (80%)
# sample.split -> podział danych przy zachowaniu proporcji klas
# Wesbrook_prepare$WESBROOK -> zbior danych do podzialu warstwowego
# SplitRatio = 0.8 -> proporcja podzialu (80%)
sample_set <- sample.split(Wesbrook2$WESBROOK, SplitRatio = 0.8)

# Tworzenie zbioru treningowego na podstawie zebranej listy indeksow
Wesbrook_train <- subset(Wesbrook2, sample_set == TRUE)

# Tworzenie zbioru walidacyjnego na podstawie dopelnienia zbioru treningowego
Wesbrook_validation <- subset(Wesbrook2, sample_set == FALSE)
