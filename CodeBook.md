Steps to run the code are describe in the README.md of this GiHub Repo

variables:

subject_train:  raw subject_train data (created by function ReadTrain)

X_train:        raw X_train data (created by function ReadTrain)

y_train:        raw Y_train data (created by function ReadTrain)



subject_test:   raw subject_test data (created by function ReadTest)

X_test:         raw X_test data (created by function ReadTest)

y_test:         raw y_test data (created by function ReadTest)



varNames:       raw names of variable (measurements) (created by function VarNames)   


testTable:      tidy test data only (created in worksheet)


trainTable:     tidy train data only (created in worksheet)


SumTable:       tidy data train and test data and labeled activity column (created in worksheet)


TidyTable:      like SumTable with reordered columns (created in worksheet)


TableMeanSd:    similar to Tidy Table but non-mean and non-std measurements are removed (created by function ExtractMeanObs)


XTable:         tidy data set with the average of each variable for each activity and each subject (created by function CreateXTab)