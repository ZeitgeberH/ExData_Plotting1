# Function to read data from txt, select the required 
# portion and save in Rdata
GetData<-function(){
    
    DataName<-'household_power_consumption.txt'
    temp<-read.delim(DataName, header = TRUE, sep = ";",na.strings = "?", colClasses =c("character","character",rep("numeric",7)),comment="") 
    
    Data<-temp[grep("^1/2/2007|^2/2/2007",temp$Date),]
    rm(temp)
        
    save(Data,file="Power.RData")
     
    Data
}

# Check if required data exist in memory
if(!exists("Data"))  
{
    # Check if required data exist in file
if(file.exists("Power.RData")) load("Power.RData") else Data<-GetData()
 
} 
# prepare timestamp
TheTime<-paste(Data$Date,Data$Time)
x<-strptime(TheTime,"%d/%m/%Y %H:%M:%S")

png(filename="Plot4.png",width=480,height=480)

par(mfcol=c(2,2))

plot(x,Data[,3],col="white",main="",xlab="",ylab="Global Active Power (kilowatts)")
lines(x,Data[,3],col="black")

plot(x,Data[,7],col="white",main="",xlab="",ylab="Energy sub metering")
lines(x,Data[,7],col="black")
lines(x,Data[,8],col="red")
lines(x,Data[,9],col="blue")
legend("topright",names(Data)[7:9],lwd=2,box.lwd = 0,bty="n",col=c("black","red","blue"))

plot(x,Data[,5],col="white",main="",xlab="datetime",ylab="Voltage")
lines(x,Data[,5],col="black")

theName=names(Data)

plot(x,Data[,4],col="white",main="",xlab="datetime",ylab=names(Data)[4])
lines(x,Data[,4],col="black")
dev.off()

