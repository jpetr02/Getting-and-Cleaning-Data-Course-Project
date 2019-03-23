###################################################################################
# /////////////////////////////////////////////////////                           #
# Getting and Cleaning Data Course Project - 3/22/19  /                           #
# /////////////////////////////////////////////////////                           #
#                                                                                 #
# The following script will produce a "tidy datset" from the                      #
# Human Activity Recognition Using Smartphones Data Set that should               #
# be downloaded from the following link to your working directory                 #
# prior to running this code. (https://d396qusza40orc.cloudfront.net/getdata      #   
# %2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)                                      #
#                                                                                 #
# This script does the following:                                                 #
# 1)Merges the training and the test sets to create one data set.                 #
# 2)Extracts only the measurements on the mean and standard deviation for each    #  
# measurement.                                                                    #
# 3)Creates/Uses descriptive activity names to name the activities in the data    #
# set, and appropriately labels the data set with descriptive variable names.     #
# 4)Finally, a new tidy dataset is created with only the average of each variable #   
# for each activity and each subject.                                             #
#                                                                                 #
###################################################################################

## Start with a clean workspace and set your working directory. NOTE: Unzip files
## first and change location for working directory.

rm(list=ls())
setwd("C:/DataScience/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

## Load necessary libraries.

library (datasets)
library (data.table)
library (dplyr)
library (plyr)
library (tibble)
library (tidyr)
library (readr)

## 1) Merge the training and test sets. Start by reading them in.

# Read all the datasets in and take a quick look using "glimpse" function.

# Test data.
dat_test <- read.table ("test/X_test.txt",header = FALSE)
glimpse(dat_test) 
label_test <- read.table ("test/y_test.txt",header = FALSE)
glimpse (label_test)
sbj_test <- read.table ("test/subject_test.txt",header = FALSE)
glimpse(sbj_test)
# Train data.
dat_train <- read.table ("train/X_train.txt",header = FALSE)
glimpse(dat_test) 
label_train <- read.table ("train/y_train.txt",header = FALSE)
glimpse (label_test)
sbj_train <- read.table ("train/subject_train.txt",header = FALSE)
glimpse(sbj_test)
# Features/Activity Data
features <- read.table ("features.txt",header = FALSE)
glimpse(features)
activities <- read.table ("activity_labels.txt",header = FALSE)
glimpse(activities)

# Give columns names to datasets before merging.

colnames(dat_test) = features[,2]; # Note: Using features file as column label source.
colnames(sbj_test) = "ID_Subject"; 
colnames(label_test) = "ID_Activity";
colnames(dat_train) = features[,2]; # Note: Using features file as column labels.  
colnames(sbj_train) = "ID_Subject"; 
colnames(label_train) = "ID_Activity";
colnames(activities) = c('ID_Activity','Type_Activity');

# Create Final Training & Test Sets. Take a quick look using glimpse.

training <- cbind(dat_test,label_test,sbj_test)
test <- cbind(dat_train,label_train,sbj_train)
glimpse(training)
glimpse (test)

# Now use row bind to merge training and test sets into master dataset.
master <- rbind(training,test)

## 2)Extract only the mean and stdv for each measurement.

# Create a vector of all column names to parse out only those that are needed.

names1 <- colnames (master)

# Use a logical argument to identify columns that should be kept.

keep_names = (grepl("ID..",names1) | grepl("Type..",names1) | grepl("-mean..",names1)& !grepl("-meanFreq..",names1) & !grepl("mean..-",names1) | grepl("-std..",names1) & !grepl("-std()..-",names1))

# Subset the dataset for just the relevant vars.

final <- master[keep_names==TRUE]

## 3) Append on the descriptive activity names from "activities" dataset.

finaldata <- left_join(final, activities, by = "ID_Activity",copy=FALSE)
summary(finaldata$Type_Activity) # Check to make sure activity type looks ok.
colnames(finaldata) # Take a look at the names that need additional cleaning.

# Rename/clean-up column names to be more descriptive.

names(finaldata) <- sub ("-","",names(finaldata))
names(finaldata) <- sub ("_","",names(finaldata))
names(finaldata) <- sub ("-","",names(finaldata))
names(finaldata) <- sub ("^(t)","time",names(finaldata))
names(finaldata) <- sub ("^(f)","freq",names(finaldata))
names(finaldata) <- sub ("\\()","",names(finaldata))

colnames(finaldata) # Check new names.
finaldata <- subset(finaldata,select= -c(19)) #Drop ID Activity Variable.

## 4) Finally, a new tidy dataset is created with only the average of each variable, ## for each activity and each subject.

newdata <-aggregate(. ~IDSubject + TypeActivity, finaldata, mean)
newdata<-newdata[order(newdata$IDSubject,newdata$TypeActivity),]
write.table(newdata, file = "tidydataset.txt",row.name=FALSE)

# Not part of the assignment, but added excel file for ease of use in reviewing.
write_excel_csv(newdata,"tidydataset.csv", na = "NA", append =FALSE, col_names = TRUE)