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

###################################################################################################################################################################
#Q6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#    Which city has seen greater changes over time in motor vehicle emissions?
###################################################################################################################################################################

#Get the observations for BALTIMORE CITY only(equivalent FIPS=24510)
Bal<-subset(nei,fips=="24510")
#Get the observations for LOS ANGELES only(equivalent FIPS=06037)
LA <- subset(nei,fips=="06037")

#Get the ONROAD obs from Bal dataset
Bal_onroad<-subset(Bal,type=="ON-ROAD")

#Get the ONROAD obs from la dataset
LA_onroad <- subset(LA,type=="ON-ROAD")


Bal_onroad$city = "Baltimore City, MD"
LA_onroad$city = "Los Angeles ,CA"

#combine Bal and LA datasets
comb<-rbind(Bal_onroad,LA_onroad)

#Get the total PM2.5 emissions per year per city
plot6<-aggregate(Emissions~year+city,comb,sum)

#Create a column/variable that will show the year-to-year change in emissions
plot6[2:8,"Change"]<-diff(plot6$Emissions)
#Set year 1999 as CHANGE=0, as this is our starting point.
plot6[c(1,5),4]=0

#Create the plot where YEAR will be the X axis, and Change_EMISSIONS will be the Y axis.
#The plot will be automatically saved as a .PNG file
png("plot6.png",width=480,height=480)
ggplot(data=plot6,aes(x=year,y=Change,group=city,color=city))+geom_line()+geom_point()+
  xlab("Year")+ylab("Change in PM2.5 Emissions (in thousands of tons)")+ggtitle("PM2.5 Emissions from Motor Vehicles: Baltimore City, MD vs. Los Angeles, CA")
dev.off()      


#########################################################################
#ANSWER in Q6: Los Angeles has higher overall change in PM2.5 emissions. 
#########################################################################