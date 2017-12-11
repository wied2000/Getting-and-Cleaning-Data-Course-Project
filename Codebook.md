
---
## Tidying data collected from the accelerometers from the Samsung Galaxy S smartphone
by WM Kartika, 11 December 2017

---

## Project Description
The goal is to prepare tidy data that can be used for later analysis.

## Study design and data processing

### Collection of the raw data
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 


## Creating the tidy datafile

### Guide to create the tidy data file
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


### Cleaning of the data

The process for getting the tidy data is as followw. Details is explained in README.md
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The resulting data.frame is saved in tidy_average.txt file

## Description of the variables in  tidy_average.txt

- subject      
class: int,  value: 1 to 30 <br>
- activity_label<br>
class: chr,  6 possible values : "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS" <br>
- dom       
class: chr,  3 possible values : "Time", "Freq","-" <br>
- body_gravity  
class: chr,  3 possible values : "Body","Gravity","-" <br>
- acc_gyro  
class: chr,  3 possible values : "Acc","Gyro","-" <br>
- jerk  
class: chr,  2 possible values : "Jerk","-" <br>
- mag  
class: chr,  2 possible values : "Mag","-" <br>
- direction  
class: chr,  4 possible values : "X","Y","Z" <br>
- stat  
class: chr,  2 possible values : "Mean","Std" <br>
- value  
class: num,  average of measurement value (Mean/Std) for each fatures <br>




