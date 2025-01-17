#Options for running if not already in session
#getwd()
#library(dplyr)
#library(lubridate)
#Sys.setlocale("LC_ALL","English")

##Read in data for plot
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                  na.strings = "?", 
                  colClasses = c('character','character','numeric','numeric','numeric','numeric',
                                 'numeric','numeric','numeric'))

##Create new daten variable from original dates & filter for 1st/2nd Feb
hpc2<-mutate(hpc, daten=dmy(Date)) %>%
  filter(as.Date("2007-02-01")== daten | daten== as.Date("2007-02-02")) %>%
  mutate(datetime = as.POSIXct(strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")))

##Create plot with specified parameters
with(hpc2, {plot(datetime, Sub_metering_1, type="l", xlab=NA, xaxt="n", col="black", ylab="Energy sub metering")
      lines(datetime, Sub_metering_2, type="l", xlab=NA, xaxt="n", col="red", ylab="Energe sub metering")
      lines(datetime, Sub_metering_3, type="l", xlab=NA, xaxt="n", col="blue", ylab="Energe sub metering")
      ##Plot not auto assigning days on x axis so add manually 
      axis(1, at = c(datetime[1], datetime[1440], datetime[2880]), labels = c("Thu","Fri","Sat"))})

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), cex=0.8,
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Send output to permanent png file
dev.copy(png, "plot3.png",
         width  = 480,
         height = 480)

##CLose of dev copy
dev.off()