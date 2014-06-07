#
# Read input file.
# We are only interested in data from the dates 2007-02-01 and 2007-02-02, hence data outside
# this range is skipped.
#
columns <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
data <- read.csv2("household_power_consumption.txt", skip=66636, nrow=2880, col.names=columns, stringsAsFactors=FALSE)

#
# Preprocess data to get in the right formats
#
data$Timestamp <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

data$Global_active_power <- as.double(data$Global_active_power)
data$Global_reactive_power <- as.double(data$Global_reactive_power)
data$Voltage <- as.double(data$Voltage)
data$Sub_metering_1 <- as.double(data$Sub_metering_1)
data$Sub_metering_2 <- as.double(data$Sub_metering_2)
data$Sub_metering_3 <- as.double(data$Sub_metering_3)

#
# Create plot:
#   Fourway overview
#
png(filename="plot4.png", width=500, height=500, pointsize=12)

par(mfcol=c(2, 2))

with(data, plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

with(data, plot(Timestamp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, lines(Timestamp, Sub_metering_2, col="red"))
with(data, lines(Timestamp, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")

with(data, plot(Timestamp, Voltage, type="l", xlab="datetime", ylab="Voltage"))

with(data, plot(Timestamp, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()
