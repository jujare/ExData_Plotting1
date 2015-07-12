library(sqldf)
meter.dataset <- read.csv.sql("exdata-data-household_power_consumption/household_power_consumption.txt", sql = "select * from file where Date in ('2/1/2007', '2/2/2007')", eol ="\n", sep=";", header=TRUE)
library(lubridate)
meter.dataset[, 1] <- dmy(meter.dataset[, 1])
meter.dataset[, 2] <- hms(meter.dataset[, 2])

# Plotting
par(mfrow=c(1,1))
hist(meter.dataset$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png")
dev.off()