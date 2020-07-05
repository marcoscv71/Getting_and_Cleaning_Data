setwd("C:\\Users\\marco\\Documents\\Data_Science_Coursera\\Getting_and_Cleaning_Data\\Week_02")

####### Webscraping
# Programatically extracting data from the HTML code of websites
# Many websites have information you may want to programaticaly read
# Attempting to read too many pages too quickly can get your IP address blocked

con <- url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=pt-BR")
htmlCode <- readLines(con)
close(con)
htmlCode

# Parsing with XML
library(XML)
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
html <- htmlTreeParse(url, useInternalNodes = T)

## GET from the httr package
library(httr); html2 <- GET(url)
content2 <- content(html2, as="text")
parsedHtml <- htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# Accessing websites with passwords
pg1 <- GET("http://httpbin.org/basic-auth/user/passwd",
           authenticate("user", "passwd"))
pg1
names(pg1)

google <- handle("http://google.com")
pg1 <- GET(handle=google, path="/")
pg2 <- GET(handle=google, path="search")