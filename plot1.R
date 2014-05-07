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

png(filename="Plot1.png",width=480,height=480)
hist(Data[,3],col='red',main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()

