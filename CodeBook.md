Getting and Cleaning Data Project Code Book
===========================================

Original data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The included R script (run_analysis.R) cleans up the data:

* It merges the training and test sets to create a single data set (train/X_train.txt with test/X_test.txt, train/subject_train.txt with test/subject_test.txt, and train/y_train.txt with test/y_test.txt.

* It reads the file features.txt and extracts only the measurements on the mean and standard deviation for each measurement.

* It reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:
        WALKING
        WALKING_UPSTAIRS
        WALKING_DOWNSTAIRS
        SITTING
        STANDING
        LAYING

* The script also labels the data set with descriptive names and removes parenthesis from the names. Then it merges features data frame with the activity and subject data frames, and saves the result as _cleaned_data.txt_, where the first column is the subject ID, the second column is the activity name and the other columns are measurements.

* In the final step, the script creates a second, tidy data set with the average of each measurement for each activity and each subject. The result is saved as _average_data_set.txt_, where, the first two columns are, respectively, the subject IDs and activity names, and the other columns are the measurements.

