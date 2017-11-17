# Multiple Linear Regression

# Data Preprocessing
# apparently no need to import libraries - they are included with R by default

# Importing the dataset
# set the working directory in file explorer

dataset = read.csv("50_Startups.csv")
# dataset = dataset[, 2:3] # use this to select a subset of the data
str(dataset)
summary(dataset)

# Taking care of missing data
# dataset$Age = ifelse(is.na(dataset$Age),
#                      ave(dataset$Age, FUN=function(x) mean(x,na.rm=TRUE)),
#                      dataset$Age)
# dataset$Salary = ifelse(is.na(dataset$Salary),
#                         ave(dataset$Salary, FUN=function(x) mean(x,na.rm=TRUE)),
#                         dataset$Salary)

# Encoding categorical data
dataset$State = factor(dataset$State,
                       levels = c("New York","California","Florida"),
                       labels = c(1, 2, 3))

# Splitting the dataset into the Training set and Test set
# install.packages("caTools")
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio=0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set[,2:3] = scale(training_set[,2:3])
# test_set[,2:3] = scale(test_set[,2:3])



# Fitting multiple linear regression to the training set
# regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State)
regressor = lm(formula = Profit ~ .,
               data = training_set)
summary(regressor)

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)
y_pred



# Building the optimal model using Backward Elimination
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = dataset)
# you can do backward elimination with the training set or the full set
summary(regressor)
# State2 P-value 0.990 > 0.05 (State3 is also very high, so remove the State predictor)

regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
               data = dataset)
summary(regressor)
# Administration P-value 0.602 > 0.05, so remove Administration predictor

regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
               data = dataset)
summary(regressor)
# Marketing.Spend P-value 0.06 > 0.05, barely, let's remove it since it is much higher than R.D.Spend
# There is another strategy to determine whether this should be kept

regressor = lm(formula = Profit ~ R.D.Spend,
               data = dataset)
summary(regressor)
# R.D.Spend P-value 2e-16 < 0.05, so we're done - fit the model to the training set