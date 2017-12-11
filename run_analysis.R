
#set working directory to UCI HAR Dataset after extracting data getdata%2Fprojectfiles%2FUCI HAR Dataset

#1.Merges the training and the test sets to create one data set.

#a. Construct testdata containing 
#- Load Measurement data(X file)
X_test <- read.table("test/X_test.txt", quote="\"", comment.char="")

#- Load Subject(subject file)
subject_test <- read.table("test/subject_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

#- Load Activity(y file)
y_test <- read.table("test/y_test.txt", quote="\"", comment.char="")

test <- cbind(X_test,subject_test,y_test)

#b. Construct training data containing 
#- Load Measurement data(X file)
X_train <- read.table("train/X_train.txt", quote="\"", comment.char="")

#- Load Subject(subject file)
subject_train <- read.table("train/subject_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

#- Load Activity(y file)
y_train <- read.table("train/y_train.txt", quote="\"", comment.char="")

train<- cbind(X_train,subject_train,y_train)

#c. Merge taining data and test data 

w4data <- rbind(train,test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#load the features (561 column)
features <- read.table("features.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

#change the column names of the original data
colnames(w4data) <- c(features$V2,"subject","activity")

#create logical with the feature index containgn words "mean" OR "std" and subject and activity column 
logic <- c(grepl(("mean|std"),features$V2),TRUE,TRUE)

#filter the column based on logic vector above
w4data <- w4data[,logic]

#3. Uses descriptive activity names to name the activities in the data set
#get the activity label
activity_labels <- read.table("activity_labels.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

#add new column activity_label  
w4data$activity_label <- activity_labels$V2[w4data$activity]

#4. Appropriately labels the data set with descriptive variable names.

#convert all features column into a column (features) that will be split later
library(tidyr)
w4datares <- gather(w4data,features,value,-subject,-activity,-activity_label )

#create new column for dom
w4datares$dom <- rep("-",nrow(w4datares))
w4datares$dom[grepl("^t",w4datares$features)]<-"Time"
w4datares$dom[grepl("^f",w4datares$features)]<-"Freq"

#create new column for type body_gravity
w4datares$body_gravity <- rep("-",nrow(w4datares))
w4datares$body_gravity[grepl("Body",w4datares$features)]<-"Body"
w4datares$body_gravity[grepl("Gravity",w4datares$features)]<-"Gravity"

#create new column for type acc_gyro
w4datares$acc_gyro <- rep("-",nrow(w4datares))
w4datares$acc_gyro[grepl("Gyro",w4datares$features)]<-"Gyro"
w4datares$acc_gyro[grepl("Acc",w4datares$features)]<-"Acc"

#create new column for type jerk
w4datares$jerk <- rep("-",nrow(w4datares))
w4datares$jerk[grepl("Jerk",w4datares$features)]<-"Jerk"

#create new column for type Mag
w4datares$mag <- rep("-",nrow(w4datares))
w4datares$mag[grepl("Mag",w4datares$features)]<-"Mag"

#create new column for type dir
w4datares$direction <- rep("-",nrow(w4datares))
w4datares$direction[grepl("X",w4datares$features)]<-"X"
w4datares$direction[grepl("Y",w4datares$features)]<-"Y"
w4datares$direction[grepl("Z",w4datares$features)]<-"Z"

#create new column for type stat
w4datares$stat <- rep("-",nrow(w4datares))
w4datares$stat[grepl("mean",w4datares$features)]<-"Mean"
w4datares$stat[grepl("std",w4datares$features)]<-"Std"

#create tidy data
w4tidy <- w4datares
head(w4tidy)
write.csv(w4tidy,file="tidy.csv",row.names=FALSE)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
w4tidyave <- aggregate(value ~ subject+activity_label+dom+body_gravity+acc_gyro+jerk+mag+direction+stat,w4tidy,mean)
write.table(w4tidyave,file="tidy_average.txt",row.names=FALSE)