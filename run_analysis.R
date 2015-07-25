

# This code does the following tasks:

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for
# each activity and each subject.





# Download and unzip the UCI HAR Dataset
temp    <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = temp)
unzip(temp, exdir = ".")
list.files()




# Setting up working directory
getwd()
setwd("../")
setwd("./2-Getting and Cleaning Data/UCI HAR Dataset")




# Reading 'train' and 'test' data sets
x_train       <- read.table(file = "./train/X_train.txt", header = F)
y_train       <- read.table(file = "./train/y_train.txt", header = F, col.names = c("activity_code"))
subject_train <- read.table(file = "./train/subject_train.txt", header = F, col.names = c("subject_ID"))
train         <- cbind(subject_train, y_train, x_train)

x_test        <- read.table(file = "./test/X_test.txt", header = F)
y_test        <- read.table(file = "./test/y_test.txt", header = F, col.names = c("activity_code"))
subject_test  <- read.table(file = "./test/subject_test.txt", header = F, col.names = c("subject_ID"))
test          <- cbind(subject_test, y_test, x_test)




# Merges the training and the test sets to create one data set.
rm(list = ls()[!ls() %in% c("train", "test")])
total <- rbind(train,test)




# Read feature names
feature <- read.table("./features.txt", header = F, colClasses = c("integer", "character"))




# Uses descriptive activity names to name the activities in the data set
activity_labels     <- read.table("./activity_labels.txt", header = F, colClasses = c("integer", "character"))
total$activity_code <- car::recode(total$activity_code, "1 = 'WALKING'; 2 = 'WALKING_UPSTAIRS';
                                                         3 = 'WALKING_DOWNSTAIRS'; 4 = 'SITTING';5 = 'STANDING';
                                                         6 = 'LAYING'")



# Appropriately labels the data set with descriptive variable names. 
# We have to be careful about duplicate names in features. Here I use 'make.names' with option unique = T.
colnames(total)[-(1:2)] <- make.names(names=feature$V2, unique=TRUE, allow_ = TRUE)
length(colnames(total)) == length(unique(colnames(total)))




# Extracts only the measurements on the mean and standard deviation for each measurement.  
library(dplyr)
total            <- as.tbl(total)
total_meanANDstd <- select(total, matches("std"), matches("mean"), -matches("meanFreq"), -matches("gravityMean"),
                         -matches("tBodyAccMean"), -matches("tBodyGyroMean"), -matches("tBodyGyroJerkMean"))




# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
total_meanANDstd_activANDsub <- select(total, subject_ID, activity_code, matches("std"), matches("mean"),
                                       -matches("meanFreq"), -matches("gravityMean"), -matches("tBodyAccMean"),
                                       -matches("tBodyGyroMean"), -matches("tBodyGyroJerkMean"))

second <- total_meanANDstd_activANDsub %>% group_by(subject_ID, activity_code) %>% summarise_each(funs(mean))
write.table(second, file = "tidydata.txt", row.names = F)






