#run_analysis.R
#Created by Micha³ Bukowski, bukowmic@gmail.com
#Things that this script has to do:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

train.tmp.data <- read.table("UCI\ HAR\ Dataset\\train\\X_train.txt")
test.tmp.data <- read.table("UCI\ HAR\ Dataset\\test\\X_test.txt")