###-----Getting and Cleaning Data - Week 4 Programming Assignment----###

#Download data and place in "Data Files" folder

setwd("C:/RStudio/Coursera/Getting and Cleaning Data")
getwd()

if (!file.exists("Data Files")) {
      dir.create("Data Files")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Data Files/Dataset.zip")

#Unzip the dataset
unzip(zipfile = "./Data Files/Dataset.zip", exdir = "./Data Files")

#List of Files in UCI HAR Dataset
path_rf <- file.path("./Data Files" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

#Read data from files into variables
#Activity files
dataActivityTest <- read.table(file.path(path_rf,"test","y_test.txt"),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf,"train","y_train.txt"),header = FALSE)
#Look at the structure of the activity files
str(dataActivityTest)
str(dataActivityTrain)

#Features files
dataFeaturesTest <- read.table(file.path(path_rf,"test","x_test.txt"),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf,"train","x_train.txt"),header = FALSE)
#Look at the structure of the features files
str(dataFeaturesTest)
str(dataFeaturesTrain)

#Subject files                                
dataSubjectTest <- read.table(file.path(path_rf,"test","subject_test.txt"),header = FALSE)
dataSubjectTrain <- read.table(file.path(path_rf,"train","subject_train.txt"),header = FALSE)
#Look at the structure of the subject files
str(dataSubjectTest)
str(dataSubjectTrain)

#Combine the activity test and training data frames into one
dataActivity <- rbind(dataActivityTest,dataActivityTrain)
str(dataActivity)

#Combine data from test and train features into one
dataFeatures <- rbind(dataFeaturesTest,dataFeaturesTrain)
str(dataFeatures)

#Combine the data from test and train subject into one
dataSubject <- rbind(dataSubjectTest,dataSubjectTrain)
str(dataSubject)

#Provide column names
names(dataActivity) <- c("Activity")
names(dataSubject) <- c("Subject")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"), header = FALSE)
names(dataFeatures) <- dataFeaturesNames$V2
#Check the column names
colnames(dataActivity)
colnames(dataSubject)
colnames(dataFeatures)

#Merge the Activity, Features, and Subject data frames into one
dataAct_Subj <- cbind(dataActivity,dataSubject)
alldata <- cbind(dataFeatures, dataAct_Subj)
#Review the combined data frame
head(alldata)
str(alldata)
summary(alldata)

#Extract measurements on mean and standard deviation
subsetFeatureNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)",dataFeaturesNames$V2)]
#Subset the data frame by selected names of Features
selectedNames <- c(as.character(subsetFeatureNames), "Subject", "Activity")
Data <-subset(alldata,select = selectedNames)
#Look at the structure
str(Data)

#Read the activity names from the "activity_lables.txt"
activityLables <- read.table(file.path(path_rf,"activity_labels.txt"), header = FALSE)
#activityLables <- as.factor(activityLables)
Data$Activity <- as.character(Data$Activity)
      for (i in 1:6) {
      Data$Activity[Data$Activity == i] <- as.character(activityLables[i,2])
      }

Data$Activity <- as.factor(Data$Activity)

#Label data set with descriptive variable names
#Prefix t replace with "time"
#ACC is replaced with "Accelerometer
#Gyro is replaced by "Gyroscope"
#prefix f is replaced with "frequency"
#Mag is replaced by "Magnitude"
#BodyBody is replaced by "Body"
names(Data) <- gsub("^t","time", names(Data))
names(Data) <- gsub("^f","frequency", names(Data))
names(Data) <- gsub("Acc","Accelerometer", names(Data))
names(Data) <- gsub("Gyro","Gyroscope", names(Data))
names(Data) <- gsub("Mag","Magnitude", names(Data))
names(Data) <- gsub("BodyBody","Body", names(Data))
names(Data) <- gsub("tBody","TimeBody", names(Data))

#Check
names(Data)

#Create a tidy data set and output file
library(plyr)
Data2 <- aggregate(. ~Subject + Activity, Data, mean)
Data2 <- Data2[order(Data2$Subject, Data2$Activity),]
write.table(Data2, file = "tidydata.txt", row.names = FALSE)





