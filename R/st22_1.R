library(tidyverse)
library(magrittr)
library(sf)

# #################################################
# boundaries Jan 2022
gem_22_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2022_01/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_HOHEITSGEBIET.shp")
# bezirk_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2022_01/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_BEZIRKSGEBIET.shp")
# canton_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2022_01/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_KANTONSGEBIET.shp")
# country_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2022_01/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_LANDESGEBIET.shp")

# gem_22_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2022_01/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_HOHEITSGEBIET_LV03.shp")
# bezirk_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2022_01/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_BEZIRKSGEBIET_LV03.shp")
# canton_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2022_01/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_KANTONSGEBIET_LV03.shp")
# country_20_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2022_01/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_LANDESGEBIET_LV03.shp")

nrow(gem_22_raw)
length(unique(gem_22_raw$BFS_NUMMER))

# plot(st_geometry(gem_22_raw))

gem_22 <- gem_22_raw %>% 
  st_zm(drop = TRUE) %>% 
  filter(ICC == "CH") %>% 
  filter(BFS_NUMMER < 9000) %>% 
  filter(OBJEKTART == "Gemeindegebiet") %>% 
  select(-ICC, -OBJEKTART) %>% 
  rename(GMDNR = BFS_NUMMER) %>% 
  arrange(GMDNR, GEM_TEIL)

any(is.na(st_dimension(gem_22)))
nrow(gem_22)
length(unique(gem_22$GMDNR))

View(st_drop_geometry(gem_22))
plot(st_geometry(gem_22))

gem_22 %>% 
  select(GMDNR, NAME) %>% 
  saveRDS("data/swisstopo/swissBOUNDARIES3D/gem_22.Rds")

# gem_22 %>% 
#   select(GMDNR) %>% 
#   st_write("data/swisstopo/swissBOUNDARIES3D/gem_22.shp", delete_dsn = TRUE)

lac20 <- gem_22_raw %>% 
  st_zm(drop = TRUE) %>% 
  rename(GMDNR = BFS_NUMMER) %>% 
  filter(GMDNR >= 9000)

plot(st_geometry(lac20))
View(st_drop_geometry(lac20))

rm(gem_22_raw)

# ###############################################
can_22_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2022_01/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_KANTONSGEBIET.shp")

nrow(can_22_raw)
length(unique(can_22_raw$KANTONSNUM))

# plot(st_geometry(gem_raw))

can_22 <- can_22_raw %>% 
  st_zm(drop = TRUE) %>% 
  filter(ICC == "CH") %>% 
  select(KANTONSNUM, KT_TEIL, NAME) %>% 
  arrange(KANTONSNUM, KT_TEIL)

any(is.na(st_dimension(can_22)))
nrow(can_22)
length(unique(can_22$KANTONSNUM))

View(st_drop_geometry(can_22))
plot(st_geometry(can_22))

# write_rds(can_22, "data/swisstopo/swissBOUNDARIES3D/can_22.Rds")

# can_22 %>% 
#   select(KANTONSNUM, KT_TEIL) %>% 
#   st_write("data/swisstopo/swissBOUNDARIES3D/can_22.shp", delete_dsn = TRUE)

rm(can_22_raw)