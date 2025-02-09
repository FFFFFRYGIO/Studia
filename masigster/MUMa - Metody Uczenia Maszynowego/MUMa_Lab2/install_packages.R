packageSet <- c("car", "abind", "aplpack", "colorspace", "effects", "Hmisc",
  "leaps", "zoo", "lmtest", "mvtnorm", "multcomp", "relimp", "rgl", "RODBC",
  "clv", "rpart.plot", "flexclust", "e1071", "sem", "Rcmdr","foreign","tree","rpart","rattle","ipred","randomForest","dplyr","sqldf","genalg","corrplot","caret","nnet","RSNNS","NeuralNetTools","devtools","kohonen","tidyverse","caTools","XLConnect","neuralnet")
install.packages(packageSet)
rm(packageSet)


# Instalacja bilbiotek
packageSet <- c("car", "abind", "aplpack", "colorspace", "effects", "Hmisc",
                "leaps", "zoo", "lmtest", "mvtnorm", "multcomp", "relimp", "rgl", "RODBC",
                "clv", "rpart.plot", "flexclust", "e1071", "sem", "Rcmdr", "foreign", "tree", 
                "rpart", "rattle", "ipred", "randomForest", "dplyr", "sqldf", "genalg", 
                "corrplot", "caret", "nnet", "RSNNS", "NeuralNetTools", "devtools", "kohonen", 
                "tidyverse", "caTools", "XLConnect", "neuralnet", "GGally")
for (pkg in packageSet) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    # install.packages(pkg)
  }
}
rm(packageSet)


install.packages("BCA")
