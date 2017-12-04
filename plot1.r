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

## Convert the date and time columsn.
dataset$Date <- as.Date(dataset$Date, '%d/%m/%Y')
dataset <- subset(dataset, Date >= '2007-02-01' & Date <= '2007-02-02')
dataset$Time <- as.POSIXct(paste(dataset$Date, dataset$Time), format='%Y-%m-%d %H:%M:%S')

## Create blank png file to write into
png(filename = "plot1.png", height=480, width=480)

## Create historgram
hist(as.numeric(dataset$Global_active_power), col = "red", xlab = "Global Active Power (kilowats)", main = "Global Active Power")

## done writing to png
dev.off()
