# Course Project Code Book

# The Course Project

As the description of the course project says, "the purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. the goal is to prepare tidy data that can be used for later analysis" (see [Getting and Cleaning Data Course on Coursera](https://class.coursera.org/getdata-032/human_grading/view/courses/975116/assessments/3/submissions)).
I created seven scripts (*.R* files): one for setting the working directory and downloading the files, one for each of the five exercises and another that runs all the codes. In the following sections I will explain what each code does and what was the reasoning behind them.

# Preparation
It's a really simple code called **0-Preparations.R**. It calls two libraries (*plyr* and *dplyr*), downloads the *.zip* file that contains the data sets for the Course Project and extract it to the current working directory.

##Code
```
#######################################################
# LOADING LIBRARIES                                   #
library(plyr)
library(dplyr)


#######################################################
# DOWNLOADING FILES                                   #

# Download and unzip the file
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url=fileUrl,destfile = "./source.zip", mode='wb')
unzip(zipfile = "./source.zip", exdir = ".")
```

##Special notes
1. The *.zip* file is about 60mb, so downloading may take a while.
2. Please install the *plyr* and *dplyr* through ```install.packages()``` in case they arent installed in your computer.

# Exercise 1
```
Merge the training and the test sets to create one data set. 
```

This is the code that does most of the data handling in the Course Project. It reads all the required the files and merge them to create one single data set.

I do the following:

1. The train and test sets (*X_train.txt* and *X_test* respectively) are merged through ```rbind()``` (because they're just different observations of the same variables) and take the names of the variables of this data set from the *features.txt* file. We call this data set *traintest*.
2. The train and test subjects sets (*subject_train.txt* and *subject_test.txt* respectively) are merged through ```rbind()``` (for the same reason above) to make the *traintestsubj* data set.
3. The train and test activities labels sets (*y_train.txt* and *y_test.txt* respectively) are merged through ```rbind()``` (for the same reason above) to make the *traintestlabs* data set.
4. I add the variables in *traintestsubj* and *traintestlabs* data sets to *traintest* data set through ```cbind()```. This final data set is called *dataset*.

##Code
```
#######################################################
# EXERCISE 1 - Merge the training and the test sets   # 
# to create one data set.                             #

#######################################################
# READING AND PREPARING SETS                          #

# Training and test data sets

# Training set
train<-read.table('./UCI HAR Dataset/train/X_train.txt')
# Test set
test<-read.table('./UCI HAR Dataset/test/X_test.txt')
# Merge these two sets
traintest<-rbind(train,test)
# Read the variable names data set
features<-read.table('./UCI HAR Dataset/features.txt')
# Apply theses names to the traintest set
colnames(traintest)<-as.character(features$V2)

# Subject data sets

# Training subjects set
trainsubj<-read.table('./UCI HAR Dataset/train/subject_train.txt')
# Test subjects set
testsubj<-read.table('./UCI HAR Dataset/test/subject_test.txt')
# Merge these two sets
traintestsubj<-rbind(trainsubj,testsubj)
# Rename the first column for merging later
traintestsubj<-rename(traintestsubj, subject = V1)

# Activities labels data sets

# Training labels set
trainlabs<-read.table('./UCI HAR Dataset/train/y_train.txt')
# Test labels set
testlabs<-read.table('./UCI HAR Dataset/test/y_test.txt')
# Merge these two sets
traintestlabs<-rbind(trainlabs,testlabs)
# Rename the first column for merging later
traintestlabs<-rename(traintestlabs, activitylab = V1)

#######################################################
# EXERCISE 1 - Answer                                 # 

dataset<-cbind(traintestsubj,traintest,traintestlabs)
```

# Exercise 2
```
Extract only the measurements on the mean and standard deviation for each measurement.
```

This exercise is done with the help of the ```grep``` function. The answer for this exercise is stored in the *answer* data set.

I create a new data set called *datasetmeanstd*: it keeps only the measurements on the mean and standard deviation variables but also has the activity label (*activitylab*) and subject (*subject*) variables. They will be used in the next exercises.

##Code
```
#######################################################
# EXERCISE 2 -  Extracts only the measurements on the #
# mean and standard deviation for each measurement.   #

# We get the names of the columns with "mean" or
# "std" on them

namesmeanstd<-grep("mean\\(\\)|std\\(\\)",
                   features$V2,
                   value=TRUE)

#######################################################
# EXERCISE 2 -  Answer                                #
answer<-dataset[,namesmeanstd]

# Prepare the data set for the next exercise
datasetmeanstd<-dataset[,c(namesmeanstd,"activitylab","subject")]
```

# Exercise 3
```
Use descriptive activity names to name the activities in the data set.
```

In this exercise we will add a now collumn that describes the activities. For example, the activity called *1* in the *activitylab* variable actually represents *walking*. 

The relation between these two variables is given in the *activity_labels.txt* file, so I read it and merge the activity description (*activitydesc*) through the *activitylab* variable using the ```join``` function from the *plyr* package. The data set *datasetmeanstd* is overwritten.

##Code
```
#######################################################
# EXERCISE 3 -  Use descriptive activity names to name#
# the activities in the data set.                     #

# Read the data set with the activities descriptions
actdesc<-read.table('./UCI HAR Dataset/activity_labels.txt')
actdesc<-rename(actdesc, 
                activitylab=V1,
                activitydesc=V2)

# Merge the data sets

#######################################################
# EXERCISE 3 -  Answer                                #
datasetmeanstd<-join(datasetmeanstd,actdesc)
```

# Exercise 4
```
Appropriately labels the data set with descriptive variable names.
```

Here I change the names of the variables from the *datasetmeanstd* data set with the ```gsub``` function. I followed the following approach: all variables names should be easily readable and understandable, contain only lower case characters and not any other symbol.

After changes are made, all variables are in the format *aa-bb-cc*.

##Code
```
#######################################################
# EXERCISE 4 -  Appropriately labels the data set     #
# with descriptive variable names.                    #

# We put all the variable names in the same format:
# aa-bb-cc and so forth. We get rid of "()", we put
# "-" to make them easier to read and make all the
# names lower case
names(datasetmeanstd)<-gsub("\\()",       "",               names(datasetmeanstd))
names(datasetmeanstd)<-gsub("^t",        "time",            names(datasetmeanstd))
names(datasetmeanstd)<-gsub("^f",        "freq",            names(datasetmeanstd))
names(datasetmeanstd)<-gsub("Acc",       "-accelerometer",  names(datasetmeanstd))
names(datasetmeanstd)<-gsub("Gyro",      "-gyroscope",      names(datasetmeanstd))
names(datasetmeanstd)<-gsub("Mag",       "-magnitude",      names(datasetmeanstd))
names(datasetmeanstd)<-gsub("Body",      "-body",           names(datasetmeanstd))
names(datasetmeanstd)<-gsub("Gravity",   "-gravity",        names(datasetmeanstd))
names(datasetmeanstd)<-gsub("Jerk",      "-jerk",           names(datasetmeanstd))
```

# Exercise 5
```
From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
```

The *datasetmeanstd* data set is grouped by activity and subject and summarized with the ```group_by``` and ```summarize_each``` functions from the ```dplyr``` package, respectively. The data set is written in the work directory as a *.txt* file.

##Code
```
#######################################################
# EXERCISE 5 -  From the data set in step 4, create a #
# second, independent tidy data set with the average  #
# of each variable for each activity and each subject.#

# We group the data set from exercise 4 by subject
# and activity

groupdata<-group_by(datasetmeanstd, activitylab, subject)
summaridata<-summarize_each(as.tbl(groupdata),
                            funs(mean),
                            1:66)
# Writhe the summarized data set to a txt file in
# the working directory
write.table(summaridata, "tidydata.txt", row.name=FALSE)
```
