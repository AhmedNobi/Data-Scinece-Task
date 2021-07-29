# Loading package
library("e1071")
library("caTools")
library("caret")
library("base")

set.seed(120)
# Read file 
all_data <- read.table("nbtrain.csv", header = TRUE ,sep = ',')
all_data <- all_data[sample(nrow(all_data)), ]

# Split data into train data and test data
# Train data is from 1 to 9010
# Test data is from 9011 to 10010
train_data <- all_data[1:9010,]
test_data <- all_data[9010:10010,]

#(Predict individual's income)
# Using naive bayes model to classify income
model_income <- naiveBayes(income~.,train_data, laplace = 0.001)
model_income

# Using predict function to predict income
results_income <- predict(model_income, test_data)

# Make table from income and predicted results
confussion_matrix_income <- table(test_data$income, results_income)

# Confussion matrix for income
confusionMatrix(confussion_matrix_income)