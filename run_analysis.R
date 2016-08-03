rm(list = ls())
#wd <- getwd()


## Setup environment -----------------------------------------------------------

unzip("getdata_projectfiles_UCI HAR Dataset.zip")
setwd("UCI HAR Dataset")
dir.create("all")
dir.create("all/Inertial Signals")
setwd("all")


## Merge test and train --------------------------------------------------------

files <- list.files("../train", recursive = TRUE)
for (i in files) {
    test_data <- read.table(paste(c("../test/", gsub("train","test", i)), collapse=""))
    train_data <- read.table(paste(c("../train/", i), collapse=""))
    merged_data <- rbind(test_data, train_data)
    write.table(merged_data, file = gsub("train","all",i), row.names = FALSE, col.names = FALSE)
}
rm(list = ls())


## Add activity names for description ------------------------------------------

activity_names <- read.table("../activity_labels.txt")
row_numbers <- read.table("y_all.txt")
row_names <- activity_names[row_numbers[,1], 2]
write.table(row_names, file = "y_final.txt", row.names = FALSE, col.names = FALSE)


## Extract mean and std deviation ----------------------------------------------

extract_cols <- read.table("../features.txt")
extract_cols <- extract_cols[grep('mean\\(\\)|std\\(\\)', extract_cols[,2]),]

data <- read.table("X_all.txt")
final_data <- data[,extract_cols[,1]]
write.table(extract_cols[,2], file = "col_names.txt")
write.table(final_data, file = paste("X_final.txt"), row.names = FALSE, col.names = extract_cols[,2])


## Create tidy data set with averages ------------------------------------------

rm(list = ls())
dir.create("../tidy")
setwd("../tidy")
data <- read.table("../all/X_final.txt", header = TRUE)
activities <- read.table("../all/y_final.txt", colClasses = "character")
col_names <- read.table("../all/col_names.txt", colClasses = "character")
subjects <- read.table("../all/subject_all.txt")
d <- cbind(subjects, activities, data)
tidy_data <- NULL
for (subject in 1:30) {
    temp <- aggregate(d[subjects==subject,3:length(d)], by = list(activities[subjects==subject,]), FUN = mean)
    tidy_data <- rbind(tidy_data, cbind(subject, temp))
}

#tidy_data <- aggregate(data, by = rows, FUN = mean)
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE, col.names = c("subject","activity",col_names[,1]))

## End -------------------------------------------------------------------------

x <- read.table("tidy_data.txt")
print(x)
rm(list = ls())
#setwd(wd)
