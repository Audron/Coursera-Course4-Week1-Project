setwd("~/Coursera/Course4/week1/project/")

## Check if the data is downloaded.
if (!file.exists("household_power_consumption.txt")) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      temp <- tempfile()
      download.file(fileURL, temp, mode="wb")
      unzip(temp, "household_power_consumption.txt")
}
## Load the dataset into memory
dataset <- read.csv("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")

## Convert the date and time columsn.
dataset$Date <- as.Date(dataset$Date, '%d/%m/%Y')
dataset <- subset(dataset, Date >= '2007-02-01' & Date <= '2007-02-02')
dataset$Time <- as.POSIXct(paste(dataset$Date, dataset$Time), format='%Y-%m-%d %H:%M:%S')

## Create blank png file to write into.
png(filename = "plot4.png", height=480, width=480)

## Define the par layout
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# Combine the plots
with(dataset, {
      # Plot 1.
      plot(Time, Global_active_power, pch="", ylab="Global Active Power (kilowats)", xlab="")
      lines(Time, Global_active_power)
      
      #plot 2.
      plot(y=Voltage, x=Time, pch="", ylab="Voltage", xlab="datetime")
      lines(y=Voltage, x=Time)
      
      #Plot 3.
      plot(y=Sub_metering_1, x=Time, pch="", ylab="Global Active Power (kilowatts)", xlab="")
      lines(Time, Sub_metering_1)
      lines(Sub_metering_2~Time,col='Red')
      lines(Sub_metering_3~Time,col='Blue')
      
      #Plot 4.
      plot(y=Global_reactive_power, x=Time, pch="", xlab="datetime")
      lines(y=Global_reactive_power, x=Time)
})


# Done writing to png
dev.off()
