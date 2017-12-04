setwd("~/Coursera/Course4/week1/project/")

## Now download and load the file if it doesn't exist.
if (!file.exists("household_power_consumption.txt")) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      temp <- tempfile()
      download.file(fileURL, temp, mode="wb")
      unzip(temp, "household_power_consumption.txt")
}
## Load the dataset into memory
dataset <- read.csv("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
## Convert date and time columns
dataset$Date <- as.Date(dataset$Date, '%d/%m/%Y')
dataset <- subset(dataset, Date >= '2007-02-01' & Date <= '2007-02-02')
dataset$Time <- as.POSIXct(paste(dataset$Date, dataset$Time), format='%Y-%m-%d %H:%M:%S')

## Create blank png file to write into
png(filename = "plot2.png", height=480, width=480)

## Generate the plots
plot(dataset$Time,dataset$Global_active_power, pch="", ylab="Global Active Power (kilowats)", xlab="", yaxt = "n")

## Now, draw in the lines.
lines(dataset$Time,dataset$Global_active_power)

## data axis
axis(2, xlab=c(0, 6000, 4))

## done writing to png
dev.off()
