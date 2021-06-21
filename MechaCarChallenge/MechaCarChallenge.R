#import libraries
library(tidyverse)

#DELIVERABLE 1
#read the MechaCar_mpg.csv file
MechaMpg <- read.csv("MechaCar_mpg.csv")
head(MechaMpg)
?lm()

#independent variables
# vehicle_length, vehicle_weight, spoiler_angle, ground_clearance, AWD
#dependent variables
# mpg

#creates the linear regression model
reg_mod <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, MechaMpg)

#creates summary statistics
summary(reg_mod)

#calculates each R-value
cor(MechaMpg$mpg, MechaMpg$vehicle_length)
cor(MechaMpg$mpg, MechaMpg$vehicle_weight)
cor(MechaMpg$mpg, MechaMpg$spoiler_angle)
cor(MechaMpg$mpg, MechaMpg$ground_clearance)
cor(MechaMpg$mpg, MechaMpg$AWD)

#DELIVERABLE 2
#read the Suspension_Coil.csv file
coils <- read.csv("Suspension_Coil.csv")
head(coils)

#create total summary dataframe using summarize() of the PSI column.
psi_summary <- coils %>% summarize(Mean_psi = mean(PSI), Median_psi = median(PSI), Variance = var(PSI), Std.Dev. = sd(PSI), .groups = 'keep')
psi_summary

#create a lot_summary df using group_by() and summarize() to group each lot by mean, med., var., and std.dev. of PSI column
lot_summary <- coils %>% group_by(Manufacturing_Lot) %>% summarize(Mean_psi = mean(PSI), Median_psi = median(PSI), Variance = var(PSI), Std.Dev. = sd(PSI), .groups = 'keep')
lot_summary
