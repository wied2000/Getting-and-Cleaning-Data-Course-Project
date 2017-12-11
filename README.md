README
================

Getting and Cleaning Data Course Project
========================================

This Readme file explains how to run the analysis files (run\_analysis.R) from your working directory for getting the tidy data as instructed by Getting and Cleaning Data Course Project.

Data and Files
--------------

To be able to run the analysis file you need to: 1. Download original samsung data from

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

to your working directory

1.  Unzip getdata%2Fprojectfiles%2FUCI HAR Dataset

2.  Download run\_analysis.R from this repository to your working directory

Running run\_analysis.R
-----------------------

### 1. Merges the training and the test sets to create one data set.

1.  Construct testdata containing

-   Load Measurement data(X file)

``` r
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
```

-   Load Subject(subject file)

``` r
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
```

-   Load Activity(y file)

``` r
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
```

-   Create test data set

``` r
test <- cbind(X_test,subject_test,y_test)
```

1.  Construct training data containing

-   Load Measurement data(X file)

``` r
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
```

-   Load Subject(subject file)

``` r
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
```

-   Load Activity(y file)

``` r
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
```

-   Create training data set

``` r
train <- cbind(X_train,subject_train,y_train)
```

1.  Merge taining data and test data

-   Create complete data set (training and test) with R command rbind

``` r
w4data <- rbind(train,test)
```

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

-   load the features data from file (561 column)

``` r
features <- read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
```

-   change the column names of the original data. Before (V1...V561,V1,V1) to (561 Features,subject,activity)

``` r
colnames(w4data) <- c(features$V2,"subject","activity")
```

-   create logical vector with the features column containing words "mean" OR "std"

``` r
logic <- c(grepl(("mean|std"),features$V2),TRUE,TRUE)
```

-   create a new data set with filtering the column based on logic vector above

``` r
w4data <- w4data[,logic]
```

### 3. Uses descriptive activity names to name the activities in the data set

-   get the activity label form the file

``` r
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
```

-   add new column activity\_label

``` r
w4data$activity_label <- activity_labels$V2[w4data$activity]
```

### 4. Appropriately labels the data set with descriptive variable names.

-   convert all features column into ONE column (features) that will be split later

``` r
library(tidyr)
w4datares <- gather(w4data,features,value,-subject,-activity,-activity_label )
```

-   create new column for variable dom

``` r
w4datares$dom <- rep("-",nrow(w4datares))
w4datares$dom[grepl("^t",w4datares$features)]<-"Time"
w4datares$dom[grepl("^f",w4datares$features)]<-"Freq"
```

-   create new column for variable body\_gravity

``` r
w4datares$body_gravity <- rep("-",nrow(w4datares))
w4datares$body_gravity[grepl("Body",w4datares$features)]<-"Body"
w4datares$body_gravity[grepl("Gravity",w4datares$features)]<-"Gravity"
```

-   create new column for variable acc\_gyro

``` r
w4datares$acc_gyro <- rep("-",nrow(w4datares))
w4datares$acc_gyro[grepl("Gyro",w4datares$features)]<-"Gyro"
w4datares$acc_gyro[grepl("Acc",w4datares$features)]<-"Acc"
```

-   create new column for variable jerk

``` r
w4datares$jerk <- rep("-",nrow(w4datares))
w4datares$jerk[grepl("Jerk",w4datares$features)]<-"Jerk"
```

-   create new column for variable mag

``` r
w4datares$mag <- rep("-",nrow(w4datares))
w4datares$mag[grepl("Mag",w4datares$features)]<-"Mag"
```

-   create new column for variable direction

``` r
w4datares$direction <- rep("-",nrow(w4datares))
w4datares$direction[grepl("X",w4datares$features)]<-"X"
w4datares$direction[grepl("Y",w4datares$features)]<-"Y"
w4datares$direction[grepl("Z",w4datares$features)]<-"Z"
```

-   create new column for variable stat

``` r
w4datares$stat <- rep("-",nrow(w4datares))
w4datares$stat[grepl("mean",w4datares$features)]<-"Mean"
w4datares$stat[grepl("std",w4datares$features)]<-"Std"
```

-   create tidy data

``` r
w4tidy <- w4datares
head(w4tidy)
```

    ##   subject activity activity_label          features     value  dom
    ## 1       1        5       STANDING tBodyAcc-mean()-X 0.2885845 Time
    ## 2       1        5       STANDING tBodyAcc-mean()-X 0.2784188 Time
    ## 3       1        5       STANDING tBodyAcc-mean()-X 0.2796531 Time
    ## 4       1        5       STANDING tBodyAcc-mean()-X 0.2791739 Time
    ## 5       1        5       STANDING tBodyAcc-mean()-X 0.2766288 Time
    ## 6       1        5       STANDING tBodyAcc-mean()-X 0.2771988 Time
    ##   body_gravity acc_gyro jerk mag direction stat
    ## 1         Body      Acc    -   -         X Mean
    ## 2         Body      Acc    -   -         X Mean
    ## 3         Body      Acc    -   -         X Mean
    ## 4         Body      Acc    -   -         X Mean
    ## 5         Body      Acc    -   -         X Mean
    ## 6         Body      Acc    -   -         X Mean

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

-   Use aggregate with function mean to get the average value of each variable for each activity and each subject.

``` r
w4tidyave <- aggregate(value ~ subject+activity_label+dom+body_gravity+acc_gyro+jerk+mag+direction+stat,w4tidy,mean)
str(w4tidyave)
```

    ## 'data.frame':    11880 obs. of  10 variables:
    ##  $ subject       : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ activity_label: chr  "LAYING" "LAYING" "LAYING" "LAYING" ...
    ##  $ dom           : chr  "Freq" "Freq" "Freq" "Freq" ...
    ##  $ body_gravity  : chr  "Body" "Body" "Body" "Body" ...
    ##  $ acc_gyro      : chr  "Acc" "Acc" "Acc" "Acc" ...
    ##  $ jerk          : chr  "-" "-" "-" "-" ...
    ##  $ mag           : chr  "Mag" "Mag" "Mag" "Mag" ...
    ##  $ direction     : chr  "-" "-" "-" "-" ...
    ##  $ stat          : chr  "Mean" "Mean" "Mean" "Mean" ...
    ##  $ value         : num  -0.388 -0.354 -0.364 -0.349 -0.335 ...

``` r
head(w4tidyave)
```

    ##   subject activity_label  dom body_gravity acc_gyro jerk mag direction
    ## 1       1         LAYING Freq         Body      Acc    - Mag         -
    ## 2       2         LAYING Freq         Body      Acc    - Mag         -
    ## 3       3         LAYING Freq         Body      Acc    - Mag         -
    ## 4       4         LAYING Freq         Body      Acc    - Mag         -
    ## 5       5         LAYING Freq         Body      Acc    - Mag         -
    ## 6       6         LAYING Freq         Body      Acc    - Mag         -
    ##   stat      value
    ## 1 Mean -0.3876795
    ## 2 Mean -0.3544060
    ## 3 Mean -0.3642671
    ## 4 Mean -0.3488459
    ## 5 Mean -0.3351014
    ## 6 Mean -0.3838733

-   create tidy data txt file

``` r
write.table(w4tidyave,file="tidy_average.txt",row.names=FALSE)
```
