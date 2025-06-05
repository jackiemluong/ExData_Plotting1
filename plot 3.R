## Reading in the Table
three <- read.table("C:/Users/jacki/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
three$Date <- as.Date(three$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
three <- subset(three, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
three <- three[complete.cases(three),]

## Combine Date and Time column
dateTime <- paste(three$Date, three$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
three <- three[ ,!(names(three) %in% c("Date","Time"))]

## Add DateTime column
three <- cbind(dateTime, three)

## Format dateTime Column
three$dateTime <- as.POSIXct(dateTime)

## Plot 3
with(three, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving Plot 3
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
