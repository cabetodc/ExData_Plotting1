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

## Making the plot: Plot 3
Sys.setlocale("LC_TIME", "English")
#windows.options(width = 6, height = 6); windows()
with(data, {
        plot(datetime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
        lines(datetime, Sub_metering_2,col='Red')
        lines(datetime, Sub_metering_3,col='Blue')
})
legend("topright", col = c("black", "red", "blue"),  lty = 1, cex = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
