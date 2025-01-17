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
with(hpc2, plot(datetime, Global_active_power, type="l", xlab=NA, xaxt="n", ylab="Global Active Power (kilowatts)"))
##Plot not auto assigning days on x axis so add manually
with(hpc2, axis(1, at = c(datetime[1], datetime[1440], datetime[2880]), labels = c("Thu","Fri","Sat")))


##Send output to permanent png file
dev.copy(png, "plot2.png",
         width  = 480,
         height = 480)

##CLose of dev copy
dev.off()

