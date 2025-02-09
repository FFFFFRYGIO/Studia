# Wyłączenie ostrzerzeń w ramach skryptu
options(warn = -1)

# Zimportowanie bibliotek
library(BCA)
library(relimp)
library(car)
library(RcmdrMisc)
library(sqldf)

# Zaimportowanie zbioru bank
Bank <-read.csv("http://jolej.linuxpl.info/bank.csv", header=TRUE, sep = ";")

# Tworzenie zbioru walidacyjnego i estymacyjnego
Bank$Sample <- create.samples(Bank, est = 0.7, val = 0.3)

# Obejrzyj zbi?r zobacz nowo dodana zmiena Sample
showData(Bank)

# Utworzenie zmiennej numerycznej na podstawie zmiennej czynnikowej y
Bank <- within(Bank, {
  y.Num <- Recode(y, '"yes"=1; "no"=0', as.factor=FALSE)
})

# Wykres rozkladu zmiennych
scatterplot(y.Num~balance, reg.line=lm, smooth=TRUE, 
            id.n = 2, boxplots='xy', span=0.5, data=Bank)

# Przedzialowsanie zmiennej numerycznej
Bank$balance.cat <- with(Bank, bin.var(balance, bins=4, method='proportions',
                                       labels=NULL))

# Wykres srednich dla balance.cat
with(Bank, plotMeans(y.Num, balance.cat, error.bars="none"))

# Wykres srednich dla zmiennej education
with(Bank, plotMeans(y.Num, education, error.bars="none"))

#Przeorganizowanie poziom?w dla zmienej education
Bank$Neducation <- relabel.factor(factor(Bank$education), new.labels=c('UNK','2ND','PRI','TER'))
with(Bank, plotMeans(y.Num, Neducation))

# Sprawdz rodzaj zaleznosci (liniowa nieliniowa dla pozostalych zmiennych numerycznych
numeric_vars <- setdiff(names(Bank)[sapply(Bank, is.numeric)], "y.Num")
for (var in numeric_vars) {
  scatterplot(as.formula(paste("y.Num ~", var)), reg.line = lm, smooth = TRUE, 
              id.n = 2, boxplots = "xy", span = 0.5, data = Bank,
              main = paste("Scatterplot for", var))
}

# Analizując wykresy wszystkie zmienne wyglądają na zależność nieliniową
# Nie da się wyznaczyć linii trendu

# Uog?lniony model liniowy
GLM.2 <- glm(y.Num ~ age + job + marital + education + default + balance +
               housing + loan + contact + day + month + duration + campaign +
               pdays + previous + poutcome, family=binomial(logit), data=Bank)
summary(GLM.2)

# Wsp?lczynnik R2 McFaddena
1 - (GLM.2$deviance/GLM.2$null.deviance) # McFadden R2

# Budowa modelu nieliniowego

# sprawdzanie czy zmienne nie posiadaja wartosci zerowych
colSums(Bank==0)

# W przypadku zmiennej previous uzywamy log(X+n)
Bank$LogAge <- with(Bank, log(age))
Bank$LogDay <- with(Bank, log(day))
Bank$LogDuration <- with(Bank, log(duration))
Bank$LogCampaign <- with(Bank, log(campaign))
Bank$LogPrevious <- with(Bank, log(previous+4))

# Tworzenie modelu nieliniowego
LogBank <- glm(y.Num ~ LogAge + LogDay + LogDuration + 
                 LogCampaign + LogCampaign + LogPrevious, family=binomial(logit), 
              data=Bank, subset=Sample=="Estimation")
summary(LogBank)
1 - (LogBank$deviance/LogBank$null.deviance) # McFadden R2

# Sprawdzanie istotnosci zmiennych czynnikowych
Anova(LogBank)

#  Budowa modelu mieszanego

MixedBank <- glm(y.Num ~ LogAge + job + marital + education + default + balance +
                   housing + loan + contact + LogDay + month + LogDuration + LogCampaign +
                   pdays + LogPrevious + poutcome, family=binomial(logit), data=Bank, 
                subset=Sample=="Estimation")
summary(MixedBank)
1 - (MixedBank$deviance/MixedBank$null.deviance) # McFadden R2
