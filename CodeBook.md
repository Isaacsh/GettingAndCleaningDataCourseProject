# Getting and Cleaning Data Course Project #

Isaac | *version 7/25/2015* 

---
The purpose of this Code Book is to document all steps performed to clean up the data I got from UCI Machine Learning Repository, [Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The input is a zipped folder that includes training and test data sets along with some text files describing study design, statistical subjects, measurements, and information about features. Each of the training and test subset has 3 flat files including subject ID, feature values, and activity code.

The output is a tidy data that has measurements only on the mean and standard deviation of original measurements.

  
## Collection of raw data ##
The experiments have been carried out with a group of 30 volunteers within [19-48] years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 


Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 


## Feature information##
For each record in the raw dataset we have:

-  Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Features are normalized and bounded within [-1,1]. Each feature vector is a row on the text file.

##Creating the tidy data##
1. Download raw data from this [link](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip).
2. Read three flat datafiles, X\_train, y\_train, and subject_train from the train folder.
3. Read three flat datafiles, X\_test, y\_test, and subject_test from the test folder.
4. Bind columns of the three flat datafiles in step 2 and step 3 to create a single train and a single test data.
5. Merge the resulting train and test datasets.
6. Read feature.txt data. Set column classes to integer and character, one-to-one.
7. Read activity_labels.txt data and set column classes to integer and character, one-to-one.
8. Recode activity\_code in the merged data as 1 = 'WALKING', 2 = 'WALKING_UPSTAIRS', etc.
9. Build unique variable names with make.names from feature.txt, and assign it to the merged column names. Doing this, column names having '()' will change to '...'
10. Using ***dplyr*** library, select those variables that matches 'mean' and 'std'. Then deselect some variables with names containing 'mean' such as 'meanFreq', 'gravityMean', etc. Be reminded to include 'subject\_ID' and 'activity\_code'.
11. Group the data from step 10 by 'subject\_ID' and 'activity\_code'. Then use 'summarise_each' with 'funs(mean)' to make average of each variable for each activity and each subject.
12. Write the resulting data in step 11 with 'write.table' and 'row.name=F' and name it 'tidydata'. This will be in .txt format.

##Description of the variables in the tidy data##
The tidy data called '*second*' has 180 rows and 68 columns. The variables are "subject_ID" and "activity\_code", along with those measurements on the mean and standard deviation for each measurement. The 'subject\_ID' is an integer variable taking values in range of [1,30]. The 'activity\_code' takes values from the six activities. The rest of variables are numeric and bounded to [-1,1]. 