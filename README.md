# Getting and Cleaning Data Course Project

This Readme file explains how to run the analysis files (run_analysis.R) from your working directory for getting the tidy data as instructed by Getting and Cleaning Data Course Project.

## Data and Files

To be able to run the analysis file you need to:
1. Download original samsung data from 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

to your working directory

2. Unzip getdata%2Fprojectfiles%2FUCI HAR Dataset

3. Download run_analysis.R from this repository to your working directory

## Analysis File Description

### 1.Merges the training and the test sets to create one data set.  

#### a. Construct testdata containing  
- Load Measurement data(X file) 
- Load Subject(subject file)  
- Load Activity(y file) 
- Create test data set with R command cbind

#### b. Construct training data containing  
- Load Measurement data(X file) 
- Load Subject(subject file)  
- Load Activity(y file) 
- Create training data set with R command cbind

#### c. Merge taining data and test data 
- Create complete data (training and test) with R command rbind

### 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
- load the features data from file (561 column) 
- change the column names of the original data. Before (V1...V561,V1,V1) to (561 Features,subject,activity) 
- create logical vector with the features column containing words "mean" OR "std" 
- create a new data set with filtering the column based on logic vector above

### 3. Uses descriptive activity names to name the activities in the data set
- get the activity label form the filw
- add new column activity_label  

### 4. Appropriately labels the data set with descriptive variable names.

- convert all features column into a column (features) that will be split later
- create new column for variable dom
- create new column for variable body_gravity
- create new column for variable acc_gyro
- create new column for variable jerk
- create new column for variable Mag
- create new column for variable dir
- create new column for variable stat
- create tidy data

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Use aggregate with function mean to get the average value of each variable for each activity and each subject.

