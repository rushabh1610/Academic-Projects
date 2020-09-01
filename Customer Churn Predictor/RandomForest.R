install.packages('randomForest')
install.packages('corrplot')
install.packages('gridExtra')
install.packages('grid')
install.packages('ggplot2')
install.packages('lattice')
install.packages('MASS')
install.packages('party')
install.packages('e1071', dependencies=TRUE)
install.packages('caret', dependencies=TRUE)

library(e1071)
library(party)
library(MASS)
library(randomForest)
library(corrplot)
library(gridExtra)
library(grid) 
library(ggplot2)
library(lattice)

###########################################################################################

#Reading the train and test files

churn_train <- read.csv('C:\\Users\\vrush\\OneDrive\\Desktop\\BIA-652\\Final Project\\ChurnModelling (TrainData).csv')
churn_test <- read.csv('C:\\Users\\vrush\\OneDrive\\Desktop\\BIA-652\\Final Project\\ChurnModelling (TestData).csv')

str(churn_train)
str(churn_test)

#Removing the columns we do not need for the analysis.

churn_train$RowNumber <- NULL
churn_train$CustomerId <- NULL
churn_train$Surname <- NULL

churn_test$RowNumber <- NULL
churn_test$CustomerId <- NULL
churn_test$Surname <- NULL

#Correlation between numeric variables

numeric.var <- sapply(churn_train, is.numeric)
corr.matrix <- cor(churn_train[,numeric.var])
corrplot(corr.matrix, main="\n\nCorrelation Plot for Numerical Variables", method="number")

#Bar plots of categorical variables

p1 <- ggplot(churn_train, aes(x=Geography)) + ggtitle("Geography") + xlab("Geography") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()

p2 <- ggplot(churn_train, aes(x=Gender)) + ggtitle("Gender") + xlab("Gender") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()

p3 <- ggplot(churn_train, aes(x=Age)) + ggtitle("Age") + xlab("Age") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()

p4 <- ggplot(churn_train, aes(x=NumOfProducts)) + ggtitle("NumOfProducts") + xlab("NumOfProducts") +
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()

p5 <- ggplot(churn_train, aes(x=HasCrCard)) + ggtitle("HasCrCard") + xlab("HasCrCard") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()

p6 <- ggplot(churn_train, aes(x=IsActiveMember)) + ggtitle("IsActiveMember") + xlab("IsActiveMember") + 
  geom_bar(aes(y = 100*(..count..)/sum(..count..)), width = 0.5) + ylab("Percentage") + coord_flip() + theme_minimal()

grid.arrange(p1, p2, p3, p4, p5, p6, ncol=3)

############################################################################################

#Logistic Regression

LogModel <- glm(Exited~., family=binomial(link="logit"),data=churn_train)
print(summary(LogModel))

#Anova

anova(LogModel, test="Chisq")

#Testing the model

churn_test$Exited <- as.character(churn_test$Exited)
churn_test$Exited[churn_test$Exited=="No"] <- "0"
churn_test$Exited[churn_test$Exited=="Yes"] <- "1"
fitted.results <- predict(LogModel,newdata=churn_test,type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)
misClasificError <- mean(fitted.results != churn_test$Exited)
print(paste('Logistic Regression Accuracy',1-misClasificError))

#Logistic regression confusion matrix

print("Confusion Matrix for Logistic Regression"); 
table(churn_test$Exited, fitted.results > 0.5)

#Odds Ratio

exp(cbind(OR=coef(LogModel), confint(LogModel)))

#############################################################################################

#Random Forest

rfModel <- randomForest(Exited ~., data = churn_train, importance = T)
print(rfModel)

#Random Forest Prediction and Confusion Matrix

pred_rf <- predict(rfModel, churn_test)
pred_rf <- ifelse(pred_rf>0.5, 1,0)
caret::confusionMatrix(factor(pred_rf), factor(churn_test$Exited))

#Random Forest Error Rate before tuning

plot(rfModel)

#Tune random forest model

t <- tuneRF(churn_train[, -11], churn_train[, 11], stepFactor = 0.5, plot = TRUE, ntreeTry = 200, trace = TRUE, improve = 0.05)

#Fit the random forest model after tuning

rfModel_new <- randomForest(Exited ~., data = churn_train, ntree = 200, mtry = 3, importance = TRUE, proximity = TRUE)
print(rfModel_new)

#Random Forest predictions and confusion matrix after tuning

pred_rf_new <- predict(rfModel_new, churn_test)
pred_rf_new <- ifelse(pred_rf_new > 0.5, 1, 0)
caret::confusionMatrix(factor(pred_rf_new), factor(churn_test$Exited))

#Random Forest Error Rate after tuning

plot(rfModel_new)

#Random Forest feature importance

varImpPlot(rfModel_new, sort=T, n.var = 10, main = 'Top 10 Feature Importance')