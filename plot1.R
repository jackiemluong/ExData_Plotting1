
## Reading in the Table
one <- read.table("C:/Users/jacki/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
one$Date <- as.Date(one$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
one <- subset(one,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
one <- one[complete.cases(one),]

## Combine Date and Time column
dateTime <- paste(one$Date, one$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
one <- one[ ,!(names(one) %in% c("Date","Time"))]

## Add DateTime column
one <- cbind(dateTime, one)

## Format dateTime Column
one$dateTime <- as.POSIXct(dateTime)

## Plot 1
hist(one$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Saving the File
dev.copy(png,"plot1.png", width = 480, height = 480)
dev.off()
