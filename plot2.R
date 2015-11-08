# make sure the plots folder exists
if (!file.exists('plots')) {
  dir.create('plots')
}

# load data
source('get_and_clean_data.R')

# open device
png(filename='plots/plot2.png',width=480,height=480,units='px')

# plot data
plot(power.consumption$DateTime,power.consumption$GlobalActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')

# close device
x<-dev.off()
