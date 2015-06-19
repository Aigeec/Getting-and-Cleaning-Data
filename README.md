README
======

This readme is about the run_analysis.R R script.

The script requires this dataset https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to be unzip into a "UCI HAR Dataset" folder in the working directory. The script should be run from the same location as this folder. Please see README.md for more information on the script itself.

The aim of this script is to take this dataset and assemble it into a single "tidy" dataset.

This script has a dependency on dplyr. The library is loaded but not installed. Please uncomment the line if installation is required.

The brief was:

You should create one R script called run_analysis.R that does the following. 
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script contains a tidyData function. This function does the heavy lifting with regards to creating the main "tidy" dataset.

1. It reads in the look up data
	- Variable (column) names from ./UCI HAR Dataset/features.txt
	- Activity Labels from ./UCI HAR Dataset/activity_labels.txt

2. Reads in the Test Data set
	- The main data set from ./UCI HAR Dataset/test/X_test.txt
		- Please note that the column name are set as the data is read in
	- The related activites from ./UCI HAR Dataset/test/Y_test.txt
	- The related subjest from ./UCI HAR Dataset/test/subject_test.txt

3. Transforms the Test Data set
	- Extracts only columns that contain "mean" or "std"
	- Adds the activity label by joining to the Activitys imported above
	- Adds the subject to the main data set

4. Same process is repeated for the Training data set

5. The Training data appended to the Test data

The script itself has three actions

1. Call tidyData and assign the result to a data variable
2. Using this data group by activity and subject and average the other variables
3. Output the result to a file called ./Step_5_Data_Set.txt