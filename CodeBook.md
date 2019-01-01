## Code Book
### Experiment Background
The raw data is from a Human activity recognition database built from the recordings of 30 subjects performing the daily activites: walking, walking upstairs, walking downstairs, sitting, standing and lying. The test subjects carried a waist mounted smartphone with embedded intertial sensors.

Using the accelerometer, the x, y and z-axis linear acceleration, along with 3-axial angular velocity was recorded. The experiements were video recorded to manually decide what activity (walking, sitting, etc.) was taking place corresponding to the data.

The resulting data set was partitioned randomly into two sets: test (30% of the volunteers) and train (70% of the volunteers).

Lastly, the acceleration and angular velocity magnitudes are normalized and hence the data range is [-1, 1].

Source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Components of the Raw Data
The raw data is stored in a folder that contains another folder called "UCI HAR Dataset" which contains two folders named "test" which contains test data and "train" which have training data. The structure of these folders are identical. The main acceleration data is contained in the "subject_train.txt" file. The "y_train.txt" data gives information about the corresponding activity being done by the person. The README file explains that the activities are donoted by the following numbers: WALKING - 1, WALKING_UPSTAIRS - 2, WALKING_DOWNSTAIRS - 3, SITTING - 4, STANDING - 5 and LAYING - 6. Furthermore, "subject_train.txt" file tells us which person (numbered 1 - 30) the data in the other two files correspond to.
UCI HAR Dataset/
test/
* Inertial Signals
* subject_test.txt
* y_test.txt
* x_test.txt
train/
* Inertial Signals
* subject_train.txt
* y_train.txt
* x_train.txt
activity_labels.txt
features.txt
features_info.txt
README.txt
### Study Design
* Data is downloaded to datapath, which if doesn't exists is created, is indicated in code which can be changed as per need
* All the test and training files are loaded and can be seen in workspace and is merged into one common data set.
* Assign appropriate column names
* Extract only the measurements on the mean and standard deviation for each measurement in the merged data set.
* Determine columns of data set to keep based on column name and keep data in these columns only.
* Use descriptive activity names to name the activities in the data set and replace activity values with named factor levels
* Expand abbreviations and clean up variable names by removing spaces, dashes and brackets.
* From the data set obtained, create a second, independent tidy data set with the average of each variable for each activity and each subject.
* Write the data frame into a final text file.