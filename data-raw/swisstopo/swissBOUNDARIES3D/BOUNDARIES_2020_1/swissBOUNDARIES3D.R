library(tidyverse)
library(magrittr)
library(sf)

# #################################################
# boundaries 20 january
gem_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_HOHEITSGEBIET.shp")
# bezirk_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_BEZIRKSGEBIET.shp")
# canton_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_KANTONSGEBIET.shp")
# country_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_LANDESGEBIET.shp")

# gem_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_HOHEITSGEBIET_LV03.shp")
# bezirk_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_BEZIRKSGEBIET_LV03.shp")
# canton_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_KANTONSGEBIET_LV03.shp")
# country_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_LANDESGEBIET_LV03.shp")

nrow(gem_20_raw)
length(unique(gem_20_raw$BFS_NUMMER))

# plot(st_geometry(gem_20_raw))

gem20 <- gem_20_raw %>% 
  st_zm(drop = TRUE) %>% 
  filter(ICC == "CH") %>% 
  filter(BFS_NUMMER < 9000) %>% 
  filter(OBJEKTART == "Gemeindegebiet") %>% 
  select(-ICC, OBJEKTART) %>% 
  rename(GMDNR = BFS_NUMMER) %>% 
  arrange(GMDNR, GEM_TEIL)

any(is.na(st_dimension(gem20)))
nrow(gem20)
length(unique(gem20$GMDNR))

View(st_drop_geometry(gem20))
plot(st_geometry(gem20))

# Monthey - multi polygon example
gem20 %>% 
  filter(GMDNR == 6153) %>% 
  select(GEM_TEIL) %>% 
  plot()

lac20 <- gem_20_raw %>% 
  st_zm(drop = TRUE) %>% 
  rename(GMDNR = BFS_NUMMER) %>% 
  filter(GMDNR >= 9000)

plot(st_geometry(lac20))
View(st_drop_geometry(lac20))

gem20 %>% 
  select(GMDNR) %>% 
  saveRDS("data/swisstopo/swissBOUNDARIES3D/gem20.Rds")

gem20 %>% 
  select(GMDNR) %>% 
  st_write("data/swisstopo/swissBOUNDARIES3D/gem20.shp", delete_dsn = TRUE)

# lac20 %>% 
#   select(GMDNR) %>% 
#   st_write("data/swisstopo/swissBOUNDARIES3D/lac20.shp", delete_dsn = TRUE)

rm(gem_20_raw)

# ###############################################
can_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2020_1/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_KANTONSGEBIET.shp")

nrow(can_20_raw)
length(unique(can_20_raw$KANTONSNUM))

# plot(st_geometry(gem_raw))

can_20 <- can_20_raw %>% 
  st_zm(drop = TRUE) %>% 
  filter(ICC == "CH") %>% 
  select(KANTONSNUM, KT_TEIL, NAME) %>% 
  arrange(KANTONSNUM, KT_TEIL)

any(is.na(st_dimension(can_20)))
nrow(can_20)
length(unique(can_20$KANTONSNUM))

View(st_drop_geometry(can_20))
plot(st_geometry(can_20))

# FR
can_20 %>% 
  filter(KANTONSNUM == 10) %>% 
  select(KT_TEIL) %>% 
  plot()

write_rds(can_20, "data/swisstopo/swissBOUNDARIES3D/can_20.Rds")

can_20 %>% 
  select(KANTONSNUM, KT_TEIL) %>% 
  st_write("data/swisstopo/swissBOUNDARIES3D/can_20.shp", delete_dsn = TRUE)

rm(can_20_raw)
