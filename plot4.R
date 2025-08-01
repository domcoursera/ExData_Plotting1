## read and clean data
data <- data.table::fread(input = "household_power_consumption.txt",
                          na.strings="?")

data[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-02")]

png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

## plot 1
plot(data[,dateTime], data[, Global_active_power], type = "l", xlab = "", ylab = "Global_active_power")

## plot 2
plot(data[, dateTime], data[, Voltage], type = "l", xlab = "datetime", ylab = "Voltage")

## plot 3
plot(x = data[,dateTime], y = data[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = data[, dateTime], y = data[, Sub_metering_2], col = "red")
lines(x = data[, dateTime], y = data[, Sub_metering_3], col = "blue")
legend("topright",
       col = c("black", "red", "blue"),
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), 
       lwd=c(1,1))

# Create plot 4
plot(data[, dateTime], data[, Global_reactive_power], type = "l", xlab = "datetime", ylab = "Voltage")

dev.off()