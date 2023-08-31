# Loading the packages data.table reshape2 and gsubfn from pacman
# data.table is used for efficient data manipulation, particularly on large datasets.,reshape2 is used for reshaping data for easier visualizations,gsubfn is used for matching patterns
if (!require("pacman")) {
    install.packages("pacman")
}
pacman::p_load(data.table, reshape2, gsubfn)
# this code is used for retrieving the current working directory using getwd(), specifies a URL to a ZIP file containing data, and then downloads that ZIP file using download.file()
# The downloaded file is saved in the working directory with the name file1.zip
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", file.path(getwd(), "file1.zip"))
unzip(zipfile = "file1.zip")
# extracting data into activityLabels and features
activityLabels <- fread(
    file.path(getwd(), "UCI HAR Dataset/activity_labels.txt"),
    col.names = c("activityLabel", "activityNames")
)
features <-fread(
        file.path(getwd(), "/UCI HAR Dataset/features.txt"),
        col.names = c("sno", "featureNames")
)
# meeting the requirements: Extracts only the measurements on the mean and standard deviation for each measurement. 
# Appropriately labels the data set with descriptive variable names from the given conditions from the project
featuresNeeded <- grep("(mean|std)\\(\\)", features[, featureNames])
extractedMeasurements <- features[featuresNeeded, featureNames]
extractedMeasurements <- gsubfn(
    "(^t|^f|Acc|Gyro|Mag|BodyBody|\\(\\))",
    list(
        "t" = "time",
        "f" = "frequency",
        "Acc" = "accelerometer",
        "Gyro" = "gyroscope",
        "Mag" = "magnitude",
        "BodyBody" = "body",
        "()" = ""),extractedMeasurements
)
#loading train data and extracting features needed
train <- fread(file.path(getwd(), "/UCI HAR Dataset/train/X_train.txt"))[, featuresNeeded, with = FALSE]
setnames(train, colnames(train), extractedMeasurements)
activityTrain <-
    fread(file.path(getwd(), "/UCI HAR Dataset/train/y_train.txt"),
          col.names = "Activity")
subjectTrain <-
    fread(file.path(getwd(), "/UCI HAR Dataset/train/subject_train.txt"),
          col.names = "SubjectNo.")
# extracting columns needed and stroring them in train
train <- cbind(activityTrain, subjectTrain, train)

#loading test data and repeating above steps for test data
test <- fread(file.path(getwd(), "/UCI HAR Dataset/test/X_test.txt"))[, featuresNeeded, with = FALSE]
setnames(test, colnames(test),extractedMeasurements)

activityTest <-
    fread(file.path(getwd(), "/UCI HAR Dataset/test/y_test.txt"),
          col.names = "Activity")
subjectTest <-
    fread(file.path(getwd(), "/UCI HAR Dataset/test/subject_test.txt"),
          col.names = "SubjectNo.")

# meeting the following requirement: Merges the training and the test sets to create one data set
test <- cbind(activityTest, subjectTest, test)
testTrain <- rbind(train, test)

testTrain[["Activity"]] <- factor(testTrain[, Activity],levels = activityLabels[["activityLabel"]], labels = activityLabels[["activityNames"]])
testTrain[["SubjectNo."]] <- as.factor(testTrain[, SubjectNo.])
testTrain <- melt.data.table(testTrain, id=c("SubjectNo.", "Activity"))
testTrain <- dcast(testTrain, SubjectNo. + Activity ~ variable, mean)

# writing cleaned data into tidyData.txt
fwrite(testTrain, file="tidyData.txt")
