#Script Sebastian ML Appendectomy

#Open libraries
library(randomForest)
library(missForest)
library(Hmisc)
library(rms)
library(pROC)

setwd("PATH~ /Appendektomie/ML_Analysis/")
#GPT<- Training<-read.csv("PATH~ /Entscheidung.csv", header = TRUE, sep = ";", quote = "\"", dec = ",", fill = TRUE, comment.char = "", check.names = F)

#Loading and pre-processing data including imputation with missForest
Training<-read.csv("Training.csv", header = TRUE, sep = ";", quote = "\"", dec = ",", fill = TRUE, comment.char = "", check.names = F)
Testing<-read.csv("Testing.csv", header = TRUE, sep = ";", quote = "\"", dec = ",", fill = TRUE, comment.char = "", check.names = F)

Training_Data<-Training[,c("Alter (Jahre)","Körperliche Untersuchung Score", "Temp (°C)", "SBD", "DBD", "Atemfrequenz (/min)", "CRP (mg/dl)", "Leukozyten (/μl)", "US", "CT")]
Testing_Data<-Testing[,c("Alter (Jahre)","Körperliche Untersuchung Score", "Temp (°C)", "SBD", "DBD", "Atemfrequenz (/min)", "CRP (mg/dl)", "Leukozyten (/μl)", "US", "CT")]

Training_Data <- missForest(Training_Data)
Training_Data  <- Training_Data$ximp
Training_Data  <- data.frame(Training_Data)

Testing_Data <- missForest(Testing_Data)
Testing_Data  <- Testing_Data$ximp
Testing_Data  <- data.frame(Testing_Data)

# Define outcome variable (Fachartz Entscheidung)
Outcome_Training <- c(rep(1,50), rep(0,40))
Outcome_Testing <- c(rep(1,13), rep(0,10))

# Train and validate RF model
set.seed(123)
model_rf<-randomForest(Training_Data, y=Outcome_Training)

predictionsTraining <- predict(model_rf, data=Training_Data) 
predictionsTesting <- predict(model_rf, newdata=Testing_Data) 
RocObject_Train <- roc(Outcome_Training, as.numeric(round(predictionsTraining, digits = 0)), ci=TRUE) # Do not round for final result
RocObject_Testing <- roc(Outcome_Testing, as.numeric(round(predictionsTesting, digits = 0)), ci=TRUE) # Do not round for final result
#RocObject_GPT <- roc(GPT$Board_Entscheidung, GPT$Chat_GPT_Entscheidung, plot=T, asp=NA, col = 'blue', lwd=3, legacy.axes=T, print.auc=TRUE)
RocObject_GPT <- roc(GPT$Board_Entscheidung, GPT$Chat_GPT_Entscheidung)

#Generate ROC-plot
MakePlot <-function (RocObject_Train, RocObject_Testing, title)
{
  tiff(filename=title, width= 500, height = 500)
  plot.roc(RocObject_Train, col='red')
  plot.roc(RocObject_Testing, add=TRUE, lty=2, col = 'green')
  
  #legend(0.95, 0.20, c(paste("Training GFO Troisdorf\n(AUC=", ...), paste("Validation GFO Troisorf + UKK Köln\n(AUC=", ...)), col = c('red', 'green'), lty=1, border =FALSE)
  
  legend(0.70,0.20, c(paste('Training GFO Troisdorf\n (AUC=', round(RocObject_Train$auc[1],2), " 95% CI: ", round(RocObject_Train$ci[1],2), "-",round(RocObject_Train$ci[3],2), ")" , sep=""),
                      paste('Validation GFO Troisorf + UKK Cologne\n (AUC=', round(RocObject_Testing$auc[1],2), " 95% CI: ", round(RocObject_Testing$ci[1],2), "-",round(RocObject_Testing$ci[3],2), ")" , sep="")),
         col = c('red', 'green'), lty=1, border =FALSE, y.intersp = 1.5)
  #varImpPlot(model_rf, n.var=6, main = "Most important variables")
  #dev.off()
}

MakePlot(RocObject_Train, RocObject_Testing, "ROC-curve.tiff")

# McNemar test compare accuracies
Performance <-
  matrix(c(794, 86, 150, 570),
         nrow = 2,
         dimnames = list("1st Survey" = c("Approve", "Disapprove"),
                         "2nd Survey" = c("Approve", "Disapprove")))
Performance
mcnemar.test(Performance)

