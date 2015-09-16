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