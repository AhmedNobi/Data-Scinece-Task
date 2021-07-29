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


# (Predict individual's gender)
# Using naive bayes model to classify gender
model_gender <- naiveBayes(gender~.,train_data, laplace = 0.001)
model_gender

# Using predict function to predict gender
results_gender <- predict(model_gender, test_data)

# Make table from gender and predicted results
confussion_matrix_gender <- table(test_data$gender, results_gender)

# Confussion matrix for gender
confusionMatrix(confussion_matrix_gender)