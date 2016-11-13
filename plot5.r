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

#Divide by thousand, so there will be no so much numbers when we plot it.
nei$Emissions <- nei$Emissions/1000


#Source Classification Code
#It provides the mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source
scc <- readRDS("Source_Classification_Code.rds")
names(scc)

#############################################################################################
#Q5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#############################################################################################

#Get the observations for BALTIMORE CITY only(equivalent FIPS=24510)
Bal<-subset(nei,fips=="24510")

#Get the ONROAD obs from Bal dataset
Bal_onroad<-subset(Bal,type=="ON-ROAD")

plot5<-aggregate(Emissions~year,Bal_onroad,sum)


#Create the plot where YEAR will be the X axis, and EMISSIONS will be the Y axis.
#The plot will be automatically saved as a .PNG file
png("plot5.png",width=480,height=480)
ggplot(data=plot5,aes(x=year,y=Emissions))+geom_line()+geom_point()+
  xlab("Year")+ylab("Total PM2.5 Emissions (in thousands of tons)")+ggtitle("Total PM2.5 Emissions from Motor Vehicles in Baltimore City")
dev.off()      


########################################################################################################################
#ANSWER in Q5: Over the period of 1999 to 2008, PM2.5 Emissions from Motor Vehicles in Baltimore City have decreased.
########################################################################################################################
