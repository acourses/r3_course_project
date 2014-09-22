Coursera's Getting and Cleaning Data Course Project
=================

The script loads Human Activity Recognition Using Smartphones Dataset and calculates mean values for all mean() and std() variables for each subject and each activity.
This work is based on "Human Activity Recognition Using Smartphones Dataset" provided by [1].


R script called run_analysis.R that does the following.

Script assumes "UCI HAR Dataset" folder in the current directory.
It can be extracted from the dataset file obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

activity_labels.txt and features.txt are read as delimeted files. Feature labels then split into 4 different columns according to variable name patterns ```signal-variable()param_1,param_2``` and ```angle(param_1)?,param_2)``` for angle variables.

```subject``` and ```activity``` references for each window sample are read with scan as the files contain one numberic column.

Data set feature vector values are read from ```X_train.txt``` and ```X_test.txt``` fixed width files.

Train and test data have the same format so they are merged with simple vector concatenation and cbind function.

Next activity identifiers in the merged dataset are replaced with actual acivity names using sapply function.

Then features dataset is filtered by variable names "mean" and "std" and the result get applied as a column filter on the merged dataset.

The tidy dataset is created first by melting the feature columns into rows. And casting it back with aggregation fuction mean applied.

Finally the tidy dataset is written to dist with write.table function (row.name=FALSE argument used).



[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012



