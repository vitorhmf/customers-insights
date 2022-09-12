# 1. IMPORTS

## 1.1 Libraries
install.packages('readr')
install.packages('dplyr')

library('dplyr')
library('readr')

## 1.2 Loading Data
trip_data_2021_08 <- read_csv('/home/vitor/Repos/google_project/data/202108-divvy-tripdata.csv')
trip_data_2021_09 <- read_csv('/home/vitor/Repos/google_project/data/202109-divvy-tripdata.csv')
trip_data_2021_10 <- read_csv('/home/vitor/Repos/google_project/data/202110-divvy-tripdata.csv')
trip_data_2021_11 <- read_csv('/home/vitor/Repos/google_project/data/202111-divvy-tripdata.csv')
trip_data_2021_12 <- read_csv('/home/vitor/Repos/google_project/data/202112-divvy-tripdata.csv')
trip_data_2022_01 <- read_csv('/home/vitor/Repos/google_project/data/202201-divvy-tripdata.csv')
trip_data_2022_02 <- read_csv('/home/vitor/Repos/google_project/data/202202-divvy-tripdata.csv')
trip_data_2022_03 <- read_csv('/home/vitor/Repos/google_project/data/202203-divvy-tripdata.csv')
trip_data_2022_04 <- read_csv('/home/vitor/Repos/google_project/data/202204-divvy-tripdata.csv')
trip_data_2022_05 <- read_csv('/home/vitor/Repos/google_project/data/202205-divvy-tripdata.csv')
trip_data_2022_06 <- read_csv('/home/vitor/Repos/google_project/data/202206-divvy-tripdata.csv')
trip_data_2022_07 <- read_csv('/home/vitor/Repos/google_project/data/202207-divvy-tripdata.csv')

## 1.3 Join
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

View(df1)

## 1.4 Export Raw Data
write.csv(df1,"/home/vitor/Repos/google_project/data/df_raw_cyclistic.csv", row.names = FALSE)
