CodeBook
======================================

##Dataset files description##

###features.txt###
List of all features

- feature_id - unique identifier used to reference feature.

- feature_label - feature label. Each feature_label consists from several separate values: signal name, variable name and variable params. Feature names follow this pattern: ```signal-variable()param_1,param_2``` except angle variables they have different pattern: ```angle(param_1)?,param_2)```.

Feautre labels were processed and split by the corresponding pattern into 4 additional columns:

- signal

- variable

- param_1

- param_2

Detailed information about the variables used on the feature vector can be found in 'features_info.txt'.

###activity_labels.txt###
Links the class labels with their activity name

- activity_id - unique identifier used to reference activity.

- activity_label - physical activity name, can be WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING or LAYING.

###train/X_train.txt###
Training set

Contains data values for each of a 561-feature vector for each window sample. Features are normalized and bounded within [-1,1]. Each feature vector is a row on the text file.

###train/y_train.txt###
Training labels

Each row identifies the activity performed by subject for each window sample. Its range is from 1 to 6. 

###train/subject_train.txt###
Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

###test/X_test.txt###
Test set

Contains data values for each of a 561-feature vector for each window sample. Features are normalized and bounded within [-1,1]. Each feature vector is a row on the text file.

###test/y_test.txt###
Test labels

Each row identifies the activity performed by subject for each window sample. Its range is from 1 to 6.

###test/subject_test.txt###
Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
