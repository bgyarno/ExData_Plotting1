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

##Print Histogram to png file
png(filename = "plot1.png")
hist(data$Global_active_power, col = "red", xlab = " Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()