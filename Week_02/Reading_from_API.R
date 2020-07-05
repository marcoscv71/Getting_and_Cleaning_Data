# install.packages("jsonlite")
library(jsonlite)
# install.packages("httpuv")
library(httpuv)
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("Get_API_Test",
                   key = "***",
                   secret = "***"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

stop_for_status(req)

jsonData <- content(req)

# Converting this json to a dataframe
df <- jsonlite::fromJSON(jsonlite::toJSON(jsonData))

df[df$full_name == "jtleek/datasharing", "created_at"]
