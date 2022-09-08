# 1. IMPORTS

## 1.1 Libraries
install.packages('readr')
install.packages('dplyr')
install.packages('geosphere')

library('dplyr')
library('readr')
library('geosphere')

## 1.2 Loading Data
trip_data_2021_08 <- read_csv('/home/vitor/Repos/google_project/data/202108-divvy-tripdata.csv')
trip_data_2021_09 <- read_csv('/home/vitor/Repos/google_project/data/202109-divvy-tripdata.csv')
trip_data_2021_10 <- read_csv('/home/vitor/Repos/google_project/data/202110-divvy-tripdata.csv')
trip_data_2021_11 <- read_csv('/home/vitor/Repos/google_project/data/202111-divvy-tripdata.csv')
trip_data_2021_12 <- read_csv('/home/vitor/Repos/google_project/data/202112-divvy-tripdata.csv')
trip_data_2022_01 <- read_csv('/home/vitor/Repos/google_project/data/202201-divvy-tripdata.csv')
trip_data_2022_02 <- read_csv('/home/vitor/Repos/google_project/data/202202-divvy-tripdata.csv')
trip_data_2022_03 <- read_csv('/home/vitor/Repos/google_project/data/202202-divvy-tripdata.csv')
trip_data_2022_04 <- read_csv('/home/vitor/Repos/google_project/data/202204-divvy-tripdata.csv')
trip_data_2022_05 <- read_csv('/home/vitor/Repos/google_project/data/202205-divvy-tripdata.csv')
trip_data_2022_06 <- read_csv('/home/vitor/Repos/google_project/data/202206-divvy-tripdata.csv')
trip_data_2022_07 <- read_csv('/home/vitor/Repos/google_project/data/202207-divvy-tripdata.csv')

df1 <- bind_rows(trip_data_2021_08, 
                      trip_data_2021_09, 
                      trip_data_2021_10, 
                      trip_data_2021_11, 
                      trip_data_2021_12,
                      trip_data_2022_01,
                      trip_data_2022_02,
                      trip_data_2022_03,
                      trip_data_2022_04,
                      trip_data_2022_05,
                      trip_data_2022_06,
                      trip_data_2022_07)

############################################################################

# 2. DATA DESCRIPTION

## 2.1 Overview
head(df1)
glimpse(df1)
summary(df1)

## 2.2 Check and Fillout NA
df1[5:8] <- list(NULL) # drop columns 
df1 <- na.omit(df1)

df1 <- df1[order(df1$started_at),]
View(df1)

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

## 3.6 Duration (min)
df3$duration <- difftime(df3$ended_at, df3$started_at, units='mins')

## 3.7 Distance (km)
df3$distance <- distGeo(matrix(c(df3$start_lng, df3$start_lat), ncol=2), matrix(c(df3$end_lng, df3$end_lat), ncol=2))/1000

## 3.8 Speed (km/h)
df3$speed = c(df3$distance)/as.numeric(c(df3$duration), units='hours')

summary(df3)

############################################################################

# 4. DATA FILTERING

df4 <- data.frame(df3)

## 4.1 Speed = NA
df4 <- na.omit(df4)

## 4.2 Speed < 0 
df4 <- subset(df4, df4[17] > 0)

## 4.3 Speed > 50
df4 <- subset(df4, df4[17] < 50)

## 4.4 Distance < 1m
df4 <- subset(df4, df4[16] > 0.001)

## 4.5 Distance > 100km (wrong records)
df4 <- subset(df4, df4[16] < 100)

## 4.6 Duration < 2 min
df4 <- subset(df4, df4[15] >= 2 )

# 5. EXPORT DATA FRAME

write.csv(df4,"/home/vitor/Repos/google_project/data/df_cyclistic_analysis.csv", row.names = FALSE)

