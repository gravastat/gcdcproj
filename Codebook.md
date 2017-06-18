## Data Cleaning Steps

The run_analysis.R scripts downloads the study data set and extracts it into a working directory.  

The script ingests the following files:
* activity_labels.txt
* features.txt
* test/subject_test.txt
* test/X_test.txt
* test/y_test.txt
* train/subject_train.txt
* train/X_train.txt
* train/y_train.txt

The Inertial Signals directories are ignored.

Descriptive variables names are given.  The subject, activity, and data are first combined into their repective groupset (test or train).  Then the two datasets are combined into one.   The combined dataset is then refined to extract only the measurements on mean and standard deviation.  The variable names have been cleaned with regular expressions.

### Combined dataset variables:
* variable.name variable type
* subject	int 
* activity	factor(WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING)
* groupset	chr (test,train)
* time.BodyAcc.meanX	num
* time.BodyAcc.meanY	num
* time.BodyAcc.meanZ	num
* time.BodyAcc.stdX	num
* time.BodyAcc.stdY	num
* time.BodyAcc.stdZ	num
* time.GravityAcc.meanX	num
* time.GravityAcc.meanY	num
* time.GravityAcc.meanZ	num
* time.GravityAcc.stdX	num
* time.GravityAcc.stdY	num
* time.GravityAcc.stdZ	num
* time.BodyAccJerk.meanX	num
* time.BodyAccJerk.meanY	num
* time.BodyAccJerk.meanZ	num
* time.BodyAccJerk.stdX	num
* time.BodyAccJerk.stdY	num
* time.BodyAccJerk.stdZ	num
* time.BodyGyro.meanX	num
* time.BodyGyro.meanY	num
* time.BodyGyro.meanZ	num
* time.BodyGyro.stdX	num
* time.BodyGyro.stdY	num
* time.BodyGyro.stdZ	num
* time.BodyGyroJerk.meanX	num
* time.BodyGyroJerk.meanY	num
* time.BodyGyroJerk.meanZ	num
* time.BodyGyroJerk.stdX	num
* time.BodyGyroJerk.stdY	num
* time.BodyGyroJerk.stdZ	num
* time.BodyAccMag.mean	num
* time.BodyAccMag.std	num
* time.GravityAccMag.mean	num
* time.GravityAccMag.std	num
* time.BodyAccJerkMag.mean	num
* time.BodyAccJerkMag.std	num
* time.BodyGyroMag.mean	num
* time.BodyGyroMag.std	num
* time.BodyGyroJerkMag.mean	num
* time.BodyGyroJerkMag.std	num
* freq.BodyAcc.meanX	num
* freq.BodyAcc.meanY	num
* freq.BodyAcc.meanZ	num
* freq.BodyAcc.stdX	num
* freq.BodyAcc.stdY	num
* freq.BodyAcc.stdZ	num
* freq.BodyAccJerk.meanX	num
* freq.BodyAccJerk.meanY	num
* freq.BodyAccJerk.meanZ	num
* freq.BodyAccJerk.stdX	num
* freq.BodyAccJerk.stdY	num
* freq.BodyAccJerk.stdZ	num
* freq.BodyGyro.meanX	num
* freq.BodyGyro.meanY	num
* freq.BodyGyro.meanZ	num
* freq.BodyGyro.stdX	num
* freq.BodyGyro.stdY	num
* freq.BodyGyro.stdZ	num
* freq.BodyAccMag.mean	num
* freq.BodyAccMag.std	num
* freq.BodyAccJerkMag.mean	num
* freq.BodyAccJerkMag.std	num
* freq.BodyGyroMag.mean	num
* freq.BodyGyroMag.std	num
* freq.BodyGyroJerkMag.mean	num
* freq.BodyGyroJerkMag.std	num

From this combined dataset an independent tidy dataset with the average of each variable for each activity and subject was created.  The variables are the same but the data values are the averages of the variables grouped by activity and subject.
