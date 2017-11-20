# SVR - support vector regression

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
# create regressor here
# install.packages("e1071")
library(e1071)
regressor = svm(formula=Salary~.,
                data=dataset,
                type="eps-regression")

# Predicting a new result with non-linear regression
y_pred = predict(regressor,data.frame(Level=6.5))


# Visualizing the non-linear regression results
library(ggplot2)
ggplot() +
  geom_point(aes(x=dataset$Level,y=dataset$Salary),
             color="red") +
  geom_line(aes(x=dataset$Level,y=predict(regressor,newdata=dataset)),
            color="blue") +
  ggtitle("Truth or Bluff (SVR Model)") +
  xlab("Level") +
  ylab("Salary")
