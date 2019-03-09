---
title: "Code Book"
author: "Ziyad Abushima"
date: "March 09, 2019"
output: IndependentTidyData.txt
---
# Getting and Cleaning Data Project

## Description
This document describes the data and transformations used by [run_analysis.R](https://github.com/zabushim/GettingCleaningDataProject/blob/master/run_analysis.R) and the definition of variables in [IndependentTidyData.txt](https://github.com/zabushim/GettingCleaningDataProject/blob/master/IndependentTidyData.txt).

## Source Data
The data linked are collected from the accelerometers from the Samsung Galaxy S smartphone. 
Description can be found here [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
Data can be found here [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Input Data Set

The input data containts the following data files:

- `X_train.txt` contains variable features that are intended for training.
- `y_train.txt` contains the activities corresponding to `X_train.txt`.
- `subject_train.txt` contains information on the subjects from whom data is collected.
- `X_test.txt` contains variable features that are intended for testing.
- `y_test.txt` contains the activities corresponding to `X_test.txt`.
- `subject_test.txt` contains information on the subjects from whom data is collected.
- `activity_labels.txt` contains metadata on the different types of activities.
- `features.txt` contains the name of the features in the data sets.

## Transformations

Following are the transformations that were performed on the input dataset:

### Read:
- `X_train.txt` is read into `featuresTrain`.
- `y_train.txt` is read into `activityTrain`.
- `subject_train.txt` is read into `subjectTrain`.
- `X_test.txt` is read into `featuresTest`.
- `y_test.txt` is read into `activityTest`.
- `subject_test.txt` is read into `subjectTest`.
- `features.txt` is read into `featureNames`.
- `activity_labels.txt` is read into `activityLabels`.

### Merges & other transformations:
- The subjects in training and test set data are merged to form `subject`.
- The activities in training and test set data are merged to form `activity`.
- The features of test and training are merged to form `features`.
- The name of the features are set in `features` from `featureNames`.
- `features`, `activity` and `subject` are merged to form `AllData`.

### Extract mean and standard deviation variables and express Activity as Factor
- Indices of columns that contain std or mean, activity and subject are taken into `AllReq` .
- `AllFAS` is created with data from columns in `AllReq`.
- `Activity` column in `AllFAS` is updated with descriptive names of activities taken from `activityLabels`. 
- `Activity` column is expressed as a factor variable.

### Descriptive labels:
- Abbreviations in variable names in `AllFAS`, like 'Acc', 'Gyro', 'Mag', 't' and 'f' are replaced with descriptive labels such as 'Accelerometer', 'Gyroscpoe', 'Magnitude', 'Time' and 'Frequency'.
- Other variable names were aligned with the new descriptive labels (BodyBody --> Body, tBody --> TimeBody, angle --> Angle, gravity --> Gravity, freq --> Frequency)

### Output generation:
- `IndependentTidyData` is created as a set with average for each activity and subject of `AllFAS`. Entries in `IndependentTidyData` are ordered based on activity and subject.
- Finally, the data in `IndependentTidyData` is written into `IndependentTidyData.txt`.

## Output Data Set
The output data [IndependentTidyData.txt](https://github.com/zabushim/GettingCleaningDataProject/blob/master/IndependentTidyData.txt) is a a space-delimited value file. 
The header line contains the descriptive names of the variables. It contains the mean and standard deviation values of the data contained in the input files.
