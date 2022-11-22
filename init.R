library(tidyverse)

bahnhof <- read.csv("./data/bahnhof.csv", sep = ";")
plz_einwohner <- read.csv("./data/plz_einwohner.csv")

bahnhof_einwohner <- merge(bahnhof, plz_einwohner, by.x = "PLZ", by.y = "plz")

