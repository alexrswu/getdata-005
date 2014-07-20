###
# run_analysis.R
#
# This script has the following goals:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#
# Note: The script uses the unzip shell command in a linux/mac fashion way to extract dataset files.
###

# Check required R libraries
if (!require("data.table")) install.packages("data.table")
if (!require("reshape2")) install.packages("reshape2")

# Load needed packages
require("data.table")
require("reshape2")

# Set current working directory
setwd("/Users/mirco/Dropbox/E-Courses/Coursera/DataScience/3. Getting and Cleaning Data/Project/getdata-005")

# Get Dataset file and save it to the current working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "UCI_HAR_DataSet.zip"
dataFolderName <- "data"
dataSetPath <- "./data/UCI HAR Dataset"

if(!file.exists(filename)) {
        download.file(fileUrl, destfile=filename, method="curl")        
}

# Extracts DatSet file and save it into 'data' folder
if(!file.exists(dataFolderName)){
        dir.create(dataFolderName)
        if(!file.exists(dataSetPath)) {
                unzipCmd <- paste(paste("unzip", filename), paste0("-d ./", dataFolderName))
                system(unzipCmd)
        }
}

# Read Training subject, activity and data files.
#
# Note:
# fread() is faster than data.table() but some error occurs reading the dataset file. 
# For uniformity fread() has been replaced with read.table()
# Anyway, performances are not so bad in this case.
dtSubjectTrain <- read.table(file.path(dataSetPath, "train", "subject_train.txt"))
dtActivityTrain <- read.table(file.path(dataSetPath, "train", "Y_train.txt"))
dtTrain <- data.table(read.table(file.path(dataSetPath, "train", "X_train.txt")))

# Read Test subject, activity and data files.
#
# Note:
# fread() is faster than data.table() but some error occurs reading the dataset file. 
# For uniformity fread() has been replaced with read.table()
# Anyway, performances are not so bad in this case.
dtSubjectTest <- read.table(file.path(dataSetPath, "test", "subject_test.txt"))
dtActivityTest <- read.table(file.path(dataSetPath, "test", "Y_test.txt"))
dtTest <- data.table(read.table(file.path(dataSetPath, "test", "X_test.txt")))

##
# 1st script goal
# Merges the training and the test sets to create one data set.
##
dtSubject <- rbind(dtSubjectTrain, dtSubjectTest)
setnames(dtSubject, "V1", "subject") #setnames(x,old,new)

dtActivity <- rbind(dtActivityTrain, dtActivityTest)
setnames(dtActivity, "V1", "activityNumber") #setnames(x,old,new)

dt <- rbind(dtTrain, dtTest) #combining Objects by rows
dtAll <- cbind(dtSubject, dtActivity) #combining Objects by columns
dtFinal <- cbind(dtAll, dt)

dtFinal <- data.table(dtFinal) #convert data.frame to data.table

setkey(dtFinal, subject, activityNumber) #sorts a data.table and marks it as sorted

##
# 2nd script goal
# Extracts only the measurements on the mean and standard deviation for each measurement.
##
dtFeatures <- fread(file.path(dataSetPath, "features.txt"))
setnames(dtFeatures, names(dtFeatures), c("featureNumber", "featureName"))

# subsetting only measurements for the mean and standard deviation.
dtExtractedFeatures <- dtFeatures[grepl("mean|std", featureName)]

featureCode <- dtFeatures[, paste0("V", featureNumber)]
head(dtFeatures)
select <- c(key(dtFinal), featureCode)
dtFinal <- dtFinal[, select, with=FALSE]


##
# 3rd script goal
# Uses descriptive activity names to name the activities in the data set
##

# used to add descriptive names to the activities
dtActivityNames <- fread(file.path(dataSetPath, "activity_labels.txt")) 
setnames(dtActivityNames, names(dtActivityNames), c("activityNumber", "activityName")) 