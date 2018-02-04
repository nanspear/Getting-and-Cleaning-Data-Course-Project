Project Codebook for Cleaning and Getting Data Course Assignment
=================================================

Thirty volunteers between the ages of 19-48 performed six different activities. These activities were recorded using a Samsung Galaxy 5 II on their waist.  Three axial linear acceleration and three axial angular velocity were captured at a constant rate of 50Hz. The recorded dataset was randomly split into two sets, 70% of the volunteers were selected for generating the training data and 30% of the volunteers were selected for the test data.


Each record provides:
======================================
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Activities performed by the volunteers (Subjects)
1. Walking
2. Walking_Upstairs
3. Walking_Downstairs
4. Sitting
5. Standing
6. Laying


The following files were used:
====================================
1. Subject_test: Each row identifies the test subjects who performed the activity for each window sample.
2. Subject_train: Each row identifies the train subjects who performed the activity for each window sample.
3. Activity_Lables: Links the class labels with their activity name.
4. features.txt: List of all 561 features.
5. X_test: Test data
6. y_test: Test labels
7. X_train: Training data
8. y_train - Training labels


Transformations
================================
The zip file containing the source data is located:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Listed below are the transformations applied to the source data:
1. The test and training data sets were merged together into one data set.
2. A subset was created only using the measurements on the mean and standard deviation.  Strings
   containing mean and std were extracted into the subset.
3. The activity lables were replaced with the name of the activity.
4. The variable names were replaced with descriptive lables using the following set of rules:
      a. "t" was replaced with "time"
      b. "f" was replaced with "frequency"
      c. "Acc" was replaced with "Accelerometer"
      d. "Gyro" was replaced with "Gyroscope"
      e. "Mag" was replaced with "Magnitude""
      f. "BodyBody" was replaced with "Body"
5. The final data set was created with the mean and standard deviation for each activity on each subject.

Downloading the data and the transformations were implemented using the script "run_analysis.R".
See README.md file for more information on using the "run_analysis.R" script.
