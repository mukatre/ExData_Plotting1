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


## Plot 2
png("plot2.png", width=10, height=8, units="in", res=300)## create a png file

## create a plot
with(data, 
     plot(DateTime, 
          Global_active_power,
          type="l", 
          xlab="", 
          ylab="Global Active Power (kilowatts)"))

dev.off()## close the file