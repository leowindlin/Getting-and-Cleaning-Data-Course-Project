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
