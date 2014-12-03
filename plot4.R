library(dplyr)

## read all data
filename <- file("household_power_consumption.txt","r")
## read only the lines for 1st and 2nd February 2007
data <- read.table(text = grep("^[1,2]/2/2007", readLines(filename), value=TRUE), 
                   header=TRUE, 
                   sep=";",
                   na.strings="?") ##identifies that ? represents NA
## need to give the data proper column names                   
colnames(data)<- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3" )


## Add DateTime column to combine Date and Time and coerce it to be of class POSIXIt and POSIXt
data <- mutate(data, DateTime = paste(Date, Time)) ## uses dplyr
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

## Plot 4
png("plot4.png", width=10, height=8, units="in", res=300)## create a png file

## create a plot

par(mfrow = c(2,2)) ## plot area with 2 rows, 2 columns

## 1st Plot
with(data, 
     plot(DateTime, 
          Global_active_power,
          type="l", 
          xlab="", 
          ylab="Global Active Power (kilowatts)"))

## 2nd Plot
with(data, 
     plot(DateTime, 
          Voltage,
          type="l", 
          xlab="", 
          ylab="Voltage"))

## 3rd Plot
with(data, 
     plot(DateTime, 
          Sub_metering_1,
          type="l", 
          xlab="", 
          ylab="Energy Sub Metering",
          col = "black")) ## create a line plot for sub metering 1
points(data$DateTime,data$Sub_metering_2, type = "l", col = "red") ## add sub metering 2 to existing plot
points(data$DateTime,data$Sub_metering_3, type = "l", col = "blue") ## add sub metering 3 to existing plot
## add legend to existing plot
legend("topright", lty = 1, 
       col = c("black","red","blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## 4th Plot
with(data, 
     plot(DateTime, 
          Global_reactive_power,
          type="l", 
          xlab="", 
          ylab="Global Rective Power"))

dev.off()## close the file
