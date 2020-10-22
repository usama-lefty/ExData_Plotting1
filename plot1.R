
if (!file.exists("Data/Electrical.zip")) {
  dir.create("Data/")
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "Data/Electrical.zip")
}
if (!file.exists("Data/Electrical")) {
  
  unzip(zipfile = "Data/Electrical.zip")
}

data <- read.table("household_power_consumption.txt",sep = ";",header  = TRUE)

data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

dataTime <-strptime(data$Time,format = "%H:%M:%S")

data$Time <- strftime(dataTime,format = "%H:%M:%S")

data2 <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

png("plot1.png", width=480, height=480)

hist(as.numeric(data2$Global_active_power),col = "red",xlab = "Global Active Power (kilowatts)",ylab = "Frequency",main = "Global Active Power")

dev.off()
