# Getting and Cleaning Data Course Project (jpetrO2)


The goal of this project was to prepare tidy dataset that could be used for later analysis. We were required to submit: 1) a tidy data set a 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data called CodeBook.md. 

This project used the Human Activity Recognition Using Smartphones Data Set, which is part of the UC Irvine Machine Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The smart data in this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. The data by and large provide information on the subjects activities.

## Getting Started

First download the .zip file of data and metadata from the following link (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Next unzip the file and contents on you computer. Take note of the location for the unzipped data. You will use this location and update the working directory in the "run_analysis.R" script at the beginning of the file.  The current location in the file is listed as "C:/DataScience/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset". Replace this with your unzipped folder of data.

Next you can use teh "run_analysis.R" script with RStudio (i.e. the script was developed using R version 3.5.2 (2018-12-20) on the PC [not MAC]). The script is commented and should be self-explanatory.

The script as part of this project was created to:
1)Merges the training and the test sets to create one data set.  
2)Extract only the measurements on the mean and standard deviation for each measurement.                                                  3)Introduce and add descriptive activity names to name the activities in the dataset, and appropriately label the data set with descriptive variable names.     
4)And finally, creat a new tidy dataset with only the average of each variable for each activity and each subject. 

At the end of this project and after running the "run_analysis.R" script you will have a new .txt file named "tidydataset.txt" with the average of each of the mean and standard deviation variables, for each subject/participant in the study (n=30), and each activity (

### Prerequisites/Other Notes


a) The "glimpse" function is used often to take a look at the newly created datsets. You may choose to ignore this output if you want.
b) There are several files, within several folders, that download with this dataset. This project and script do not use any of the data in the test or train "Inertial Signals" folders. Please ignore these.
c) 

### Installing

a) The following pacakages must be installed to run the script (datasets,data.table, dplyr,plyr,tibble,tidyr,readr).

## Running the tests

The script for this project runs tests (glimpse, colnames, etc. to check data transformations along the process).

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* R version 3.5.2 (2018-12-20) -- "Eggshell Igloo"
Copyright (C) 2018 The R Foundation for Statistical Computing
Platform: i386-w64-mingw32/i386 (32-bit)
* Codebook.md created using 'dataMaid' package in R and using 'makeCodebook' function.

## Contributing

This ReadMe template was adapted from https://gist.github.com/PurpleBooth/109311bb0361f32d87a2.

## Authors

* **jpetrO2

