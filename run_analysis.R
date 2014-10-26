# reading test data
X_test<-read.table(file = "./X_test.txt", sep = "", header = FALSE, row.names=NULL)
y_test<-read.table(file = "./y_test.txt", sep = "", header = FALSE)
subject_test<-read.table(file = "./subject_test.txt", sep = "", header = FALSE)
activity_labels<-read.table(file = "./activity_labels.txt", sep = "", header = FALSE)
features<-read.table(file = "./features.txt", sep = "", header = FALSE)

# merging test data sets into a single file. I'm using features.txt to give columm's names,
# y_test to create a columm with the activity's id and subject_test to create a columm with
# the subject's Id. Furthermore, I used the activity labels to create a columm with the  
# activity names.

X_test<-cbind(X_test, subject_test)
X_test<-cbind(X_test, y_test)
names(X_test)<-c(as.vector(features[,2]), c("subject", "activityId"))
X_test$activity[X_test$activityId == 1]<-"WALKING"
X_test$activity[X_test$activityId == 2]<-"WALKING_UPSTAIRS"
X_test$activity[X_test$activityId == 3]<-"WALKING_DOWNSTAIRS"
X_test$activity[X_test$activityId == 4]<-"SITTING"
X_test$activity[X_test$activityId == 5]<-"STANDING"
X_test$activity[X_test$activityId == 6]<-"LAYING"

# reading training data
X_train<-read.table(file = "./X_train.txt", sep = "", header = FALSE, row.names=NULL)
y_train<-read.table(file = "./y_train.txt", sep = "", header = FALSE)
subject_train<-read.table(file = "./subject_train.txt", sep = "", header = FALSE)

# Here I did the same as before for the training data sets.

X_train<-cbind(X_train, subject_train)
X_train<-cbind(X_train, y_train)
names(X_train)<-c(as.vector(features[,2]), c("subject", "activityId"))
X_train$activity[X_train$activityId == 1]<-"WALKING"
X_train$activity[X_train$activityId == 2]<-"WALKING_UPSTAIRS"
X_train$activity[X_train$activityId == 3]<-"WALKING_DOWNSTAIRS"
X_train$activity[X_train$activityId == 4]<-"SITTING"
X_train$activity[X_train$activityId == 5]<-"STANDING"
X_train$activity[X_train$activityId == 6]<-"LAYING"

# Appending the two X_test and X_train data frames

X_test_train<-rbind(X_test, X_train)

# Extrating only the mean and the standart deviation

selected_col<-grep("mean", names(X_test_train))
selected_col<-sort(c(selected_col, grep("std", names(X_test_train)), c(562, 563, 564)))
X_data<-X_test_train[selected_col]

# building the tidy data set with the average information

tidy_data<-aggregate(X_data[, 1:79], list(X_data$subject, X_data$activity), mean)
write.table(tidy_data, "./tidydata.txt", row.names = FALSE)






