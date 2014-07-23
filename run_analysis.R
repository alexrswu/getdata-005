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
if(!require("data.table")) install.packages("data.table")
if(!require("reshape2")) install.packages("reshape2")

# Load needed packages
require("data.table")
require("reshape2")

# Set current working directory
setwd("_path_to_where_you_save_this_file_")

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
} else {
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
select <- c(key(dtFinal), featureCode)
dtFinal <- dtFinal[, select, with=FALSE]


##
# 3rd script goal
# Uses descriptive activity names to name the activities in the data set
##
dtActivityNames <- fread(file.path(dataSetPath, "activity_labels.txt")) 
setnames(dtActivityNames, names(dtActivityNames), c("activityNumber", "activityName")) 


##
# 4th script goal
# Appropriately labels the data set with descriptive variable names
##
dtFinal <- merge(dtFinal, dtActivityNames, by="activityNumber", all.x=TRUE)
setkey(dtFinal, subject, activityNumber, activityName)

dtFinal <- data.table(melt(dtFinal, key(dtFinal), variable.name="featureCode"))
dtFinal <- merge(dtFinal, dtFeatures[, list(featureNumber, featureCode, featureName)], by="featureCode", all.x=TRUE)

dtFinal$activity <- factor(dtFinal$activityName)
dtFinal$feature <- factor(dtFinal$featureName)

# features with 1 category
dtFinal$jerkFeature <- factor(grepl("Jerk", dtFinal$feature), labels=c(NA, "Jerk"))
dtFinal$magnitudeFeature <- factor(grepl("Mag", dtFinal$feature), labels=c(NA, "Magnitude"))

# features with 2 categories
m <- matrix(1:2, nrow=2)

grepped <- c(grepl("^t", dtFinal$feature), grepl("^f", dtFinal$feature))
mx <- matrix(grepped, ncol=nrow(m))
dtFinal$domainFeature <- factor(mx %*% m, labels=c(NA, "Time", "Frequency"))

grepped <- c(grepl("Acc", dtFinal$feature), grepl("Gyro", dtFinal$feature))
mx <- matrix(grepped, ncol=nrow(m))
dtFinal$instrumentsFeature <- factor(mx %*% m, labels=c(NA, "Accelerometer", "Gyroscope"))

grepped <- c(grepl("BodyAcc", dtFinal$feature), grepl("GravityAcc", dtFinal$feature))
mx <- matrix(grepped, ncol=nrow(m))
dtFinal$accelerationFeature <- factor(mx %*% m, labels=c(NA, "Body", "Gravity"))

grepped <- c(grepl("mean()", dtFinal$feature), grepl("std()", dtFinal$feature))
mx <- matrix(grepped, ncol=nrow(m))
dtFinal$variableFeature <- factor(mx %*% m, labels=c(NA, "Mean", "Standard Deviation"))

# features with 3 categories
m <- matrix(1:3, nrow=3)

grepped <- c(grepl("-X", dtFinal$feature), grepl("-Y", dtFinal$feature), grepl("-Z", dtFinal$feature))
mx <- matrix(grepped, ncol = nrow(m))

dtFinal$axisFeature <- factor(mx %*% m, labels=c(NA, "X", "Y", "Z"))

##
# 5th script goal
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject
##
setkey(dtFinal, subject, activity, domainFeature, accelerationFeature, instrumentsFeature, jerkFeature, magnitudeFeature, variableFeature, axisFeature)
dtTidyDataSet <- dtFinal[, list(count = .N, average = mean(value)), by = key(dtFinal)]

# Saving the tidy data set to file.
write.table(dtTidyDataSet, "tidy.txt", sep="\t")