library(tidyverse)

setwd("C:\\Users\\marco\\Documents\\Getting_and_Cleaning_Data\\Week_01")

######################## 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/housing.csv", method = "curl")

housingData <- read.table("./data/housing.csv", sep = ",", header = TRUE)
class(housingData)
str(housingData)

# Counting house prices worth 1 milion or more  
nrow(housingData[housingData$VAL == 24 & !is.na(housingData$VAL), ])

######################## 2
unique(housingData$FES)

######################## 3
# Reading a xlsx file
library(xlsx)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/NGAP.xlsx", mode='wb')

dat <- read.xlsx("./data/NGAP.xlsx",
                 sheetIndex = 1,
                 colIndex = 7:15,
                 rowIndex = 18:23,
                 header = TRUE)
sum(dat$Zip*dat$Ext,na.rm=T)

######################## 4
# Reading a XML file
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"
my.doc <- xmlTreeParse(file=file,useInternal=TRUE)
root.Node <- xmlRoot(my.doc)
xmlName(root.Node)

zipcode <- xpathSApply(root.Node, "//zipcode", xmlValue)
length(zipcode[zipcode==21231])

######################## 5
library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/ss06pid.csv")

DT <- fread(input="./data/ss06pid.csv", sep=",")
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
