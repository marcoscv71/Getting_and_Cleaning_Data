## mySQL
# Each row is called a record
# install.packages("RMySQL", type="source")
# Guide to install: http://www.ahschulz.de/2013/07/23/installing-rmysql-under-windows/
# Genome configuration: https://genome.ucsc.edu/goldenPath/help/mysql.html

library(RMySQL)

# Connect on genoma databases
ucscDb <- dbConnect(MySQL(), user="genome",
                    host="genome-mysql.soe.ucsc.edu")

# Query to show all the databases and storing on result variable
result <- dbGetQuery(ucscDb, "show databases;")

# Closing connection
dbDisconnect(ucscDb)

# Connecting to hg19 and listing tables
hg19 <- dbConnect(MySQL(), user="genome", db="hg19",
                  host="genome-mysql.soe.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

# Get dimensions of a specific table
dbListFields(hg19, "affyU133Plus2")

dbGetQuery(hg19, "select count(*) from affyU133Plus2")

# Read from the table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# Select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
dbDisconnect(hg19)
