demo_table <- read.csv(file='demo.csv', check.names=F,stringsAsFactors = F)

library(jsonlite)

demo_table2 <- fromJSON(txt='demo.json')

#filter table by price above 10000 
filter_table <- demo_table2[demo_table2$price > 10000,]

#filter by price and drive train. This method is cleaner than using brackets
filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status)
#what it looks like to use brackets for the same code
#filter_table3 <- demo_table2[("clean" %in% demo_table2$title_status) & (demo_table2$price > 10000) & (demo_table2$drive == "4wd"),]



#capture the number of rows in demo_table in a variable.
num_rows <- 1:nrow(demo_table)

#sample 3 of those rows, as shown in this code:
sample_rows <- sample(num_rows, 3)

#retrieve requested data within the demo_table:
demo_table[sample_rows,]

# COMBINE all three previous steps into one line of code:
demo_table[sample(1:nrow(demo_table), 3),]

#import tidyverse so we can use ggplot2
library(tidyverse)

# 15.2.5
#Add columns to original data frame
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2021-Year),IsActive=TRUE)

#group data by the condition of vehicle and determine avg mileage per condition
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n(), .groups = 'keep')

# load the demo2.csv file into R environment and look at top of df
demo_table3 <- read.csv('demo2.csv', check.names = F, stringsAsFactors = F)
# now change the data set to long format using gather()
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)
# spread out the long-format data frame back to its original format using spread()
wide_table <- long_table %>% spread(key="Metric",value="Score")

# compare original table to this new one and make sure they're the same:
all.equal(demo_table3,wide_table)
#the columns are not in the same order, rearrange them so they are in the same order in each df
#NOTE the comma in these brackets indicates that we are selecting all rows
#NOTE the table being inside of the colnames() function is the table being matched. 
#Here, wide_table columns will be moved around to match demo_table3
table <- wide_table[,(colnames(demo_table3))]
#now compare the 'table' df we just created to the original demo_table3
all.equal(table,demo_table3)

#create a barplot that represents the distribution of vehicle classes from the mpg data set
plt <- ggplot(mpg,aes(x=class)) #import dataset into ggplot2
plt + geom_bar() #plot a bar plot

#15.3.3
#compare the number of vehicles form each manufacturer in the dataset using summarize() to summarize data
#and ggplot2's geom_col() to visualize it
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count)) #import dataset into ggplot2
plt + geom_col() #plot a bar plot
#change the labels of the plot to describe the data being displayed
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + #plot bar plot with labels
theme(axis.text.x=element_text(angle = 45, hjust=1)) #rotate the x-axis 45 degrees

#15.3.4
#compare differences in avg highway fuel economy of Toyota vehicles as a function of the different cylinder sizes
#create summary table
mpg_summary <- subset(mpg,manufacturer=="toyota") %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep')
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy)) #import dataset into ggplot2
#setup line plot
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30))

#scatter plot: visualize relationship between size of each car engine vs their city fuel efficiency
plt <- ggplot(mpg,aes(x=displ,y=cty, color=class, shape=drv, size=cty)) #import dataset into ggplot2 
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class", shape="Type of Drive", size="City Fuel_Efficiency (MPG)") #add scatter plot with labels


#15.3.5
#generate a boxplot to visualize the highway fuel efficiency of our mpg dataset
plt <- ggplot(mpg,aes(y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() #add boxplot

#create a set of boxplots that compares highway fuel efficiency for each car manufacturer
### NOTE: if you are only naming x and y values inside of aes() then you do not need to put x= and y= as it 
### NOTE: follows the standard (x, y) format
plt <- ggplot(mpg, aes(manufacturer, hwy)) #import dataset into ggplot2 
plt + geom_boxplot(fill = "gray", colour = "#3366FF", outlier.colour = "red") + theme(axis.text.x = element_text(angle=45, hjust=1)) #add boxplot and rotate x-axis labels 45 degrees


#15.3.6
#visualize avg highway fuel efficiency across type of vehicle class from 1999-2008
mpg_summary <- mpg %>% group_by(class,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=class,y=factor(year), fill = Mean_Hwy))
plt + geom_tile() + labs(x= "Vehicle Class", y= "Vehicle Year", fill= "Mean Highway (MPG)") #create heatmap with labels

#difference in avg highway fuel efficiency across each vehicle model from 1999 to 2008
mpg_summary <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x= model, y= factor(year), fill= Mean_Hwy)) # import dataset into ggplot2
#add heatmap with labels and rotate xaxis labels 90 degrees
plt + geom_tile() + labs(x= "Model", y= "Vehicle Year", fill= "Mean Highway (MPG)") + theme(axis.text.x = element_text(angle= 90, hjust= 1, vjust= .5))


#15.3.7 
#recreate our previouse boxplot example comparing the highway fuel efficiency across manufacturers, add data points using geom_point()
plt <- ggplot(mpg, aes(manufacturer, hwy))
plt + geom_boxplot() + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + geom_point()

#what if we want to compare avg engine size for each class? supply our new data and variables directly to our geom function
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine = mean(displ), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(class, Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size = 4) + labs(x = "Vehicle Class", y = "Mean Engince Size") #add scatter plot

#add standard deviation: compute sd's in dplyr summarize() so we can layer upper and lower sd boundaries to our viz using geom_errorbar()
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine = mean(displ), SD_Engine = sd(displ), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(class, Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size = 4) + labs(x = "Vehicle Class", y = "Mean Engince Size") + #add scatter plot
geom_errorbar(aes(ymin = Mean_Engine - SD_Engine, ymax = Mean_Engine + SD_Engine)) #overlay with errorbars


