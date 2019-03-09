# Load Packages and get the Data
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "UCIHARDataset.zip"))
unzip(zipfile = "UCIHARDataset.zip")

#Read Supporting Metadata
featureNames <- read.table("./UCI HAR Dataset/features.txt")
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

#Format train data
#The data is split up into features (F) , activity (A) and subject (S)

#Read train data
featuresTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

#Read test data F A S
featuresTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
activityTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

#Merges the training and the test sets to create one data set for F A S
features <- rbind(featuresTrain, featuresTest)
activity <- rbind(activityTrain, activityTest)
subject <- rbind(subjectTrain, subjectTest)

#Name the column names from the features file in variable featureNames
colnames(features) <- t(featureNames[2])

#Add activity and subject as a column to features
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
AllData <- cbind(features,activity,subject)

#Extracts only the measurements on the mean and standard deviation for each measurement
featuresReq <- grep(".*Mean.*|.*Std.*", names(AllData), ignore.case=TRUE)

#Adding activity and subject columns
AllReq <- c(featuresReq, 562, 563)

AllFAS <- AllData[,AllReq]

#Uses descriptive activity names to name the activities in the data set

AllFAS$Activity <- as.character(AllFAS$Activity)
for (i in 1:6){
  AllFAS$Activity[AllFAS$Activity == i] <- as.character(activityLabels[i,2])
}
#Set the activity variable in the data as a factor
AllFAS$Activity <- as.factor(AllFAS$Activity)


# Creating the data headers with appropriate names

names(AllFAS)<-gsub("Acc", "Accelerometer", names(AllFAS))
names(AllFAS)<-gsub("Gyro", "Gyroscope", names(AllFAS))
names(AllFAS)<-gsub("BodyBody", "Body", names(AllFAS))
names(AllFAS)<-gsub("Mag", "Magnitude", names(AllFAS))
names(AllFAS)<-gsub("^t", "Time", names(AllFAS))
names(AllFAS)<-gsub("^f", "Frequency", names(AllFAS))
names(AllFAS)<-gsub("tBody", "TimeBody", names(AllFAS))
names(AllFAS)<-gsub("-mean()", "Mean", names(AllFAS), ignore.case = TRUE)
names(AllFAS)<-gsub("-std()", "STD", names(AllFAS), ignore.case = TRUE)
names(AllFAS)<-gsub("-freq()", "Frequency", names(AllFAS), ignore.case = TRUE)
names(AllFAS)<-gsub("angle", "Angle", names(AllFAS))
names(AllFAS)<-gsub("gravity", "Gravity", names(AllFAS))

#From the data set, create a second, independent tidy data set with the average of each variable for each activity and each subject.
#Set the subject variable in the data as a factor

AllFAS$Subject <- as.factor(AllFAS$Subject)
AllFAS <- data.table(AllFAS)

#Create IndependentTidyData as a data set with the average of each variable for each activity and each subject.
IndependentTidyData <- aggregate(. ~Subject + Activity, AllFAS, mean)

#Ordering per subject and activity
IndependentTidyData <- IndependentTidyData[order(IndependentTidyData$Subject,IndependentTidyData$Activity),]

#Writing IndependentTidyData into a text file
write.table(IndependentTidyData, file = "IndependentTidyData.txt", row.names = FALSE)