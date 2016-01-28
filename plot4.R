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
                                                                                        
# Question 4 : Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
#Lets check out the years we have data for
unique(NEI$year)
unique(SCC$EI.Sector)
neiscc<-merge(NEI, SCC)

coalSectors <- unique(grep("Coal$", neiscc$EI.Sector, value = TRUE, ignore.case = TRUE))

coalData <-  subset(neiscc, grepl("Coal", EI.Sector))
CombCoalD<- subset(coalData,grepl("Comb|Coal", Short.Name) ) 

totalEmByYr <- tapply(CombCoalD$Emissions,CombCoalD$year, sum)

png("plot4.png")

ggplot() +
  geom_line(aes(x = names(totalEmByYr), y = log10(totalEmByYr), group = 1), colour="red", linetype="solid", size=1.5) +
  geom_point(aes(x = names(totalEmByYr), y = log10(totalEmByYr), size=2.0 ) )+
  labs(x="Year", y=expression("Coal Source Emissions")) + 
  labs(title=expression("US Coal Combustion emissions from 1999 to 2008"))

dev.off()




# Question 5 : How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Question 6 : Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
