##You should create one R script called run_analysis.R that does the following. 
##1.Merges the training and the test sets to create one data set.
##2.Extracts only the measurements on the mean and standard deviation for each measurement. 
##3.Uses descriptive activity names to name the activities in the data set
##4.Appropriately labels the data set with descriptive variable names. 
##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##1.Merges the training and the test sets to create one data set.
##4.Appropriately labels the data set with descriptive variable names. 

##install.packages("dplyr")
library(dplyr)

tidyData <- function(){    
    
    ## 1. It reads in the look up data
    ## Variable (column) names from ./UCI HAR Dataset/features.txt
    columnNames <- read.table("./UCI HAR Dataset/features.txt")
    
    ## Activity Labels from ./UCI HAR Dataset/activity_labels.txt
    activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    
    ## This just simplifies the join
    names(activityLabels) <- c("activity_id", "activity")
    
    ## 2. Reads in the Test Data set     
    ## The main data set from ./UCI HAR Dataset/test/X_test.txt
    ## Please note that the column name are set as the data is read in
    testX <- read.table("./UCI HAR Dataset/test/X_test.txt", sep = "", strip.white=T, col.names=columnNames[,2]);    
    
    ## The related activites from ./UCI HAR Dataset/test/Y_test.txt
    testY <- read.table("./UCI HAR Dataset/test/Y_test.txt", sep = "", strip.white=T, col.names=c("activity_id"));    
    
    ## The related subjest from ./UCI HAR Dataset/test/subject_test.txt
    testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = "", strip.white=T, col.names=c("subject_id"));
    
    ## 3. Transforms the Test Data set
    ## Extracts only columns that contain "mean" or "std"
    testX <- select(testX, matches("mean|std")) 
    
    ## Adds the activity label by joining to the Activitys imported above
    testX <- cbind(testX, inner_join(testY, activityLabels)[2])    
    
    ## Adds the subject to the main data set
    testX <- cbind(testX, testSubject)
        
    ## 4. Same process is repeated for the Training data set
    trainX <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "", strip.white=T, col.names=columnNames[,2]);        
    trainY <- read.table("./UCI HAR Dataset/train/Y_train.txt", sep = "", strip.white=T, col.names=c("activity_id"));    
    trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = "", strip.white=T, col.names=c("subject_id"));
    
    ##transforms    
    trainX <- select(trainX, matches("mean|std"))
    trainX <- cbind(trainX, inner_join(trainY, activityLabels)[2])    
    trainX <- cbind(trainX, trainSubject)
    
    ## 5. The Training data appended to the Test data
    data <- rbind(testX, trainX)        
}

## 1. Call tidyData and assign the result to a data variable
data <- tidyData();

## 2. Using this data group by activity and subject and average the other variables
averages <- data %>% group_by(activity, subject_id) %>% summarise_each(funs(mean))

## 3. Output the result to a file called ./Step_5_Data_Set.txt
write.table(averages, "./Step_5_Data_Set.txt", row.name=F)
