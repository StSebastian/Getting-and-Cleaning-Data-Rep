## Steps to run the code are describe in the README.md of this GiHub Repo

### Dataset variable

subject:        variable for subject id
    levels: 1 to 30
    
group:          variable indicating test or train group belonging
    levels: * test
            * train
    
y:              id variable for activity
    levels: 1 to 6
    
activity:       variable with descriptive activity names (generated from variable y)
    levels: * WALKING
            * WALKING_UPSTAIRS
            * WALKING_DOWNSTAIRS
			* SITTING
            * STANDING
            * LAYING

measurement variables:
    tBodyAcc-XYZ, tGravityAcc-XYZ, tBodyAccJerk-XYZ, tBodyGyro-XYZ, tBodyGyroJerk-XYZ
    tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag
    fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccMag, fBodyAccJerkMag       

    
### Code variables:

subject_train:  raw subject_train data (read from folder)

X_train:        raw X_train data (read from folder)

y_train:        raw Y_train data (read from folder)


subject_test:   raw subject_test data (read from folder)

X_test:         raw X_test data (read from folder)

y_test:         raw y_test data (read from folder)


varNames:       raw names of variable (measurements) (read from folder)   

testTable:      tidy test data only (created in worksheet, contains subject activity and group information in addition to the variables)
    
trainTable:     tidy train data only (created in worksheet, contains subject activity and group information in addition to the variables)
    
SumTable:       tidy train and test data and labeled activity column (created in worksheet)

TidyTable:      like SumTable with reordered columns, descriptive activity names and Appropriately labeled variables(created in worksheet)

    
MeltedData:     TadyTable data ordered for id variables "activity" and "subject" with melt() - function from package reshape 2
 
ActivityMeans:  average of each variable for each activity level, calculated with dcast() - function 
   
SubjectMeans:   average of each variable for each subject id, calculated with dcast() - function
    
ActivitySubjectMeans:   ActivityMeans and SubjectMeans combined
   