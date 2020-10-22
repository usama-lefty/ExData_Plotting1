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

png("plot2.png", width=480, height=480)

plot(dates, as.numeric(data2$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()


