library(sqldf)
meter.dataset <- read.csv.sql("exdata-data-household_power_consumption/household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", eol ="\n", sep=";", header=TRUE)
library(lubridate)
meter.dataset[, 1] <- dmy(meter.dataset[, 1])
meter.dataset[, 2] <- hms(meter.dataset[, 2])
meter.dataset <- cbind(meter.dataset, DateTime=paste(meter.dataset$Date, meter.dataset$Time))
meter.dataset <- cbind(meter.dataset, Weekday=wday(meter.dataset$DateTime, label=TRUE, abbr=TRUE))
meter.dataset$Weekday <- factor(meter.dataset$Weekday)

# Plotting
par(mfrow=c(1,1))
plot(meter.dataset$DateTime, meter.dataset$Sub_metering_1, type="n", ylab="Energy sub metering", xaxt="n")
lines(meter.dataset$DateTime, meter.dataset$Sub_metering_1, col="black", type="l")
lines(meter.dataset$DateTime, meter.dataset$Sub_metering_2, col="red", type="l")
lines(meter.dataset$DateTime, meter.dataset$Sub_metering_3, col="blue", type="l")
axis(1, at=meter.dataset$DateTime, labels=meter.dataset$Weekday)
legend("topright", lty=c(1,1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Copy my plot to a PNG file
dev.copy(png, file = "plot3.png")
dev.off()