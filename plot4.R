## R code for plot 4
## R environment - installing and loading for fread()
## install.packages("data.table")   ## If not installed
## library(data.table)

## Read a subset of the in-file
## Calculating no of observations performed under two days if one per minute
rowsToRead <- as.numeric( difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"), units="mins") )

## Read the subset of the infile - NA=? and empty
DT <- fread("household_power_consumption.txt",skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))       
setnames(DT, colnames(fread("household_power_consumption.txt", nrows = 0)))   ## Set the headers

## DataTime = typecased from the dates and time
DateTime <- as.POSIXct(paste(as.character(DT$Date),as.character(DT$Time)), format="%d/%m/%Y %H:%M:%S")
DT$DateTime <- DateTime

## prints out the histogram to a png-file
## open/create png-file with size 480*480
png(file = "plot4.png", width = 480, height = 480)

## defining 2 by 2 plot area
par(mfrow = c(2, 2) )

## Plot 1 (1,1)
## Adding annotations
y_title <- "Global Active Power"
## draw the plot
plot(DT$DateTime, DT$Global_active_power, type="l", xlab=" ", ylab=y_title)

## Plot 2 (1,2)
## Adding annotations
x_title <- "datetime"
y_title <- "Voltage"
## draw the plot
plot(DT$DateTime, DT$Voltage, type="l", xlab=x_title, ylab=y_title)

## Plot 3 (2,1)
## Adding annotations
y_title <- "Energy sub metering"
## draw the plot
with (DT, plot(DT$DateTime, DT$Sub_metering_1, type="n", xlab=" ", ylab=y_title) )
with (DT, points(DT$DateTime, DT$Sub_metering_1, type="l",col="BLACK" ))
with (DT, points(DT$DateTime, DT$Sub_metering_2, type="l",col="RED" ))
with (DT, points(DT$DateTime, DT$Sub_metering_3, type="l",col="BLUE" ))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

## Plot 4 (2,2)
## Adding annotations
x_title <- "datetime"
y_title <- "Global_reactive_power"
## draw the plot
plot(DT$DateTime, DT$Global_reactive_power, type="l", xlab=x_title, ylab=y_title)


## close the graphic device - file
dev.off()  
