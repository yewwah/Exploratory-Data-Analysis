              #### Plot 1 ####
              
## We install the packages that will be useful : data.table and dplyr, then we load them              
install.packages("data.table")
install.packages("dplyr")
library(dplyr)
library(data.table)

              
## We read the data using fread which is faster than read.table
fdata <- fread("household_power_consumption.txt", na.strings='?')

## We select the data we want, that is the correct dates              
fdata2 <- filter(fdata, Date=="1/2/2007" | Date=="2/2/2007")

## We coerce the variable Global_active_power into a numric one, in order to be able to make our histogram
fdata2$Global_active_power <- as.numeric(fdata2$Global_active_power)

              
## We plot our histogram, and we specify the name of the x axis and the Title
par(mfrow=c(1,1))
hist(fdata2$Global_active_power, col="red", xlab="Global Actvie Power (kilowatts)", main="Global Active Power")

              
## Saving the plot
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()