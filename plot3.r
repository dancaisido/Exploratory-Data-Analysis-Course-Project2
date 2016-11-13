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

######################################################################################################
#Q3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#   which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#   Which have seen increases in emissions from 1999-2008? 
#   Use the ggplot2 plotting system to make a plot answer this question.
######################################################################################################

#Get the observations for BALTIMORE CITY only(equivalent FIPS=24510)
Bal<-subset(nei,fips=="24510")

#Get the total emissions per type per year
plot3<-aggregate(Emissions~type+year,Bal,sum)

#Create the plot where YEAR will be the X axis, and EMISSIONS will be the Y axis.
#The plot will be automatically saved as a .PNG file
png("plot3.png",width=480,height=480)
ggplot(data=plot3,aes(x=year,y=Emissions,group=type,color=type))+geom_line()+geom_point()+
  xlab("Year")+ylab("Total PM2.5 Emissions (in thousands of tons)")+ggtitle("Total PM2.5 Emissions in Baltimore City per Source type per Year")
dev.off()

################################################################################################################################
#ANSWER: Over the period of 1999 to 2008, there's a decrease in PM2.5 emissions from NON-ROAD, ON-ROAD, and NON-POINT sources.
#        On the other hand, there's an increase in PM2.5 emissions from POINT source.
################################################################################################################################
