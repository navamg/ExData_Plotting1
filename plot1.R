## This code plots a histogram of Global Active Power from the household_power_consumption.txt
## dataset. THe code assumes that the extracted dataset is in the working directory

## Use sqldf to only read the data from 1/2/2007 and 2/2/2007
library(sqldf)
house_power<-read.csv.sql("household_power_consumption.txt", sql="SELECT * from file WHERE Date in ('1/2/2007', '2/2/2007')", sep=";", header=TRUE)

sqldf()
## Subset just the Global Active Power Data
global_active_power<-as.numeric(house_power$Global_active_power)


##create a png of rhe histogram of global active power
png(filename="plot1.png", width=480, height=480)
hist(global_active_power, col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowatts)", ylim=c(0,1200))
dev.off()