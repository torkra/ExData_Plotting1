## R code for plot 2
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
## Adding annotations
H_title <- "Global Active Power (kilowatts)"


## open/create png-file with size 480*480
png(file = "plot2.png", width = 480, height = 480)

## draw the plot
plot(DT$DateTime, DT$Global_active_power, type="l",
     xlab=" ", ylab=H_title)

## close the graphic device - file
dev.off()  
