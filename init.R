library(tidyverse)
library(ggmap)
library(broom)
library(sf)

bahnhof <- read.csv("./data/bahnhof.csv", sep = ";")
plz_einwohner <- read.csv("./data/plz_einwohner.csv")

bahnhof_einwohner <- merge(bahnhof, plz_einwohner, by.x = "PLZ", by.y = "plz")

# locations <- geocode(paste(bahnhof$Straße, bahnhof$Ort, sep = " "))
# write_csv(locations, "data/locations.csv")

stations_geo_loc <- read_csv("data/locations.csv")

german_states <- st_read(dsn = "data/german_states/")
german_states$name_1[german_states$id_1 == "1"] <- "Baden-Württemberg"
german_states$name_1[german_states$id_1 == "16"] <- "Thüringen"
german_states$population <- c(
  11124642,
  13176989,
  3677472,
  2537868,
  676463,
  1853935,
  6295017,
  1611160,
  8027031,
  17924591,
  4106485,
  982348,
  4043002,
  2169253,
  2922005,
  2108863
)

# Geolocation of all stations
ggplot() + 
  geom_sf(data = german_states) +
  geom_point(stations_geo_loc[stations_geo_loc$lon > 0, ], mapping = aes(x = lon, y = lat))

german_states_weighted <- left_join(
  german_states, 
  bahnhof %>% 
    count(Bundesland),
  by = c("name_1" = "Bundesland")
)

# Heatmap of station density
ggplot() + 
  geom_sf(data = german_states_weighted, aes(fill = n/population))


