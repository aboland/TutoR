

# Data with counties as polygon
covid_ireland <- readr::read_csv("http://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.csv?outSR={%22latestWkid%22:3857,%22wkid%22:102100}")
head(covid_ireland)

all_county_ids <- 
  covid_ireland %>%
  select(CountyName, UGI) %>%
  distinct()

all_county_ids$xml_link <- paste0(gsub("resource/county","pathpage/geo:hasGeometry/county", all_county_ids$UGI),"?output=xml")
    

# http://data.geohive.ie/resource/county/2ae19629-143d-13a3-e055-000000000001
# http://data.geohive.ie/pathpage/geo:hasGeometry/county/2ae19629-143d-13a3-e055-000000000001
# http://data.geohive.ie/pathdata/geo:hasGeometry/county/2ae19629-143d-13a3-e055-000000000001?output=xml

my_county_poly_func <- function(x){
  xml_table <- 
    xml2::read_html(x) %>%
    rvest::html_table()
  
  poly_data <- 
    data.frame(strsplit(gsub("[POLYGON ((]|[))\n\ngeo:wktiteral)]"," ", xml_table[[1]]$Value[1]), ","),
               stringsAsFactors = F)
  names(poly_data) <- "merged_data"
  
  tidy_county <- 
    poly_data %>%
    mutate(merged_data = trimws(merged_data),
           order = 1:nrow(.),
           group = 1) %>%
    tidyr::separate(col = merged_data, into = c("long", "lat"), sep = " ")
  
  return(tidy_county)
}

all_county_data <- list()

for(i in 1:nrow(all_county_ids)){
  all_county_data[[all_county_ids$CountyName[i]]] <- my_county_poly_func(all_county_ids$xml_link[i])
}




library(ggplot2)

all_county_data[[2]] %>%
  ggplot() +
  geom_polygon(aes(x = long, y = lat, group = group), fill = NA, colour = "black") +
  coord_fixed(1.3) +
  theme_void()



do.call(rbind, all_county_data) %>%
  mutate(order = 1:nrow(.)) %>%
  ggplot() +
  geom_polygon(aes(x = long, y = lat, group = group), fill = NA, colour = "black") +
  coord_fixed(1.3) +
  theme_void()




#####
fn <- file.path("Code_Walkthrough/COVID/data", "IRE_electoral_regions.zip")
download.file('http://data-osi.opendata.arcgis.com/datasets/862a628b73d14a86b2f46ef9506dda8b_0.zip?outSR={"latestWkid":3857,"wkid":102100}', fn)
utils::unzip(fn, exdir = "Code_Walkthrough/COVID/data")
shp <- rgdal::readOGR(dsn = file.path("Code_Walkthrough/COVID/data", "6674493c-ac73-4998-b33c-542767be56ff2020328-1-1e1htqf.0cjo.shp"), stringsAsFactors = F)
#https://opendata.arcgis.com/datasets/4779c505c43c40da9101ce53f34bb923_0.zip?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D
#http://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.zip?outSR={%22latestWkid%22:3857,%22wkid%22:102100}

tidy_electorate <- broom::tidy(shp, region = "ENGLISH_NA")


fn2 <- file.path("Code_Walkthrough/COVID/data", "IRE_counties.zip")
download.file('http://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.zip?outSR={%22latestWkid%22:3857,%22wkid%22:102100}', fn2)
utils::unzip(fn2, exdir = "Code_Walkthrough/COVID/data")
shp2 <-  rgdal::readOGR(dsn = "Code_Walkthrough/COVID/data/Covid19CountyStatisticsHPSCIreland.shp", stringsAsFactors = F)

shp2$TimeStamp <- as.Date(shp2$TimeStamp)

# ggplot() + geom_polygon(data = shp2, aes(x = long, y = lat, group = group, fil = ConfirmedCases), colour = "black", fill = NA) + theme_void()

latest_data <- shp2[shp2$TimeStamp >= max(shp2$TimeStamp) - 7,]
ggplot() + geom_polygon(data = latest_data, aes(x = long, y = lat, group = group, fill = Population), colour = "black") + theme_void()

tidy_covid <- broom::tidy(shp2, region = "CountyName", group = "TimeStamp", cases = ConfirmedCases)

ggplot() + geom_polygon(data = tidy_covd, aes(x = long, y = lat, group = group), colour = "black", fill = NA) + theme_void()

# Data with counties as point
covid_ireland2 <- readr::read_csv("http://opendata-geohive.hub.arcgis.com/datasets/4779c505c43c40da9101ce53f34bb923_0.csv?outSR={%22latestWkid%22:3857,%22wkid%22:102100}")





test_json <- jsonlite::fromJSON("https://services1.arcgis.com/eNO7HHeQ3rUcBllm/arcgis/rest/services/Covid19CountyStatisticsHPSCIreland/FeatureServer/0/query?where=1%3D1&outFields=OBJECTID,ORIGID,CountyName,PopulationCensus16,TimeStamp,ConfirmedCovidCases&returnGeometry=false&outSR=4326&f=json")
raw_covid_stats <- test_json$features$attributes
raw_covid_stats$TimeStamp  <- as.POSIXct(raw_covid_stats$TimeStamp/1000, origin = "1970-01-01", tz = "GMT")
max(raw_covid_stats$TimeStamp)




library(csodata)
library(tmap)
shp <- cso_get_geo("NUTS3")
t_test <- tm_shape(shp) + tm_fill(col = "TOTAL2011")
print(t_test)






sample_tidy <- lapply(covid_openddata_shpdata@polygons, function(x) cbind(x@Polygons[[1]]@coords, x@ID))
county_ids <- unique(covid_openddata_shpdata@data[, c("ORIGID","CountyName")])
for(i in 1:length(sample_tidy)){
  sample_tidy[[i]] <- data.frame(sample_tidy[[i]], stringsAsFactors = F)
  names(sample_tidy[[i]]) <- c("long", "lat", "id")
  sample_tidy[[i]]$id <- as.numeric(sample_tidy[[i]]$id)
  sample_tidy[[i]]$group <- i
  sample_tidy[[i]]$county <- county_ids[which(county_ids$ORIGID == (unique(sample_tidy[[i]]$id)+1)),"CountyName"]
}
county_polygon_data2 <- do.call(rbind, sample_tidy)

