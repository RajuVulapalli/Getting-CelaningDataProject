Getting and Cleaning Data – Course Project

This repository contains the R code and Documentation files for the Course Project requirements of “Getting and Cleaning Data”
The original data on Human Activity Recognition Using Smartphones is from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
A sub-set of this data was used for this project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


This document contains the details of how the code works with example data.  The file “run_analysis.R” has the code that can be executed to get the tidy data set.  The tidyData.txt contains the tidy data.  The Code Book in this repository contains the details of variables.
Getting the data
1. Download the file and put the file in the “Data” folder
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
 [1] "activity_labels.txt"                         
 [2] "features.txt"                                
 [3] "features_info.txt"                           
 [4] "README.txt"                                  
 [5] "test/Inertial Signals/body_acc_x_test.txt"   
 [6] "test/Inertial Signals/body_acc_y_test.txt"   
 [7] "test/Inertial Signals/body_acc_z_test.txt"   
 [8] "test/Inertial Signals/body_gyro_x_test.txt"  
 [9] "test/Inertial Signals/body_gyro_y_test.txt"  
[10] "test/Inertial Signals/body_gyro_z_test.txt"  
[11] "test/Inertial Signals/total_acc_x_test.txt"  
[12] "test/Inertial Signals/total_acc_y_test.txt"  
[13] "test/Inertial Signals/total_acc_z_test.txt"  
[14] "test/subject_test.txt"                       
[15] "test/X_test.txt"                             
[16] "test/y_test.txt"                             
[17] "train/Inertial Signals/body_acc_x_train.txt" 
[18] "train/Inertial Signals/body_acc_y_train.txt" 
[19] "train/Inertial Signals/body_acc_z_train.txt" 
[20] "train/Inertial Signals/body_gyro_x_train.txt"
[21] "train/Inertial Signals/body_gyro_y_train.txt"
[22] "train/Inertial Signals/body_gyro_z_train.txt"
[23] "train/Inertial Signals/total_acc_x_train.txt"
[24] "train/Inertial Signals/total_acc_y_train.txt"
[25] "train/Inertial Signals/total_acc_z_train.txt"
[26] "train/subject_train.txt"                     
[27] "train/X_train.txt"                           
[28] "train/y_train.txt"                           
From Readme.txt file for the detailed information on the dataset. For the purposes of this 
project, we will be using the following files :
* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt
       From the related files, we can see:
1. Values of Variable “Activity” consists of data from “Y_train.txt” and “Y_test.txt”
2. Values of Variable “Subject” consist of data from “subject_train.txt” and subject_test.txt"
3. Values of Variable ”Features” consist of data from “X_train.txt” and “X_test.txt”
4. Names of Variable ”Features” consist of data from “features.txt”
5. Levels of Variable “Activity” comes from  “activity_lables.txt”
Based on this “Activity, Subject and Features” can be sued as part of descriptive variable names for the data in the data frame.
2.  Read data from the files into the variables
a. Read the Activity files
AcitivityTest_Data <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
AcitivityTrain_Data <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE) 
b. Read the Subject files
SubjectTrain_Data <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
SubjectTest_Data <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE) c. 
c. Read Features files
FeaturesTrain_Data <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
FeaturesTest_Data <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE) 3. Look at the properties of these variables
> str(AcitivityTest_Data)
'data.frame':	2947 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
> str(AcitivityTrain_Data)
'data.frame':	7352 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...
> str(SubjectTrain_Data)
'data.frame':	7352 obs. of  1 variable:
 $ V1: int  1 1 1 1 1 1 1 1 1 1 ...
> str(SubjectTest_Data)
'data.frame':	2947 obs. of  1 variable:
 $ V1: int  2 2 2 2 2 2 2 2 2 2 ...
> str(FeaturesTrain_Data)
'data.frame':	7352 obs. of  561 variables:
 $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
 $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
 $ V4  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
 $ V5  : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
 $ V6  : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
 $ V7  : num  -0.995 -0.999 -0.997 -0.997 -0.998 ...
 $ V8  : num  -0.983 -0.975 -0.964 -0.983 -0.98 ...
 $ V9  : num  -0.924 -0.958 -0.977 -0.989 -0.99 ...
.
.
. $ V66 : num  -0.59042 -0.41006 0.00223 -0.06493 -0.25727 ...
 $ V67 : num  0.5911 0.4139 0.0275 0.0754 0.2689 ...
 $ V68 : num  -0.5918 -0.4176 -0.0567 -0.0858 -0.2807 ...
 $ V69 : num  0.5925 0.4213 0.0855 0.0962 0.2926 ...
 $ V70 : num  -0.745 -0.196 -0.329 -0.295 -0.167 ...
 $ V71 : num  0.7209 0.1253 0.2705 0.2283 0.0899 ...
 $ V72 : num  -0.7124 -0.1056 -0.2545 -0.2063 -0.0663 ...
 $ V73 : num  0.7113 0.1091 0.2576 0.2048 0.0671 ...
 $ V74 : num  -0.995 -0.834 -0.705 -0.385 -0.237 ...
 $ V75 : num  0.996 0.834 0.714 0.386 0.239 ...
 $ V76 : num  -0.996 -0.834 -0.723 -0.387 -0.241 ...
 $ V77 : num  0.992 0.83 0.729 0.385 0.241 ...
 $ V78 : num  0.57 -0.831 -0.181 -0.991 -0.408 ...
 $ V79 : num  0.439 -0.866 0.338 -0.969 -0.185 ...
 $ V80 : num  0.987 0.974 0.643 0.984 0.965 ...
 $ V81 : num  0.078 0.074 0.0736 0.0773 0.0734 ...
 $ V82 : num  0.005 0.00577 0.0031 0.02006 0.01912 ...
 $ V83 : num  -0.06783 0.02938 -0.00905 -0.00986 0.01678 ...
 $ V84 : num  -0.994 -0.996 -0.991 -0.993 -0.996 ...
 $ V85 : num  -0.988 -0.981 -0.981 -0.988 -0.988 ...
 $ V86 : num  -0.994 -0.992 -0.99 -0.993 -0.992 ...
 $ V87 : num  -0.994 -0.996 -0.991 -0.994 -0.997 ...
 $ V88 : num  -0.986 -0.979 -0.979 -0.986 -0.987 ...
 $ V89 : num  -0.993 -0.991 -0.987 -0.991 -0.991 ...
 $ V90 : num  -0.985 -0.995 -0.987 -0.987 -0.997 ...
 $ V91 : num  -0.992 -0.979 -0.979 -0.992 -0.992 ...
 $ V92 : num  -0.993 -0.992 -0.992 -0.99 -0.99 ...
 $ V93 : num  0.99 0.993 0.988 0.988 0.994 ...
 $ V94 : num  0.992 0.992 0.992 0.993 0.993 ...
 $ V95 : num  0.991 0.989 0.989 0.993 0.986 ...
 $ V96 : num  -0.994 -0.991 -0.988 -0.993 -0.994 ...
 $ V97 : num  -1 -1 -1 -1 -1 ...
 $ V98 : num  -1 -1 -1 -1 -1 ...
 $ V99 : num  -1 -1 -1 -1 -1 ...
  [list output truncated]
