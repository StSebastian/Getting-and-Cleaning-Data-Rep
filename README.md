# Getting and Cleaning Data: Peer Assessments  
### Steps to run the code are described below 

information where to find the code in the **run_analysis.R** file are given by the *section-information*

**Merges the training and the test sets to create one data set.**  
*section: Merging data*

```{} 
    testTable <- cbind(subject_test,y_test,"test",X_test)
    colnames(testTable) <- c("subject","y","group" ,colnames(testTable[,-(1:3)]))
    
    trainTable <- cbind(subject_train,y_train,"train",X_train)
    colnames(trainTable) <- c("subject","y", "group",colnames(trainTable[,-(1:3)]))
    
    SumTable <- rbind(testTable,trainTable)
```

**Extract only the measurements on the mean and standard deviation for each measurement.**  
*section: Extracting only the measurements on the mean and standard deviation for each measurement*    
   

* extract means and standard deviation columns:  

```{}  
        newColNames <- gsub("[Mm][Ee][Aa][Nn]","Mean",newColNames)
        newColNames <- gsub("[Ss][Tt][Dd]","Std",newColNames)
```
* select those columns from tidy data table:
  
```{}       
        colnames(TidyTable) <- newColNames
```

**Uses descriptive activity names to name the activities in the data set**  
*section: Use descriptive activity names to name the activities in the data set*

* create function for activity variable conversion:

```{}      
        activityConv <- function(x){
              switch(x,"1"="WALKING","2"="WALKING_UPSTAIRS","3"="WALKING_DOWNSTAIRS","4"  
              ="SITTING","5"="STANDING","6"="LAYING")}
```
* apply function on tidy data table:

```{} 
        TidyTable$activity <- sapply(TidyTable$y,activityConv)
```

**Appropriately label the data set with descriptive variable names.**

* variable names from feature.txt are already assigned to X_test and X_train in the beginning *(section labeling data)*:

```{}       
        colnames(X_test) <- varNames[,2]
        colnames(X_train) <- varNames[,2]
```        
* variable names are further cleaned for better names by erasing confusing signs *(section Appropriately labeling the data set with descriptive variable names)*:

```{}        
        newColNames <- gsub("[(|)|,|-]","",colnames(TidyTable))
        colnames(TidyTable) <- newColNames  
```

**Create a second, independent tidy data set with the average of each variable for each activity and each subject.**  
*section: Create a second, independent tidy data set with the average of each variable for each activity and each subject*  
*requires package reshape2*

* creating new dataset with activity and subject as id-variables:

```{}        
        MeltedData <- melt(TidyTable[,-(2:3)],id=c("activity","subject"))
```
* creating dataset with average of each variable for each activity, each subject and both togther

```{} 
        ActivityMeans <- dcast(MeltedData,activity~variable,mean,na.rm=T)

        SubjectMeans <- dcast(MeltedData,subject~variable,mean,na.rm=T)

        ActivitySubjectMeans <- dcast(MeltedData,activity+subject~variable,mean,na.rm=T)
```
