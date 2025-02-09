# Zimportowanie bibliotek
library('car')
library('RcmdrMisc')
library('sandwich')
library('relimp')
library('corrplot')

# Zaimportowanie zbiorów Day oraz Hour
Day<-read.csv("http://jolej.linuxpl.info/day.csv", header=TRUE)
Hour<-read.csv("http://jolej.linuxpl.info/hour.csv", header=TRUE)

# Wybór zmiennej zależnej
target_variable_day <- Day$cnt
target_variable_day_name <- colnames(Day)[which(sapply(Day, identical, target_variable_day))]
plot(as.Date(Day$dteday), target_variable_day)

target_variable_hour <- Hour$cnt
target_variable_hour_name <- colnames(Hour)[which(sapply(Hour, identical, target_variable_hour))]
plot(as.Date(Hour$dteday), target_variable_hour)

# Po wyświetleniu wykresów zmiennej cnt dla obu zbiorów widać, że Hours posiada znacznie więcej punktów, dużo z nich o bardzo niskich wartościach
# Wynika to z tego, że rejestrując co godzinę rejestruje również godziny nocne, w których liczba wypożyczeń jest praktycznie znikoma
# Dlatego przy dalszej analizie skupię się na zbiorze Day

# Sprawdzenie wszystkich zmiennych
variable.summary(Day)

# Po analize podsumowania stwierdzam, ze zmienne nie posiadaja wartosci null
# odchylenia standardowe są bardzo małe, żadna z nich nie wskazuje na to, żeby miała mieć dużą istotność

# Określenie wartości logicznej dla każdej kolumny czy jest numeryczna (prawda jeśli tak, fałsz jeśli nie)
numeric_vars <- sapply(Day, is.numeric)
# Wybranie na podstawie numeric_vars samych kolumn o wartościach numerycnzych
numeric_vars_names <- names(
  numeric_vars[
    numeric_vars == TRUE 
    & names(numeric_vars) != target_variable_day_name
    & names(numeric_vars) != "casual"
    & names(numeric_vars) != "registered"])
# Stworzenie formuły do listowania zmiennych numerycznych dla wykresu
numeric_vars_formula <- as.formula(paste("~", paste(numeric_vars_names, collapse = "+")))

# Wykres macierzowy
# numeric_vars_day_formula - lista zmiennych do analizy
# reg.line=lm - dodanie linii regresji liniowej
# smooth=TRUE - dodanie wygładzonej linii regresji na wykresach rozrzutu
# spread=FALSE - wyłączenie rysowania wykresu odchylenia standardowego wokół linii regresji
# span=0.5 - wykorzystanie 50% danych lokalnych do obliczenia krzywej wygładzenia
# id.n=0 - wyłączenie etykietowania abserwacji odstających
# diagonal='boxplot' - rodzaj wizualizacji na przekątnych w postaci wykresu pudełkowego
# data=Day - dane wejściowe do wykresu
scatterplotMatrix(numeric_vars_formula,
                  reg.line=lm, smooth=TRUE, spread=FALSE, span=0.5, id.n=0, 
                  diagonal = 'boxplot', data=Day)

# Wykresy pokazują, że rozkład zmiennych jest bardzo zróżnicowany
# Widać po nich również jak zmieniają się warunki w zależności od czasu:
# - season - zdarza się cyklicznie
# - holiday - wakacje są raz w roku
# - temp/atemp - temperatura zmienia się w zależności od pory roku
# - windspeed - duży w jednej porze roku, w inne mniejszy

# wykres punktowy
# target_variable_day~temp - określa zmienne do wykresu
# reg.line=lm - dodanie linii regresji liniowej
# smooth=TRUE - dodanie wygładzonej linii regresji na wykresach rozrzutu
# spread=FALSE - wyłączenie rysowania wykresu odchylenia standardowego wokół linii regresji
# id.method='mahal' - użycie odległości Mahalanobisa do wykrycia obserwacji i etykierowania obserwacji odstających
# id.n = 2 - określenie liczby obserwacji odstających do etykierowania
# boxplots='xy' - rysuje wykresy pudełkowe wzdłuż osi x i y
# span=0.5 - szerokość okna dla krzywej wygłaszenia
# data=Day - dane wejściowe do wykresu
scatterplot(target_variable_day~temp, reg.line=lm, smooth=TRUE, spread=FALSE, id.method='mahal', id.n = 2, boxplots='xy', span=0.5, data=Day)

# Wraz ze wzrostem temperatury rośnie liczba wypożyczeń, stabilizuje się po pewnej wartości
# rośnie również niepewność względem dalszych przewidywań (inaczej szansa, że regresja będzie zgodna z danymi)