> str(FeaturesTest_Data)
'data.frame':	2947 obs. of  561 variables:
 $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
 $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ V3  : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
 $ V4  : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
 $ V5  : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
 $ V6  : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
 $ V7  : num  -0.953 -0.987 -0.994 -0.995 -0.994 ...
 $ V8  : num  -0.925 -0.968 -0.971 -0.974 -0.966 ...
 $ V9  : num  -0.674 -0.946 -0.963 -0.969 -0.977 ...
 $ V10 : num  -0.894 -0.894 -0.939 -0.939 -0.939 ...
 $ V11 : num  -0.555 -0.555 -0.569 -0.569 -0.561 ...
 $ V12 : num  -0.466 -0.806 -0.799 -0.799 -0.826 ...
 $ V13 : num  0.717 0.768 0.848 0.848 0.849 ...
 $ V14 : num  0.636 0.684 0.668 0.668 0.671 ...
 $ V15 : num  0.789 0.797 0.822 0.822 0.83 ...
 $ V16 : num  -0.878 -0.969 -0.977 -0.974 -0.975 ...
 $ V17 : num  -0.998 -1 -1 -1 -1 ...
 $ V18 : num  -0.998 -1 -1 -0.999 -0.999 ...
 $ V19 : num  -0.934 -0.998 -0.999 -0.999 -0.999 ...
 $ V20 : num  -0.976 -0.994 -0.993 -0.995 -0.993 ...
 $ V21 : num  -0.95 -0.974 -0.974 -0.979 -0.967 ...
 $ V22 : num  -0.83 -0.951 -0.965 -0.97 -0.976 ...
 $ V23 : num  -0.168 -0.302 -0.618 -0.75 -0.591 ...
 $ V24 : num  -0.379 -0.348 -0.695 -0.899 -0.74 ...
 $ V25 : num  0.246 -0.405 -0.537 -0.554 -0.799 ...
 $ V26 : num  0.521 0.507 0.242 0.175 0.116 ...
 $ V27 : num  -0.4878 -0.1565 -0.115 -0.0513 -0.0289 ...
 $ V28 : num  0.4823 0.0407 0.0327 0.0342 -0.0328 ...
 $ V29 : num  -0.0455 0.273 0.1924 0.1536 0.2943 ...
 $ V30 : num  0.21196 0.19757 -0.01194 0.03077 0.00063 ...
 $ V31 : num  -0.1349 -0.1946 -0.0634 -0.1293 -0.0453 ...
 $ V32 : num  0.131 0.411 0.471 0.446 0.168 ...
 $ V33 : num  -0.0142 -0.3405 -0.5074 -0.4195 -0.0682 ...
 $ V34 : num  -0.106 0.0776 0.1885 0.2715 0.0744 ...
 $ V35 : num  0.0735 -0.084 -0.2316 -0.2258 0.0271 ...
 $ V36 : num  -0.1715 0.0353 0.6321 0.4164 -0.1459 ...
 $ V37 : num  0.0401 -0.0101 -0.5507 -0.2864 -0.0502 ...
 $ V38 : num  0.077 -0.105 0.3057 -0.0638 0.2352 ...
 $ V39 : num  -0.491 -0.429 -0.324 -0.167 0.29 ...
 $ V40 : num  -0.709 0.399 0.28 0.545 0.458 ...
 $ V41 : num  0.936 0.927 0.93 0.929 0.927 ...
 $ V42 : num  -0.283 -0.289 -0.288 -0.293 -0.303 ...
 $ V43 : num  0.115 0.153 0.146 0.143 0.138 ...
 $ V44 : num  -0.925 -0.989 -0.996 -0.993 -0.996 ...
 $ V45 : num  -0.937 -0.984 -0.988 -0.97 -0.971 ...
 $ V46 : num  -0.564 -0.965 -0.982 -0.992 -0.968 ...
 $ V47 : num  -0.93 -0.989 -0.996 -0.993 -0.996 ...
 $ V48 : num  -0.938 -0.983 -0.989 -0.971 -0.971 ...
 $ V49 : num  -0.606 -0.965 -0.98 -0.993 -0.969 ...
 $ V50 : num  0.906 0.856 0.856 0.856 0.854 ...
 $ V51 : num  -0.279 -0.305 -0.305 -0.305 -0.313 ...
 $ V52 : num  0.153 0.153 0.139 0.136 0.134 ...
 $ V53 : num  0.944 0.944 0.949 0.947 0.946 ...
 $ V54 : num  -0.262 -0.262 -0.262 -0.273 -0.279 ...
 $ V55 : num  -0.0762 0.149 0.145 0.1421 0.1309 ...
 $ V56 : num  -0.0178 0.0577 0.0406 0.0461 0.0554 ...
 $ V57 : num  0.829 0.806 0.812 0.809 0.804 ...
 $ V58 : num  -0.865 -0.858 -0.86 -0.854 -0.843 ...
 $ V59 : num  -0.968 -0.957 -0.961 -0.963 -0.965 ...
 $ V60 : num  -0.95 -0.988 -0.996 -0.992 -0.996 ...
 $ V61 : num  -0.946 -0.982 -0.99 -0.973 -0.972 ...
 $ V62 : num  -0.76 -0.971 -0.979 -0.996 -0.969 ...
 $ V63 : num  -0.425 -0.729 -0.823 -0.823 -0.83 ...
 $ V64 : num  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...
 $ V65 : num  0.219 -0.465 -0.53 -0.7 -0.302 ...
 $ V66 : num  -0.43 -0.51 -0.295 -0.343 -0.482 ...
 $ V67 : num  0.431 0.525 0.305 0.359 0.539 ...
 $ V68 : num  -0.432 -0.54 -0.315 -0.375 -0.596 ...
 $ V69 : num  0.433 0.554 0.326 0.392 0.655 ...
 $ V70 : num  -0.795 -0.746 -0.232 -0.233 -0.493 ...
 $ V71 : num  0.781 0.733 0.169 0.176 0.463 ...
 $ V72 : num  -0.78 -0.737 -0.155 -0.169 -0.465 ...
 $ V73 : num  0.785 0.749 0.164 0.185 0.483 ...
 $ V74 : num  -0.984 -0.845 -0.429 -0.297 -0.536 ...
 $ V75 : num  0.987 0.869 0.44 0.304 0.544 ...
 $ V76 : num  -0.989 -0.893 -0.451 -0.311 -0.553 ...
 $ V77 : num  0.988 0.913 0.458 0.315 0.559 ...
 $ V78 : num  0.981 0.945 0.548 0.986 0.998 ...
 $ V79 : num  -0.996 -0.911 -0.335 0.653 0.916 ...
 $ V80 : num  -0.96 -0.739 0.59 0.747 0.929 ...
 $ V81 : num  0.072 0.0702 0.0694 0.0749 0.0784 ...
 $ V82 : num  0.04575 -0.01788 -0.00491 0.03227 0.02228 ...
 $ V83 : num  -0.10604 -0.00172 -0.01367 0.01214 0.00275 ...
 $ V84 : num  -0.907 -0.949 -0.991 -0.991 -0.992 ...
 $ V85 : num  -0.938 -0.973 -0.971 -0.973 -0.979 ...
 $ V86 : num  -0.936 -0.978 -0.973 -0.976 -0.987 ...
 $ V87 : num  -0.916 -0.969 -0.991 -0.99 -0.991 ...
 $ V88 : num  -0.937 -0.974 -0.973 -0.973 -0.977 ...
 $ V89 : num  -0.949 -0.979 -0.975 -0.978 -0.985 ...
 $ V90 : num  -0.903 -0.915 -0.992 -0.992 -0.994 ...
 $ V91 : num  -0.95 -0.981 -0.975 -0.975 -0.986 ...
 $ V92 : num  -0.891 -0.978 -0.962 -0.962 -0.986 ...
 $ V93 : num  0.898 0.898 0.994 0.994 0.994 ...
 $ V94 : num  0.95 0.968 0.976 0.976 0.98 ...
 $ V95 : num  0.946 0.966 0.966 0.97 0.985 ...
 $ V96 : num  -0.931 -0.974 -0.982 -0.983 -0.987 ...
 $ V97 : num  -0.995 -0.998 -1 -1 -1 ...
 $ V98 : num  -0.997 -0.999 -0.999 -0.999 -1 ...
 $ V99 : num  -0.997 -0.999 -0.999 -0.999 -1 ...
  [list output truncated]

I. Merging the training and the test datasets into one data set
       Concatenate the data tables by rows
Subject_Data <- rbind(SubjectTrain_Data, SubjectTest_Data)
Activity_Data <- rbind(AcitivityTrain_Data, AcitivityTest_Data)
Features_Data <- rbind(FeaturesTrain_Data, FeaturesTest_Data)
Set Names to variables
names(Subject_Data) <- c("Subject")
names(Activity_Data) <- c("Activity")
Features_Data_Names <- read.table("features.txt", header = FALSE)
names(Features_Data) <- Features_Data_Names$V2

       Merging columns to get the data frame “FinalData” for all data
CombinedData <- cbind(Subject_Data, Activity_Data)
AllData <- cbind(Features_Data, CombinedData)


