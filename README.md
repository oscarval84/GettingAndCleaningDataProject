# GettingAndCleaningDataProject

run_analysis.R should do the following:

1) Merges the training and the test sets to create one data set.

2) Extracts only the measurements on the mean and standard deviation for each measurement.

3) Uses descriptive activity names to name the activities in the data set

4) Appropriately labels the data set with descriptive variable names.

5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Please upload the tidy data set created in step 5 of the instructions. 

Please upload your data set as a txt file created with write.table() using row.name=FALSE 
(do not cut and paste a dataset directly into the text box, as this may cause errors 
saving your submission).

# Steps to work on this course project

Download the data files from github and the data set from *https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip* and put into a folder on your local drive. 
Put run_analysis.R (from github) in the parent folder of the dataset, then set it as your working directory using setwd() function in RStudio.
Run source("run_analysis.R"), then it will generate a new file tiny_data.txt in your working directory.