# Zbudowa? wykresy dla kombinacji zmiennej zależnej i posta?ych zmiennych nie czynnikowych
# Pętla po wszystkich koumnach numerycznych
for (var in numeric_vars_names) {
  # Tworzenie wykresu rozrzutu
  # Day[[target_variable_day_name]] - zmienne dla osi x
  # Day[[var]] - iterowana zmienna
  # main = paste(target_variable_day_name, "vs", var) - tytuł wykresu
  # xlab = target_variable_day_name - etykieta osi x
  # ylab = var - etykieta osi y
  plot(Day[[target_variable_day_name]], Day[[var]], main = paste(target_variable_day_name, "vs", var), xlab = target_variable_day_name, ylab = var)
}

# wnioski z analizy wykresów i ocena przewidywanego wpływu na zmienną zależną
# cnt vs czas (season, yr, mnth, holiday, weekday, workingday): pora roku i czy dzień pracujący mają wpływ na liczbę wypożyczeń - duży wpływ
# cnt vs weathersit: rodzaj pogody ma wpływ na liczbę wypożyczeń - duży wpływ
# cnt vs temperatura (temp, atemp): wzrost temperatury powoduje wzrost liczby wypożyczeń - duży wpływ
# cnt vs hum: nieznacznie mniejsze wypżyczenie przy zwiększonej wilkgotności - mały wpływ
# cnt vs windspeed: nieznacznie mniejsze wypżyczenie przy zwiększonym wietrze - mały wpływ

# Wykres liniowy
# with umożliwia odwołąnie się do kolumn ramki bez ich listowania poprzez data$column
with(Day, lineplot(as.Date(Day$dteday), target_variable_day))
# Widać tentencje wzrostowe w miesiące letnie
# Widać jeden duży spadek (majniższy punkt), wynika on z tego, że 2012-10-30 był huragan (Hurricane Sandy)
# Duży pik jest natomiast w marcu, jeden z nich wynika z daty 17 marca, jest to Dzień Świętego Patryka

# Wykres pudełkowy dla podzielonego zbioru cnt na kategorie w zależności od tego czy jest to dzień pracujący
Boxplot(target_variable_day~workingday, data=Day)
# Jak widać liczba wypożyczeń nie różni się znacznie w zależności od tego czy jest to dzień pracujący

# Analiza korelacji zmiennych
# Pakiet corrplot 

# Tworzenie ramki dla zmiennych numerycznych Day
a<-data.frame(Day$cnt, Day$season, Day$yr, Day$mnth, Day$holiday, Day$weekday, Day$workingday, Day$weathersit, Day$temp, Day$atemp, Day$hum, Day$windspeed)

# Tworzenie macierzy korelacji ilościowych dla zmiennych z ramki a
b<-cor(a)
# Tworzenie wykresów koleracji - wizualizacja w postaci kół, których
# kolory i wielkośc mówią o sile i kierunku korelacji
corrplot(b)
corrplot(b, method="number")  # w formie liczb w macierzy
corrplot(b, method="color")  # w formie gradientu kolorów
corrplot(b, method="pie")  # w formie części koła
corrplot(b, method="square")  # w formie kolorowyc kwadratów
corrplot(b, method="ellipse")  # W formie elips - im bardziej wydłużone tym silniejsza korelacja

# Widać różne formy graficzne prezentujące te same dane
# Dla tych danych najbardziej przejrzysty wydaje się numeryczny
# Widac, ze najsilniejsza korelacje ze zmienna cnt mają zmienne temp oraz atemp (jest ona pozytywna)
# Spośród negatywnych korelacji największa jest dla weathersit

# Model regresji liniowej
Day.model1 <- lm(target_variable_day ~ yr + mnth + holiday + weekday + workingday + weathersit + temp + atemp + hum + windspeed, data=Day)
summary(Day.model1)


# Tablica ANOVA
# Sprawdzenie istotno?ci zmiennych czynnikowych
# Tablica Anova jesy używana do oceny dopasowania modelu do danych
# Co zawiera:
# - Sum Sq - suma kwadratów odchyleń, im wyższa wartość, tym większy wpływ czynnika na zmienność danych
# - Df - liczba stopni swobody
# - value - średnia kwadratów, (suma kwadratów)/(stopnie swobody)
# - Pr(>F) - Prawodopobieństwo uzyskania ekstremalnych wyników
Anova(Day.model1)


# Dokona? redukcji zmiennych zwa?aj?? na wsp??czynnik R kwadrat

# Wyznaczam zmienne mające najwyższy poziom istotniości (wysokie Pr(>F)):
# workingday: 0.1038436
# temp: 0.1931140
# atemp: 0.0120107
# Dokonuję redukcji przez ponowne utworzenie modelu z pominięciem tych 2 zmiennych
Day.model1 <- lm(target_variable_day ~ yr + mnth + holiday + weekday + weathersit + hum + windspeed, data=Day)
summary(Day.model1)
Anova(Day.model1)

# Model nieliniowy

# Sprawdzenie liczby wartosci zerowych dla kazdej kolumny
colSums(Day==0)

