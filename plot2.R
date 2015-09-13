setwd('~/R Studio Working Directory/Exploratory_Data_Analysis_1')

if (!file.exists('data')) {
  dir.create('data')
}

library(data.table)
library(lubridate)

# check to see if the existing tidy data set exists; if not, make it...
if (!file.exists('data/power_consumption.txt')) {
  
  # download and unzip
  file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(file.url, destfile='data/power_consumption.zip')
  unzip('data/power_consumption.zip', exdir='data',overwrite=TRUE)
  
  # read in data from 2007-02-01 and 2007-02-02
  x.class<-c(rep('character',2), rep('numeric',7))
  power.consumption<-read.table('data/household_power_consumption.txt',
                                header=TRUE, sep=';',
                                na.strings='?',
                                colClasses=x.class)
  power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]
  
  # convert date/time fields
  columns<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity',
             'SubMetering1','SubMetering2','SubMetering3')
  colnames(power.consumption)<-columns
  power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
  power.consumption<-power.consumption[,c(10,3:9)]
  
  # write a clean data set to the directory
  write.table(power.consumption,file='data/power_consumption.txt',sep='|',row.names=FALSE)
  print("Data downloaded and tidied!")
  
} else { #use the data already created
  
  power.consumption<-read.table('data/power_consumption.txt',header=TRUE,sep='|')
  power.consumption$DateTime<-as.POSIXlt(power.consumption$DateTime)
}

# open device
png(filename='plot2.png',width=480,height=480,units='px')

# plot data
plot(power.consumption$DateTime,power.consumption$GlobalActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')

x<-dev.off()