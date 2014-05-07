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

png(filename="Plot3.png",width=480,height=480)
plot(x,Data[,7],col="white",main="",xlab="",ylab="Energy sub metering")
lines(x,Data[,7],col="black")
lines(x,Data[,8],col="red")
lines(x,Data[,9],col="blue")
legend("topright",names(Data)[7:9],col=c("black","red","blue"),lwd=2)
dev.off()

