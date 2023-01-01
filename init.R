library(tidyverse)
library(ggmap)
library(broom)
library(sf)
library(cowplot)

############################
# Loading + Cleansing Data #
############################

# plz als char um start mit 0 besser zu erkennen
bahnhof <- read_delim("./data/bahnhof.csv", delim = ";", col_types = "cccdccdcccc")
sapply(german_plz_weighted, function(x) (sum(is.na(x))))

# Feldkirchener Straße
length(unique(bahnhof$`Bf. Nr.`)) == nrow(bahnhof)
bahnhof[bahnhof$`Bf. Nr.` == "8268", c("PLZ", "Ort")] <- list("60549", "Frankfurt")
bahnhof[bahnhof$`Bf. Nr.` == "8353", c("Straße", "PLZ", "Ort")] <- list("Vareler Straße", "26349", "Jaderberg")
bahnhof[bahnhof$`Bf. Nr.` == "8256", c("Straße", "PLZ", "Ort")] <- list("Oberaustraße", "83026", "Rosenheim")
bahnhof[bahnhof$`Bf. Nr.` == "8298", c("Straße", "PLZ", "Ort")] <- list("Schlosswald 20z", "09114", "Chemnitz")
bahnhof[bahnhof$`Bf. Nr.` == "8276", c("Straße", "PLZ", "Ort")] <- list("Mockauer Straße 123", "04357", "Leipzig")
bahnhof[bahnhof$`Bf. Nr.` == "8233", c("Straße", "PLZ", "Ort")] <- list("Am Stadtrand", "06406", "Bernburg")
bahnhof[bahnhof$`Bf. Nr.` == "8288", c("Straße", "PLZ", "Ort", "Bf DS 100Abk.")] <- list("Mühlenweg 4", "48734", "Reken", "EREK")
bahnhof[bahnhof$`Bf. Nr.` == "8314", "Straße"] <- "Zweibrückenstraße 13"
bahnhof[bahnhof$`Bf. Nr.` == "5827", "Straße"] <- "Feldkirchener Straße"
bahnhof$PLZ[nchar(bahnhof$PLZ) == 4] <- paste("0", bahnhof$PLZ[nchar(bahnhof$PLZ) == 4], sep = "")

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

german_states$area <- c(
  35747.83,
  70541.57,
  891.12,
  29654.43,
  419.37,
  755.09,
  21115.64,
  23295.22,
  47709.80,
  34112.44,
  19858,
  2571.11,
  18449.93,
  20456.51,
  15800.54,
  16202.35
)

# Geolocation of all stations
## filter out outlier
stations_geo_loc <- stations_geo_loc[!stations_geo_loc$bahnhof_index %in% c(4651,654,1937,2794,2807,3080,184,4851,559,3622,2703,2305,3494,3160,3084), ]

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
p1 <- ggplot(data = german_states_weighted) + 
  geom_sf(
    aes(fill = population/n)
  ) +
  theme(legend.position = "bottom")

p2 <- ggplot(data = german_states_weighted) + 
  geom_sf(
    aes(fill = population/area)
  ) +
  theme(legend.position = "bottom")

p3 <- ggplot(data = german_states_weighted) + 
  geom_sf(
    aes(fill = n/area)
  ) +
  theme(legend.position = "bottom")

plot_grid(p2, p3, p1, nrow = 1)


# mehr granulatität durch postleitzahlen
german_plz <- st_read("./data/german_plz")

german_plz_weighted <- left_join(
  german_plz,
  bahnhof %>%
    count(PLZ) %>%
    replace_na(list(n = 0)),
  by = c("plz" = "PLZ")
)

german_plz_weighted <- german_plz_weighted %>%
  mutate(
    ratio1 = einwohner/n,
    ratio2 = einwohner/qkm,
    ratio3 = n/qkm,
  ) %>%
  replace_na(list(n = 0, ratio1 = 0, ratio2 = 0, ratio3 = 0))

# TODO (obersten 2 sind flughäfen)
# german_plz_weighted %>% arrange((ratio2))

# wir sehen wesentlich breiteren ausbau im osten (mehr plz haben bahnhöfe)
p1 <- ggplot(data = german_plz_weighted) +
  geom_sf(
    aes(fill = ratio1), 
    linewidth = 0.01
  ) +
  theme(legend.position = "bottom")

p2 <- ggplot(data = german_plz_weighted) +
  geom_sf(
    aes(fill = ratio2), 
    linewidth = 0.00001
  ) +
  scale_fill_gradient(name = "Bevölkerungsdichte", trans = "log") +
  theme(legend.position = "bottom")

p3 <- ggplot(data = german_plz_weighted) +
  geom_sf(
    aes(fill = ratio3), 
    linewidth = 0.01
  ) +
  theme(legend.position = "bottom")

plot_grid(p2, p3, p1, nrow = 1)

# aber potentielle probleme: plz sind größer und es gibt pro fläche weniger einwohner

# plz größe ost vs west 

p2

bahnhof %>%
  filter(grepl("Bahnhof", Straße)) %>%
  count(.) / nrow(bahnhof)

