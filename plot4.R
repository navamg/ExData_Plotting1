## This code plots a line graphs of Energy sub metering over time from 
## the household_power_consumption.txt dataset
## THe code assumes that the extracted dataset is in the working directory

## Use sqldf to only read the data from 1/2/2007 and 2/2/2007

library(lubridate)
library(dplyr)
library(sqldf)
house_power<-read.csv.sql("household_power_consumption.txt", 
                          sql="SELECT * from file WHERE Date in ('1/2/2007', '2/2/2007')", 
                          sep=";", header=TRUE)

##create a data table and create a date+time column
house_power<-tbl_dt(house_power)
house_power<-mutate(house_power, Long_date=dmy_hms(paste(Date, Time)))

##plot the four files
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(house_power, {
    plot(Long_date, Global_active_power, type="l", xlab="", ylab="Global Active Power")
    plot(Long_date, Voltage, type="l", xlab="datetime", ylab="Voltage")
    plot(Long_date, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(energy_sub_metering$Long_date, energy_sub_metering$Sub_metering_2, col="red")
        lines(energy_sub_metering$Long_date, energy_sub_metering$Sub_metering_3, col="blue")
        legend("topright", lty=1, col=c("black", "red", "blue"), 
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Long_date, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    
})
dev.off()

