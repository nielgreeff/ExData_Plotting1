######
# Code for Plot1 -- week 1 - Exploratory Data Analysis
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


## now that we have the data .. the plot is a histogram chart (hist) of Global Active Power
power_data <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")

### but we only need certain dates ... 
our_data <- subset(power_data, power_data$Date=="1/2/2007" | power_data$Date =="2/2/2007")

# now we need to do a histogram of our_data$Glocal_active_power column
# and do it in red with the main title = "Global Active Power" and the x-axis label = "Global Active Power (kilowatts)"

# we might also have "?" in there ... so if we convert this to numeric .. it will become NA
hist(as.numeric(as.character(our_data$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

# now we have a plot .. we need to plot this to png
png("plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(our_data$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

# close the file
dev.off()


