library(tidyverse)
library(magrittr)
library(sf)

# #################################################
# boundaries 18
gem_18_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2018/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_HOHEITSGEBIET.shp")
# bezirk_18_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2018/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_BEZIRKSGEBIET.shp")
# canton_18_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2018/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_KANTONSGEBIET.shp")
# country_18_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2018/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_LANDESGEBIET.shp")

# gem_18_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2018/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_HOHEITSGEBIET_LV03.shp")
# bezirk_18_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2018/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_BEZIRKSGEBIET_LV03.shp")
# canton_18_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2018/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_KANTONSGEBIET_LV03.shp")
# country_18_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2018/DATEN/swissTLMRegio/SHAPEFILE_LV03/swissTLMRegio_LANDESGEBIET_LV03.shp")

nrow(gem_18_raw)
length(unique(gem_18_raw$BFS_NUMMER))

# plot(st_geometry(gem_18_raw))

gem18 <- gem_18_raw %>% 
  st_zm(drop = TRUE) %>% 
  filter(ICC == "CH") %>% 
  filter(BFS_NUMMER < 9000) %>% 
  filter(OBJEKTART == "Gemeindegebiet") %>% 
  select(BFS_NUMMER, NAME, GEM_TEIL) %>% 
  rename(GMDNR = BFS_NUMMER) %>% 
  arrange(GMDNR, GEM_TEIL)

any(is.na(st_dimension(gem18)))
nrow(gem18)
length(unique(gem18$GMDNR))

View(st_drop_geometry(gem18))
plot(st_geometry(gem18))

lac18 <- gem_18_raw %>% 
  st_zm(drop = TRUE) %>% 
  select(BFS_NUMMER, NAME, GEM_TEIL) %>% 
  rename(GMDNR = BFS_NUMMER) %>% 
  filter(GMDNR >= 9000)

plot(st_geometry(lac18))
View(st_drop_geometry(lac18))

gem18 %>% 
  # select(GMDNR) %>%
  saveRDS("data/swisstopo/swissBOUNDARIES3D/gem18.Rds")

# gem18 %>% 
#   select(GMDNR) %>%
#   st_write("data/swisstopo/swissBOUNDARIES3D/gem18.shp", delete_dsn = TRUE)

lac18 %>% 
  select(GMDNR) %>%
  saveRDS("data/swisstopo/swissBOUNDARIES3D/lac18.Rds")

# lac18 %>% 
#   select(GMDNR) %>% 
#   st_write("data/swisstopo/swissBOUNDARIES3D/lac18.shp", delete_dsn = TRUE)

rm(gem_18_raw)

# ###############################################
can_18_raw <- st_read("data-raw/swisstopo/swissBOUNDARIES3D/BOUNDARIES_2018/DATEN/swissBOUNDARIES3D/SHAPEFILE_LV95_LN02/swissBOUNDARIES3D_1_3_TLM_KANTONSGEBIET.shp")

nrow(can_18_raw)
length(unique(can_18_raw$KANTONSNUM))

# plot(st_geometry(gem_raw))

can_18 <- can_18_raw %>% 
  st_zm(drop = TRUE) %>% 
  filter(ICC == "CH") %>% 
  select(KANTONSNUM, KT_TEIL, NAME) %>% 
  arrange(KANTONSNUM, KT_TEIL)

any(is.na(st_dimension(can_18)))
nrow(can_18)
length(unique(can_18$KANTONSNUM))

View(st_drop_geometry(can_18))
plot(st_geometry(can_18))

# FR
can_18 %>% 
  filter(KANTONSNUM == 10) %>% 
  select(KT_TEIL) %>% 
  plot()

write_rds(can_18, "data/swisstopo/swissBOUNDARIES3D/can_18.Rds")

can_18 %>% 
  select(KANTONSNUM, KT_TEIL) %>% 
  st_write("data/swisstopo/swissBOUNDARIES3D/can_18.shp", delete_dsn = TRUE)

rm(can_18_raw)
