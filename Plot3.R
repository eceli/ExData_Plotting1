##download the zip
if (!file.exists("data.zip")) {
        fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL,destfile="./data.zip")
        unzip("data.zip")  
}

##read only data from the dates 2007-02-01 and 2007-02-02
data <- read.csv("household_power_consumption.txt",skip=66637,nrows=2880,na.strings = "?",header=F,sep=";")

##load the column headers
names(data) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))
## convert the Date and Time variables to Date/Time
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- paste(data$Date, data$Time, sep=" ")
data$Time <- strptime(data$Time, format="%Y-%m-%d %H:%M:%S")

##define the plot file
png(filename="plot3.png", width=480, height=480)
##plot the grafic
plot(data$Time, data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering", main="")
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")
legend("topright", lwd=1, lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##close the file
dev.off()