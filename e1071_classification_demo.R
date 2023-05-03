install.packages ("e1071", dependencies = TRUE)
library(e1071)
library(randomForest)

data(Glass, package="mlbench")

## split data into a train and test set
index <- 1: nrow(Glass)
N <- trunc(length(index)/3)
testindex <- sample(index, N)
testset <- Glass[testindex,]
trainset <- Glass[-testindex,]

#both for SVM and randomForest (via randomForest()), we fit the model and 
#predict the test set values:

## SVM
svm.model <- svm(Type ~ ., data = trainset, cost = 100, gamma = 1)
svm.pred <- predict(svm.model, testset[,-10])

#The dependent variable, "Type", has column number 10.
#cost is a general penalizing parameter for C-classification and gamma is the 
#radial basis function-specific kernel parameter

## randomForest
rf.model <- randomForest(Type ~ .,data = trainset)
rf.pred <- predict(rf.model, testset[,-10])

#A cross-tabulation of the true versus the predicted values yields:

## compute svm confusion matrix
print("SVM")
table(pred = svm.pred, true = testset[,10])

## compute randomForest confusion matrix
print("Random Forest")
table(pred = rf.pred, true= testset[,10])