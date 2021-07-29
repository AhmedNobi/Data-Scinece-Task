# Loading package
library("e1071")
library("caTools")
library("caret")
library("base")

# Read file 
all_data <- read.table("nbtrain.csv", header = TRUE ,sep = ',')
all_data <- all_data[sample(nrow(all_data)), ]

# Split data into train data and test data
# Train data is from 1 to 9010
# Test data is from 9011 to 10010
train_data <- all_data[1:9010,]
test_data <- all_data[9010:10010,]

df <- data.frame(train_data)

male <- subset(df,gender %in% c('M'))

female <- subset(df,gender %in% c('F'))

male_data <- male[sample(nrow(male), 3500), ]
female_data <- female[sample(nrow(female), 3500), ]

new_data <- rbind(male_data, female_data)




# (Predict individual's gender)
# Using naive bayes model to classify gender
model_new <- naiveBayes(gender~.,new_data, laplace = 0.001)
model_new

# Using predict function to predict gender
results_new <- predict(model_new, test_data)

# Make table from gender and predicted results
confussion_matrix_gender <- table(test_data$gender, results_new)

# Confussion matrix for gender
confusionMatrix(confussion_matrix_gender)