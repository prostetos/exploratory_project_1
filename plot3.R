library(plyr)
library(datasets)
Sys.setlocale("LC_TIME", "english")

# library("data.table", lib.loc="~/R/win-library/3.2")

# data<-fread("grep ^5/3/2007 household_power_consumption.txt")

first_data<-read.table(pipe('grep "^1/2/2007" "household_power_consumption.txt"'), header = TRUE, sep = ";")
second_data<-read.table(pipe('grep "^2/2/2007" "household_power_consumption.txt"'), header = TRUE, sep = ";")

# system.time(data <- read.table(pipe('grep "^1/2/2007" "household_power_consumption.txt"')))

colnames(first_data) <- c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
colnames(second_data) <- c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
names(first_data)
names(second_data)
clear_data<-merge(first_data,second_data, all=TRUE)

clear_data[[1]]<-as.Date(clear_data[[1]], "%d/%m/%Y")
clear_data[[2]]<-strptime(paste(clear_data[[1]], clear_data[[2]]), "%Y-%m-%d %H:%M:%S")

# plot 3

png(file = "plot3.png", width = 480, height = 480)
plot(clear_data$Time, clear_data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(clear_data$Time, clear_data$Sub_metering_2, type = "l", col = "red")
lines(clear_data$Time, clear_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()