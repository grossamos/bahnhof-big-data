library(tidyverse)
library(ggmap)
library(broom)
library(sf)

############################
# Loading + Cleansing Data #
############################

bahnhof <- read_delim("./data/bahnhof.csv", delim = ";")
sapply(bahnhof, function(x) (sum(is.na(x))))

# Feldkirchener Straße
length(unique(bahnhof$`Bf. Nr.`)) == nrow(bahnhof)
bahnhof[bahnhof$`Bf. Nr.` == "8268", c("PLZ", "Ort")] <- list(60549, "Frankfurt")
bahnhof[bahnhof$`Bf. Nr.` == "8353", c("Straße", "PLZ", "Ort")] <- list("Vareler Straße", 26349, "Jaderberg")
bahnhof[bahnhof$`Bf. Nr.` == "8256", c("Straße", "PLZ", "Ort")] <- list("Oberaustraße", 83026, "Rosenheim")
bahnhof[bahnhof$`Bf. Nr.` == "8298", c("Straße", "PLZ", "Ort")] <- list("Schlosswald 20z", 09114, "Chemnitz")
bahnhof[bahnhof$`Bf. Nr.` == "8276", c("Straße", "PLZ", "Ort")] <- list("Mockauer Straße 123", 04357, "Leipzig")
bahnhof[bahnhof$`Bf. Nr.` == "8233", c("Straße", "PLZ", "Ort")] <- list("Am Stadtrand", 06406, "Bernburg")
bahnhof[bahnhof$`Bf. Nr.` == "8288", c("Straße", "PLZ", "Ort", "Bf DS 100Abk.")] <- list("Mühlenweg 4", 48734, "Reken", "EREK")
bahnhof[bahnhof$`Bf. Nr.` == "8314", "Straße"] <- "Zweibrückenstraße 13"
bahnhof[bahnhof$`Bf. Nr.` == "5827", "Straße"] <- "Feldkirchener Straße"

bahnhof # Datentypen ergeben sinn

# Code um geolocation von bahnhöfen zu kriegen
# locations <- geocode(paste(bahnhof$Straße, bahnhof$Ort, sep = " "))
# write_csv(locations, "data/locations.csv")

stations_geo_loc <- read_csv("data/locations.csv")
# filter stations which google maps couldn't find
stations_geo_loc <- stations_geo_loc[!is.na(stations_geo_loc$lon), ]

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

german_plz <- st_read("./data/german_plz")

bahnhof %>%
  count(PLZ) 

german_plz_weighted <- left_join(
  german_plz %>%
    mutate_at(vars(plz), as.double),
  bahnhof %>%
    count(PLZ) %>%
    replace_na(list(n = 0)),
  by = c("plz" = "PLZ")
)

bahnhof %>%
  select(PLZ, Bundesland)
  count(PLZ) 

german_plz_weighted <- german_plz_weighted %>%
  mutate(
    ratio = n/einwohner
  )

# obersten 2 sind flughäfen
german_plz_weighted %>% arrange(desc(ratio))

# wir sehen wesentlich breiteren ausbau im osten (mehr plz haben bahnhöfe)
ggplot() +
  geom_sf(data = german_plz_weighted, aes(fill = ratio)) 

# aber potentielle probleme: plz sind größer und es gibt pro fläche weniger einwohner

# plz größe ost vs west 


bahnhof %>%
  filter(grepl("Bahnhof", Straße)) %>%
  count(.) / nrow(bahnhof)