# Sprawdzenie liczby wystąpień, w tym wartości zerowych
table(Day$yr)  # wartości logiczne, na rzecz modelu logicznego wartość roku 2011 (0) zostanie zamieniona na 2
table(Day$holiday)  # wartości logiczne, na rzecz modelu logicznego wartość braku wakacji (0) zostanie zamieniona na 2
table(Day$weekday)  # Numer dnia, na rzecz modelu logicznego dzień o numerze 0 będzie mieć przypisaną wartość 7
table(Day$workingday)  # wartości logiczne, na rzecz modelu logicznego wartość dnia niepracującego (0) zostanie zamieniona na 2
table(Day$hum)  # wilgotność, na rzecz modelu logicznego jedna obserwacja o wartości 0 zostanie usunięta

DayForNonLinear <- Day
DayForNonLinear$yr <- ifelse(DayForNonLinear$yr == 0, 2, DayForNonLinear$yr)  # Zamiana 0 na 2 w 'yr'
DayForNonLinear$holiday <- ifelse(DayForNonLinear$holiday == 0, 2, DayForNonLinear$holiday)  # Zamiana 0 na 2 w 'holiday'
DayForNonLinear$weekday <- ifelse(DayForNonLinear$weekday == 0, 7, DayForNonLinear$weekday)  # Zamiana 0 na 7 w 'weekday'
DayForNonLinear$workingday <- ifelse(DayForNonLinear$workingday == 0, 2, DayForNonLinear$workingday)  # Zamiana 0 na 2 w 'workingday'
DayForNonLinear <- subset(DayForNonLinear, hum > 0)  # Usunięcie obserwacji z wartością 0 w 'hum'

# Logarytmowanie zmiennych ci?g?ych
# Dla wybranych kolumn przypisuje jej wartosc logarytmiczna
DayForNonLinear$log.cnt <- with(DayForNonLinear, log(cnt))
DayForNonLinear$log.yr <- with(DayForNonLinear, log(yr))
DayForNonLinear$log.mnth <- with(DayForNonLinear, log(mnth))
DayForNonLinear$log.holiday <- with(DayForNonLinear, log(holiday))
DayForNonLinear$log.weekday <- with(DayForNonLinear, log(weekday))
DayForNonLinear$log.workingday <- with(DayForNonLinear, log(workingday))
DayForNonLinear$log.weathersit <- with(DayForNonLinear, log(weathersit))
DayForNonLinear$log.temp <- with(DayForNonLinear, log(temp))
DayForNonLinear$log.atemp <- with(DayForNonLinear, log(atemp))
DayForNonLinear$log.hum <- with(DayForNonLinear, log(hum))
DayForNonLinear$log.windspeed <- with(DayForNonLinear, log(windspeed))

# Budowa modelu nieliniowego
Non.LinearModel.2 <- lm(log.cnt ~ log.yr + log.mnth + log.holiday + log.weekday + log.workingday + log.weathersit + log.temp + log.atemp + log.hum + log.windspeed, data=DayForNonLinear)
summary(Non.LinearModel.2)

# Dokona? redukcji zmiennych zwa?aj?? na wsp??czynnik R kwadrat

# Tablica ANOVA
# Sprawdzenie istotno?ci zmiennych czynnikowych
# Tablica Anova jesy używana do oceny dopasowania modelu do danych
# Co zawiera:
# - Sum Sq - suma kwadratów odchyleń, im wyższa wartość, tym większy wpływ czynnika na zmienność danych
# - Df - liczba stopni swobody
# - value - średnia kwadratów, (suma kwadratów)/(stopnie swobody)
# - Pr(>F) - Prawodopobieństwo uzyskania ekstremalnych wyników
Anova(Non.LinearModel.2)

# Wyznaczam zmienne mające najwyższy poziom istotniości (wysokie Pr(>|t|)):
# log.holiday: 0.13177
# log.weekday: 0.10152
# log.workingday: 0.01262
# log.temp: 0.06015
# log.atemp: 0.15772
# Dokonuję redukcji przez ponowne utworzenie modelu z pominięciem tych 2 zmiennych
Non.LinearModel.2 <- lm(log.cnt ~ log.yr + log.mnth + log.weathersit + log.hum + log.windspeed, data=DayForNonLinear)
summary(Non.LinearModel.2)
Anova(Non.LinearModel.2)

# ?wiczenie 
# Prosz? dokona? redukcji zmiennych dla obydwu modeli, wybra? najlepszy.

# Porównanie wartości współczynnika R^2:
summary(Day.model1)$r.squared  # 0.5178787
summary(Non.LinearModel.2)$r.squared  # 0.4672008

# Wnioski podczas analizy porównawczej modeli:
# 1. Obydwa modele wykluczyły te same zmienne
# 2. Obydwa modele dokonały tej samej oceny poziomu istotności zmiennych
# 3. Analizując sumy kwadratów znacznie łatwiej porównuje się ich wpływ dla modelu nieliniowego

# Wartość współczynnika R^2 pokazuje, że model liniowy lepiej dopasowuje się do danych, więc jest on lepszy

