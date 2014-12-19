GettinAndCleaningDataProject
============================
The first thing the run_analysis.R script does it is including necessary libraries for used functions and methods (dplyr).

Next it is reading training and test data (train/X_train.txt and test/X_test.txt). Then merges both tables.

Script reads the headers data (features.txt) and uses it to extract only mean and standard deviation by reading variables names.
In this step it adds also descriptive variables names to the dataset. New columns will get their names added in the moment of preparation.

After that it names properly activities by reading activity_labels.txt and codes for them from train/Y_train.txt and test/Y_test.txt.

Next it adds informations about subjects from train/subject_train.txt and test/subject_test.txt.

In the end the script creates a summary dataset and exports it to the text file getdata16_peer_project_final_data.txt.

For the final cleaning we remove data frames to free space.
