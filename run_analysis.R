#Course Project 2
##You should create one R script called run_analysis.R that does the following tasks;

##Task 1: Merges the training and the test sets to create one data set.
-----------------------------------------------------------------------
getwd()
?read.table
        
##Merge the test and train data sets
subject_test<-read.table("./GettingData_Project2/test/subject_test.txt",col.names=c("subject"))
head(subject_test, n=10)
subject_train<-read.table("./GettingData_Project2/train/subject_train.txt",col.names=c("subject"))
head(subject_train, n=10)
merge_subj<-rbind(subject_train,subject_test)
head(merge_subj, n=10)
str(merge_subj)

##Merge the other data sets too
X_test<-read.table("./GettingData_Project2/test/X_test.txt")
X_train<-read.table("./GettingData_Project2/train/X_train.txt")
y_test<-read.table("./GettingData_Project2/test/y_test.txt",col.names=c("activityid"))
y_train<-read.table("./GettingData_Project2/train/y_train.txt",col.names=c("activityid"))
mergeX<-rbind(X_test,X_train)
mergeY<-rbind(y_test,y_train)
head(mergeX,n=10)
head(mergeY,n=10)


##Task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
-------------------------------------------------------------------------------------------------
feature<-read.table("./GettingData_Project2/features.txt", col.names=c("featureid", "featurename"))
idx<-grep("-mean\\(\\)|-std\\(\\)", feature$featurename)
names(mergeX)<-feature[,2]
MSD<-mergeX[,idx]
head(MSD,n=4) 


##Task 3:Uses descriptive activity names to name the activities in the data set.
--------------------------------------------------------------------------------
activities <- read.table("./GettingData_Project2/activity_labels.txt",col.names=c("activityid","activity"))
activities[, 2] = gsub("_", "", as.character(activities[, 2]))
mergeY [,1] = activities[y[,1], 2]
names(mergeY) <- "activity"
         
                
##Task 4:Appropriately labels the data set with descriptive variable names.
---------------------------------------------------------------------------
tidyData1<-cbind(merge_subj,mergeY,MSD)
names(tidyData1)[2]<-paste("activity")
names(tidyData1)<-gsub("\\(|\\)", "", names(tidyData1))
write.table(tidyData1,"./GettingData_Project2/tidyData1.txt")     
View(tidyData1)    
        
        
##Task 5:Creates a second, independent tidy data set with the average of each 
##variable for each activity and each subject. 
------------------------------------------------------------------------------
install.packages("reshape2")
library(reshape2)
tidyData2<-melt(tidyData1,id=c("subject","activity"))
z<-dcast(tidyData2,subject+activity ~ variable,mean)
write.table(z, file= "./GettingData_Project2/tidyData2.txt", row.names=FALSE)
View(tidyData2)

##THE END
