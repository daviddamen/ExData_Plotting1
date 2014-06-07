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

#
# Create plot:
#   Global Active Power over time
#
with(data, plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png") 
dev.off()
