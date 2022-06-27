library(tidyverse)
library(magrittr)
library(sf)
library(tmap)
tmap_mode("view")

# #################################################
# testing

# testing <- st_read("data-raw/PLZ/20210101/PLZO_SHP_LV95/PLZO_PLZ.shp")
# 
# summary(testing$PLZ)
# 
# any(is.na(st_dimension(testing)))
# 
# # FL
# testing %>%
#   filter(PLZ>= 9485 & PLZ <= 9499) %>%
#   qtm()
# 
# # lakes
# testing %>%
#   filter(PLZ == 9999) %>%
#   qtm(fill = "blue", borders = "blue")
# 
# testing %<>% 
#   select(PLZ) %>% 
#   filter(PLZ != 9999) %>% 
#   filter(PLZ < 9485 | PLZ > 9499)
# 
# # funny ones
# testing %>%
#   filter(PLZ %in% c(8238)) %>%
#   qtm(fill = NULL, borders = "red")
# 
# # multipart features!
# nrow(testing)
# length(unique(testing$PLZ))
# 
# rm(testing)

# #################################################
# read func
# at the mo it needs "202010" as argument
# add checks fo rcorrect arg
# maybe convert to string if user adds nummeric
# fancy pantsy regex check for input could be an option too?

read_plz <- function(plz_date) {
  
  path <- paste0("data-raw/PLZ/", plz_date, "001/PLZO_SHP_LV95/PLZO_PLZ.shp")
  
  plz_raw <- sf::st_read("data-raw/PLZ/20201001/PLZO_SHP_LV95/PLZO_PLZ.shp",
                     quiet = TRUE) 
  
  plz <- plz_raw %>% 
    dplyr::select(PLZ) %>%
    dplyr::filter(PLZ != 9999) %>%
    dplyr::filter(PLZ < 9485 | PLZ > 9499)
  
  raw_features <- nrow(plz_raw)
  raw_distinct <- length(unique(plz_raw$PLZ))
  plz_features <- nrow(plz)
  plz_distinct <- length(unique(plz$PLZ))
  
  print(paste0("Processing data from: ", path))
  print(paste0("Raw dataset of ", raw_features, " features representing ",
               raw_distinct, " postcodes"))
  print(paste0("Processed to ", plz_features, " features representing ",
               plz_distinct, " postcodes"))  
  plz

}

# #################################################
# boundaries 2020-10

plz_20_10 <- read_plz("202010")

# plot(st_geometry(plz_20_10))
qtm(plz_20_10)
# View(st_drop_geometry(plz_20_10))
# View(plz_20_10)

plz_20_10 %>% 
  write_rds("data/PLZ/plz_20_10.Rds")

# plz_20_10 %>% 
#   st_write("data/PLZ/plz_20_10.shp", delete_dsn = TRUE)

# #################################################
# boundaries 2021-01

plz_21_01 <- read_plz("202101")

# plot(st_geometry(plz_21_01))
qtm(plz_21_01)
# View(st_drop_geometry(plz_21_01))
# View(plz_21_01)

plz_21_01 %>% 
  write_rds("data/PLZ/plz_21_01.Rds")

# plz_21_01 %>% 
#   st_write("data/PLZ/plz_21_01.shp", delete_dsn = TRUE)

# #################################################
# boundaries 2022-06

plz_22_06 <- read_plz("202206")

# plot(st_geometry(plz_22_06))
qtm(plz_22_06)
# View(st_drop_geometry(plz_22_06))
# View(plz_22_06)

# 1000 - multi polygon example
plz_22_06 %>% 
  filter(PLZ == 1000) %>% 
  qtm(fill = NULL, borders = "red")

plz_22_06 %>% 
  write_rds("data/PLZ/plz_22_06.Rds")

# plz_22_06 %>% 
#   st_write("data/PLZ/plz_22_06.shp", delete_dsn = TRUE)
