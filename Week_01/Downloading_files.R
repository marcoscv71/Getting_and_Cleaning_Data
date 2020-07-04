setwd("C:\\Users\\marco\\Documents\\Getting_and_Cleaning_Data\\Week_01")

## Cheking for and creating directories

# file.exists("directory name") will check to see if the directory exists
# dir.create("directory name") will create a directory if it doesnt exists


if(!file.exists("data")) {
    dir.create("data")
}

# download.file() downloads a file from internet
# important parameters are url, destfile, method
# useful for downloading tab-delimited, csv, and other files
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")
list.files("./data")

dateDownloaded <- date()
dateDownloaded

## Loading flat files - read.table()

# this is the main function for reading data into R
# flexible and robust but requires more parameters
# reads the data into RAM - big data can cause problems
# important parameters: file, header, sep, row.names, nrows
# related: read.csv(), read.csv2()

cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

# read.csv() automatically put sep = "," and header=TRUE

## Some more important parameters

# quote: you can tell R whether there area any quoted values quote="" means no 
# quotes.
# na.strings: set the character that represents a missing value
# nrows: how many rows to read of the file (e.g. nrows = 10 reads 10 lines)
# skip: number of lines to skip before starting to read

## one of the most troubles with reading flat files are quotation marks ` or " 
# placed in data values
## setting quote="" often resolves these.

###############################################################################

## Reading Excel Files
# read.xlsx(), read.xslx2() {xlsx package}
# write.xlsx function will write out an Excel file with similar arguments
# read.xlsx2 is much faster than read.xlsx but for reading subsets of rows may
# be slightly unstable

# XLConnect package has more options for writing and manipulating Excel files

###############################################################################
## data.table
# Inherets from data.frame 
# (all functions that accept data.frame work on data table)
# Written in C so it is much faster
# Much, much faster at subsetting, group, and updating
library(data.table)
DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DF, 3)

DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DT, 3)

# See all the data tables in memory
tables()

# Subsetting rows
DT[c(2,3)]

# Subsetting columns

