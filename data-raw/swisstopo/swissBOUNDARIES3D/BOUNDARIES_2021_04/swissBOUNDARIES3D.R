library(tidyverse)
library(magrittr)
library(sf)

# #################################################
# boundaries Apr 2021
gem_21_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2021_04/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_HOHEITSGEBIET.shp")
# bezirk_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2021_04/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_BEZIRKSGEBIET.shp")
# canton_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2021_04/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_KANTONSGEBIET.shp")
# country_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2021_04/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_LANDESGEBIET.shp")

# gem_21_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2021_04/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_HOHEITSGEBIET_LV03.shp")
# bezirk_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2021_04/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_BEZIRKSGEBIET_LV03.shp")
# canton_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2021_04/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_KANTONSGEBIET_LV03.shp")
# country_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2021_04/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_LANDESGEBIET_LV03.shp")

nrow(gem_21_raw)
length(unique(gem_21_raw$BFS_NUMMER))

# plot(st_geometry(gem_21_raw))

gem_21 <- gem_21_raw %>% 
  st_zm(drop = TRUE) %>% 
  filter(ICC == "CH") %>% 
  filter(BFS_NUMMER < 9000) %>% 
  filter(OBJEKTART == "Gemeindegebiet") %>% 
  select(-ICC, OBJEKTART) %>% 
  rename(GMDNR = BFS_NUMMER) %>% 
  arrange(GMDNR, GEM_TEIL)

any(is.na(st_dimension(gem_21)))
nrow(gem_21)
length(unique(gem_21$GMDNR))

View(st_drop_geometry(gem_21))
plot(st_geometry(gem_21))

# Monthey - multi polygon example
gem_21 %>% 
  filter(GMDNR == 6153) %>% 
  select(GEM_TEIL) %>% 
  plot()

lac20 <- gem_21_raw %>% 
  st_zm(drop = TRUE) %>% 
  rename(GMDNR = BFS_NUMMER) %>% 
  filter(GMDNR >= 9000)

plot(st_geometry(lac20))
View(st_drop_geometry(lac20))

gem_21 %>% 
  select(GMDNR) %>% 
  saveRDS("data/swisstopo/swissBOUNDARIES3D/gem_21.Rds")

gem_21 %>% 
  select(GMDNR) %>% 
  st_write("data/swisstopo/swissBOUNDARIES3D/gem_21.shp", delete_dsn = TRUE)

# lac20 %>% 
#   select(GMDNR) %>% 
#   st_write("data/swisstopo/swissBOUNDARIES3D/lac20.shp", delete_dsn = TRUE)

rm(gem_21_raw)

# ###############################################
can_21_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2021_04/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_KANTONSGEBIET.shp")

nrow(can_21_raw)
length(unique(can_21_raw$KANTONSNUM))

# plot(st_geometry(gem_raw))

can_21 <- can_21_raw %>% 
  st_zm(drop = TRUE) %>% 
  filter(ICC == "CH") %>% 
  select(KANTONSNUM, KT_TEIL, NAME) %>% 
  arrange(KANTONSNUM, KT_TEIL)

any(is.na(st_dimension(can_21)))
nrow(can_21)
length(unique(can_21$KANTONSNUM))

View(st_drop_geometry(can_21))
plot(st_geometry(can_21))

# FR
can_21 %>% 
  filter(KANTONSNUM == 10) %>% 
  select(KT_TEIL) %>% 
  plot()

write_rds(can_21, "data/swisstopo/swissBOUNDARIES3D/can_21.Rds")

can_21 %>% 
  select(KANTONSNUM, KT_TEIL) %>% 
  st_write("data/swisstopo/swissBOUNDARIES3D/can_21.shp", delete_dsn = TRUE)

rm(can_21_raw)