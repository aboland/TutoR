

# Covid19CountyStatisticsHPSCIrelandOpenData

covid_opend_shapefile <- 'http://opendata-geohive.hub.arcgis.com/datasets/4779c505c43c40da9101ce53f34bb923_0.zip?outSR={%22latestWkid%22:3857,%22wkid%22:102100}'
covid_opend_csv <-"http://opendata-geohive.hub.arcgis.com/datasets/4779c505c43c40da9101ce53f34bb923_0.csv?outSR={%22latestWkid%22:3857,%22wkid%22:102100}"


raw_data_csv <- readr::read_csv(covid_opend_csv)


covid_opend_fp <- file.path("Code_Walkthrough/COVID/data/CountyHPSCOpenD", "Covid19CountyStatisticsHPSCIrelandOpenData.zip")
download.file(covid_opend_shapefile, covid_opend_fp)
utils::unzip(covid_opend_fp, exdir = "Code_Walkthrough/COVID/data/CountyHPSCOpenD")
covid_opend_shpdata <-  rgdal::readOGR(dsn = "Code_Walkthrough/COVID/data/CountyHPSCOpenD/Covid19CountyStatisticsHPSCIrelandOpenData.shp", stringsAsFactors = F)

head(covid_opend_shpdata)
ggplot() + geom_polygon(data = covid_opend_shpdata, aes(x = long, y = lat), colour = "black", fill = NA) + theme_void()






library(ggplot2)
# Covid19CountyStatisticsHPSCIreland

covid_shapefile <- 'http://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.zip?outSR={%22latestWkid%22:3857,%22wkid%22:102100}'
covid_csv <-"http://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.csv?outSR={%22latestWkid%22:3857,%22wkid%22:102100}"


raw_data_csv <- 
  readr::read_csv(covid_csv)

tidy_raw_data <- 
  raw_data_csv %>%
  mutate(TimeStamp = as.Date(TimeStamp)) %>%
  filter(TimeStamp > "2020-09-01") %>%
  group_by(CountyName) %>%
  mutate(total_cases = sum(ConfirmedCovidCases),
         per100 = 100000*(total_cases/PopulationCensus16)) %>%
  select(CountyName, total_cases, per100)


covid_fp <- file.path("Code_Walkthrough/COVID/data/CountyHPSC", "Covid19CountyStatisticsHPSCIreland.zip")
download.file(covid_shapefile, covid_fp)
utils::unzip(covid_fp, exdir = "Code_Walkthrough/COVID/data/CountyHPSC")
covid_shpdata <-  rgdal::readOGR(dsn = "Code_Walkthrough/COVID/data/CountyHPSC/Covid19CountyStatisticsHPSCIreland.shp", stringsAsFactors = F)

covid_shpdata$TimeStamp <- as.Date(covid_shpdata$TimeStamp)

sample_data <- covid_shpdata[covid_shpdata$TimeStamp == max(covid_shpdata$TimeStamp),]
ggplot() + geom_polygon(data = sample_data, aes(x = long, y = lat, group = group), colour = "black", fill = NA) + theme_void()

tidy_shpdata <- broom::tidy(covid_shpdata[!duplicated(covid_shpdata$CountyName),], region = "CountyName")




covid_data <-
  tidy_raw_data %>%
  full_join(tidy_shpdata, by = c("CountyName" = "id")) %>%
  mutate(TimeStamp = as.Date(TimeStamp))


covid_data %>%
  ggplot() + geom_polygon(aes(x = long, y = lat, group = group, fill = total_cases), colour = "black") + theme_void() +
  scale_fill_distiller(palette = "Spectral") +
  labs(fill = "Total cases")


covid_data %>%
  ggplot() + geom_polygon(aes(x = long, y = lat, group = group, fill = per100), colour = "black") + theme_void() +
  scale_fill_distiller(palette = "Spectral") +
  labs(fill = "Cases per 100k")






# LaboratoryLocalTimeSeriesHistoricView

testing_csv <- "http://opendata-geohive.hub.arcgis.com/datasets/f6d6332820ca466999dbd852f6ad4d5a_0.csv?outSR={%22latestWkid%22:3857,%22wkid%22:102100}"


testing_csv <- 
  readr::read_csv("http://opendata-geohive.hub.arcgis.com/datasets/f6d6332820ca466999dbd852f6ad4d5a_0.csv?outSR={%22latestWkid%22:3857,%22wkid%22:102100}")
testing_csv$Date_HPSC <- as.Date(testing_csv$Date_HPSC)


testing_anim <- 
  testing_csv %>%
  arrange(Date_HPSC) %>%
  mutate(lag_labs = lag(TotalLabs),
         daily_labs = TotalLabs - lag_labs,
         rolling14 = rollsum(daily_labs, 14, align = "right", fill = 0)) %>%
  filter(Date_HPSC >= "2020-08-01") %>%
  ggplot() +
  geom_vline(aes(xintercept =  Date_HPSC, frame = Date_HPSC)) +
  geom_line(aes(x = Date_HPSC, y = rolling14)) +
  transition_states(
    states = Date_HPSC,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink()

animate(testing_anim)






# ArcGIS

arcgis_url <- "https://services1.arcgis.com/eNO7HHeQ3rUcBllm/arcgis/rest/services/Covid19CountyStatisticsHPSCIrelandOpenData/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json"



arcgis_shapefile_opendata <- "https://opendata.arcgis.com/datasets/4779c505c43c40da9101ce53f34bb923_0.zip?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D"
arcgis_shapefile <-"https://opendata.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.zip?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D"

covid_arcgis_fp <- file.path("Code_Walkthrough/COVID/data/arcgisCounty", "Covid19CountyStatisticsHPSCIreland.zip")
download.file(arcgis_shapefile, covid_arcgis_fp)
utils::unzip(covid_arcgis_fp, exdir = "Code_Walkthrough/COVID/data/arcgisCounty")
arcgis_shpdata <-  rgdal::readOGR(dsn = "Code_Walkthrough/COVID/data/arcgisCounty/Covid19CountyStatisticsHPSCIreland.shp", stringsAsFactors = F)


arcgis_shpdata$TimeStamp <- as.Date(arcgis_shpdata$TimeStamp)
raw_arcgis <- arcgis_shpdata@data

# County polygon data.frame
temp_tidy <- broom::tidy(arcgis_shpdata, region = "CountyName")
write.csv(temp_tidy, file = "Code_Walkthrough/COVID/data/county_polygon.csv", row.names = F)


tidy_arcgis <- 
  raw_arcgis %>%
  filter(TimeStamp > Sys.Date() - 30) %>%
  group_by(CountyName) %>%
  mutate(total_cases = sum(ConfirmedC),
         per100 = 100000*(total_cases/Population)) %>%
  full_join(temp_tidy, by = c("CountyName" = "id"))


tidy_arcgis %>%
  ggplot() + geom_polygon(aes(x = long, y = lat, group = group, fill = per100), colour = "black") + theme_void() +
  scale_fill_distiller(palette = "Spectral") +
  labs(fill = "Cases per 100k")


