#Exploratorive Data Analysis Week1 Assignment
library(dplyr)

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
        
        
#plot4
        
        #make grid
        par(mfrow = c(2, 2))
        
        #plot top left: Global active power
        
        plot(data$Time,data$Global_active_power, 
             type = "l", col="black", lwd="1",
             ylab = "Globale Active Power (kilowatts)",
             xlab =""
        )
        
        #plot topright:Voltage
        
        plot(data$Time,data$Voltage, 
             type = "l", col="black", lwd="1",
             ylab = "Voltage",
             xlab ="datetime"
        )
        
        #plot bottom left: Sub metering
        
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
        
        legend("topright", lwd = 1, bty="n", 
               col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        #plot bottom right:Global reactive power
        
        plot(data$Time,data$Global_reactive_power, 
             type = "l", col="black", lwd="1",
             ylab = "GLobal_reactive_power",
             xlab ="datetime"
        )
        
        #write into png file
        dev.copy(png, file = "plot4.png")
        dev.off()