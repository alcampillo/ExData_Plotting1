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
# We'll now print the first plot, a histogram of global active power
# Here we plot and annotate the histogram
hist(data$Global_active_power, xlab= "Global Active Power (kilowatts)", 
     col = "red", main ="Global Active Power")
# We copy it to a png file 
dev.copy(png, file="plot1.png", width=480, height=480)
# And finally close the graphics device
dev.off()