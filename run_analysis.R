library(dplyr)

# download zip file containing data if it hasn't already been downloaded
zipurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCI HAR Dataset.zip"

if (!file.exists(zipfile)) {
  download.file(zipurl, zipfile, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(zipfile)
}
 
# reading training, test and feature data
trainingSubjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(dataPath, "train", "y_train.txt"))
testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"))
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")



#1.Merge the test and training sets into one data set
Activity <- rbind(
  cbind(trainingSubjects, trainingValues, trainingActivity),
  cbind(testSubjects, testValues, testActivity)
)

# assign column names
colnames(Activity) <- c("subject", features[, 2], "activity")

#2.Extract only the measurements on the mean and standard deviation for each measurement

# determine columns of data set to keep based on column name
columnsToKeep <- grepl("subject|activity|mean|std", colnames(Activity))

# ... and keep data in these columns only
Activity <- Activity[, columnsToKeep]



#3.Use descriptive activity names to name the activities in the data set


# replace activity values with named factor levels
Activity$activity <- factor(Activity$activity, 
  levels = activities[, 1], labels = activities[, 2])

#4.Appropriately labels the data set with descriptive variable names.


#expand abbreviations and clean up column names
ActivityCols <- colnames(Activity)
ActivityCols <- gsub("[\\(\\)-]", "", ActivityCols)
ActivityCols <- gsub("^f", "frequencyDomain", ActivityCols)
ActivityCols <- gsub("^t", "timeDomain", ActivityCols)
ActivityCols <- gsub("Acc", "Accelerometer", ActivityCols)
ActivityCols <- gsub("Gyro", "Gyroscope", ActivityCols)
ActivityCols <- gsub("Mag", "Magnitude", ActivityCols)
ActivityCols <- gsub("Freq", "Frequency", ActivityCols)
ActivityCols <- gsub("mean", "Mean", ActivityCols)
ActivityCols <- gsub("std", "StandardDeviation", ActivityCols)
ActivityCols <- gsub("BodyBody", "Body", ActivityCols)
colnames(Activity) <- ActivityCols

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
ActivityMeans <- Activity %>% 
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# output to file "tidy_data.txt"
write.table(ActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)