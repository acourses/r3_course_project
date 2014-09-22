##
# run_analysis.R
##

# Script assumes "UCI HAR Dataset" folder in the current directory.
# It can be extracted from the dataset file obtained from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

library(stringr)
library(reshape2)

# Load data

# 1. activity_labels
activity_labels <- read.delim("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F,
                              sep = " ", header = F)
colnames(activity_labels) <- c("acivity_id", "acivity_label")

# 2. features
features <- read.delim("UCI HAR Dataset/features.txt", sep = " ", stringsAsFactors = F, header = F)
colnames(features) <- c("feature_id", "feature_label")

# feature_label consists from several separate values:
# signal name, varable name and variable params.
# There are two feature name pattens:
# * "signal-variable()param_1,param_2"
# * "angle(param_1)?,param_2)"

# decode feature name parts into separate data frame columns
t <- str_trim(str_replace_all(features$feature_label, "[,()-]+", " "))
t <- str_replace_all(t, "angle", "_ angle")
tt <- str_split(t, " ")

parsed_features <- t(sapply(tt, function(i) i[1:4]))
parsed_features[parsed_features[,1] == "_" ,1] <- NA

colnames(parsed_features) <- c("signal", "variable", "param_1", "param_2")

features <- cbind(features, parsed_features)

# 3. test
subject_test <- scan("UCI HAR Dataset/test/subject_test.txt")
y_test <- scan("UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = F)

# 3. train
subject_train <- scan("UCI HAR Dataset/train/subject_train.txt")
y_train <- scan("UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = F)

# Merge the training and the test sets to create one data set.
subject_merged <- c(subject_test, subject_train)
y_merged <- c(y_test, y_train)
x_merged <- rbind(x_test, x_train)

# Extract only the measurements on the mean and standard deviation
# for each measurement.
# Name the activities in the data set with descriptive activity names.
# Label the data set with descriptive variable names appropriately.

selected_features <- features$variable == "mean" | features$variable == "std"
selected_features_id <- features[selected_features, "feature_id"]
selected_features_label <- features[selected_features, "feature_label"]

x_merged <- x_merged[, selected_features_id]
colnames(x_merged) <- selected_features_label

# attach subject and activity columns to dataset
x_merged <- cbind(x_merged, subject = subject_merged)
x_merged <- cbind(x_merged, activity = y_merged)

x_merged_activity <- sapply(x_merged$activity, function(x) {
    activity_labels[activity_labels$acivity_id == x, "acivity_label"]
  })

x_merged$activity <- as.factor(x_merged_activity)

# From the data set in step 4, creates a second,
# independent tidy data set with the average of each variable for each activity and each subject.

melted <- melt(x_merged,
               id=c("subject", "activity"),
               measure.vars=selected_features_label)
tidy_data_set <- dcast(melted, subject + activity ~ variable, mean)

write.table(tidy_data_set, file = "tidy_data_set.txt", row.name=FALSE)

