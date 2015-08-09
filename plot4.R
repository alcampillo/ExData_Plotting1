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
# We start with a new, blank canvas and open our png graphics device
dev.off()
png(file="plot4.png", width=480, height=480)
# And prepare the canvas for 4 plots (2 by 2)
par(mfrow=c(2,2))
# The graph on the topleft part is similar to plot 2 of the project
with(data, plot(datetime, Global_active_power, type ="l", xlab="", ylab="Global Active Power"))
# The graph on the topright part
with(data, plot(datetime, Voltage, type ="l", xlab="datetime", ylab="Voltage"))
# The graph on the bottomleft part is similar to plot 3 of the project
with(data, plot(datetime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="n"))
with(data, lines(datetime, Sub_metering_1), col = "black")
with(data, lines(datetime, Sub_metering_2, col = "red"))
with(data, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# And finally, the graph on the bottomright part
with(data, plot(datetime, Global_reactive_power, type ="l", xlab="datetime"))
# The weekdays of the x-axis appear in Spanish (Thu = Jue, Fri = Vie, Sat = Sáb)
# Finally, we close the graphics device
dev.off()