## This code plots a line graph of Global Active Power over time from 
## the household_power_consumption.txt dataset
## THe code assumes that the extracted dataset is in the working directory

## Use sqldf to only read the data from 1/2/2007 and 2/2/2007

library(lubridate)
library(dplyr)
library(sqldf)
house_power<-read.csv.sql("household_power_consumption.txt", 
                          sql="SELECT * from file WHERE Date in ('1/2/2007', '2/2/2007')", 
                          sep=";", header=TRUE)
##close connection
sqldf()
##create a combined date and time column and extact date and global_active_power
house_power<-tbl_dt(house_power)
house_power<-mutate(house_power, Long_date=dmy_hms(paste(Date, Time)))
global_active_power<-select(house_power, Long_date, Global_active_power)

##plot to png
png(filename="plot2.png", width=480, height=480)
with(global_active_power, 
     plot(Long_date, Global_active_power, 
          type="l", main="Plot 2", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()