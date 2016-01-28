#install.packages("ggplot2")
#library(ggplot2)
#library(plyr)

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


# Question 5 : How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

#unique(NEI$year)
#unique(SCC$EI.Sector)


# Question 6 : Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
neiscc<-merge(NEI, SCC)

BaLAData <- subset(neiscc,grepl("24510|06037", fips))
VehBaLAData <- subset(BaLAData, grepl("Vehicle", EI.Sector))
sumBaLA<- aggregate(Emissions ~ fips * year, data = VehBaLAData, FUN = sum)
sumBaLA$county<- sub("06037", "Los Angeles", sumBaLA$fips)
sumBaLA$county<- sub("24510", "Baltimore", sumBaLA$county)
sumBaLA

png("plot6.png")


  qplot(year, Emissions, data=sumBaLA, geom="line", color=county) +
  ggtitle(expression("Motor Vehicle Emission Levels for LA and Baltimore from 1999 to 2008")) + 
  xlab("Year") + 
  ylab(expression("Emissions"))
dev.off()

#################################################################################
# Below is some graphing stuff that did not work but I want to get working later.
#################################################################################

#  scale_fill_discrete(name="City Emissions", breaks=c("ctrl", "trt1"), labels=c("Control", "Treatment 1") )
  #BaltimoreData <- subset(neiscc, grepl("24510", fips))
  #LAData <- subset(neiscc, grepl("06037", fips))
  #Calculate summary data for Baltimore
  #BaltVehData <- subset(BaltimoreData, grepl("Vehicle", EI.Sector))
  #SumBaltData <- tapply(BaltVehData$Emissions, BaltVehData$year, sum)
  #Calculate summary data for LA
  #LAVehData <- subset(LAData, grepl("Vehicle", EI.Sector))
  #SumLAData <- tapply(LAData$Emissions, LAData$year, sum)
# ggplot() +
#   geom_line(aes(x = names(SumBaltData), y = SumBaltData, group = 1), colour="red", linetype="solid", size=1.5) +
#   geom_point(aes(x = names(SumBaltData), y = SumBaltData, size=2.0 ) )+
#   geom_line(aes(x = names(SumLAData), y = SumLAData, group = 1), colour="blue", linetype="solid", size=1.5) +
#   geom_point(aes(x = names(SumLAData), y = SumLAData, size=2.0 ) )+
#   labs(x="Year", y=expression("Motor Vehicle Emissions")) + 
#   labs(title=expression("Motor Vehicle Emissions of LA and Baltimore from 1999 to 2008"))+
#   theme(legend.title = element_text(colour="chocolate", size=16, face="bold"))
# scale_color_discrete(name="This color is\ncalled chocolate!?")
