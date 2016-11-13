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

###################################################################################################################
#Q2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#   Use the base plotting system to make a plot answering this question.
###################################################################################################################


#Get the observations for BALTIMORE CITY only(equivalent FIPS=24510)
Bal<-subset(nei,fips=="24510")


#Get the total PM2.5 emissions per year
plot2<-aggregate(Emissions~year,Bal,sum)

#Create the plot where YEAR will be the X axis, and EMISSIONS will be the Y axis.
#The plot will be automatically saved as a .PNG file
png("plot2.png",width=480,height=480)
plot(plot2$year,plot2$Emissions, main="Total PM2.5 Emissions in Baltimore City from 1999 to 2008",
     xlab="Year", ylab="Total PM2.5 Emissions (in thousands of tons)","b")
dev.off()

###########################################################################################
#ANSWER: Yes, the total PM2.5 emissions in Baltimore City have decreased from 1999 to 2008.
###########################################################################################
