#### Plot 4 ####
setwd("C:/Users/Antoine/Documents/GitHub/ExData_Plotting1")
## We install the packages that will be useful : data.table, lubridate and dplyr, then we load them              
install.packages("data.table")
install.packages("dplyr")
install.packages("lubridate")
install.packages("lattice")
library(dplyr)
library(data.table)
library(lubridate)
library(lattice)

## We read the data using fread which is faster than read.table
fdata <- fread("household_power_consumption.txt", na.strings='?')

## We select the data we want, that is the correct dates              
fdata2 <- filter(fdata, Date=="1/2/2007" | Date=="2/2/2007")

## We coerce the variables in the format we want : numeric for active power, and posict for the date
fdata2$Global_active_power <- as.numeric(fdata2$Global_active_power)

fdata2$Datetime <- as.POSIXct(paste(as.Date(fdata2$Date, format="%d/%m/%Y"), fdata2$Time))

## The plot, using the par command to place the different graphs
par(mfrow=c(2,2), oma=c(0,0,2,0) ) #The oma and omd command changes margin, so that the scales appear the same than the given plots
with(fdata2, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='orangered')
  lines(Sub_metering_3~Datetime,col='dodgerblue')
  legend("topright", col=c("black", "orangered", "dodgerblue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

## Saving the plot
dev.copy(png, file="plot4.png", height=700, width=700)
dev.off()