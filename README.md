###**************************************************************************

information about the functions can be found at the bottom of the script

### step one: reading tables

Set the working directory to the folder containing the following files:"subject_train.txt", "X_train.txt", "y_train.txt", "subject_test.txt", 
"X_test.txt", "y_test.txt" AND "features.txt".

Please take care that the file "features.txt" containing the list of variable names is also storer
in the folder.

Following function will automatically read the tables and assign them to predetermined variables

ReadTrain()

ReadTest()

VarNames()

###*************************************************************************

### step two: assembling the first tidy table (all variables/observations, no calculations of means)

The Code will assemble a table calles "TidyTable" which contains all the variables and values for
all measurements.


colnames(X_test) <- varNames[,2]

colnames(X_train) <- varNames[,2]

testTable <- cbind(subject_test,y_test,"test",X_test)

colnames(testTable) <- c("subject","y","group" ,colnames(testTable[,-(1:3)]))

trainTable <- cbind(subject_train,y_train,"train",X_train)

colnames(trainTable) <- c("subject","y", "group",colnames(trainTable[,-(1:3)]))

SumTable <- rbind(testTable,trainTable)

SumTable$activity<-sapply(SumTable$y,activityConv)

TidyTable <- cbind(SumTable[,c("subject","y", "group","activity")],SumTable[,-c(1,2,3,length(SumTable))])

###**********************************************************************

### step three: erasing non mean/sd variables and computing XTable for activities and subjects

The first function creates a table "TableMeanSd" in which all observations/varibles have been erased,
that do not state mean- or sd-values (point 4 of Course Project Instructions)

Second function creates table "XTable" in which all the average values for each single activity and 
each single subject have been calculated and assigned to each varible (point 5 of Course Project Instructions)

TableMeanSd <- ExtractMeanObs(TidyTable)

XTable <- CreateXTab(TableMeanSd)



###*********************************************************************************

### functions required:

functions for reading tables:

ReadTrain <- function()

    {subject_train<<-read.table("subject_train.txt")
	X_train<<-read.table("X_train.txt")
	y_train<<-read.table("y_train.txt")
    }

ReadTest <- function()

    {subject_test<<-read.table("subject_test.txt")
	X_test<<-read.table("X_test.txt")
	y_test<<-read.table("y_test.txt")
    }


VarNames <- function()

    {varNames<<-read.table("features.txt")
	}

    
###***********************************************************************
    
functions for labeling activities :

activityConv <- function(x)

    {switch(x,"1"="WALKING","2"="WALKING_UPSTAIRS","3"="WALKING_DOWNSTAIRS",
			"4"="SITTING","5"="STANDING","6"="LAYING")
	}

    
###***********************************************************************

function for extraction of mean- and sd-observations/varaibles only (point 4 of Course Project Instructions) :

ExtractMeanObs <- function(SumTable)

    {Mean <- !colnames(SumTable)==sub(".*mean", "", colnames(SumTable))
	Sd <- !colnames(SumTable)==sub(".*std", "", colnames(SumTable))
	ObsSelect <- Mean | Sd
	SumTable <- cbind(SumTable[,c("subject","group","activity","y")],SumTable[,ObsSelect])
	}

    
###***********************************************************************

function for calculation of second tidy data set, creating an Xtable which states the average of each variable for each activity and each subject (point 5 of Course Project Instructions) :

CreateXTab <- function(TableMeanSd)
    
    {ActivityList <- split(TableMeanSd[,-(1:4)],TableMeanSd[,"activity"])
	ActivityMeans <- sapply(ActivityList,colMeans)

	SubjectList <- split(TableMeanSd[,-(1:4)],TableMeanSd[,"subject"])
	SubjectMeans <- sapply(SubjectList,colMeans)

	colnames(SubjectMeans) <- paste("subject",colnames(SubjectMeans))

	XTable <- cbind(ActivityMeans,SubjectMeans)
	XTable
	}