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