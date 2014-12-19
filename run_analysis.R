#run_analysis.R
#Created by Michał Bukowski, bukowmic@gmail.com
#Things that this script has to do:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Including necessary libraries for used functions and methods.
if(sum(.packages(all.available = TRUE) == "dplyr")){
  library(dplyr)
} else {
  install.packages("dplyr")
  library(dplyr)
}

#Reading training and test data, as well as headers, from txt files.
train.tmp.data <- read.table("UCI\ HAR\ Dataset\\train\\X_train.txt")
train.tmp.data <- tbl_df(train.tmp.data)

test.tmp.data <- read.table("UCI\ HAR\ Dataset\\test\\X_test.txt")
test.tmp.data <- tbl_df(test.tmp.data)

merged.data <- rbind_list(train.tmp.data, test.tmp.data)

#2. Extracting only mean and standard deviation by reading variables names
headers.data <- read.table("UCI\ HAR\ Dataset\\features.txt")
headers.data <- tbl_df(headers.data)
tmp <- headers.data %>%
  filter(grepl("mean",V2) | grepl("std",V2))

extracted.data <- merged.data %>%
  select(num_range("V", tmp$V1))

colnames(extracted.data) <- tmp$V2

#3. Naming properly activities
activity.labels.data <- read.table("UCI\ HAR\ Dataset\\activity_labels.txt")
activity.labels.data <- tbl_df(activity.labels.data)

train.activity.data <- read.table("UCI\ HAR\ Dataset\\train\\y_train.txt")
train.activity.data <- tbl_df(train.activity.data)

test.activity.data <- read.table("UCI\ HAR\ Dataset\\test\\y_test.txt")
test.activity.data <- tbl_df(test.activity.data)

activity.data <- rbind(train.activity.data, test.activity.data)

activity.data <- inner_join(activity.data, activity.labels.data)
colnames(activity.data) <- c("id", "activityLabel")

extracted.activity.data <- cbind(activity.data[,2], extracted.data)
extracted.activity.data <- tbl_df(extracted.activity.data)

#4. Adding descriptive names to variables was done in points 2 and 3 as well as will be in point 5.

#5a. Adding informations about subjects
train.subject.data <- read.table("UCI\ HAR\ Dataset\\train\\subject_train.txt")
train.subject.data <- tbl_df(train.subject.data)

test.subject.data <- read.table("UCI\ HAR\ Dataset\\test\\subject_test.txt")
test.subject.data <- tbl_df(test.subject.data)

subject.data <- rbind(train.subject.data, test.subject.data)
colnames(subject.data) <- c("subjectName")

final.data <- cbind(subject.data, extracted.activity.data)
final.data <- tbl_df(final.data)

#5b. Creating a summary dataset
final.mean.data <- final.data %>%
  group_by(subjectName, activityLabel) %>%
  summarise_each(funs(mean))

# Exporting final data to txt file


# Making free space by deleting not used data
rm(train.tmp.data) 
rm(test.tmp.data)
rm(headers.data)
rm(merged.data)
rm(tmp)
rm(activity.labels.data)
rm(train.activity.data)
rm(test.activity.data)
rm(activity.data)
rm(extracted.data)
rm(train.subject.data)
rm(test.subject.data)
rm(subject.data)
rm(extracted.activity.data)
