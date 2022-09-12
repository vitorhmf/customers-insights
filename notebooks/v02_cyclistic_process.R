# 1. IMPORTS

## 1.1 Libraries
install.packages('readr')
install.packages('dplyr')
install.packages('geosphere')
install.packages('stringr')

library('dplyr')
library('readr')
library('geosphere')
library('stringr')

## 1.2 Loading Data
df1 <- read_csv('/home/vitor/Repos/google_project/data/df_raw_cyclistic.csv')

############################################################################

# 2. DATA DESCRIPTION

## 2.1 Overview
head(df1)
glimpse(df1)
summary(df1)
str(df1)

## 2.2 Check and Fillout NA

sum(is.na(df1$start_station_id))

df1[5:8] <- list(NULL) # drop stations columns (14,5% NA)
df1 <- na.omit(df1)

df1 <- df1[order(df1$started_at),]

## 2.3 Change Types

  # Was not necessary #

############################################################################

# 3. FEATURE ENGINEERING

df3 <- data.frame(df1)

## 3.1 Date
df3$date <- as.Date(df3$started_at)

## 3.2 Month
df3$month <- format(as.Date(df3$date), '%m')

## 3.3 Day
df3$day <- format(as.Date(df3$date), '%d')

## 3.4 Year
df3$year <- format(as.Date(df3$date), '%Y')

## 3.5 Day of Week
df3$day_of_week <- format(as.Date(df3$date), '%A')

## 3.6 Season
df3$season[df3$month=="12"] <- "winter"
df3$season[df3$month=="01"] <- "winter"
df3$season[df3$month=="02"] <- "winter"
df3$season[df3$month=="03"] <- "spring"
df3$season[df3$month=="04"] <- "spring"
df3$season[df3$month=="05"] <- "spring"
df3$season[df3$month=="06"] <- "summer"
df3$season[df3$month=="07"] <- "summer"
df3$season[df3$month=="08"] <- "summer"
df3$season[df3$month=="09"] <- "fall"
df3$season[df3$month=="10"] <- "fall"
df3$season[df3$month=="11"] <- "fall"

## 3.7 Duration (min)
df3$duration <- difftime(df3$ended_at, df3$started_at, units='mins')
df3$duration <- round(df3$duration, digit=2)

## 3.8 Distance (km)
df3$distance <- distGeo(matrix(c(df3$start_lng, df3$start_lat), ncol=2), matrix(c(df3$end_lng, df3$end_lat), ncol=2))/1000
df3$distance <- round(df3$distance, digit=2)

## 3.9 Speed (km/h)
df3$speed = c(df3$distance)/as.numeric(c(df3$duration), units='hours')
df3$speed <- round(df3$speed, digit=2)

## 3.10 Station Location
df3$start_lat <- round(df3$start_lat, digit=3)
df3$start_lng <- round(df3$start_lng, digit=3)
df3$end_lat <- round(df3$start_lat, digit=3)
df3$end_lng <- round(df3$end_lng, digit=3)

df3$start_station <- str_c(df3$start_lat, ' , ', df3$start_lng)
df3$end_station <- str_c(df3$end_lat, ' , ', df3$end_lng)

# n_distinct(df3$end_station)

############################################################################

# 4. DATA FILTERING

df4 <- data.frame(df3)

## 4.1 Duration < 1 min
df4 <- subset(df4, df4[16] >= 1 )

## 4.2 Distance < 1m
df4 <- subset(df4, df4[17] > 0.001)

## 4.3 Distance > 100km (wrong records)
df4 <- subset(df4, df4[17] < 100)

## 4.2 Speed < 0 
df4 <- subset(df4, df4[18] > 0)

## 4.3 Speed > 50
df4 <- subset(df4, df4[18] < 60)

############################################################################

# 5. EXPORT DATA FRAME

write.csv(df4,"/home/vitor/Repos/google_project/data/df_cyclistic_analysis.csv", row.names = FALSE)

