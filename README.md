# MechaCar Analysis

## Overview
- AutosRU's newest prototype, the MechaCar, is suffering from production troubles that are blocking the manufacturing team's progress. Management has set a task to review production data for insights that may help the manufacturing team.

### Tasks
  - Performed multiple linear regression analysis to identify which variables in the dataset predict the mpg of MechaCar prototypes.
  - Collected summary statistics on the pounds per square inch of the suspension coils from the manufacturing lots.
  - Ran t-tests to determine if the manufacturing lots are statistically different from the mean population.
  - Designed a statistical study to compare vehicle performance of the MechaCar vehicles against vehicles from other manufacturers. Included summary interpretation of findings for each statistical analysis.


## Linear Regression to Predict MPG

![Inkedlinear-regression-and-summary_LI](https://user-images.githubusercontent.com/78178900/122695958-7be2d780-d207-11eb-9d1e-f14d5d7eec65.jpg)

- Which variables/coefficients provided a non-random amount of variance to the mpg values in the dataset?
  - According to the results of the summary statistics the Intercept, vehicle_length, and ground_clearance are statistically unlikely to provide random amounts of variance in to the linear model so, they provided a non-random amount of variance. Their p-values are less than the level of significance.

- Is the slope of the linear model considered to be zero? Why or why not?
  - No, it is not condisdered to be zero because the p-value is 5.35e-11. p-value is used to determine significance in the linear relationship between independent and dependent variable, since it is less than our significance level of 0.05 that idicates a significant linear relationship.

- Does this linear model predict mpg of MechaCar prototypes effectively? Why or why not?
  - Yes,the R-squared value of 0.7149 indicates it effectively predicts mpg of the MechaCar. Although, the level to which it is effective can be interpreted between moderate and substantial.


## Summary Statistics on Suspension Coils

![summary_dfs](https://user-images.githubusercontent.com/78178900/122706268-25809380-d21d-11eb-9fb1-5056b95eee3f.png)

- Design specifications for the suspension coils dictate the variance of them must not exceed 100 PSI. Does the current manufacturing data meet this design specification for all manufacturing lots in total and each lot individually? Why or why not?
  - The current manufacturing data meets the design specification of being less than 100 for all manufacturing lots because the total variance for all three lots is 62.29356.
  - The current manufacturing data does NOT meet the design specification for being less than 100 for each lot individually because the lot 3 variance is 170.
