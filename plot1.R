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
        
#plot1: Histogram Global active power 2007-02-01 and 2007-02-02
        
        #make grid
        par(mfrow = c(1, 1))
        
        hist(data$Global_active_power, main="Globale Active Power", 
             xlab = "Global Active Power (kilowatts)", 
             ylab = "Frequency",
             col= "red"
             )
        #write into png file
        dev.copy(png, file = "plot1.png")
        dev.off()
        