
#checking the requirements
if (!require("data.table")) {
  install.packages("data.table")
}

require("data.table")


if (!require("reshape2")) {
  install.packages("reshape2")
}

require("reshape2")


#files
zip.file <- './getdata-projectfiles-UCI HAR Dataset.zip'
local.dir <- './UCI HAR Dataset'
tidy.file <- './tidy-dataset.csv'


# Uncompress the original data file
if (! file.exists(local.dir)) {
  unzip(zip.file)
}

# Fail if unzip failed
if (! file.exists(local.dir)) {
  stop(paste('Unable to unpack the compressed data.'))
}

# Load: activity labels
activity_labels <- read.table(paste(local.dir, 'activity_labels.txt', sep = '/'))[,2]

# Load: data column names
features <- read.table(paste(local.dir, 'features.txt', sep = '/'))[,2]

# Extract only the measurements on the mean and standard deviation for each measurement.
extract_features <- grepl("mean|std", features)

# Load and process X_test & y_test data.
X_test <- read.table(paste(local.dir, 'test', 'X_test.txt', sep = '/'))
y_test <- read.table(paste(local.dir, 'test', 'y_test.txt', sep = '/'))
subject_test <- read.table(paste(local.dir, 'test', 'subject_test.txt', sep = '/'))

names(X_test) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_test = X_test[,extract_features]

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Load and process X_train & y_train data.
X_train <- read.table(paste(local.dir, 'train', 'X_train.txt', sep = '/'))
y_train <- read.table(paste(local.dir, 'train', 'y_train.txt', sep = '/'))

subject_train <- read.table(paste(local.dir, 'train', 'subject_train.txt', sep = '/'))

names(X_train) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Bind data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# Merge test and train data
data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_data, file = tidy.file)