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
