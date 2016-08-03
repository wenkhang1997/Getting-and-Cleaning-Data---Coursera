# Getting and Cleaning Data - Coursera
Programming assignment (peer review) for the above mentioned course

## Running the script
Download the zip file given in the assignment ("getdata_projectfiles_UCI HAR Dataset.zip" - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to the same folder as this script.
Then, from the R terminal (in the current directory), execute 'source("run_analysis.R", echo = TRUE)'

### Checking the output
After the above script finishes running, variable tidy_data will hold the value  of the result. 
The result is also stored in the file "tidy_data.txt" in the source folder.

## Working of the script
 - The first code section extracts the zip file and creates a subfolder for storing the merged data
 - The second section merges the test and the train data and stores the final outputs to 'all' folder
 - The third section maps the activity ids to the activity names
 - The fourth section selects the columns with the mean and std-deviations and discards the others
 - The fifth section finds the averge of the required values and stores the output in 'tidy_data.txt'
