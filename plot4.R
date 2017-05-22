##Assignment 1
data <- read.csv('household_power_consumption.txt', sep = ";", header = TRUE, stringsAsFactors = FALSE)

##Convert Date string to POSIXlt
data$Date <- strptime(data$Date, "%e/%m/%Y")

##subset data for 2007-02-01 and 2007-02-02
data <- subset(data, data$Date == strptime("2007-02-01", "%Y-%m-%d") | data$Date == strptime("2007-02-02", "%Y-%m-%d"))

## create new field combining date and time
data$Date_Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

##convert remaining fields to numeric
data[,3:8] <- apply(data[3:8], 2, as.numeric)

## print plot to png
png(filename = "plot4.png")
par(mfrow = c(2,2))
par(cex.lab = .9)
plot(data$Global_active_power ~ as.POSIXct(data$Date_Time), type = "l", ylab = "Global Active Power", xlab = "")
plot(data$Voltage ~ as.POSIXct(data$Date_Time), type = "l", ylab = "Voltage", xlab = "datetime")
plot(as.POSIXct(data$Date_Time),data$Sub_metering_1, type = "l", col = "black",ylab = "Energy sub metering", xlab = "")
lines(as.POSIXct(data$Date_Time), data$Sub_metering_2, col = "red")
lines(as.POSIXct(data$Date_Time), data$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, bty = "n")
plot(data$Global_reactive_power ~ as.POSIXct(data$Date_Time), type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()