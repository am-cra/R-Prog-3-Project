# Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

wd="UCI HAR Dataset/"
# 1. Merge the training and the test sets to create one data set.
X.train <- read.table(paste0(wd,"train/X_train.txt"))
X.test <- read.table(paste0(wd,"test/X_test.txt"))
X <- rbind(X.train, X.test)

S.train <- read.table(paste0(wd,"train/subject_train.txt"))
S.test <- read.table(paste0(wd,"test/subject_test.txt"))
S <- rbind(S.train, S.test)

Y.train <- read.table(paste0(wd,"train/y_train.txt"))
Y.test <- read.table(paste0(wd,"test/y_test.txt"))
Y <- rbind(Y.train, Y.test)

# 2. Extract the measurements on the mean and std. dev. for each measurement.

features <- read.table(paste0(wd,"features.txt"))
good_indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, good_indices]
names(X) <- features[good_indices, 2]
names(X) <- gsub("\\(|\\)", "", names(X))

# 3. Use descriptive activity names to name the activities in the data set.

activities <- read.table(paste0(wd,"activity_labels.txt"))
#activities[, 2] <- gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] <- activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
cleaned_data <- cbind(S, Y, X)
write.table(cleaned_data, "cleaned_data.txt")

# 5. Creates a second, tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "average_data.txt", row.names=FALSE)