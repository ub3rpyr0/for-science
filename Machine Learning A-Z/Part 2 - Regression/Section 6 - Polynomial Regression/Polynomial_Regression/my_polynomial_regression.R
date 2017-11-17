# Polynomial Regression

# Data Preprocessing
# apparently no need to import libraries - they are included with R by default

# Importing the dataset
# set the working directory manually

dataset = read.csv("Position_Salaries.csv")
dataset = dataset[2:3] # use this to select a subset of the data
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
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$Purchased, SplitRatio=0.8)
# training_set = subset(dataset, split == TRUE)
# test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set[,2:3] = scale(training_set[,2:3])
# test_set[,2:3] = scale(test_set[,2:3])



# Fitting Linear Regression to the dataset - for comparison
lin_reg = lm(formula = Salary ~ .,
             data = dataset)
summary(lin_reg)

# Fitting Polynomial Regression to the dataset
# add a new independent variable with polynomial values
dataset$Level2 = dataset$Level ^ 2
dataset$Level3 = dataset$Level ^ 3
poly_reg = lm(formula = Salary ~ .,
              data = dataset)
summary(poly_reg)
