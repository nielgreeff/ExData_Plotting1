######
# Code for Plot3 -- week 1 - Exploratory Data Analysis
######

### download and unzip the data
filename <- "power_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  getfileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(getfileURL, filename)
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}


## now that we have the data .. the plot is a plot of sub-metering 1 .. 3 on the Y-axis and time on X-axis 
power_data <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

### but we only need certain dates ... 
our_data <- subset(power_data, power_data$Date=="1/2/2007" | power_data$Date =="2/2/2007")

### we will have to convert the Date and Time columns (from text) to date and time types
our_data$Date <- as.Date(our_data$Date, format="%d/%m/%Y")
our_data$Time <- strptime(our_data$Time, format="%H:%M:%S")

# if we plot now .. we will just get the times .. not days ....
# So, we have to split off the first day (the first 1440 entries) and then add the second day
# and use the format function to grab add the date before the time
# We place the data and time in the Time column .. so if we print againts the time column
# R will see it is time span .. over days ... and plot out the days and not the hours for us
our_data[1:1440,"Time"] <- format(our_data[1:1440,"Time"],"2007-02-01 %H:%M:%S")
our_data[1441:2880,"Time"] <- format(our_data[1441:2880,"Time"],"2007-02-02 %H:%M:%S")



# for our plot , we will have sub-metering_1 in black, 2 in red and 3 in blue
# we need to put a Y label in there = "Energy sub metering" .. set up the frame (no data line yet)
plot(our_data$Time,our_data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")

# add the lines for the different sub metering to the plot
with(our_data,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(our_data,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(our_data,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))

# now add the legend at the top right of the plot
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Give our plot a title
title(main="Energy sub-metering")


# now we have a plot .. we need to plot this to png
png("plot3.png", width = 480, height = 480)

# repeat our plot (could have done it better with a fucntion ... only 4 lines ... leaving it here)
plot(our_data$Time,our_data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")

# add the lines for the different sub metering to the plot
with(our_data,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(our_data,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(our_data,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))

# now add the legend at the top right of the plot
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Give our plot a title
title(main="Energy sub-metering")


# close the file
dev.off()

