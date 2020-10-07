
# data tidy
library(dplyr)

# rolling sums
library(zoo)

# animation
library(ggplot2)
library(gganimate)
library(transformr)

# Other libraries used
# utils, rgdal, broom, tidyr 

# The data can be found at a few different links, the shapefile type must be downloaded to a local directory
# https://data.gov.ie/dataset/covid19countystatisticshpscireland
# https://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0?geometry=-26.767%2C51.133%2C10.147%2C55.710
covid_opendata_shapefile <- "https://opendata.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.zip?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D"

# Change this to save your files in a specific directory
# directory_to_use <- tempdir()
directory_to_use <- "Code_Walkthrough/COVID/data/CountyHPSC/"
covid_opendata_fp <- file.path(directory_to_use, "Covid19CountyStatisticsHPSCIreland.zip")

# Download and save data
download.file(covid_opendata_shapefile, covid_opendata_fp)
utils::unzip(covid_opendata_fp, exdir = directory_to_use)
covid_openddata_shpdata <-  rgdal::readOGR(dsn = file.path(directory_to_use, "Covid19CountyStatisticsHPSCIreland.shp"), stringsAsFactors = F)



# Create data frame containing the polygon coordinates
county_polygon_data <- broom::tidy(covid_openddata_shpdata, region = "CountyName")
# Optional save county polygon data
# write.csv(county_polygon_data, file = "data/county_polygon.csv", row.names = F)
# county_polygon_data <- readr::read_csv(county_polygon_data, file = "data/county_polygon.csv")



# Create data frame of the covid stats only, no spatial data
raw_covid_stats <- 
  covid_openddata_shpdata@data  %>%
  rename(PopulationCensus16 = Population, ConfirmedCovidCases = ConfirmedC)

# A more up to date dataset (without spatial data)
# https://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0?geometry=-26.767%2C51.133%2C10.147%2C55.710
raw_covid_stats <- readr::read_csv("http://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.csv?outSR={%22latestWkid%22:3857,%22wkid%22:102100}")


# Tidy and wrangle data
raw_covid_stats %>%
  # Remove unneeded columns and parse date
  select(CountyName, TimeStamp, Population, ConfirmedCovidCases) %>%
  mutate(TimeStamp = as.Date(TimeStamp)) %>%
  
  # Add any missing dates and fill the data for missing dates
  group_by(CountyName) %>%
  tidyr::complete(TimeStamp = seq(min(as.Date(.$TimeStamp)), # use .$TimeStamp to get global data min 
                                  max(as.Date(.$TimeStamp)), # not just the min for the group_by var
                                  by = "day")) %>%
  # Ensure the data is arranged by date
  arrange(TimeStamp) %>%
  tidyr::fill(Population, ConfirmedCovidCases, .direction = "down") %>%
  
  # Calculate the lag and then the cases per day
  mutate(lag_cases = lag(ConfirmedCovidCases, 1, default = 0),
         new_cases = ConfirmedCovidCases - lag_cases,
         new_cases_per100 = 100000 * (new_cases/PopulationCensus16),
         
         # Rolling 14 Day Total
         rolling14 = rollsum(new_cases, 14, align = "right", fill = 0),
         rolling14_per100 = rollsum(new_cases_per100, 14, align = "right", fill = 0)) %>%
  ungroup() -> covid_rolling14



# Animation
rolling14_anim <- 
  covid_rolling14 %>%
  # Filter the data by date
  filter(TimeStamp >= "2020-08-01") %>% # Sys.Date() - 50
  # Join data to county map data
  full_join(county_polygon_data, by = c("CountyName" = "id")) %>%
  ggplot() + geom_polygon(aes(x = long, y = lat, group = group, fill = rolling14_per100), colour = "black") + 
  theme_void() +
  scale_fill_distiller(palette = "RdYlGn") +
  coord_quickmap() +
  # -Animation-
  # Plot elements for animation
  transition_time(TimeStamp) +
  labs(title = "COVID Rolling 14 Day Cases Per 100,000",
       subtitle = 'Up to {format(frame_time, "%B %d")}', 
       fill = "Cases per 100k")


# Create the animation, nframes and fps will set the speed of the animation
# This can be slow depending on choices
map_anim <- 
  animate(rolling14_anim, 
          nframes = 120, 
          fps = 4,
          start_pause = 2,
          end_pause = 10)

anim_save(filename = paste0(directory_to_use, "rolling_14day_total2_", Sys.Date(),".gif"))






# Testing data
testing_csv <- readr::read_csv("http://opendata-geohive.hub.arcgis.com/datasets/f6d6332820ca466999dbd852f6ad4d5a_0.csv?outSR={%22latestWkid%22:3857,%22wkid%22:102100}")

as.Date(testing_csv$Date_HPSC[1:3])





