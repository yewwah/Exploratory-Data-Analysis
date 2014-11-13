#### Plot 2 ####

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

## We Plot (note that days are in French, as I am French and Rstudio is therefore installed this way)
## We make sure we use lines and correctly label the y axis
par(mfrow=c(1,1))
plot(fdata2$Global_active_power ~ fdata2$Datetime, type="l",   ylab="Global Active Power (kilowatts)", xlab="")

## Saving the plot
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
