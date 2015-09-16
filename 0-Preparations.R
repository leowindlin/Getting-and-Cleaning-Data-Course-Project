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