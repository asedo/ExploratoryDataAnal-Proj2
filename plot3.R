install.packages("ggplot2")
library(ggplot2)
library(plyr)

rm(list = ls())
setwd("~/Coursera/Analytics/Exploratory Data Analysis/Project2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# You must address the following questions and tasks in your exploratory analysis. For each question/task you will 
# need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.
# 
# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting 
# system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# For tapply to work, Emmissions and year must have same length

# In this case, I think having the average emissions would be a more meaningful number
# However, Total gets interpreted as sum so I will do sum. However, I will still calculate the mean for the grins.
#em_yr_mean <-tapply(NEI$Emissions, NEI$year, mean)
#plot(names(em_yr_mean), em_yr_mean, type="l", xlab = "Year", ylab = "Average of Emmissions per year")

# Question 2 : Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Question 3 : Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these
# four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
# 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

length(NEI$Emissions)
length(NEI$year)
#Lets check out the years we have data for
#unique(NEI$year)

#These will be the labels

Baltimore_data<- subset(NEI,fips==24510)

#Balt_em_yr<- aggregate(Emissions ~ year, Baltimore_data ,sum)

png("plot3.png")
ggplot(data=Baltimore_data, aes(x=year, y=Emissions, fill=type)) + geom_bar(stat="identity", position="dodge") + 
  labs(x="Year", y=expression("Total PM2.5 Emissions")) + 
  labs(title=expression("Baltimore Emissions PM2.5 1999-2008 by Type"))

dev.off()

                                                                                        
# Question 4 : Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?



# Question 5 : How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Question 6 : Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
