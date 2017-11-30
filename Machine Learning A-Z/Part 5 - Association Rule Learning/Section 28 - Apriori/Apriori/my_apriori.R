# Apriori

# Data Preprocessing
# install.packages('arules')
library(arules)
dataset <- read.csv('Market_Basket_Optimisation.csv', header=FALSE)
dataset <- read.transactions('Market_Basket_Optimisation.csv', sep=',', rm.duplicates=TRUE)
summary(dataset)
itemFrequencyPlot(dataset,topN=10)

# Training apriori on the dataset
rules <- apriori(data=dataset, parameter=list(support=0.003, confidence=0.8)) # 0 rules
rules <- apriori(data=dataset, parameter=list(support=0.003, confidence=0.4)) # 281 rules
rules <- apriori(data=dataset, parameter=list(support=0.003, confidence=0.2)) # 1348 rules
rules <- apriori(data=dataset, parameter=list(support=0.004, confidence=0.2)) # 811 rules

# Visualizing the results
inspect(sort(rules, by='lift')[1:10])
