library(reshape2)

#Download the file if it does not exist

filename <- "getdata_UCI_HAR_Dataset.zip"
if(!file.exists(filename)){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,filename,methos = "curl")
}

#Unzip the file if not done

if(!file.exists("UCI HAR Dataset")){
        print("unzip")
       unzip(filename)
}

#Fetch the features

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracting the mean and std deviation data
featuresWanted <- grep(".*mean.*|.*std.*",features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names <- gsub('-mean','Mean',featuresWanted.names)
featuresWanted.names <- gsub('-std','Std',featuresWanted.names)
featuresWanted.names <- gsub('[-()]','',featuresWanted.names)

 
# Load the train datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects,trainActivities,train)

# Load the test datasets
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects,testActivities,test)

#Merging the training and test datasets
alldata <- rbind(train,test)

#Labelling the dataset variables
colnames(alldata) <- c("subject","activities",featuresWanted.names)
colnames(alldata) <- gsub("Acc","Acceleration",colnames(alldata))
colnames(alldata) <- gsub("Mag", "Magnitude",colnames(alldata))
colnames(alldata) <- gsub("Gyro", "Gyroscope",colnames(alldata))
colnames(alldata) <- gsub("^t", "time",colnames(alldata))
colnames(alldata) <- gsub("^f", "frequency",colnames(alldata))

# Fetch the activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

# Assigning activity description to dataset
alldata$activities <- factor(alldata$activities, levels = activityLabels[,1], labels = activityLabels[,2])

# New tidy data set with mean value
alldata.melted <- melt(alldata, id =c("subject","activities"))
alldata.mean <- dcast(alldata.melted,subject+activities ~ variable,mean)
write.table(alldata.mean,"tidy.txt",row.names = FALSE, quote = FALSE)



