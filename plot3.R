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
png(file="plot3.png", width=480, height=480)
# Firstly we set the plot but don't put the data in it
with(data, plot(datetime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="n"))
# Now we add the 3 series
with(data, lines(datetime, Sub_metering_1), col = "black")
with(data, lines(datetime, Sub_metering_2, col = "red"))
with(data, lines(datetime, Sub_metering_3, col = "blue"))
# And now we add the legend
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# The weekdays of the x-axis appear in Spanish (Thu = Jue, Fri = Vie, Sat = Sáb)
# Finally, we close the graphics device
dev.off()