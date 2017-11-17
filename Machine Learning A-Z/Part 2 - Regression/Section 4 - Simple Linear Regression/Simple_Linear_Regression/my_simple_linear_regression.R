# Simple Linear Regression

# Importing the dataset
getwd()
setwd("C:\\Users\\swenz02\\Documents\\MachineLearning\\Machine Learning A-Z\\Part 2 - Regression\\Section 4 - Simple Linear Regression\\Simple_Linear_Regression")
getwd()

dataset = read.csv("Salary_Data.csv")
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
# dataset$Country = factor(dataset$Country,
#                          levels = c("France","Spain","Germany"),
#                          labels = c(1, 2, 3))
# dataset$Purchased = factor(dataset$Purchased,
#                          levels = c("No","Yes"),
#                          labels = c(0, 1))

# Splitting the dataset into the Training set and Test set
# install.packages("caTools")
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio=2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set[,2:3] = scale(training_set[,2:3])
# test_set[,2:3] = scale(test_set[,2:3])



# Fitting Simple Linear Regression to the Training Set
regressor = lm(formula = Salary ~ YearsExperience,
               data = training_set)
summary(regressor) # gives you info including coefficients

# Predicting the test set results
y_pred = predict(regressor, newdata = test_set)

# Visualizing the Training set results
# install.packages("ggplot2")
library(ggplot2)

ggplot() +
  geom_point(aes(x=training_set$YearsExperience, y=training_set$Salary),
             color="Red") +
  geom_line(aes(x=training_set$YearsExperience, y=predict(regressor, newdata = training_set)),
            color="Blue") +
  ggtitle("Salary vs Experience (Training Set)") +
  xlab("Years of Experience") +
  ylab("Salary")

# Visualizing the Test set results
# install.packages("ggplot2")
library(ggplot2)

ggplot() +
  geom_point(aes(x=test_set$YearsExperience, y=test_set$Salary),
             color="Red") +
  geom_line(aes(x=training_set$YearsExperience, y=predict(regressor, newdata = training_set)),
            color="Blue") +
  ggtitle("Salary vs Experience (Test Set)") +
  xlab("Years of Experience") +
  ylab("Salary")