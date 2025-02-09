# Zimportowanie bibliotek
library('BCA')
library('car')
library('RcmdrMisc')
library('sandwich')
library('relimp')
library('corrplot')

# Zaimportowanie zbioru Eggs
data(Eggs, package="BCA")

# Sprawdzenie wszystkich zmiennych
variable.summary(Eggs)

# Po analize podsumowania stwierdzam, ze zmienne nie posiadaja wartosci null
# odchylenie standardowe jest największe dla Pork.Pr, co może sugerować, że 
# będzie miała ona dużą istotność i większy potencjał do wyjaśnienia zróżnicowania w zmiennej zależnej

# Wykres macierzowy
# ~Beef.Pr+Cases+Cereal.Pr+Chicken.Pr+Egg.Pr+Pork.Pr - lista zmiennych do analizy
# reg.line=lm - dodanie linii regresji liniowej
# smooth=TRUE - dodanie wygładzonej linii regresji na wykresach rozrzutu
# spread=FALSE - wyłączenie rysowania wykresu odchylenia standardowego wokół linii regresji
# span=0.5 - wykorzystanie 50% danych lokalnych do obliczenia krzywej wygładzenia
# id.n=0 - wyłączenie etykietowania abserwacji odstających
# diagonal='boxplot' - rodzaj wizualizacji na przekątnych w postaci wykresu pudełkowego
# data=Eggs - dane wejściowe do wykresu
scatterplotMatrix(~Beef.Pr+Cases+Cereal.Pr+Chicken.Pr+Egg.Pr+Pork.Pr,
                  reg.line=lm, smooth=TRUE, spread=FALSE, span=0.5, id.n=0, 
                  diagonal = 'boxplot', data=Eggs)

# Wykresy pokazują, że rozkład zmiennych ma wartość maksymalną, która 
# następnie ma tendencję malejącą w obie srony. Wyjątkiem są Cereal.Pr z dużo mniejszym maximum lokalnym
# oraz Pork.Pr z podobnie dużymi maximum lokalnymi

# wykres punktowy
# Cases~Egg.Pr - określa zmienne do wykresu
# reg.line=lm - dodanie linii regresji liniowej
# smooth=TRUE - dodanie wygładzonej linii regresji na wykresach rozrzutu
# spread=FALSE - wyłączenie rysowania wykresu odchylenia standardowego wokół linii regresji
# id.method='mahal' - użycie odległości Mahalanobisa do wykrycia obserwacji i etykierowania obserwacji odstających
# id.n = 2 - określenie liczby obserwacji odstających do etykierowania
# boxplots='xy' - rysuje wykresy pudełkowe wzdłuż osi x i y
# span=0.5 - szerokość okna dla krzywej wygłaszenia
# data=Eggs - dane wejściowe do wykresu
scatterplot(Cases~Egg.Pr, reg.line=lm, smooth=TRUE, spread=FALSE, id.method='mahal', id.n = 2, boxplots='xy', span=0.5, data=Eggs)

# Wraz ze wzrostem cen jajek maleje liczba przypadków (umiarkowana negatywna korelacja)
# maleje również niepewność względem dalszych przewidywań (szansa, że regresja będzie zgodna z danymi)

# Zbudowa? wykresy dla kombinacji zmiennej Cases i posta?ych zmiennych nie czynnikowych
# Określenie wartości logicznej dla każdej kolumny czy jest numeryczna (prawda jeśli tak, fałsz jeśli nie)
numeric_vars <- sapply(Eggs, is.numeric)
# Wybranie na podstawie numeric_vars samych kolumn o wartościach numerycnzych
numeric_vars_names <- names(numeric_vars[numeric_vars == TRUE & names(numeric_vars) != "Cases"])
# Pętla po wszystkich koumnach numerycznych
for (var in numeric_vars_names) {
  # Tworzenie wykresu rozrzutu
  # Eggs$Cases - zmienne dla osi x
  # Eggs[[var]] - iterowana zmienna
  # main = paste("Cases vs", var) - tytuł wykresu
  # xlab = "Cases" - etykieta osi x
  # ylab = var - etykieta osi y
  plot(Eggs$Cases, Eggs[[var]], main = paste("Cases vs", var), xlab = "Cases", ylab = var)
}

