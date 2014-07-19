# Getting and Cleaning Data: Peer Assessments
    
### Setting the directory:  
    currentDirectory <- getwd()
    newDirectory <- paste(currentDirectory,"/PeerAssessment",sep="")
    if(!file.exists("PeerAssessment")){dir.create("PeerAssessment")}
    setwd(newDirectory)
  
### Downloading and unzipping data:  
    setInternet2()
    file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(file,"data.zip")    
    unzip("data.zip")

### Loading packages
    install.packages("reshape2",repos="http://cran.us.r-project.org")
    library("reshape2")
    
### Reading data:      
    newDirectory <- paste(currentDirectory,"/PeerAssessment/UCI HAR Dataset/train",sep="")
    setwd(newDirectory)
    subject_train <- read.table("subject_train.txt")
	X_train <- read.table("X_train.txt")
	y_train <- read.table("y_train.txt")
    
    newDirectory <- paste(currentDirectory,"/PeerAssessment/UCI HAR Dataset/test",sep="")
    setwd(newDirectory)   
	subject_test <- read.table("subject_test.txt")
	X_test <- read.table("X_test.txt")
	y_test <- read.table("y_test.txt")

    newDirectory <- paste(currentDirectory,"/PeerAssessment/UCI HAR Dataset/",sep="")
    setwd(newDirectory)     
    varNames <- read.table("features.txt")    
   
### Labeling data   
    colnames(X_test) <- varNames[,2]
    colnames(X_train) <- varNames[,2]

### Merging data    
    testTable <- cbind(subject_test,y_test,"test",X_test)
    colnames(testTable) <- c("subject","y","group" ,colnames(testTable[,-(1:3)]))
    
    trainTable <- cbind(subject_train,y_train,"train",X_train)
    colnames(trainTable) <- c("subject","y", "group",colnames(trainTable[,-(1:3)]))
    
    SumTable <- rbind(testTable,trainTable)

### Extracting only the measurements on the mean and standard deviation for each measurement:    
    MeanAndStdCol <- grepl("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]",colnames(SumTable))
    MeanAndStdCol[1:3] <- TRUE #preserving the first three columns where activity, group and subject values are stored
    TidyTable <- SumTable[,MeanAndStdCol]    
    
### Uses descriptive activity names to name the activities in the data set    
    activityConv <- function(x){
	switch(x,"1"="WALKING","2"="WALKING_UPSTAIRS","3"="WALKING_DOWNSTAIRS",
			"4"="SITTING","5"="STANDING","6"="LAYING")
	}
    
    TidyTable$activity <- sapply(TidyTable$y,activityConv)

### Appropriately labeling the data set with descriptive variable names.     
   newColNames <- gsub("[(|)|,|-]","",colnames(TidyTable))
   newColNames <- gsub("[Mm][Ee][Aa][Nn]","Mean",newColNames)
   newColNames <- gsub("[Ss][Tt][Dd]","Std",newColNames)
   colnames(TidyTable) <- newColNames
 
### Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

    MeltedData <- melt(TidyTable[,-(2:3)],id=c("activity","subject"))
    ActivityMeans <- dcast(MeltedData,activity~variable,mean,na.rm=T)
    SubjectMeans <- dcast(MeltedData,subject~variable,mean,na.rm=T)
    ActivitySubjectMeans <- dcast(MeltedData,activity+subject~variable,mean,na.rm=T)

### Writind data
    write.table(SubjectMeans,file="SubjectMeans.txt",sep=";",row.names=F)
    write.table(ActivityMeans,file="ActivityMeans.txt",sep=";",row.names=F)
    write.table(ActivitySubjectMeans,file="ActivitySubjectMeans.txt",sep=";",row.names=F)
    write.table(TidyTable,file="TidyTable.txt",sep=";",row.names=F)

 