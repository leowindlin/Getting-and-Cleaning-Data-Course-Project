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