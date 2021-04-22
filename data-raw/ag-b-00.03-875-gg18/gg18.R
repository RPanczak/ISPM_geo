library(dplyr)
library(readr)
library(sf)

gem_18 <- st_read("data-raw/ag-b-00.03-875-gg18/ggg_2018-LV95/shp/g1g18.shp") %>%
  select(GMDNR, GMDNAME) 

str(gem_18)
# View(st_drop_geometry(gem_18))
plot(st_geometry(gem_18))

# st_write(gem_18, "data/ag-b-00.03-875-gg18/gem_18.shp", delete_dsn = TRUE)
write_rds(gem_18, "data/ag-b-00.03-875-gg18/gem_18.Rds")

lake_18 <- st_read("data-raw/ag-b-00.03-875-gg18/ggg_2018-LV95/shp/g1s18.shp") %>%
  select(SEENR, SEENAME)

str(lake_18)
# View(st_drop_geometry(lake_18))
plot(st_geometry(lake_18))

# st_write(lake_18, "data/ag-b-00.03-875-gg18/lake_18.shp", delete_dsn = TRUE)
write_rds(lake_18, "data/ag-b-00.03-875-gg18/lake_18.Rds")

canton_18 <- st_read("data-raw/ag-b-00.03-875-gg20/ggg_2020-LV95/shp/g1k20.shp") %>%
  select(KTNR, KTNAME)

str(canton_18)
# View(st_drop_geometry(canton_18))
plot(st_geometry(canton_18))

# st_write(canton_18, "data/ag-b-00.03-875-gg18/canton_18.shp", delete_dsn = TRUE)
write_rds(canton_18, "data/ag-b-00.03-875-gg18/canton_18.Rds")
