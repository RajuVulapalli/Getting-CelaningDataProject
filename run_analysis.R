##download the files
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

##unzip the files
unzip(zipfile="./data/Dataset.zip",exdir="./data")

##checking files in the folder

path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

### read the Activity files
AcitivityTest_Data <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
AcitivityTrain_Data <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
## Read the Subject files
SubjectTrain_Data <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
SubjectTest_Data <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
## Read Features files
FeaturesTrain_Data <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
FeaturesTest_Data <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
##Merging training and testing data sets
##Concatenate the data tables by rows
Subject_Data <- rbind(SubjectTrain_Data, SubjectTest_Data)
Activity_Data <- rbind(AcitivityTrain_Data, AcitivityTest_Data)
Features_Data <- rbind(FeaturesTrain_Data, FeaturesTest_Data)
## Giving names to variables
names(Subject_Data) <- c("Subject")
names(Activity_Data) <- c("Activity")
Features_Data_Names <- read.table("features.txt", header = FALSE)
names(Features_Data) <- Features_Data_Names$V2
##Step 1  Merge coulmns to get the dataframe "AllData" 
CombinedData <- cbind(Subject_Data, Activity_Data)
AllData <- cbind(Features_Data, CombinedData)
##  Step 2 and 3 Sub-setting Names of Features by measurements on the mean and sd
Features_Data_NamesSubset <- Features_Data_Names$V2[grep("mean\\(\\)|std\\(\\)", Features_Data_Names$V2)]
## Sub-seeting FinalData frame by selected Features Names
SelectedNames <- c(as.character(Features_Data_NamesSubset),"Subject", "Activity")
SelectedData <- subset(AllData, select = SelectedNames)
## Checking data frams "SelectedData"
str(SelectedData)
## reading activity_labels and check the activity description names in data set
ActivityLabels <- read.table("activity_labels.txt", header = FALSE)
#########ActivityLabels[,2] <- as.character(ActivityLabels[,2])
##turing activities and subjects into factors
AllData$Activity <- factor(AllData$Activity, levels = ActivityLabels[,1], labels = ActivityLabels[,2])
##AllData$Subject <- as.factor(AllData$Subject)
##AllData$Activity <- factor(AllData$Activity, levels = ActivityLabels[,1], labels = ActivityLabels[,2])
head(AllData$Activity, 20)
## Step 4 Feature variable change to meaning ful variables
names(SelectedData) <- gsub("Acc", "Accelerometer", names(SelectedData))
names(SelectedData) <- gsub("BodyBody", "Body", names(SelectedData))
names(SelectedData) <- gsub("Gyro", "Gyroscope", names(SelectedData))
names(SelectedData) <- gsub("Mag", "Magnitude", names(SelectedData))
names(SelectedData) <- gsub("^f", "frequency", names(SelectedData))
names(SelectedData) <- gsub("^t", "time", names(SelectedData))
## Step 5 Creating a second independent tidy data set and out put it as txt file
library(plyr)
tidyData <- aggregate(.~Subject + Activity, SelectedData, mean)
tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity),]
write.table(tidyData, file = "tidyData.txt", row.names = FALSE)
names(tidyData) ## 68 columns