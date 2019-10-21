# Initializing Global Environment

rm(list=ls())
#setwd('/home/cnemri/Documents/JHU Data Science/Exploratory_Data_Analysis/Week 1 Project/')

# Installing required packages

if (!'data.table' %in% installed.packages()[, 1]) install.packages('data.table')
library(data.table)

if (!'dplyr' %in% installed.packages()[, 1]) install.packages('dplyr')
library(dplyr)

if (!'lubridate' %in% installed.packages()[, 1]) install.packages('lubridate')
library(lubridate)

if (!'lubridate' %in% installed.packages()[, 1]) install.packages('lubridate')
library(lubridate)

# Loading dataset

if (!file.exists('./data')) dir.create('./data')

fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, './data/dataset.zip', method='curl')

unzip('./data/dataset.zip', exdir = './data')

readLines('./data/household_power_consumption.txt',n=2)
consumption <- fread(file = './data/household_power_consumption.txt', header = TRUE)

# Reshaping dataset

consumption$Date = dmy(consumption$Date)
consumption$Date_Time = ymd_hms(paste(consumption$Date, consumption$Time))
consumption$Global_active_power = as.numeric(consumption$Global_active_power)
consumption$Global_reactive_power = as.numeric(consumption$Global_reactive_power)
consumption$Voltage = as.numeric(consumption$Voltage)
consumption$Global_intensity = as.numeric(consumption$Global_intensity)
consumption$Sub_metering_1 = as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 = as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 = as.numeric(consumption$Sub_metering_3)

# Extracting February 2007 first two days dataset
Feb_2d_consumption = filter(consumption, month(Date) == 2 & day(Date) %in% c(1,2) & year(Date) == 2007)

# Plotting
par(mfrow = c(1,1))
hist(Feb_2d_consumption$Global_active_power,
     freq = T,
     col = 'red',
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)',
     ylab = 'Frequency')

dev.copy(png, file = 'plot1.png')
dev.off()

plot(Feb_2d_consumption$Date_Time,
     Feb_2d_consumption$Global_active_power,
     type = 'l',
     ylab = 'Global Active Power (kilowatts',
     xlab = '')

dev.copy(png, file = 'plot2.png')
dev.off()

plot(Feb_2d_consumption$Date_Time,
     Feb_2d_consumption$Sub_metering_1,
     col = 'black',
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering')

lines(Feb_2d_consumption$Date_Time,
      Feb_2d_consumption$Sub_metering_2,
      col = 'red')

lines(Feb_2d_consumption$Date_Time,
      Feb_2d_consumption$Sub_metering_3,
      col = 'blue')

legend('topright', legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       col=c("black", "red", "blue"), lty=rep(1,3))

dev.copy(png, file = 'plot3.png')
dev.off()

par(mfrow = c(2,2))

plot(Feb_2d_consumption$Date_Time,
     Feb_2d_consumption$Global_active_power,
     type = 'l',
     ylab = 'Global Active Power (kilowatts',
     xlab = '')

plot(Feb_2d_consumption$Date_Time,
     Feb_2d_consumption$Voltage,
     type = 'l',
     ylab = 'Voltage',
     xlab = '')

plot(Feb_2d_consumption$Date_Time,
     Feb_2d_consumption$Sub_metering_1,
     col = 'black',
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering')

lines(Feb_2d_consumption$Date_Time,
      Feb_2d_consumption$Sub_metering_2,
      col = 'red')

lines(Feb_2d_consumption$Date_Time,
      Feb_2d_consumption$Sub_metering_3,
      col = 'blue')

legend('topright', legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       col=c("black", "red", "blue"), lty=rep(1,3))

plot(Feb_2d_consumption$Date_Time,
     Feb_2d_consumption$Global_reactive_power,
     type = 'l',
     ylab = 'Global_Reactive_Power',
     xlab = '')

dev.copy(png, file = 'plot4.png')
dev.off()