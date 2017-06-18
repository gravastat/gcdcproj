# run_analysis.R 
# downloads the UCI Smartphone data set, combines test and training data
# into one tidy data set containing the mean and standard deviation variable data


#set working directory
setwd("~/Coursera/Course3_GettingCleaningData/week4/r_working")

library(downloader)
library(data.table)
library(plyr)
library(dplyr)

if (!file.exists("smartphonedata")) {
  dir.create("smartphonedata")
}


fileURL<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
download(fileURL,"./smartphonedata/ucidataset.zip",mode="wb")
unzip("./smartphonedata/ucidataset.zip", exdir="./smartphonedata")

#change working directory to UCI Dataset to read files
setwd("~/Coursera/Course3_GettingCleaningData/week4/r_working/smartphonedata/UCI HAR Dataset")


# read files
activityLabels <- fread("./activity_labels.txt")  ## rowsActivityID ActivityName
dataFeatures <- fread("./features.txt")  ## rows data variable names
testSubjects <- fread("./test/subject_test.txt")  ## contains subject doing the test, one per line for test group
testData <- fread("./test/X_test.txt") ## contains Data variables from one run per line for test group
testActivity <- fread("./test/y_test.txt") ## ActivityID one per line for test group
trainSubjects <- fread("./train/subject_train.txt")  ## contains subject doing the test, one per line for train group
trainData <- fread("./train/X_train.txt")  ## contains Data variables from one run per line for train group
trainActivity <- fread("./train/y_train.txt") ## ActivityID one per line for train group

# add descriptive variable names to general files

names(dataFeatures)=c("featureId","featureName")
names(activityLabels)=c("activityId","activityName")


# TEST Data
# TEST Data
# TEST Data
# add descriptive variable names to test files
names(testActivity)="activity"
names(testSubjects)=c("subject")
names(testData)<-dataFeatures$featureName

# factorize testActivity
testActivity$activity=as.factor(testActivity$activity)
levels(testActivity$activity)=activityLabels$activityName

# combine test subject and activity, add variable identifying each record being from the test group
testSubAct <- cbind(testSubjects,testActivity)
testSubAct[,groupset:="test"]  ## Add variable 'groupset' and identify these observations belonging to test group

# combine test subject, activity, and data observations
testSubActData<-cbind(testSubAct,testData)

# TRAIN data
# TRAIN data
# TRAIN data

# add descriptive variable names to train files
names(trainActivity)="activity"
names(trainSubjects)=c("subject")
names(trainData)<-dataFeatures$featureName

# factorize trainActivity
trainActivity$activity=as.factor(trainActivity$activity)
levels(trainActivity$activity)=activityLabels$activityName

#combine train subject and activity, add variable identifying each record being from the train group
trainSubAct <- cbind(trainSubjects,trainActivity)
trainSubAct[,groupset:="train"]  ## Add variable 'groupset' and identify these observations belonging to train group

# combine test subject, activity, and data observations
trainSubActData<-cbind(trainSubAct,trainData)


# combine test and train data into one tidy dataset
data<-rbind(testSubActData,trainSubActData)

# output combined data set
write.table(data, file = "tidy0.txt",row.name=FALSE)

# extract just mean and std deviation variables
subDataFeaturesNames<-dataFeatures$featureName[grep("mean\\(\\)|std\\(\\)", dataFeatures$featureName)]


# create list to get subject,activity,groupset and data variables for subset
subDataFeaturesNamesSAG<-data[,c("subject","activity","groupset",subDataFeaturesNames)]

#create data subset
subData <- data[,subDataFeaturesNamesSAG, with=FALSE]


# clean up the variable names in the data subset, pass 1
names(subData)<-sub("(^f|^t|^angle)(BodyAcc|GravityAcc|BodyAccJerk|BodyGyro|BodyGyroJerk|BodyAccMag|GravityAccMag|BodyAccJerkMag|BodyGyroMag|BodyGyroJerkMag|BodyAcc|BodyAccJerk|BodyGyro|BodyAccMag|BodyBodyAccJerkMag|BodyBodyGyroMag|BodyBodyGyroJerkMag)(.*)$","\\1.\\2.\\3",(gsub("-|\\(|\\)|,","",names(subData))))

# clean up the variable names in the data subset, pass 2
names(subData)<-gsub("BodyBody", "Body", names(subData))
names(subData)<-gsub("^t", "time", names(subData))
names(subData)<-gsub("^f", "freq", names(subData))


# Create data set with average of each variable for each activty and each subject
activitySubjectAverages<-select(subData,-groupset) %>% group_by(activity,subject) %>% summarise_all(funs(mean))


#output Average Data Set
write.table(activitySubjectAverages, file = "tidy1.txt",row.name=FALSE)
