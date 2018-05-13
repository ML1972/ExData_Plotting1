#######################
# GENERAL INFORMATION #
#######################

# Course Project 1 (EDA)
# Developed by: Mario Lechner
# File: plot2.R

###############################################################################
# DATASET TO BE USED                                                          #
#                                                                             #     
# Dataset: Electric power consumption [20Mb]                                  #
# Description: Measurements of electric power consumption in one household    #
# with a one-minute sampling rate over a period of almost 4 years. Different  #
# electrical quantities and some sub-metering values are available.           # 
# The following descriptions of the 9 variables in the dataset are taken from #
# the UCI web site:                                                           #
#                                                                             # 
# (-) Date: Date in format dd/mm/yyyy                                         #
# (-) Time: time in format hh:mm:ss                                           #
# (-) Global_active_power: household global minute-averaged active power      #
#                          (in kilowatt)                                      # 
# (-) Global_reactive_power: household global minute-averaged reactive power  #
#                            (in kilowatt)                                    # 
# (-) Voltage: minute-averaged voltage (in volt)                              #
# (-) Global_intensity: household global minute-averaged current intensity    #
#                       (in ampere)                                           # 
# (-) Sub_metering_1: energy sub-metering No. 1                               #
#                     (in watt-hour of active energy). It corresponds to the  #
#                     kitchen, containing mainly a dishwasher, an oven and a  #
#                     microwave (hot plates are not electric but gas powered).#
# (-) Sub_metering_2: energy sub-metering No. 2                               #
#                     (in watt-hour of active energy). It corresponds to the  #
#                     laundry room, containing a washing-machine,             #
#                     a tumble-drier, a refrigerator and a light.             # 
# (-) Sub_metering_3: energy sub-metering No. 3                               #
#                     (in watt-hour of active energy). It corresponds to an   #
#                     electric water-heater and an air-conditioner.           #
#                                                                             #          
# When loading the dataset into R, consider the following:                    #
#                                                                             #          
# 1. The dataset has 2,075,259 rows and 9 columns. Calculate a rough estimate #
#    of how much memory the dataset will require in memory before reading     #
#    data set into R                                                          #
# 2. Data used for this task: from the dates 2007-02-01 and 2007-02-02.       #
# 3. Useful to convert the Date and Time variables to Date/Time classes in R  #
#    using the strptime() and as.Date() functions.                            #
# 4. In this dataset missing values are coded as ?.                           #
#                                                                             #          
###############################################################################
# GOAL                                                                        #  
# Our overall goal here is simply to examine how household energy usage       #
# varies over a 2-day period in February, 2007. Your task is to reconstruct   #
# the following plots given in the course task, all of which were constructed #
# using the base plotting system.                                             #                                                                 # 
#                                                                             #          
############################################################################### 
# TASK                                                                        #        
#                                                                             #      
# 1. Construct the plot and save it to a PNG file with a width of 480 pixels  #
#    and a height of 480 pixels.                                              # 
# 2. Name plot file as plot2.png                                              # 
# 3. Create a separate R code file plot1.R that constructs the corresponding  #
#    plot, i.e. code in plot1.R constructs the plot1.png plot. The code file  #
#    should include code for reading the data so that the plot can be fully   #
#    reproduced. You should also include the code that creates the PNG file.  #
#                                                                             #          
############################################################################### 


#####################
# SOURCE CODE PLOT2 #
#####################

# PRELIMINARY SETTINGS #
########################

# Set packages to use
library(graphics)
library(grDevices)
library(lubridate)

# Remove all existing variables in environment
rm(list = ls())

# Define paths
mypath<-getwd()
Datadir<-"C04_Course_Project_01" # Define data directory
if(!file.exists(Datadir))
{
     dir.create(Datadir)
}
set_zipfname<-"exdata%2Fdata%2Fhousehold_power_consumption.zip" # Define zip filename
DataZip<-paste(mypath,set_zipfname,sep="/")

# unzip file
unzip(zipfile=DataZip,exdir=paste(mypath,Datadir,sep="/")) # Unzip Zip file

# Set directories
EPC_dir<-paste(mypath,Datadir,sep="/") # Electric power consumption dataset directory

# Set file names with its path
EPC_fname<-paste(EPC_dir,"household_power_consumption.txt",sep="/")

# Read data set
hpc_data<-read.table(EPC_fname, header=TRUE, sep = ";",na.strings = "?",
                     colClasses = c("character","character","numeric","numeric","numeric",
                                    "numeric","numeric","numeric","numeric"))

# Create data subset from 2007-02-01 and 2007-02-02
hpc_subset<-hpc_data[grepl("^[1,2]/2/2007",hpc_data$Date),]

# Change date and time info into 'm/d/y h:m:s'
DateTime<-with(hpc_subset,paste(as.Date(Date,"%d/%m/%Y"), Time))

# Merging data sets
hpc_subset<-cbind(DateTime,hpc_subset)
hpc_subset$DateTime<-as.POSIXct(hpc_subset$DateTime,)

# Remove all data in the environment which is not any more of use from now on
rm(set_zipfname, DataZip)
rm(hpc_data, estimatememory, DateTime)


# CREATE PLOT 02 #
##################
plot(hpc_subset$Global_active_power~hpc_subset$DateTime,type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

# SAVE PLOT 02 AS PNG FILE #
############################
plot_fname<-"plot2.png"
dev.copy(png,paste(mypath,paste(Datadir,plot_fname,sep="/"),sep="/"),width=480,height=480)
dev.off() # close graphic device