if (!file.exists("Data/Electrical.zip")) {
  dir.create("Data/")
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "Data/Electrical.zip")
}
if (!file.exists("Data/Electrical")) {
  
  unzip(zipfile = "Data/Electrical.zip")
}

data <- read.table("household_power_consumption.txt",sep = ";",header  = TRUE)
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

data2 <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

dates <- strptime(paste(data2$Date, data2$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 

png("plot4.png", width=480, height=480)

par(mfrow = c(2,2))

plot(dates, as.numeric(data2$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(dates, as.numeric(data2$Voltage), type="l", xlab="datetime", ylab="Voltage")

plot(dates, as.numeric(data2$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering")
lines(dates, as.numeric(data2$Sub_metering_2), type="l",col= "red")
lines(dates, as.numeric(data2$Sub_metering_3), type="l",col= "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"),lty = 1,lwd= 2)

plot(dates, as.numeric(data2$Global_reactive_power), type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
