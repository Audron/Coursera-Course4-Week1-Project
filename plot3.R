setwd("~/Coursera/Course4/week1/project/")

## Download and load the file if it doesn't exist.
if (!file.exists("household_power_consumption.txt")) {
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      temp <- tempfile()
      download.file(fileURL, temp, mode="wb")
      unzip(temp, "household_power_consumption.txt")
}
## Load the dataset into memory
dataset <- read.csv("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")

## Now convert the date field, subset, and then convert the time field.
dataset$Date <- as.Date(dataset$Date, '%d/%m/%Y')
dataset <- subset(dataset, Date >= '2007-02-01' & Date <= '2007-02-02')
dataset$Time <- as.POSIXct(paste(dataset$Date, dataset$Time), format='%Y-%m-%d %H:%M:%S')

## Create blank png file to write into
png(filename = "plot3.png", height=480, width=480)

with(dataset, {
            plot(y=Sub_metering_1, x=Time, pch="", ylab="Global Active Power (kilowatts)", xlab="", yaxt = "n")
            lines(Time, Sub_metering_1)
            lines(Sub_metering_2~Time,col='Red')
            lines(Sub_metering_3~Time,col='Blue')
      })

## Create legends
legend("topright", col=c("black", "red", "blue"), lty=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Change axis
axis(2, at = c(0,10,20,30))

# Done writing to png
dev.off()
