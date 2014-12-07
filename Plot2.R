
plot2 <- function()
{
  ##Read the  zip file from the location
  ##https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
  
  numbytes =  2075259 * 9 * 8 
  numMB = numbytes/(2^20) ##Number of MBs required to load the entire data into memory
  
  zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  local_file <- "exdata-data-household_power_consumption.zip"
  
  dirList <- dir()
  
  if (local_file %in% dirList)
  {
    ##Read the data from the url into a tempfile
    
  } else
  {
    ##Read the data from the url into a tempfile
    download.file(zip_url,
                  destfile=local_file)
  }
  
  files <- unzip(local_file, list=TRUE) #list the names of the files in the zip
  
  #go through the list of files and unzip them
  for (i in nrow(files))
  {
    fname<- files[i,"Name"]
    unzip(local_file, fname)
  }
  
  ## here we have only one txt file in the zip, so I am taking the liberty to just read that one file
  ## Hardcoding the filename will be required, if we are looking for a particular file to read from teh zip
  ## Read data from the txt file
  tmp_data <- read.csv(fname, sep=";",
                       colClasses=c(rep("character",2), 
                                    rep("numeric", 7) ), 
                       na.strings="?")
  
  ##subset only the required part of data
  tmp_data <- subset(tmp_data, Date=="1/2/2007"| Date =="2/2/2007")
  
  ##summary(tmp_data)
  
  ##head(tmp_data)
  
  tmp_data$Date <- as.Date(tmp_data$Date, "%d/%m/%Y")  ##Convert the first col into Date type
  
  ##Convert the second col into Time type
  tmp_data$DateTime <- strptime(paste(tmp_data$Date, tmp_data$Time), "%Y-%m-%d %H:%M:%S")
  
  
  ##plot 2
  with(tmp_data, plot( DateTime,Global_active_power, type="l", ylab="Global Active Power (kilowatts)"))
  title(main="Plot 2")
  dev.copy(png, "plot2.png", width=480. height=480)
  dev.off()
}