II.   Dxtracting only the measurements on the mean and Standard Deviation for each measurement
1. Subsetting Name of Features by measurements on the mean and standard deviation.( taking Names of Features with “mean()” or “Std()”
Features_Data_NamesSubset <- Features_Data_Names$V2[grep("mean\\(\\)|std\\(\\)", Features_Data_Names$V2)]

2. Sub-setting the FinalData frame by selected names of Features
SelectedData <- subset(AllData, select = SelectedNames)
3. Checking the structure of the data frame “SelectedData”
str(SelectedData)
/////
'data.frame':	10299 obs. of  68 variables:
 $ tBodyAcc-mean()-X          : num  0.289 0.278 0.28 0.279 0.277 ...
 $ tBodyAcc-mean()-Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 $ tBodyAcc-mean()-Z          : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
 $ tBodyAcc-std()-X           : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
 $ tBodyAcc-std()-Y           : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
 $ tBodyAcc-std()-Z           : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
 $ tGravityAcc-mean()-X       : num  0.963 0.967 0.967 0.968 0.968 ...
 $ tGravityAcc-mean()-Y       : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
 $ tGravityAcc-mean()-Z       : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
 $ tGravityAcc-std()-X        : num  -0.985 -0.997 -1 -0.997 -0.998 ...
 $ tGravityAcc-std()-Y        : num  -0.982 -0.989 -0.993 -0.981 -0.988 ...
 $ tGravityAcc-std()-Z        : num  -0.878 -0.932 -0.993 -0.978 -0.979 ...
 $ tBodyAccJerk-mean()-X      : num  0.078 0.074 0.0736 0.0773 0.0734 ...
 $ tBodyAccJerk-mean()-Y      : num  0.005 0.00577 0.0031 0.02006 0.01912 ...
 $ tBodyAccJerk-mean()-Z      : num  -0.06783 0.02938 -0.00905 -0.00986 0.01678 ...
 $ tBodyAccJerk-std()-X       : num  -0.994 -0.996 -0.991 -0.993 -0.996 ...
 $ tBodyAccJerk-std()-Y       : num  -0.988 -0.981 -0.981 -0.988 -0.988 ...
 $ tBodyAccJerk-std()-Z       : num  -0.994 -0.992 -0.99 -0.993 -0.992 ...
 $ tBodyGyro-mean()-X         : num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
 $ tBodyGyro-mean()-Y         : num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
 $ tBodyGyro-mean()-Z         : num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
 $ tBodyGyro-std()-X          : num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
 $ tBodyGyro-std()-Y          : num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
 $ tBodyGyro-std()-Z          : num  -0.992 -0.989 -0.986 -0.988 -0.987 ...
 $ tBodyGyroJerk-mean()-X     : num  -0.0992 -0.1105 -0.1085 -0.0912 -0.0908 ...
 $ tBodyGyroJerk-mean()-Y     : num  -0.0555 -0.0448 -0.0424 -0.0363 -0.0376 ...
 $ tBodyGyroJerk-mean()-Z     : num  -0.062 -0.0592 -0.0558 -0.0605 -0.0583 ...
 $ tBodyGyroJerk-std()-X      : num  -0.992 -0.99 -0.988 -0.991 -0.991 ...
 $ tBodyGyroJerk-std()-Y      : num  -0.993 -0.997 -0.996 -0.997 -0.996 ...
 $ tBodyGyroJerk-std()-Z      : num  -0.992 -0.994 -0.992 -0.993 -0.995 ...
 $ tBodyAccMag-mean()         : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
 $ tBodyAccMag-std()          : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
 $ tGravityAccMag-mean()      : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
 $ tGravityAccMag-std()       : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
 $ tBodyAccJerkMag-mean()     : num  -0.993 -0.991 -0.989 -0.993 -0.993 ...
 $ tBodyAccJerkMag-std()      : num  -0.994 -0.992 -0.99 -0.993 -0.996 ...
 $ tBodyGyroMag-mean()        : num  -0.969 -0.981 -0.976 -0.982 -0.985 ...
 $ tBodyGyroMag-std()         : num  -0.964 -0.984 -0.986 -0.987 -0.989 ...
 $ tBodyGyroJerkMag-mean()    : num  -0.994 -0.995 -0.993 -0.996 -0.996 ...
 $ tBodyGyroJerkMag-std()     : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
 $ fBodyAcc-mean()-X          : num  -0.995 -0.997 -0.994 -0.995 -0.997 ...
 $ fBodyAcc-mean()-Y          : num  -0.983 -0.977 -0.973 -0.984 -0.982 ...
 $ fBodyAcc-mean()-Z          : num  -0.939 -0.974 -0.983 -0.991 -0.988 ...
 $ fBodyAcc-std()-X           : num  -0.995 -0.999 -0.996 -0.996 -0.999 ...
 $ fBodyAcc-std()-Y           : num  -0.983 -0.975 -0.966 -0.983 -0.98 ...
 $ fBodyAcc-std()-Z           : num  -0.906 -0.955 -0.977 -0.99 -0.992 ...
 $ fBodyAccJerk-mean()-X      : num  -0.992 -0.995 -0.991 -0.994 -0.996 ...
 $ fBodyAccJerk-mean()-Y      : num  -0.987 -0.981 -0.982 -0.989 -0.989 ...
 $ fBodyAccJerk-mean()-Z      : num  -0.99 -0.99 -0.988 -0.991 -0.991 ...
 $ fBodyAccJerk-std()-X       : num  -0.996 -0.997 -0.991 -0.991 -0.997 ...
 $ fBodyAccJerk-std()-Y       : num  -0.991 -0.982 -0.981 -0.987 -0.989 ...
 $ fBodyAccJerk-std()-Z       : num  -0.997 -0.993 -0.99 -0.994 -0.993 ...
 $ fBodyGyro-mean()-X         : num  -0.987 -0.977 -0.975 -0.987 -0.982 ...
 $ fBodyGyro-mean()-Y         : num  -0.982 -0.993 -0.994 -0.994 -0.993 ...
 $ fBodyGyro-mean()-Z         : num  -0.99 -0.99 -0.987 -0.987 -0.989 ...
 $ fBodyGyro-std()-X          : num  -0.985 -0.985 -0.977 -0.993 -0.986 ...
 $ fBodyGyro-std()-Y          : num  -0.974 -0.987 -0.993 -0.992 -0.992 ...
 $ fBodyGyro-std()-Z          : num  -0.994 -0.99 -0.987 -0.989 -0.988 ...
 $ fBodyAccMag-mean()         : num  -0.952 -0.981 -0.988 -0.988 -0.994 ...
 $ fBodyAccMag-std()          : num  -0.956 -0.976 -0.989 -0.987 -0.99 ...
 $ fBodyBodyAccJerkMag-mean() : num  -0.994 -0.99 -0.989 -0.993 -0.996 ...
 $ fBodyBodyAccJerkMag-std()  : num  -0.994 -0.992 -0.991 -0.992 -0.994 ...
 $ fBodyBodyGyroMag-mean()    : num  -0.98 -0.988 -0.989 -0.989 -0.991 ...
 $ fBodyBodyGyroMag-std()     : num  -0.961 -0.983 -0.986 -0.988 -0.989 ...
 $ fBodyBodyGyroJerkMag-mean(): num  -0.992 -0.996 -0.995 -0.995 -0.995 ...
 $ fBodyBodyGyroJerkMag-std() : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
 $ Subject                    : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity                   : int  5 5 5 5 5 5 5 5 5 5 ...

III.  Uses descriptive activity names to name the activities in the data set
## reading activity_labels and check the activity description names in data set
ActivityLabels <- read.table("activity_labels.txt", header = FALSE)
ActivityLabels[,2] <- as.character(ActivityLabels[,2])
## turning activities into factors
AllData$Activity <- factor(AllData$Activity, levels = ActivityLabels[,1], labels = ActivityLabels[,2])
head(AllData$Activity, 20)
 [1] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING
[12] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING

Levels: WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS SITTING STANDING LAYING

IV. Appropriately labels the data set with descriptive variable names. 

In this part, the Feature variable names are replaced by descriptive names.
- Acc is replaced by Accelerometer
- BodyBody is replaced by Body
- Gyro is replaced by Gyroscope
- Mag is replaced by Magnitude
- Prefix ‘f’ is replaced by frequency
- Prefix ‘t’ is replaced by time

names(AllData) <- gsub("Acc", "Accelerometer", names(AllData))
names(AllData) <- gsub("BodyBody", "Body", names(AllData))
names(AllData) <- gsub("Gyro", "Gyroscope", names(AllData))
names(AllData) <- gsub("Mag", "Magnitude", names(AllData))
names(AllData) <- gsub("^f", "frequency", names(AllData))
names(AllData) <- gsub("^t", "time", names(AllData))
       Checking
> names(AllData)
  [1] "timeBodyAccelerometer-mean()-X"                    
  [2] "timeBodyAccelerometer-mean()-Y"                    
  [3] "timeBodyAccelerometer-mean()-Z"                    
  [4] "timeBodyAccelerometer-std()-X"                     
  [5] "timeBodyAccelerometer-std()-Y"                     
  [6] "timeBodyAccelerometer-std()-Z"                     
  [7] "timeBodyAccelerometer-mad()-X"                     
  [8] "timeBodyAccelerometer-mad()-Y"                     
  [9] "timeBodyAccelerometer-mad()-Z"                     
 [10] "timeBodyAccelerometer-max()-X"                     
 [11] "timeBodyAccelerometer-max()-Y"                     
 [12] "timeBodyAccelerometer-max()-Z"                     
 [13] "timeBodyAccelerometer-min()-X"                     
 [14] "timeBodyAccelerometer-min()-Y"                     
 [15] "timeBodyAccelerometer-min()-Z"                     
 [16] "timeBodyAccelerometer-sma()"                       
 [17] "timeBodyAccelerometer-energy()-X"                  
 [18] "timeBodyAccelerometer-energy()-Y"                  
 [19] "timeBodyAccelerometer-energy()-Z"                  
 [20] "timeBodyAccelerometer-iqr()-X"                     
 [21] "timeBodyAccelerometer-iqr()-Y"                     
 [22] "timeBodyAccelerometer-iqr()-Z"                     
 [23] "timeBodyAccelerometer-entropy()-X"                 
 [24] "timeBodyAccelerometer-entropy()-Y"                 
 [25] "timeBodyAccelerometer-entropy()-Z"                 
 [26] "timeBodyAccelerometer-arCoeff()-X,1"               
 [27] "timeBodyAccelerometer-arCoeff()-X,2"               
 [28] "timeBodyAccelerometer-arCoeff()-X,3"               
 [29] "timeBodyAccelerometer-arCoeff()-X,4"               
 [30] "timeBodyAccelerometer-arCoeff()-Y,1"               
 [31] "timeBodyAccelerometer-arCoeff()-Y,2"               
 [32] "timeBodyAccelerometer-arCoeff()-Y,3"               
 [33] "timeBodyAccelerometer-arCoeff()-Y,4"               
 [34] "timeBodyAccelerometer-arCoeff()-Z,1"               
 [35] "timeBodyAccelerometer-arCoeff()-Z,2"               
 [36] "timeBodyAccelerometer-arCoeff()-Z,3"               
 [37] "timeBodyAccelerometer-arCoeff()-Z,4"               
 [38] "timeBodyAccelerometer-correlation()-X,Y"           
 [39] "timeBodyAccelerometer-correlation()-X,Z"           
 [40] "timeBodyAccelerometer-correlation()-Y,Z"           
 [41] "timeGravityAccelerometer-mean()-X"                 
 [42] "timeGravityAccelerometer-mean()-Y"                 
 [43] "timeGravityAccelerometer-mean()-Z"                 
 [44] "timeGravityAccelerometer-std()-X"                  
 [45] "timeGravityAccelerometer-std()-Y"                  
 [46] "timeGravityAccelerometer-std()-Z"                  
 [47] "timeGravityAccelerometer-mad()-X"                  
 [48] "timeGravityAccelerometer-mad()-Y"                  
 [49] "timeGravityAccelerometer-mad()-Z"                  
 [50] "timeGravityAccelerometer-max()-X"                  
 [51] "timeGravityAccelerometer-max()-Y"                  
 [52] "timeGravityAccelerometer-max()-Z"                  
 [53] "timeGravityAccelerometer-min()-X"                  
 [54] "timeGravityAccelerometer-min()-Y"                  
 [55] "timeGravityAccelerometer-min()-Z"                  
 [56] "timeGravityAccelerometer-sma()"                    
 [57] "timeGravityAccelerometer-energy()-X"               
 [58] "timeGravityAccelerometer-energy()-Y"               
 [59] "timeGravityAccelerometer-energy()-Z"               
 [60] "timeGravityAccelerometer-iqr()-X"                  
 [61] "timeGravityAccelerometer-iqr()-Y"                  
 [62] "timeGravityAccelerometer-iqr()-Z"                  
 [63] "timeGravityAccelerometer-entropy()-X"              
 [64] "timeGravityAccelerometer-entropy()-Y"              
 [65] "timeGravityAccelerometer-entropy()-Z"              
 [66] "timeGravityAccelerometer-arCoeff()-X,1"            
 [67] "timeGravityAccelerometer-arCoeff()-X,2"            
 [68] "timeGravityAccelerometer-arCoeff()-X,3"            
 [69] "timeGravityAccelerometer-arCoeff()-X,4"            
 [70] "timeGravityAccelerometer-arCoeff()-Y,1"            
 [71] "timeGravityAccelerometer-arCoeff()-Y,2"            
 [72] "timeGravityAccelerometer-arCoeff()-Y,3"            
 [73] "timeGravityAccelerometer-arCoeff()-Y,4"            
 [74] "timeGravityAccelerometer-arCoeff()-Z,1"            
 [75] "timeGravityAccelerometer-arCoeff()-Z,2"            
 [76] "timeGravityAccelerometer-arCoeff()-Z,3"            
 [77] "timeGravityAccelerometer-arCoeff()-Z,4"            
 [78] "timeGravityAccelerometer-correlation()-X,Y"        
 [79] "timeGravityAccelerometer-correlation()-X,Z"        
 [80] "timeGravityAccelerometer-correlation()-Y,Z"        
 [81] "timeBodyAccelerometerJerk-mean()-X"                
 [82] "timeBodyAccelerometerJerk-mean()-Y"                
 [83] "timeBodyAccelerometerJerk-mean()-Z"                
 [84] "timeBodyAccelerometerJerk-std()-X"                 
 [85] "timeBodyAccelerometerJerk-std()-Y"                 
 [86] "timeBodyAccelerometerJerk-std()-Z"                 
 [87] "timeBodyAccelerometerJerk-mad()-X"                 
 [88] "timeBodyAccelerometerJerk-mad()-Y"                 
 [89] "timeBodyAccelerometerJerk-mad()-Z"                 
 [90] "timeBodyAccelerometerJerk-max()-X"                 
 [91] "timeBodyAccelerometerJerk-max()-Y"                 
 [92] "timeBodyAccelerometerJerk-max()-Z"                 
 [93] "timeBodyAccelerometerJerk-min()-X"                 
 [94] "timeBodyAccelerometerJerk-min()-Y"                 
 [95] "timeBodyAccelerometerJerk-min()-Z"                 
 [96] "timeBodyAccelerometerJerk-sma()"                   
 [97] "timeBodyAccelerometerJerk-energy()-X"              
 [98] "timeBodyAccelerometerJerk-energy()-Y"              
 [99] "timeBodyAccelerometerJerk-energy()-Z"              
[100] "timeBodyAccelerometerJerk-iqr()-X"                 
[101] "timeBodyAccelerometerJerk-iqr()-Y"                 
[102] "timeBodyAccelerometerJerk-iqr()-Z"                 
[103] "timeBodyAccelerometerJerk-entropy()-X"             
[104] "timeBodyAccelerometerJerk-entropy()-Y"             
[105] "timeBodyAccelerometerJerk-entropy()-Z"             
[106] "timeBodyAccelerometerJerk-arCoeff()-X,1"           
[107] "timeBodyAccelerometerJerk-arCoeff()-X,2"           
[108] "timeBodyAccelerometerJerk-arCoeff()-X,3"           
[109] "timeBodyAccelerometerJerk-arCoeff()-X,4"           
[110] "timeBodyAccelerometerJerk-arCoeff()-Y,1"           
[111] "timeBodyAccelerometerJerk-arCoeff()-Y,2"           
[112] "timeBodyAccelerometerJerk-arCoeff()-Y,3"           
[113] "timeBodyAccelerometerJerk-arCoeff()-Y,4"           
[114] "timeBodyAccelerometerJerk-arCoeff()-Z,1"           
[115] "timeBodyAccelerometerJerk-arCoeff()-Z,2"           
[116] "timeBodyAccelerometerJerk-arCoeff()-Z,3"           
[117] "timeBodyAccelerometerJerk-arCoeff()-Z,4"           
[118] "timeBodyAccelerometerJerk-correlation()-X,Y"       
[119] "timeBodyAccelerometerJerk-correlation()-X,Z"       
[120] "timeBodyAccelerometerJerk-correlation()-Y,Z"       
[121] "timeBodyGyroscope-mean()-X"                        
[122] "timeBodyGyroscope-mean()-Y"                        
[123] "timeBodyGyroscope-mean()-Z"                        
[124] "timeBodyGyroscope-std()-X"                         
[125] "timeBodyGyroscope-std()-Y"                         
[126] "timeBodyGyroscope-std()-Z"                         
[127] "timeBodyGyroscope-mad()-X"                         
[128] "timeBodyGyroscope-mad()-Y"                         
[129] "timeBodyGyroscope-mad()-Z"                         
[130] "timeBodyGyroscope-max()-X"                         
[131] "timeBodyGyroscope-max()-Y"                         
[132] "timeBodyGyroscope-max()-Z"                         
[133] "timeBodyGyroscope-min()-X"                         
[134] "timeBodyGyroscope-min()-Y"                         
[135] "timeBodyGyroscope-min()-Z"                         
[136] "timeBodyGyroscope-sma()"                           
[137] "timeBodyGyroscope-energy()-X"                      
[138] "timeBodyGyroscope-energy()-Y"                      
[139] "timeBodyGyroscope-energy()-Z"                      
[140] "timeBodyGyroscope-iqr()-X"                         
[141] "timeBodyGyroscope-iqr()-Y"                         
[142] "timeBodyGyroscope-iqr()-Z"                         
[143] "timeBodyGyroscope-entropy()-X"                     
[144] "timeBodyGyroscope-entropy()-Y"                     
[145] "timeBodyGyroscope-entropy()-Z"                     
[146] "timeBodyGyroscope-arCoeff()-X,1"                   
[147] "timeBodyGyroscope-arCoeff()-X,2"                   
[148] "timeBodyGyroscope-arCoeff()-X,3"                   
[149] "timeBodyGyroscope-arCoeff()-X,4"                   
[150] "timeBodyGyroscope-arCoeff()-Y,1"                   
[151] "timeBodyGyroscope-arCoeff()-Y,2"                   
[152] "timeBodyGyroscope-arCoeff()-Y,3"                   
[153] "timeBodyGyroscope-arCoeff()-Y,4"                   
[154] "timeBodyGyroscope-arCoeff()-Z,1"                   
[155] "timeBodyGyroscope-arCoeff()-Z,2"                   
[156] "timeBodyGyroscope-arCoeff()-Z,3"                   
[157] "timeBodyGyroscope-arCoeff()-Z,4"                   
[158] "timeBodyGyroscope-correlation()-X,Y"               
[159] "timeBodyGyroscope-correlation()-X,Z"               
[160] "timeBodyGyroscope-correlation()-Y,Z"               
[161] "timeBodyGyroscopeJerk-mean()-X"                    
[162] "timeBodyGyroscopeJerk-mean()-Y"                    
[163] "timeBodyGyroscopeJerk-mean()-Z"                    
[164] "timeBodyGyroscopeJerk-std()-X"                     
[165] "timeBodyGyroscopeJerk-std()-Y"                     
[166] "timeBodyGyroscopeJerk-std()-Z"                     
[167] "timeBodyGyroscopeJerk-mad()-X"                     
[168] "timeBodyGyroscopeJerk-mad()-Y"                     
[169] "timeBodyGyroscopeJerk-mad()-Z"                     
[170] "timeBodyGyroscopeJerk-max()-X"                     
[171] "timeBodyGyroscopeJerk-max()-Y"                     
[172] "timeBodyGyroscopeJerk-max()-Z"                     
[173] "timeBodyGyroscopeJerk-min()-X"                     
[174] "timeBodyGyroscopeJerk-min()-Y"                     
[175] "timeBodyGyroscopeJerk-min()-Z"                     
[176] "timeBodyGyroscopeJerk-sma()"                       
[177] "timeBodyGyroscopeJerk-energy()-X"                  
[178] "timeBodyGyroscopeJerk-energy()-Y"                  
[179] "timeBodyGyroscopeJerk-energy()-Z"                  
[180] "timeBodyGyroscopeJerk-iqr()-X"                     
[181] "timeBodyGyroscopeJerk-iqr()-Y"                     
[182] "timeBodyGyroscopeJerk-iqr()-Z"                     
[183] "timeBodyGyroscopeJerk-entropy()-X"                 
[184] "timeBodyGyroscopeJerk-entropy()-Y"                 
[185] "timeBodyGyroscopeJerk-entropy()-Z"                 
[186] "timeBodyGyroscopeJerk-arCoeff()-X,1"               
[187] "timeBodyGyroscopeJerk-arCoeff()-X,2"               
[188] "timeBodyGyroscopeJerk-arCoeff()-X,3"               
[189] "timeBodyGyroscopeJerk-arCoeff()-X,4"               
[190] "timeBodyGyroscopeJerk-arCoeff()-Y,1"               
[191] "timeBodyGyroscopeJerk-arCoeff()-Y,2"               
[192] "timeBodyGyroscopeJerk-arCoeff()-Y,3"               
[193] "timeBodyGyroscopeJerk-arCoeff()-Y,4"               
[194] "timeBodyGyroscopeJerk-arCoeff()-Z,1"               
[195] "timeBodyGyroscopeJerk-arCoeff()-Z,2"               
[196] "timeBodyGyroscopeJerk-arCoeff()-Z,3"               
[197] "timeBodyGyroscopeJerk-arCoeff()-Z,4"               
[198] "timeBodyGyroscopeJerk-correlation()-X,Y"           
[199] "timeBodyGyroscopeJerk-correlation()-X,Z"           
[200] "timeBodyGyroscopeJerk-correlation()-Y,Z"           
[201] "timeBodyAccelerometerMagnitude-mean()"             
[202] "timeBodyAccelerometerMagnitude-std()"              
[203] "timeBodyAccelerometerMagnitude-mad()"              
[204] "timeBodyAccelerometerMagnitude-max()"              
[205] "timeBodyAccelerometerMagnitude-min()"              
[206] "timeBodyAccelerometerMagnitude-sma()"              
[207] "timeBodyAccelerometerMagnitude-energy()"           
[208] "timeBodyAccelerometerMagnitude-iqr()"              
[209] "timeBodyAccelerometerMagnitude-entropy()"          
[210] "timeBodyAccelerometerMagnitude-arCoeff()1"         
[211] "timeBodyAccelerometerMagnitude-arCoeff()2"         
[212] "timeBodyAccelerometerMagnitude-arCoeff()3"         
[213] "timeBodyAccelerometerMagnitude-arCoeff()4"         
[214] "timeGravityAccelerometerMagnitude-mean()"          
[215] "timeGravityAccelerometerMagnitude-std()"           
[216] "timeGravityAccelerometerMagnitude-mad()"           
[217] "timeGravityAccelerometerMagnitude-max()"           
[218] "timeGravityAccelerometerMagnitude-min()"           
[219] "timeGravityAccelerometerMagnitude-sma()"           
[220] "timeGravityAccelerometerMagnitude-energy()"        
[221] "timeGravityAccelerometerMagnitude-iqr()"           
[222] "timeGravityAccelerometerMagnitude-entropy()"       
[223] "timeGravityAccelerometerMagnitude-arCoeff()1"      
[224] "timeGravityAccelerometerMagnitude-arCoeff()2"      
[225] "timeGravityAccelerometerMagnitude-arCoeff()3"      
[226] "timeGravityAccelerometerMagnitude-arCoeff()4"      
[227] "timeBodyAccelerometerJerkMagnitude-mean()"         
[228] "timeBodyAccelerometerJerkMagnitude-std()"          
[229] "timeBodyAccelerometerJerkMagnitude-mad()"          
[230] "timeBodyAccelerometerJerkMagnitude-max()"          
[231] "timeBodyAccelerometerJerkMagnitude-min()"          
[232] "timeBodyAccelerometerJerkMagnitude-sma()"          
[233] "timeBodyAccelerometerJerkMagnitude-energy()"       
[234] "timeBodyAccelerometerJerkMagnitude-iqr()"          
[235] "timeBodyAccelerometerJerkMagnitude-entropy()"      
[236] "timeBodyAccelerometerJerkMagnitude-arCoeff()1"     
[237] "timeBodyAccelerometerJerkMagnitude-arCoeff()2"     
[238] "timeBodyAccelerometerJerkMagnitude-arCoeff()3"     
[239] "timeBodyAccelerometerJerkMagnitude-arCoeff()4"     
[240] "timeBodyGyroscopeMagnitude-mean()"                 
[241] "timeBodyGyroscopeMagnitude-std()"                  
[242] "timeBodyGyroscopeMagnitude-mad()"                  
[243] "timeBodyGyroscopeMagnitude-max()"                  
[244] "timeBodyGyroscopeMagnitude-min()"                  
[245] "timeBodyGyroscopeMagnitude-sma()"                  
[246] "timeBodyGyroscopeMagnitude-energy()"               
[247] "timeBodyGyroscopeMagnitude-iqr()"                  
[248] "timeBodyGyroscopeMagnitude-entropy()"              
[249] "timeBodyGyroscopeMagnitude-arCoeff()1"             
[250] "timeBodyGyroscopeMagnitude-arCoeff()2"             
[251] "timeBodyGyroscopeMagnitude-arCoeff()3"             
[252] "timeBodyGyroscopeMagnitude-arCoeff()4"             
[253] "timeBodyGyroscopeJerkMagnitude-mean()"             
[254] "timeBodyGyroscopeJerkMagnitude-std()"              
[255] "timeBodyGyroscopeJerkMagnitude-mad()"              
[256] "timeBodyGyroscopeJerkMagnitude-max()"              
[257] "timeBodyGyroscopeJerkMagnitude-min()"              
[258] "timeBodyGyroscopeJerkMagnitude-sma()"              
[259] "timeBodyGyroscopeJerkMagnitude-energy()"           
[260] "timeBodyGyroscopeJerkMagnitude-iqr()"              
[261] "timeBodyGyroscopeJerkMagnitude-entropy()"          
[262] "timeBodyGyroscopeJerkMagnitude-arCoeff()1"         
[263] "timeBodyGyroscopeJerkMagnitude-arCoeff()2"         
[264] "timeBodyGyroscopeJerkMagnitude-arCoeff()3"         
[265] "timeBodyGyroscopeJerkMagnitude-arCoeff()4"         
[266] "frequencyBodyAccelerometer-mean()-X"               
[267] "frequencyBodyAccelerometer-mean()-Y"               
[268] "frequencyBodyAccelerometer-mean()-Z"               
[269] "frequencyBodyAccelerometer-std()-X"                
[270] "frequencyBodyAccelerometer-std()-Y"                
[271] "frequencyBodyAccelerometer-std()-Z"                
[272] "frequencyBodyAccelerometer-mad()-X"                
[273] "frequencyBodyAccelerometer-mad()-Y"                
[274] "frequencyBodyAccelerometer-mad()-Z"                
[275] "frequencyBodyAccelerometer-max()-X"                
[276] "frequencyBodyAccelerometer-max()-Y"                
[277] "frequencyBodyAccelerometer-max()-Z"                
[278] "frequencyBodyAccelerometer-min()-X"                
[279] "frequencyBodyAccelerometer-min()-Y"                
[280] "frequencyBodyAccelerometer-min()-Z"                
[281] "frequencyBodyAccelerometer-sma()"                  
[282] "frequencyBodyAccelerometer-energy()-X"             
[283] "frequencyBodyAccelerometer-energy()-Y"             
[284] "frequencyBodyAccelerometer-energy()-Z"             
[285] "frequencyBodyAccelerometer-iqr()-X"                
[286] "frequencyBodyAccelerometer-iqr()-Y"                
[287] "frequencyBodyAccelerometer-iqr()-Z"                
[288] "frequencyBodyAccelerometer-entropy()-X"            
[289] "frequencyBodyAccelerometer-entropy()-Y"            
[290] "frequencyBodyAccelerometer-entropy()-Z"            
[291] "frequencyBodyAccelerometer-maxInds-X"              
[292] "frequencyBodyAccelerometer-maxInds-Y"              
[293] "frequencyBodyAccelerometer-maxInds-Z"              
[294] "frequencyBodyAccelerometer-meanFreq()-X"           
[295] "frequencyBodyAccelerometer-meanFreq()-Y"           
[296] "frequencyBodyAccelerometer-meanFreq()-Z"           
[297] "frequencyBodyAccelerometer-skewness()-X"           
[298] "frequencyBodyAccelerometer-kurtosis()-X"           
[299] "frequencyBodyAccelerometer-skewness()-Y"           
[300] "frequencyBodyAccelerometer-kurtosis()-Y"           
[301] "frequencyBodyAccelerometer-skewness()-Z"           
[302] "frequencyBodyAccelerometer-kurtosis()-Z"           
[303] "frequencyBodyAccelerometer-bandsEnergy()-1,8"      
[304] "frequencyBodyAccelerometer-bandsEnergy()-9,16"     
[305] "frequencyBodyAccelerometer-bandsEnergy()-17,24"    
[306] "frequencyBodyAccelerometer-bandsEnergy()-25,32"    
[307] "frequencyBodyAccelerometer-bandsEnergy()-33,40"    
[308] "frequencyBodyAccelerometer-bandsEnergy()-41,48"    
[309] "frequencyBodyAccelerometer-bandsEnergy()-49,56"    
[310] "frequencyBodyAccelerometer-bandsEnergy()-57,64"    
[311] "frequencyBodyAccelerometer-bandsEnergy()-1,16"     
[312] "frequencyBodyAccelerometer-bandsEnergy()-17,32"    
[313] "frequencyBodyAccelerometer-bandsEnergy()-33,48"    
[314] "frequencyBodyAccelerometer-bandsEnergy()-49,64"    
[315] "frequencyBodyAccelerometer-bandsEnergy()-1,24"     
[316] "frequencyBodyAccelerometer-bandsEnergy()-25,48"    
[317] "frequencyBodyAccelerometer-bandsEnergy()-1,8"      
[318] "frequencyBodyAccelerometer-bandsEnergy()-9,16"     
[319] "frequencyBodyAccelerometer-bandsEnergy()-17,24"    
[320] "frequencyBodyAccelerometer-bandsEnergy()-25,32"    
[321] "frequencyBodyAccelerometer-bandsEnergy()-33,40"    
[322] "frequencyBodyAccelerometer-bandsEnergy()-41,48"    
[323] "frequencyBodyAccelerometer-bandsEnergy()-49,56"    
[324] "frequencyBodyAccelerometer-bandsEnergy()-57,64"    
[325] "frequencyBodyAccelerometer-bandsEnergy()-1,16"     
[326] "frequencyBodyAccelerometer-bandsEnergy()-17,32"    
[327] "frequencyBodyAccelerometer-bandsEnergy()-33,48"    
[328] "frequencyBodyAccelerometer-bandsEnergy()-49,64"    
[329] "frequencyBodyAccelerometer-bandsEnergy()-1,24"     
[330] "frequencyBodyAccelerometer-bandsEnergy()-25,48"    
[331] "frequencyBodyAccelerometer-bandsEnergy()-1,8"      
[332] "frequencyBodyAccelerometer-bandsEnergy()-9,16"     
[333] "frequencyBodyAccelerometer-bandsEnergy()-17,24"    
[334] "frequencyBodyAccelerometer-bandsEnergy()-25,32"    
[335] "frequencyBodyAccelerometer-bandsEnergy()-33,40"    
[336] "frequencyBodyAccelerometer-bandsEnergy()-41,48"    
[337] "frequencyBodyAccelerometer-bandsEnergy()-49,56"    
[338] "frequencyBodyAccelerometer-bandsEnergy()-57,64"    
[339] "frequencyBodyAccelerometer-bandsEnergy()-1,16"     
[340] "frequencyBodyAccelerometer-bandsEnergy()-17,32"    
[341] "frequencyBodyAccelerometer-bandsEnergy()-33,48"    
[342] "frequencyBodyAccelerometer-bandsEnergy()-49,64"    
[343] "frequencyBodyAccelerometer-bandsEnergy()-1,24"     
[344] "frequencyBodyAccelerometer-bandsEnergy()-25,48"    
[345] "frequencyBodyAccelerometerJerk-mean()-X"           
[346] "frequencyBodyAccelerometerJerk-mean()-Y"           
[347] "frequencyBodyAccelerometerJerk-mean()-Z"           
[348] "frequencyBodyAccelerometerJerk-std()-X"            
[349] "frequencyBodyAccelerometerJerk-std()-Y"            
[350] "frequencyBodyAccelerometerJerk-std()-Z"            
[351] "frequencyBodyAccelerometerJerk-mad()-X"            
[352] "frequencyBodyAccelerometerJerk-mad()-Y"            
[353] "frequencyBodyAccelerometerJerk-mad()-Z"            
[354] "frequencyBodyAccelerometerJerk-max()-X"            
[355] "frequencyBodyAccelerometerJerk-max()-Y"            
[356] "frequencyBodyAccelerometerJerk-max()-Z"            
[357] "frequencyBodyAccelerometerJerk-min()-X"            
[358] "frequencyBodyAccelerometerJerk-min()-Y"            
[359] "frequencyBodyAccelerometerJerk-min()-Z"            
[360] "frequencyBodyAccelerometerJerk-sma()"              
[361] "frequencyBodyAccelerometerJerk-energy()-X"         
[362] "frequencyBodyAccelerometerJerk-energy()-Y"         
[363] "frequencyBodyAccelerometerJerk-energy()-Z"         
[364] "frequencyBodyAccelerometerJerk-iqr()-X"            
[365] "frequencyBodyAccelerometerJerk-iqr()-Y"            
[366] "frequencyBodyAccelerometerJerk-iqr()-Z"            
[367] "frequencyBodyAccelerometerJerk-entropy()-X"        
[368] "frequencyBodyAccelerometerJerk-entropy()-Y"        
[369] "frequencyBodyAccelerometerJerk-entropy()-Z"        
[370] "frequencyBodyAccelerometerJerk-maxInds-X"          
[371] "frequencyBodyAccelerometerJerk-maxInds-Y"          
[372] "frequencyBodyAccelerometerJerk-maxInds-Z"          
[373] "frequencyBodyAccelerometerJerk-meanFreq()-X"       
[374] "frequencyBodyAccelerometerJerk-meanFreq()-Y"       
[375] "frequencyBodyAccelerometerJerk-meanFreq()-Z"       
[376] "frequencyBodyAccelerometerJerk-skewness()-X"       
[377] "frequencyBodyAccelerometerJerk-kurtosis()-X"       
[378] "frequencyBodyAccelerometerJerk-skewness()-Y"       
[379] "frequencyBodyAccelerometerJerk-kurtosis()-Y"       
[380] "frequencyBodyAccelerometerJerk-skewness()-Z"       
[381] "frequencyBodyAccelerometerJerk-kurtosis()-Z"       
[382] "frequencyBodyAccelerometerJerk-bandsEnergy()-1,8"  
[383] "frequencyBodyAccelerometerJerk-bandsEnergy()-9,16" 
[384] "frequencyBodyAccelerometerJerk-bandsEnergy()-17,24"
[385] "frequencyBodyAccelerometerJerk-bandsEnergy()-25,32"
[386] "frequencyBodyAccelerometerJerk-bandsEnergy()-33,40"
[387] "frequencyBodyAccelerometerJerk-bandsEnergy()-41,48"
[388] "frequencyBodyAccelerometerJerk-bandsEnergy()-49,56"
[389] "frequencyBodyAccelerometerJerk-bandsEnergy()-57,64"
[390] "frequencyBodyAccelerometerJerk-bandsEnergy()-1,16" 
[391] "frequencyBodyAccelerometerJerk-bandsEnergy()-17,32"
[392] "frequencyBodyAccelerometerJerk-bandsEnergy()-33,48"
[393] "frequencyBodyAccelerometerJerk-bandsEnergy()-49,64"
[394] "frequencyBodyAccelerometerJerk-bandsEnergy()-1,24" 
[395] "frequencyBodyAccelerometerJerk-bandsEnergy()-25,48"
[396] "frequencyBodyAccelerometerJerk-bandsEnergy()-1,8"  
[397] "frequencyBodyAccelerometerJerk-bandsEnergy()-9,16" 
[398] "frequencyBodyAccelerometerJerk-bandsEnergy()-17,24"
[399] "frequencyBodyAccelerometerJerk-bandsEnergy()-25,32"
[400] "frequencyBodyAccelerometerJerk-bandsEnergy()-33,40"
[401] "frequencyBodyAccelerometerJerk-bandsEnergy()-41,48"
[402] "frequencyBodyAccelerometerJerk-bandsEnergy()-49,56"
[403] "frequencyBodyAccelerometerJerk-bandsEnergy()-57,64"
[404] "frequencyBodyAccelerometerJerk-bandsEnergy()-1,16" 
[405] "frequencyBodyAccelerometerJerk-bandsEnergy()-17,32"
[406] "frequencyBodyAccelerometerJerk-bandsEnergy()-33,48"
[407] "frequencyBodyAccelerometerJerk-bandsEnergy()-49,64"
[408] "frequencyBodyAccelerometerJerk-bandsEnergy()-1,24" 
[409] "frequencyBodyAccelerometerJerk-bandsEnergy()-25,48"
[410] "frequencyBodyAccelerometerJerk-bandsEnergy()-1,8"  
[411] "frequencyBodyAccelerometerJerk-bandsEnergy()-9,16" 
[412] "frequencyBodyAccelerometerJerk-bandsEnergy()-17,24"
[413] "frequencyBodyAccelerometerJerk-bandsEnergy()-25,32"
[414] "frequencyBodyAccelerometerJerk-bandsEnergy()-33,40"
[415] "frequencyBodyAccelerometerJerk-bandsEnergy()-41,48"
[416] "frequencyBodyAccelerometerJerk-bandsEnergy()-49,56"
[417] "frequencyBodyAccelerometerJerk-bandsEnergy()-57,64"
[418] "frequencyBodyAccelerometerJerk-bandsEnergy()-1,16" 
[419] "frequencyBodyAccelerometerJerk-bandsEnergy()-17,32"
[420] "frequencyBodyAccelerometerJerk-bandsEnergy()-33,48"
[421] "frequencyBodyAccelerometerJerk-bandsEnergy()-49,64"
[422] "frequencyBodyAccelerometerJerk-bandsEnergy()-1,24" 
[423] "frequencyBodyAccelerometerJerk-bandsEnergy()-25,48"
[424] "frequencyBodyGyroscope-mean()-X"                   
[425] "frequencyBodyGyroscope-mean()-Y"                   
[426] "frequencyBodyGyroscope-mean()-Z"                   
[427] "frequencyBodyGyroscope-std()-X"                    
[428] "frequencyBodyGyroscope-std()-Y"                    
[429] "frequencyBodyGyroscope-std()-Z"                    
[430] "frequencyBodyGyroscope-mad()-X"                    
[431] "frequencyBodyGyroscope-mad()-Y"                    
[432] "frequencyBodyGyroscope-mad()-Z"                    
[433] "frequencyBodyGyroscope-max()-X"                    
[434] "frequencyBodyGyroscope-max()-Y"                    
[435] "frequencyBodyGyroscope-max()-Z"                    
[436] "frequencyBodyGyroscope-min()-X"                    
[437] "frequencyBodyGyroscope-min()-Y"                    
[438] "frequencyBodyGyroscope-min()-Z"                    
[439] "frequencyBodyGyroscope-sma()"                      
[440] "frequencyBodyGyroscope-energy()-X"                 
[441] "frequencyBodyGyroscope-energy()-Y"                 
[442] "frequencyBodyGyroscope-energy()-Z"                 
[443] "frequencyBodyGyroscope-iqr()-X"                    
[444] "frequencyBodyGyroscope-iqr()-Y"                    
[445] "frequencyBodyGyroscope-iqr()-Z"                    
[446] "frequencyBodyGyroscope-entropy()-X"                
[447] "frequencyBodyGyroscope-entropy()-Y"                
[448] "frequencyBodyGyroscope-entropy()-Z"                
[449] "frequencyBodyGyroscope-maxInds-X"                  
[450] "frequencyBodyGyroscope-maxInds-Y"                  
[451] "frequencyBodyGyroscope-maxInds-Z"                  
[452] "frequencyBodyGyroscope-meanFreq()-X"               
[453] "frequencyBodyGyroscope-meanFreq()-Y"               
[454] "frequencyBodyGyroscope-meanFreq()-Z"               
[455] "frequencyBodyGyroscope-skewness()-X"               
[456] "frequencyBodyGyroscope-kurtosis()-X"               
[457] "frequencyBodyGyroscope-skewness()-Y"               
[458] "frequencyBodyGyroscope-kurtosis()-Y"               
[459] "frequencyBodyGyroscope-skewness()-Z"               
[460] "frequencyBodyGyroscope-kurtosis()-Z"               
[461] "frequencyBodyGyroscope-bandsEnergy()-1,8"          
[462] "frequencyBodyGyroscope-bandsEnergy()-9,16"         
[463] "frequencyBodyGyroscope-bandsEnergy()-17,24"        
[464] "frequencyBodyGyroscope-bandsEnergy()-25,32"        
[465] "frequencyBodyGyroscope-bandsEnergy()-33,40"        
[466] "frequencyBodyGyroscope-bandsEnergy()-41,48"        
[467] "frequencyBodyGyroscope-bandsEnergy()-49,56"        
[468] "frequencyBodyGyroscope-bandsEnergy()-57,64"        
[469] "frequencyBodyGyroscope-bandsEnergy()-1,16"         
[470] "frequencyBodyGyroscope-bandsEnergy()-17,32"        
[471] "frequencyBodyGyroscope-bandsEnergy()-33,48"        
[472] "frequencyBodyGyroscope-bandsEnergy()-49,64"        
[473] "frequencyBodyGyroscope-bandsEnergy()-1,24"         
[474] "frequencyBodyGyroscope-bandsEnergy()-25,48"        
[475] "frequencyBodyGyroscope-bandsEnergy()-1,8"          
[476] "frequencyBodyGyroscope-bandsEnergy()-9,16"         
[477] "frequencyBodyGyroscope-bandsEnergy()-17,24"        
[478] "frequencyBodyGyroscope-bandsEnergy()-25,32"        
[479] "frequencyBodyGyroscope-bandsEnergy()-33,40"        
[480] "frequencyBodyGyroscope-bandsEnergy()-41,48"        
[481] "frequencyBodyGyroscope-bandsEnergy()-49,56"        
[482] "frequencyBodyGyroscope-bandsEnergy()-57,64"        
[483] "frequencyBodyGyroscope-bandsEnergy()-1,16"         
[484] "frequencyBodyGyroscope-bandsEnergy()-17,32"        
[485] "frequencyBodyGyroscope-bandsEnergy()-33,48"        
[486] "frequencyBodyGyroscope-bandsEnergy()-49,64"        
[487] "frequencyBodyGyroscope-bandsEnergy()-1,24"         
[488] "frequencyBodyGyroscope-bandsEnergy()-25,48"        
[489] "frequencyBodyGyroscope-bandsEnergy()-1,8"          
[490] "frequencyBodyGyroscope-bandsEnergy()-9,16"         
[491] "frequencyBodyGyroscope-bandsEnergy()-17,24"        
[492] "frequencyBodyGyroscope-bandsEnergy()-25,32"        
[493] "frequencyBodyGyroscope-bandsEnergy()-33,40"        
[494] "frequencyBodyGyroscope-bandsEnergy()-41,48"        
[495] "frequencyBodyGyroscope-bandsEnergy()-49,56"        
[496] "frequencyBodyGyroscope-bandsEnergy()-57,64"        
[497] "frequencyBodyGyroscope-bandsEnergy()-1,16"         
[498] "frequencyBodyGyroscope-bandsEnergy()-17,32"        
[499] "frequencyBodyGyroscope-bandsEnergy()-33,48"        
[500] "frequencyBodyGyroscope-bandsEnergy()-49,64"        
[501] "frequencyBodyGyroscope-bandsEnergy()-1,24"         
[502] "frequencyBodyGyroscope-bandsEnergy()-25,48"        
[503] "frequencyBodyAccelerometerMagnitude-mean()"        
[504] "frequencyBodyAccelerometerMagnitude-std()"         
[505] "frequencyBodyAccelerometerMagnitude-mad()"         
[506] "frequencyBodyAccelerometerMagnitude-max()"         
[507] "frequencyBodyAccelerometerMagnitude-min()"         
[508] "frequencyBodyAccelerometerMagnitude-sma()"         
[509] "frequencyBodyAccelerometerMagnitude-energy()"      
[510] "frequencyBodyAccelerometerMagnitude-iqr()"         
[511] "frequencyBodyAccelerometerMagnitude-entropy()"     
[512] "frequencyBodyAccelerometerMagnitude-maxInds"       
[513] "frequencyBodyAccelerometerMagnitude-meanFreq()"    
[514] "frequencyBodyAccelerometerMagnitude-skewness()"    
[515] "frequencyBodyAccelerometerMagnitude-kurtosis()"    
[516] "frequencyBodyAccelerometerJerkMagnitude-mean()"    
[517] "frequencyBodyAccelerometerJerkMagnitude-std()"     
[518] "frequencyBodyAccelerometerJerkMagnitude-mad()"     
[519] "frequencyBodyAccelerometerJerkMagnitude-max()"     
[520] "frequencyBodyAccelerometerJerkMagnitude-min()"     
[521] "frequencyBodyAccelerometerJerkMagnitude-sma()"     
[522] "frequencyBodyAccelerometerJerkMagnitude-energy()"  
[523] "frequencyBodyAccelerometerJerkMagnitude-iqr()"     
[524] "frequencyBodyAccelerometerJerkMagnitude-entropy()" 
[525] "frequencyBodyAccelerometerJerkMagnitude-maxInds"   
[526] "frequencyBodyAccelerometerJerkMagnitude-meanFreq()"
[527] "frequencyBodyAccelerometerJerkMagnitude-skewness()"
[528] "frequencyBodyAccelerometerJerkMagnitude-kurtosis()"
	         [529] "frequencyBodyGyroscopeMagnitude-mean()"            
[530] "frequencyBodyGyroscopeMagnitude-std()"             
[531] "frequencyBodyGyroscopeMagnitude-mad()"             
[532] "frequencyBodyGyroscopeMagnitude-max()"             
[533] "frequencyBodyGyroscopeMagnitude-min()"             
[534] "frequencyBodyGyroscopeMagnitude-sma()"             
[535] "frequencyBodyGyroscopeMagnitude-energy()"          
[536] "frequencyBodyGyroscopeMagnitude-iqr()"             
[537] "frequencyBodyGyroscopeMagnitude-entropy()"         
[538] "frequencyBodyGyroscopeMagnitude-maxInds"           
[539] "frequencyBodyGyroscopeMagnitude-meanFreq()"        
[540] "frequencyBodyGyroscopeMagnitude-skewness()"        
[541] "frequencyBodyGyroscopeMagnitude-kurtosis()"        
[542] "frequencyBodyGyroscopeJerkMagnitude-mean()"        
[543] "frequencyBodyGyroscopeJerkMagnitude-std()"         
[544] "frequencyBodyGyroscopeJerkMagnitude-mad()"         
[545] "frequencyBodyGyroscopeJerkMagnitude-max()"         
[546] "frequencyBodyGyroscopeJerkMagnitude-min()"         
[547] "frequencyBodyGyroscopeJerkMagnitude-sma()"         
[548] "frequencyBodyGyroscopeJerkMagnitude-energy()"      
[549] "frequencyBodyGyroscopeJerkMagnitude-iqr()"         
[550] "frequencyBodyGyroscopeJerkMagnitude-entropy()"     
[551] "frequencyBodyGyroscopeJerkMagnitude-maxInds"       
[552] "frequencyBodyGyroscopeJerkMagnitude-meanFreq()"    
[553] "frequencyBodyGyroscopeJerkMagnitude-skewness()"    
[554] "frequencyBodyGyroscopeJerkMagnitude-kurtosis()"    
[555] "angle(tBodyAccelerometerMean,gravity)"             
[556] "angle(tBodyAccelerometerJerkMean),gravityMean)"    
[557] "angle(tBodyGyroscopeMean,gravityMean)"             
[558] "angle(tBodyGyroscopeJerkMean,gravityMean)"         
[559] "angle(X,gravityMean)"                              
[560] "angle(Y,gravityMean)"                              
[561] "angle(Z,gravityMean)"                              
[562] "Subject"                                           
[563] "Activity"  


## Feature variable change to meaning ful variables
names(SelectedData) <- gsub("Acc", "Accelerometer", names(SelectedData))
names(SelectedData) <- gsub("BodyBody", "Body", names(SelectedData))
names(SelectedData) <- gsub("Gyro", "Gyroscope", names(SelectedData))
names(SelectedData) <- gsub("Mag", "Magnitude", names(SelectedData))
names(SelectedData) <- gsub("^f", "frequency", names(SelectedData))
names(SelectedData) <- gsub("^f", "frequency", names(SelectedData))
names(SelectedData) <- gsub("^t", "time", names(SelectedData))
Checking
> names(SelectedData)
  [1] "timeBodyAccelerometer-mean()-X"                 "timeBodyAccelerometer-mean()-Y"                
 [3] "timeBodyAccelerometer-mean()-Z"                 "timeBodyAccelerometer-std()-X"                 
 [5] "timeBodyAccelerometer-std()-Y"                  "timeBodyAccelerometer-std()-Z"                 
 [7] "timeGravityAccelerometer-mean()-X"              "timeGravityAccelerometer-mean()-Y"             
 [9] "timeGravityAccelerometer-mean()-Z"              "timeGravityAccelerometer-std()-X"              
[11] "timeGravityAccelerometer-std()-Y"               "timeGravityAccelerometer-std()-Z"              
[13] "timeBodyAccelerometerJerk-mean()-X"             "timeBodyAccelerometerJerk-mean()-Y"            
[15] "timeBodyAccelerometerJerk-mean()-Z"             "timeBodyAccelerometerJerk-std()-X"             
[17] "timeBodyAccelerometerJerk-std()-Y"              "timeBodyAccelerometerJerk-std()-Z"             
[19] "timeBodyGyroscope-mean()-X"                     "timeBodyGyroscope-mean()-Y"                    
[21] "timeBodyGyroscope-mean()-Z"                     "timeBodyGyroscope-std()-X"                     
[23] "timeBodyGyroscope-std()-Y"                      "timeBodyGyroscope-std()-Z"                     
[25] "timeBodyGyroscopeJerk-mean()-X"                 "timeBodyGyroscopeJerk-mean()-Y"                
[27] "timeBodyGyroscopeJerk-mean()-Z"                 "timeBodyGyroscopeJerk-std()-X"                 
[29] "timeBodyGyroscopeJerk-std()-Y"                  "timeBodyGyroscopeJerk-std()-Z"                 
[31] "timeBodyAccelerometerMagnitude-mean()"          "timeBodyAccelerometerMagnitude-std()"          
[33] "timeGravityAccelerometerMagnitude-mean()"       "timeGravityAccelerometerMagnitude-std()"       
[35] "timeBodyAccelerometerJerkMagnitude-mean()"      "timeBodyAccelerometerJerkMagnitude-std()"      
[37] "timeBodyGyroscopeMagnitude-mean()"              "timeBodyGyroscopeMagnitude-std()"              
[39] "timeBodyGyroscopeJerkMagnitude-mean()"          "timeBodyGyroscopeJerkMagnitude-std()"          
[41] "frequencyBodyAccelerometer-mean()-X"            "frequencyBodyAccelerometer-mean()-Y"           
[43] "frequencyBodyAccelerometer-mean()-Z"            "frequencyBodyAccelerometer-std()-X"            
[45] "frequencyBodyAccelerometer-std()-Y"             "frequencyBodyAccelerometer-std()-Z"            
[47] "frequencyBodyAccelerometerJerk-mean()-X"        "frequencyBodyAccelerometerJerk-mean()-Y"       
[49] "frequencyBodyAccelerometerJerk-mean()-Z"        "frequencyBodyAccelerometerJerk-std()-X"        
[51] "frequencyBodyAccelerometerJerk-std()-Y"         "frequencyBodyAccelerometerJerk-std()-Z"        
[53] "frequencyBodyGyroscope-mean()-X"                "frequencyBodyGyroscope-mean()-Y"               
[55] "frequencyBodyGyroscope-mean()-Z"                "frequencyBodyGyroscope-std()-X"                
[57] "frequencyBodyGyroscope-std()-Y"                 "frequencyBodyGyroscope-std()-Z"                
[59] "frequencyBodyAccelerometerMagnitude-mean()"     "frequencyBodyAccelerometerMagnitude-std()"     
[61] "frequencyBodyAccelerometerJerkMagnitude-mean()" "frequencyBodyAccelerometerJerkMagnitude-std()" 
[63] "frequencyBodyGyroscopeMagnitude-mean()"         "frequencyBodyGyroscopeMagnitude-std()"         
[65] "frequencyBodyGyroscopeJerkMagnitude-mean()"     "frequencyBodyGyroscopeJerkMagnitude-std()"     
[67] "Subject" 


V. From the data set in step IV, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



library(plyr)
tidyData <- aggregate(.~Subject + Activity, SelectedData, mean)
tidyData <- tidyData[order(tidyData$Subject, tidyData$Activity),]
write.table(tidyData, file = "tidyData.txt", row.names = FALSE)
names(tidyData) ## 68 columns
///
[1] "Subject"                                        "Activity"                                      
 [3] "timeBodyAccelerometer-mean()-X"                 "timeBodyAccelerometer-mean()-Y"                
 [5] "timeBodyAccelerometer-mean()-Z"                 "timeBodyAccelerometer-std()-X"                 
 [7] "timeBodyAccelerometer-std()-Y"                  "timeBodyAccelerometer-std()-Z"                 
 [9] "timeGravityAccelerometer-mean()-X"              "timeGravityAccelerometer-mean()-Y"             
[11] "timeGravityAccelerometer-mean()-Z"              "timeGravityAccelerometer-std()-X"              
[13] "timeGravityAccelerometer-std()-Y"               "timeGravityAccelerometer-std()-Z"              
[15] "timeBodyAccelerometerJerk-mean()-X"             "timeBodyAccelerometerJerk-mean()-Y"            
[17] "timeBodyAccelerometerJerk-mean()-Z"             "timeBodyAccelerometerJerk-std()-X"             
[19] "timeBodyAccelerometerJerk-std()-Y"              "timeBodyAccelerometerJerk-std()-Z"             
[21] "timeBodyGyroscope-mean()-X"                     "timeBodyGyroscope-mean()-Y"                    
[23] "timeBodyGyroscope-mean()-Z"                     "timeBodyGyroscope-std()-X"                     
[25] "timeBodyGyroscope-std()-Y"                      "timeBodyGyroscope-std()-Z"                     
[27] "timeBodyGyroscopeJerk-mean()-X"                 "timeBodyGyroscopeJerk-mean()-Y"                
[29] "timeBodyGyroscopeJerk-mean()-Z"                 "timeBodyGyroscopeJerk-std()-X"                 
[31] "timeBodyGyroscopeJerk-std()-Y"                  "timeBodyGyroscopeJerk-std()-Z"                 
[33] "timeBodyAccelerometerMagnitude-mean()"          "timeBodyAccelerometerMagnitude-std()"          
[35] "timeGravityAccelerometerMagnitude-mean()"       "timeGravityAccelerometerMagnitude-std()"       
[37] "timeBodyAccelerometerJerkMagnitude-mean()"      "timeBodyAccelerometerJerkMagnitude-std()"      
[39] "timeBodyGyroscopeMagnitude-mean()"              "timeBodyGyroscopeMagnitude-std()"              
[41] "timeBodyGyroscopeJerkMagnitude-mean()"          "timeBodyGyroscopeJerkMagnitude-std()"          
[43] "frequencyBodyAccelerometer-mean()-X"            "frequencyBodyAccelerometer-mean()-Y"           
[45] "frequencyBodyAccelerometer-mean()-Z"            "frequencyBodyAccelerometer-std()-X"            
[47] "frequencyBodyAccelerometer-std()-Y"             "frequencyBodyAccelerometer-std()-Z"            
[49] "frequencyBodyAccelerometerJerk-mean()-X"        "frequencyBodyAccelerometerJerk-mean()-Y"       
[51] "frequencyBodyAccelerometerJerk-mean()-Z"        "frequencyBodyAccelerometerJerk-std()-X"        
[53] "frequencyBodyAccelerometerJerk-std()-Y"         "frequencyBodyAccelerometerJerk-std()-Z"        
[55] "frequencyBodyGyroscope-mean()-X"                "frequencyBodyGyroscope-mean()-Y"               
[57] "frequencyBodyGyroscope-mean()-Z"                "frequencyBodyGyroscope-std()-X"                
[59] "frequencyBodyGyroscope-std()-Y"                 "frequencyBodyGyroscope-std()-Z"                
[61] "frequencyBodyAccelerometerMagnitude-mean()"     "frequencyBodyAccelerometerMagnitude-std()"     
[63] "frequencyBodyAccelerometerJerkMagnitude-mean()" "frequencyBodyAccelerometerJerkMagnitude-std()" 
[65] "frequencyBodyGyroscopeMagnitude-mean()"         "frequencyBodyGyroscopeMagnitude-std()"         
[67] "frequencyBodyGyroscopeJerkMagnitude-mean()"     "frequencyBodyGyroscopeJerkMagnitude-std()"  




