#Exploratorive Data Analysis Week1 Assignment
library(dplyr)
library(lubridate)

# Calculate size of Dataset
# memory required = no. of column * no. of rows * 8 bytes/numeric 

        memory = 9*2075259*8

        memory_mb = memory/1000000

#load dataset

        if (!file.exists("household_power_consumption.txt")) {
                url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(url, "household_power_consumption.zip")
                unzip("household_power_consumption.zip")
                unlink("household_power_consumption.zip")
        }
        
        
        file<- read.csv("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")
        

#change entries into better R structures
        
        colnames <- names(file)
       
        #extract data for 2007-02-01 and 2007-02-02
        
        data <- mutate(file, Date = as.Date(Date, format = "%d/%m/%Y"), 
                       Time = as.POSIXct(strptime(paste(Date,Time), format = "%Y-%m-%d %T"))) 
                       
        data <- filter (data, Date >= "2007-02-01" & Date <= "2007-02-02")
        

#plot3: Submetering 1-3
        
        #make grid
        png(file="plot3.png")
        par(mfrow = c(1, 1))
        
        plot(data$Time,data$Sub_metering_1, 
             type = "l", col="black", lwd="1",
             ylab = "Energy sub metering",
             xlab =""
        )
        
        lines(data$Time, data$Sub_metering_2,
             type= "l", col="red", lwd="1"
             )
        
        lines(data$Time, data$Sub_metering_3,
             type= "l", col="blue", lwd="1"
        )
        
        legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        #close png
        dev.off()
        