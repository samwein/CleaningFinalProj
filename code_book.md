**CODE BOOK**
=================

**ABOUT THE DATA IN ORIGINAL DATASETS**

These datasets are derived from the "Human Activity Recognition Using Smartphones Dataset Version 1.0"

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually.
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity.
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used.
From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record in the original dataset, the following is provided:
1) Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
2) Triaxial Angular velocity from the gyroscope. 
3) A 561-feature vector with time and frequency domain variables. 
4) Its activity label. 
5) An identifier of the subject who carried out the experiment.

======================================

**ABOUT DATA IN DATASETS ALL_DATA.TXT & MEAN_DATA.TXT**

The features selected for this database come from the:
1) accelerometer *(acc)*
2) gyroscope *(gyro)* 

Each signal is taken in three axes, creating three different variables for both the acceleraometer and the gyroscope. The suffixes below indicate the axes:
1) X
2) Y
3) Z

There are two domain signals:
1) time *(prefix 't')*
2) frequency *(prefix 'f')*


The acceleration signal was separated into two signals:
1) body
2) gravity

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals:
1) jerk

The magnitude of these three-dimensional signals were calculated:
1) mag


Combining the above gives the following signals measured or derived:  
*NOTE: 'xyz' is used to denote three individual variables for that feature, one for each axis*

**1) tbodyaccxyz
2) tgravityaccxyz
3) tbodyaccjerkxyz
4) tbodygyroxyz
5) tbodygyrojerkxyz
6) tbodyaccmag
7) tgravityaccmag
8) tbodyaccjerkmag
9) tbodygyromag
10) tbodygyrojerkmag
11) fbodyaccxyz
12) fbodyaccjerkxyz
13) fbodygyroxyz
14) fbodyaccmag
15) fbodyaccjerkmag
16) fbodygyromag
17) fbodygyrojerkmag**



For each of the above signals, the following were were estimated and correspond to variables in the dataset: 

1) mean value *(mean)*
2) standard deviation *(std)*

=======================================

**TRANSFORMATIONS AND CLEANING OF ORIGINAL DATASETS TO GET TO TIDY DATASETS**

 Function *run_analysis.r* overview
  1) Read the files into the function
  2) Use the elements of features.txt to rename columns for x_test and x_train
  3) Use the elements of activity_labels.txt to rename columns for y_test and y_train
  4) Column bind all the test datasets together and all the train datasets together
  5) Row bind the test and train datasets together
  6) Subset the resulting data frame to take only standard deviations and means <- this is the first 'tidy dataset'
  7) Convert to dplyr table
  8) Group the data by subject and activity
  9) Take the mean of each of the above groups <- this is the second 'tidy dataset'