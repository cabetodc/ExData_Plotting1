library(dplyr)

## Download and unzip the data set
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/powerc.zip")){download.file(fileUrl, destfile = "./data/powerc.zip")}
unzip("./data/powerc.zip", exdir = "./data")

## Subsetting the data
list.files("./data")
data <- read.csv("./data/household_power_consumption.txt", sep = ";", na.strings = "?",
                   stringsAsFactors = FALSE)[c(66637:69516), ]

## Converting dates and reshaping data
data = mutate(data, datetime = paste(Date, Time, sep = " "))
data$datetime <- strptime(data$datetime, format="%d/%m/%Y %H:%M:%S")
data = data %>% select(Date, Time, datetime, Global_active_power, Global_reactive_power, 
                       Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3)

## Making the plot: Plot 4
Sys.setlocale("LC_TIME", "English")
#windows.options(width = 6, height = 6); windows()
par(mfrow = c(2, 2), mar = c(4, 4, 4, 1), oma = c(0, 0, 2, 0))
with(data, {
        plot(datetime, Global_active_power, type = "l", xlab = "", 
             ylab = "Global Active Power")
        plot(datetime, Voltage, type = "l", 
             ylab = "Voltage", xlab = "datetime")
        plot(datetime, Sub_metering_1, type = "l", xlab = "", 
             ylab = "Energy sub metering")
        lines(datetime, Sub_metering_2,col = 'Red')
        lines(datetime, Sub_metering_3,col = 'Blue')
        legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(datetime, Global_reactive_power, type = "l",xlab = "datetime", 
             ylab = "Global Rective Power")
})

## Saving to file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
