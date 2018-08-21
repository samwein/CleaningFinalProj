#You should create one R script called run_analysis.R that does the following.

# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Set Variables for use by function
#x_test <- "./test/x_test.txt"
#y_test <- "./test/y_test.txt"
#sub_test <- "./test/subject_test.txt"
#x_train <- "./train/x_train.txt"
#y_train <- "./train/y_train.txt"
#sub_train <- "./train/subject_train.txt"
#act_label <- "./activity_labels.txt"
#feat <- "./features.txt"

run_analysis <- function(x_test, y_test, sub_test, x_train, y_train, sub_train, act_label, feat){
  #Function overview
  #1) Read the files into the function
  #2) Use the elements of features.txt to rename columns for x_test and x_train
  #3) Use the elements of activity_labels.txt to rename columns for y_test and y_train
  #4) Column bind all the test datasets together and all the train datasets together
  #5) Row bind the test and train datasets together
  #6) Subset the resulting data frame to take only standard deviations and means <- this is the first 'tidy dataset'
  #7) Convert to dplyr table
  #8) Group the data by subject and activity
  #9) Take the mean of each of the above groups <- this is the second 'tidy dataset'
  
  #read in data and remove "."
  feat <- read.table(feat)
  feat[,2] <- tolower(feat[,2])
  rmtext <- c("\\.", "\\,", "\\-", "\\(", "\\)")
  for(i in seq_along(rmtext)) {
    feat[,2] <- gsub(rmtext[i],"",feat[,2])
    }
  
  
  x_test <- read.table(x_test, col.names = feat[,2]) #includes elements from 'features' as column names
   y_test <- read.table(y_test)
  sub_test <- read.table(sub_test)
  x_train <- read.table(x_train, col.names = feat[,2]) #includes elements from 'features' as column names
  y_train <- read.table(y_train)
  sub_train <- read.table(sub_train)
  act_label <- read.table(act_label)
  
#rename columns
  names(y_test) <- c("activity")
  names(y_train) <- c("activity")
  names(sub_test) <- c("subject")
  names(sub_train) <- c("subject")
  
  #convert values in y_test and y_train to activity labels
  yact_test <- y_test
  yact_train <- y_train
  for(i in 1:6) {
    yact_test[,1] <- gsub(i, act_label[i,2], yact_test[,1])
    yact_train[,1] <- gsub(i, act_label[i,2], yact_train[,1])
  }
  
  #bind all test columns together and all train columns together
  test_data <- cbind(sub_test, yact_test, x_test)
  train_data <- cbind(sub_train, yact_train, x_train)
  
  #bind test and train data sets together
  
  data <- rbind(train_data, test_data)
  
  #subset to only take mean and std measurements (and not meanfreq or angle)
  subdata <- data[,grep('mean|std|subject|activity', names(data))]
  subdata <- subdata[,!grepl("meanfreq|angle", names(subdata))]
  # subdata is the first tidy dataset. It is written to file ALL_DATA.TXT
  
  
  
  #take mean of each variable for each subject and activity combination
library(dplyr)
  subdata <- tbl_df(subdata)
  grouped <- group_by(subdata, activity, subject)
  mean_data <- summarize_all(grouped, mean)
# mean_data is the second tidy dataset. It is written to file MEAN_DATA.TXT
#print(head(as.data.frame(mean_data)))
}