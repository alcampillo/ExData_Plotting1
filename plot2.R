# We'll first read in the data (only the corresponding to the dates needed)
data <- read.csv("./household_power_consumption.txt",
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric"), 
                 nrows=2880, 
                 skip=66636, 
                 sep=";", 
                 na.strings="?", 
                 col.names= c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                              "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"))
# Now, we'll do some transformations on the date and time information
datetime <- paste(data$Date,data$Time, sep=" ")
datetime <- strptime(datetime, format="%d/%m/%Y %H:%M:%S")
data <- cbind(datetime, data)
# We'll now print the second plot, the evolution of global active power through the 2 days
# Starting with a new, blank canvas
dev.off()
# Here we plot and annotate the line graph
with(data, plot(datetime, Global_active_power, 
                type ="l", xlab="", ylab="Global Active Power (kilowatts)"))
# The weekdays of the x-axis appear in Spanish (Thu = Jue, Fri = Vie, Sat = Sáb)
# And finally we copy it to a png file 
dev.copy(png, file="plot2.png", width=480, height=480)
# and close the graphics device
dev.off()