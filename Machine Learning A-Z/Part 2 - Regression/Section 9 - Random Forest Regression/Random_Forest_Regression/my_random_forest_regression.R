# Random Forest Regression

# Data Preprocessing
# apparently no need to import libraries - they are included with R by default

# Importing the dataset
# set the working directory manually

dataset = read.csv("Position_Salaries.csv")
dataset = dataset[2:3] # use this to select a subset of the data

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



# Fitting the regression model to the dataset
# install.packages("randomForest")
library(randomForest)
set.seed(1234)
regressor = randomForest(x=dataset[1],
                         y=dataset$Salary,
                         ntree=500)

# Predicting a new result with non-linear regression
y_pred = predict(regressor,data.frame(Level=6.5))


# Visualizing the non-linear regression results (for higher resolution/smoother curve)
library(ggplot2)
x_grid = seq(min(dataset$Level),max(dataset$Level),0.01)
ggplot() +
  geom_point(aes(x=dataset$Level,y=dataset$Salary),
             color="red") +
  geom_line(aes(x=x_grid,y=predict(regressor,newdata=data.frame(Level=x_grid))),
            color="blue") +
  ggtitle("Truth or Bluff (Random Forest Regression)") +
  xlab("Level") +
  ylab("Salary")
