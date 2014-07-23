Codebook
========

Variable list and descriptions
------------------------------

Variable name       | Description
--------------------|------------
subject             | The subject who performed the activity for each sample. [1, 30].
activity            | Activity name
domainFeature       | Factor: Time domain signal or frequency domain signal (Time or Frequency)
instrumentsFeature  | Factor: Measuring instrument (Accelerometer or Gyroscope)
accelerationFeature | Factor: Acceleration signal (Body or Gravity)
variableFeature     | Factor: Variable (Mean or Standard Deviation)
jerkFeature         | Factor: Jerk signal
magnitudeFeature    | Factor: Magnitude of the signals
axisFeature         | Factor: 3-axial signals in the X, Y and Z directions

Dataset structure
-----------------

Classes 'data.table' and 'data.frame':	20160 obs. of  11 variables:

- $ subject            : int  1 1 1 1 1 1 1 1 1 1 ...
- $ activity           : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
- $ domainFeature      : Factor w/ 3 levels NA,"Time","Frequency": 1 1 1 1 1 2 2 2 2 2 ...
- $ accelerationFeature: Factor w/ 3 levels NA,"Body","Gravity": 1 1 1 2 2 1 1 1 1 1 ...
- $ instrumentsFeature : Factor w/ 3 levels NA,"Accelerometer",..: 1 3 3 2 2 3 3 3 3 3 ...
- $ jerkFeature        : Factor w/ 2 levels NA,"Jerk": 1 1 2 1 2 1 1 1 1 1 ...
- $ magnitudeFeature   : Factor w/ 2 levels NA,"Magnitude": 1 1 1 1 1 1 1 1 1 1 ...
- $ variableFeature    : Factor w/ 3 levels NA,"Mean","Standard Deviation": 1 1 1 1 1 1 1 1 1 2 ...
- $ axisFeature        : Factor w/ 4 levels NA,"X","Y","Z": 1 1 1 1 1 1 2 3 4 2 ...
- $ count              : int  150 50 50 50 50 50 600 550 500 50 ...
- $ average            : num  -0.14868 -0.00167 0.08444 0.02137 0.00306 ...
- attr(*, "sorted")= chr  "subject" "activity" "domainFeature" "accelerationFeature" ...
- attr(*, ".internal.selfref")=<externalptr>

Key variables
-------------

* "subject"
* "activity"
* "domainFeature"      
* "accelerationFeature"
* "instrumentsFeature"
* "jerkFeature"   
* "magnitudeFeature"
* "variableFeature"
* "axisFeature"

