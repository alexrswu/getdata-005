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

## Classes 'data.table' and 'data.frame':	20160 obs. of  11 variables:
##  $ subject            : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity           : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ domainFeature      : Factor w/ 3 levels NA,"Time","Frequency": 1 1 1 1 1 2 2 2 2 2 ...
##  $ accelerationFeature: Factor w/ 3 levels NA,"Body","Gravity": 1 1 1 2 2 1 1 1 1 1 ...
##  $ instrumentsFeature : Factor w/ 3 levels NA,"Accelerometer",..: 1 3 3 2 2 3 3 3 3 3 ...
##  $ jerkFeature        : Factor w/ 2 levels NA,"Jerk": 1 1 2 1 2 1 1 1 1 1 ...
##  $ magnitudeFeature   : Factor w/ 2 levels NA,"Magnitude": 1 1 1 1 1 1 1 1 1 1 ...
##  $ variableFeature    : Factor w/ 3 levels NA,"Mean","Standard Deviation": 1 1 1 1 1 1 1 1 1 2 ...
##  $ axisFeature        : Factor w/ 4 levels NA,"X","Y","Z": 1 1 1 1 1 1 2 3 4 2 ...
##  $ count              : int  150 50 50 50 50 50 600 550 500 50 ...
##  $ average            : num  -0.14868 -0.00167 0.08444 0.02137 0.00306 ...
##  - attr(*, "sorted")= chr  "subject" "activity" "domainFeature" "accelerationFeature" ...
##  - attr(*, ".internal.selfref")=<externalptr>

Key variables
-------------

## [1] "subject"             "activity"            "domainFeature"      
## [4] "accelerationFeature" "instrumentsFeature"  "jerkFeature"        
## [7] "magnitudeFeature"    "variableFeature"     "axisFeature"


Few dataset rows
----------------

##        subject         activity domainFeature accelerationFeature
##     1:       1           LAYING            NA                  NA
##     2:       1           LAYING            NA                  NA
##     3:       1           LAYING            NA                  NA
##     4:       1           LAYING            NA                Body
##     5:       1           LAYING            NA                Body
##    ---                                                           
## 20156:      30 WALKING_UPSTAIRS     Frequency                Body
## 20157:      30 WALKING_UPSTAIRS     Frequency                Body
## 20158:      30 WALKING_UPSTAIRS     Frequency                Body
## 20159:      30 WALKING_UPSTAIRS     Frequency                Body
## 20160:      30 WALKING_UPSTAIRS     Frequency                Body
##        instrumentsFeature jerkFeature magnitudeFeature    variableFeature
##     1:                 NA          NA               NA                 NA
##     2:          Gyroscope          NA               NA                 NA
##     3:          Gyroscope        Jerk               NA                 NA
##     4:      Accelerometer          NA               NA                 NA
##     5:      Accelerometer        Jerk               NA                 NA
##    ---                                                                   
## 20156:      Accelerometer        Jerk               NA Standard Deviation
## 20157:      Accelerometer        Jerk               NA Standard Deviation
## 20158:      Accelerometer        Jerk        Magnitude                 NA
## 20159:      Accelerometer        Jerk        Magnitude               Mean
## 20160:      Accelerometer        Jerk        Magnitude Standard Deviation
##        axisFeature count   average
##     1:          NA   150 -0.148684
##     2:          NA    50 -0.001667
##     3:          NA    50  0.084437
##     4:          NA    50  0.021366
##     5:          NA    50  0.003060
##    ---                            
## 20156:           Y    65 -0.610827
## 20157:           Z    65 -0.784754
## 20158:          NA   650 -0.563067
## 20159:          NA   130 -0.299131
## 20160:          NA    65 -0.580878