#Faceting: consider, if instead of the wide format, out mpg dataset was obtained where city and highway fuel 
#efficiency data was provided in long format:
mpg_long <- mpg %>% gather(key = "MPG_Type", value = "Rating", c(cty,hwy)) # convert to long format
head(mpg_long)

#visualize the different vehicle fuel efficiency ratings by manufacturer
plt <- ggplot(mpg_long, aes(manufacturer, Rating, color = MPG_Type)) #import datset into ggplot2
plt + geom_boxplot() + theme(axis.text.x = element_text(angle = 45, hjust = 1)) #add boxplot with labels rotated 45 degrees

?facet_wrap()
?ggplot()

#facet our previous example by the fuel-efficiency type
plt <- ggplot(mpg_long, aes(manufacturer, Rating, color = MPG_Type))
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none") + xlab("Manufacturer")

#SKILL DRILL 15.3.7 create two additional plots using different variables for facet_wrap()
plt <- ggplot(mpg_long, aes(manufacturer, Rating, color = cyl))
plt + geom_boxplot() + facet_wrap(vars(cyl,drv)) + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5), legend.position = "none") + xlab("Manufacturer")

#15.4.1
#this section of the module contains a statistical test lookup table
#section 15 goes over different datatypes and shapes of data

#15.4.4
# test the distribution of vehicle weights from the built-in mtcars dataset
ggplot(mtcars, aes(x= wt)) + geom_density() #visualize distribution using density pot

?shapiro.test()
#to find if your sample data came from a normally distributed dataset, use a test for normality. 
#R has a built-in stats library to perform this type of quantitative test: shapiro.test()
shapiro.test(mtcars$wt)


#15.6.1
#visualize the distribution of driven miles for our entire population dataset using the used_vehicle_data
population_table <- read.csv("used_car_data.csv", check.names = F, stringsAsFactors = F) #import used car dataset
plt = ggplot(population_table, aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#now create a sample dataset using sample_n()
sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table, aes(x=log10(Miles_Driven)))#import dataset into ggplot2
plt + geom_density()#visualize distribution using density plot


#15.6.2 one-sample t-test
?t.test()
#test if miles driven from the sample dataset is statistically different from miles driven in population_table
t.test(log10(sample_table$Miles_Driven), mu = mean(log10(population_table$Miles_Driven))) #compare sample vs population means


#15.6.3 two-sample t-test
#test whether mean miles driven of two samples from used car datatset are statistically different.
#create two samples first
sample_table <- population_table %>% sample_n(50)
sample_table2 <- population_table %>% sample_n(50)
#test the two samples for potential statistical differences
t.test(log10(sample_table$Miles_Driven), log10(sample_table2$Miles_Driven)) #compares means of two samples


#15.6.4 two-sample t-test to compare samples
#use the modified version of R's built-in mpg dataset, where each 1999 vehicle was paired with a corresponding 2008 vehicle
mpg_data <- read.csv("mpg_modified.csv", check.names = F, stringsAsFactors = F)
mpg_1999 <- mpg_data %>% filter(year==1999) #select only 1999 data points
mpg_2008 <- mpg_data %>% filter(year==2008) #select only 2008 data points
#paired t-test to determine if there is a statistical difference in overall highway fuel efficiency of
#vehicles manufactured in 1999 vs 2008
t.test(mpg_1999$hwy, mpg_2008$hwy, paired = T)


#15.6.5 ANOVA tests
?aov()

#refer back to mtcars dataset to determine if there is a statistical difference in horsepower based on the size of engine
#hp is dependent variable. cyl is independent: however, cyl column is numerical interval vector. clean data so its categorical
mtcars_filt <- mtcars[, c("hp", "cyl")] #filters columns from mtcars
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #converts numeric column to factor
#use clean data in aov() function
aov(hp ~ cyl, data = mtcars_filt) #compare means across multiple levels
#wrap aov() function in summary() function to get p-value
summary(aov(hp ~ cyl, data = mtcars_filt))


#15.7.1 Correlation conundrum
?cor()
#practice using cor()
head(mtcars)
#test whether or not hp is correlated with qsec(quarter-mile race time)
plt <- ggplot(mtcars, aes(x = hp, y = qsec))
plt + geom_point()
#quantify strength of correlation between the two variables
cor(mtcars$hp, mtcars$qsec) #calculates correlation coefficient

#another example with used_cars dataset
used_cars <- read.csv("used_car_data.csv", check.names = F, stringsAsFactors = F)
head(used_cars)
#test wheter or not vehicle miles driven and selling price are correlated.
plt <- ggplot(used_cars, aes(Miles_Driven, Selling_Price))
plt + geom_point()
#test correlation strength
cor(used_cars$Miles_Driven, used_cars$Selling_Price)

#produce a correlation matrix for used_cars dataset. first, select numeric columns from df and convert to a matrix
used_matrix <- as.matrix(used_cars[, c("Selling_Price", "Present_Price", "Miles_Driven")]) #converts df to numeric matrix
cor(used_matrix)


#15.7.2
?lm()
#create a linear regresssion model
lm(qsec ~ hp, mtcars)
#determine p-value and r-squared value
summary(lm(qsec ~ hp, mtcars))
#calculate the data points to use for our line plot
model <- lm(qsec ~ hp, mtcars)
yvals <- model$coefficients['hp']*mtcars$hp + model$coefficients['(Intercept)'] #determines y-axis values from linear model
#plot linear model over scatter plot
plt <- ggplot(mtcars, aes(hp, qsec))
plt + geom_point() + geom_line(aes(y=yvals), color = "red") #plots scatter and linear model
