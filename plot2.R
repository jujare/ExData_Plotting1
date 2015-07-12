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
plot(meter.dataset$Global_active_power, type="l", xaxt="n", ylab="Global Active Power (Kilowatts)")
axis(1, at=meter.dataset$DateTime, labels=meter.dataset$Weekday)

## Copy my plot to a PNG file
dev.copy(png, file = "plot2.png")
dev.off()