#### Plot 3 ####

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

## The plot, controlling for legend, colors and y label
par(mfrow=c(1,1))
with(fdata2, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='orangered')
  lines(Sub_metering_3~Datetime,col='dodgerblue')
})
legend("topright", col=c("black", "orangered", "dodgerblue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Saving the plot
dev.copy(png, file="plot3.png", height=600, width=600)
dev.off()