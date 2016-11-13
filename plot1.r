##################################################
# DATA PREP                                     ##
##################################################
  
#Set your working directory
setwd("~/Coursera/Exploratory Data Analysis/Week4")

#Load the following packages (should be installed in your library first):
library(plyr) 
library(ggplot2)

#Download the file from the given site, then save it to your working folder
#Unzip the file
zip0="exdata2Fdata2FNEI_data.zip"
unzip(zip0)

#You will then see two extracted .RDS files in your WD.

#National Emissions Inventory
nei <- readRDS("summarySCC_PM25.rds")
names(nei)

#Source Classification Code
#It provides the mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source
scc <- readRDS("Source_Classification_Code.rds")
names(scc)

####################################################################################################
#Q1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#   Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#   for each of the years 1999, 2002, 2005, and 2008.
####################################################################################################

#Divide by thousand, so there will be no so much numbers when we plot it.
nei$Emissions <- nei$Emissions/1000

#Get the total PM2.5 emissions from years 1999, 2002,2005, and 2008
plot1<-aggregate(Emissions~year,nei,sum)


#Create the plot where YEAR will be the X axis, and EMISSIONS will be the Y axis.
#The plot will be automatically saved as a .PNG file
png("plot1.png",width=480,height=480)
plot(plot1$year,plot1$Emissions, main="Total PM2.5 Emissions in US from 1999 to 2008",
     xlab="Year", ylab="Total PM2.5 Emissions (in thousands of tons)","b")
dev.off()

###############################################################################
#ANSWER: Yes, the total PM2.5 emissions in US have decreased from 1999 to 2008.
###############################################################################
