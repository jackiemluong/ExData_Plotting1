## Reading in the Table
two <- read.table("C:/Users/jacki/Downloads/exdata_data_household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
two$Date <- as.Date(two$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
two <- subset(two, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
two <- two[complete.cases(two),]

## Combine Date and Time column
dateTime <- paste(two$Date, two$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
two <- two[ ,!(names(two) %in% c("Date","Time"))]

## Add DateTime column
two <- cbind(dateTime, two)

## Format dateTime Column
two$dateTime <- as.POSIXct(dateTime)

## Plot 2
plot(two$Global_active_power~two$dateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")


## Saving Plot 2
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