# wnioski z analizy wykresów i ocena przewidywanego wpływu na zmienną Cases
# Cases vs Egg.Pr: Wraz ze wzrostem cen liczba przypadków maleje - możliwy istotny wpływ
# Cases vs Beef.Pr: Rozkład rozproszony - mały wpływ
# Cases vs Pork.Pr: Niewielka tendencja negatywna - mały wpływ
# Cases vs Chicken.Pr: Rozkład rozproszony - mały wpływ
# Cases vs Cereal.Pr: Rozkład rozproszony - mały wpływ

# Wykres liniowy
# with umożliwia odwołąnie się do kolumn ramki bez ich listowania poprzez data$column
with(Eggs, lineplot(Week, Cases))
# Widać duży pik w jednym w tygodni, prawdopodobnie chodzi o wielkanoc

# Wykres liniowy wykluczający wielkanoc
non_easter_data <- subset(Eggs, Easter == "Non Easter")
with(non_easter_data, lineplot(Week, Cases))

# Podsumowując obydwa wykresy, widać zmiennośc liczby przypadków w poszczególnych tygodniach
# Wykluczając wielkanoc, nie ma widać, żeby przypadki miały jakiś silnie dominujący wzrost lub spadek

# Identyfikacja 40 i 90 tygodnia
# Wyświetlenie danych w tabeli w osobnym, interaktywnym oknie
showData(Eggs)
# Wykres pudełkowy dla podzielonego zbioru Cases na kategorie w zależności od Easter
Boxplot(Cases~Easter, data=Eggs)
# Widać tutaj duży wpływ okresu wielkanocnego na liczbę przypadków

# Analiza korelacji zmiennych
# Pakiet corrplot 

# Tworzenie ramki dla 6 wybranych zmiennych Eggs
a<-data.frame(Eggs$Beef.Pr,Eggs$Cases,Eggs$Cereal.Pr,Eggs$Chicken.Pr,Eggs$Egg.Pr,Eggs$Pork.Pr)
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
# Widac, ze najsilniejsza korelacje ze zmienna Cases ma zmienna Egg.Pr (jest ona negatywna)
# Druga z kolei, również silna, jest Cereal.Pr (również negatywna)

# Por?wnanie cen na jednym wykresie
# Tworzenie macierzy, gdzie kolumny to wymienione zmienne
prices_comp <- cbind(Eggs$Egg.Pr, Eggs$Beef.Pr, Eggs$Pork.Pr, Eggs$Chicken.Pr, Eggs$Cereal.Pr)
# Tworzenie wykresu serii wielu zmiennych na podstawie prices_comp
# lty= 1:1 - Ten sam styl dla kązdej linii
# pch=21:23 - różne stule punktów
# bg=c("black", "yellow", "red", "blue", "green") - kolory markerów
# type="o" - typ wykresu - "overplotted" linie i punkty
# col = "black" - kolor linii
# xlim=c(0, 105) - zakres osi x
# ylim=c(0,  350) - zakres osi y
# xlab = "Time" - etykieta osi x
# ylab = "Price" - etykieta osi y
# main= "COMPARISON OF  PRICES" - tytuł wykresu
matplot(prices_comp,  lty= 1:1, pch=21:23, bg=c("black", "yellow", "red", "blue", "green"),
        type="o", col = "black", xlim=c(0, 105), ylim=c(0,  350),
        xlab = "Time",
        ylab = "Price",
        main= "COMPARISON OF  PRICES")
# Dodanie legendy do wykresu
# "topleft" - położenie legendy
# 1,  95 -  współrzędne punktu początku legendy
# legend=c() -  etykiety legendy
# lty= 1:1 - ten sam styl, ciągła linia
# cex=1 - wielkość czcionki
# col=c() - kolory linii w legendzie
# title="Lines description" - tytuł legendy
# text.font=2 - styl czcionki
# box.lty=2 - linia ramki przerywana
# box.lwd=2 - grubość linii ramki
# box.col="green" - kolor ramki
legend("topleft", 1, 95, legend=c("Eggs price", 
                                  "Beef price", 
                                  "Pork price", 
                                  "Chicken price",
                                  "Cereal price"), 
       lty= 1:1, cex=1, 
       col=c("black", "yellow", "red", "blue", "green"),
       title="Lines description", 
       text.font=2, box.lty=2, box.lwd=2, box.col="green")

