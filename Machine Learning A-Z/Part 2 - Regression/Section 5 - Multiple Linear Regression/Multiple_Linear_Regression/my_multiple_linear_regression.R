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
