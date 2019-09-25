
# Load all data into R and save as original file name
features <- read.table("C:\\Users\\tficarro\\Downloads\\UCI HAR Dataset\\features.txt", col.names = c("feat_num", "feat_name"))
activity_labels <- read.table("C:\\Users\\tficarro\\Downloads\\UCI HAR Dataset\\activity_labels.txt", col.names = c("activity_id", "activity_name"))
subject_train <- read.table("C:\\Users\\tficarro\\Downloads\\UCI HAR Dataset\\train\\subject_train.txt", col.names = c("subject_id"))
X_train <- read.table("C:\\Users\\tficarro\\Downloads\\UCI HAR Dataset\\train\\X_train.txt", col.names = features$feat_name)
y_train <- read.table("C:\\Users\\tficarro\\Downloads\\UCI HAR Dataset\\train\\y_train.txt", col.names = "activity_id")
subject_test <- read.table("C:\\Users\\tficarro\\Downloads\\UCI HAR Dataset\\test\\subject_test.txt", col.names = c("subject_id"))
X_test <- read.table("C:\\Users\\tficarro\\Downloads\\UCI HAR Dataset\\test\\X_test.txt", col.names = features$feat_name)
y_test <- read.table("C:\\Users\\tficarro\\Downloads\\UCI HAR Dataset\\test\\y_test.txt", col.names = "activity_id")

# Merge tables together
train_data <- merge(cbind(subject_train, y_train, X_train), activity_labels, by.x = "activity_id", by.y = "activity_id")
test_data <- merge(cbind(subject_test, y_test, X_test), activity_labels, by.x = "activity_id", by.y = "activity_id")

# Rearrange the columns to my liking
train_data <- train_data[ ,c(2,1,564,3:563)]
test_data <- test_data[ ,c(2,1,564,3:563)]

# Combine data frames and sort for part 1
combined_data <- rbind(train_data, test_data)
combined_data <- combined_data[order(combined_data$subject_id, combined_data$activity_id), ]

# Only get columns pertaining to mean and sd by using dplyr package for part 2
# Retain the subject_id, act_num, act_name columns
library(dplyr)
combined_data <- combined_data %>% select(c(1:3), matches('mean|std'))

# Create tidy data set
combined_data_tidy <- aggregate(combined_data[ ,4:89], list(subject_id = combined_data$subject_id), mean)

# Write to a text file
write.table(combined_data_tidy, file = "C:\\Users\\tficarro\\Documents\\Week4_TidyData.txt", row.names = FALSE)