# Żaden z produktów nie wykazuje jednolitego trendu spadkowego lub wzrostowego
# Pork.Pr oraz Beef.Pr są najmniej stabilne, co wskazuje na większą wrażliwość na czynniki zewnętrzne
# Egg.Pr oraz Chicken.Pr wykazują bardzo małą zmienność, Cereal.Pr pokazuje niewiekie wachania
# Im mniejsza zmienność, tym większy wpływ na zmienną Cases

# Model regresji liniowej
Eggs.model1 <- lm(Cases ~ Beef.Pr + Cereal.Pr + Chicken.Pr + Easter + Egg.Pr + First.Week + Month + Pork.Pr , data=Eggs)
summary(Eggs.model1)


# Tablica ANOVA
# Sprawdzenie istotno?ci zmiennych czynnikowych
# Tablica Anova jesy używana do oceny dopasowania modelu do danych
# Co zawiera:
# - Sum Sq - suma kwadratów odchyleń, im wyższa wartość, tym większy wpływ czynnika na zmienność danych
# - Df - liczba stopni swobody
# - value - średnia kwadratów, (suma kwadratów)/(stopnie swobody)
# - Pr(>F) - Prawodopobieństwo uzyskania ekstremalnych wyników
Anova(Eggs.model1)


# Dokona? redukcji zmiennych zwa?aj?? na wsp??czynnik R kwadrat

# Wyznaczam zmienne mające najwyższy poziom istotniości (wysokie Pr(>F)):
# Cereal.Pr: 0.0249886
# Chicken.Pr: 0.3536222
# Pork.Pr: 0.5508388
# Dokonuję redukcji przez ponowne utworzenie modelu z pominięciem tych 2 zmiennych
Eggs.model1 <- lm(Cases ~ Beef.Pr + Easter + Egg.Pr + First.Week + Month , data=Eggs)
summary(Eggs.model1)
Anova(Eggs.model1)

# Model nieliniowy

# Sprawdzenie liczby wartosci zerowych dla kazdej kolumny
colSums(Eggs==0)

# Logarytmowanie zmiennych ci?g?ych
# Dla wybranych kolumn przypisuje jej wartosc logarytmiczna
Eggs$log.Cases <- with(Eggs, log(Cases))
Eggs$log.Cereal.Pr <- with(Eggs, log(Cereal.Pr))
Eggs$log.Egg.Pr <- with(Eggs, log(Egg.Pr))
Eggs$log.Chicken.Pr <- with(Eggs, log(Chicken.Pr))
Eggs$log.Beef.Pr <- with(Eggs, log(Beef.Pr))
Eggs$log.Pork.Pr <- with(Eggs, log(Pork.Pr))

# Budowa modelu nieliniowego
Non.LinearModel.2 <- lm(log.Cases ~ log.Beef.Pr + log.Cereal.Pr + log.Chicken.Pr + log.Egg.Pr + log.Pork.Pr + Month + Easter + First.Week, data=Eggs)
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
# log.Cereal.Pr: 0.032076
# log.Chicken.Pr: 0.537223
# log.Pork.Pr: 0.652098
# Dokonuję redukcji przez ponowne utworzenie modelu z pominięciem tych 2 zmiennych
Non.LinearModel.2 <- lm(log.Cases ~ log.Beef.Pr + log.Egg.Pr + Month + Easter + First.Week, data=Eggs)
summary(Non.LinearModel.2)
Anova(Non.LinearModel.2)

# ?wiczenie 
# Prosz? dokona? redukcji zmiennych dla obydwu modeli, wybra? najlepszy.

# Porównanie wartości współczynnika R^2:
summary(Eggs.model1)$r.squared  # 0.8593219
summary(Non.LinearModel.2)$r.squared  # 0.8248077



# Wnioski podczas analizy porównawczej modeli:
# 1. Obydwa modele wykluczyły te same zmienne
# 2. Obydwa modele dokonały tej samej oceny poziomu istotności zmiennych
# 3. Analizując sumy kwadratów znacznie łatwiej porównuje się ich wpływ dla modelu nieliniowego
# 4. 







