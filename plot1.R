#Options for running if not already in session
#getwd()
#library(dplyr)
#library(lubridate)

##Read in data for plot
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                  na.strings = "?", 
                  colClasses = c('character','character','numeric','numeric','numeric','numeric',
                                 'numeric','numeric','numeric'))

##Create new daten variable from original dates & filter for 1st/2nd Feb
hpc2<-mutate(hpc, daten=dmy(Date)) %>%
      filter(as.Date("2007-02-01")== daten | daten== as.Date("2007-02-02"))

##Create plot with specified parameters
hist(hpc2$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency")

##Send output to permanent png file
dev.copy(png, "plot1.png",
         width  = 480,
         height = 480)

##CLose of dev copy
dev.off()

