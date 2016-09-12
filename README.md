run_analysis.R was written as a part of completion of Coursera Getting and Cleaning Data Assignment Completion
run_analysis.R script performs the following:

- Downloads the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Extracts the files with the data
- Fetch the features from features.txt file
- Extracts the data relevent for mean and standard deviation values
- Loads the training dataset using files X_train.txt, Y_train.txt, subject_train.txt
- Loads the test dataset using the files X_test.txt, Y_test.txt, subject_test.txt
- Mergest both training and test datasets
- Labels the variables into more understandable values
- Fetches the activity labels and assigns appropriate values to the dataset
- Creates a tidy data set with the mean values