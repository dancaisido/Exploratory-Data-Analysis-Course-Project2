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

################################################################################################################
#Q4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
################################################################################################################

#Merge the NEI data with the source code so we can get the corresponding PM2.5 source
src <- subset(scc,select = c("SCC", "Short.Name"))
nei_scc <- merge(nei, src, by.x="SCC",by.y="SCC",all=TRUE)

##############################################################################
#Since Im only working with a 32bit system, I'm getting an ERROR
#because merging data process cannot allocate required memory from my system
##############################################################################

##################
#ALTERNATIVE WAY #
##################

#Get the SCC's with corresponding ShortNames that are COAL-related
coal<-subset(src,grepl("Coal",src$Short.Name,fixed=TRUE))
#Create a List of SCC's that we need
coal0<-as.character(coal[,1])

#Get the NEI observations which have SCC's that are included in the list,i.e. COAL
nei_coal<-subset(nei,nei$SCC %in% coal0)

#Get the total Emissions per year
plot4<-aggregate(Emissions~year,nei_coal,sum)

#Create the plot where YEAR will be the X axis, and EMISSIONS will be the Y axis.
#The plot will be automatically saved as a .PNG file
png("plot4.png",width=480,height=480)
ggplot(data=plot4,aes(x=year,y=Emissions))+geom_line()+geom_point()+
  xlab("Year")+ylab("Total PM2.5 Emissions (in thousands of tons)")+ggtitle("Total PM2.5 Emissions from Coal Combustion-related sources in US")
dev.off()      

#################################################################################################################################
#ANSWER: Over the period of 1999 to 2008, the total PM2.5 emissions from Coal Combustion-related sources in US have decreased.
#################################################################################################################################
