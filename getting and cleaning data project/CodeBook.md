# Getting and Cleaning Data in R - Project
this code book is created for "a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md" meeting this requirement as per course instruction

## Requirements to be met 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Method/Approach 
The code first checks if the "pacman" package is loaded, and if not, it installs "pacman" and uses it to load the "data.table", "reshape2", and "gsubfn" packages. The purpose of this code is to ensure that the required packages are available and loaded in the R environment for subsequent analysis.
Then code retrieves the current working directory using getwd(), specifies a URL to a ZIP file containing data, and then downloads that ZIP file using download.file()
The downloaded file is saved in the working directory with the name file1.zip
Then after following some steps the required columns(having mean/standard deviation info ) are extracted.
Then proper naming is given. 
Then train and test data are merged.
At last the cleaned dataset is written in the name of tidyData.txt file
