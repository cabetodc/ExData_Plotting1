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

## Making the plot: Plot 1
hist(data$Global_active_power, main = "Global Active Power", xlab= "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "Red")

## Saving to file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
