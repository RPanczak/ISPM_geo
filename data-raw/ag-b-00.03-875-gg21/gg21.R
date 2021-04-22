library(dplyr)
library(readr)
library(sf)

gem_21 <- st_read("data-raw/ag-b-00.03-875-gg21/ggg_2021-LV95/shp/g1g21_18042021.shp") %>%
  select(GMDNR, GMDNAME) 

str(gem_21)
# View(st_drop_geometry(gem_21))
plot(st_geometry(gem_21))

# st_write(gem_21, "data/ag-b-00.03-875-gg21/gem_21.shp", delete_dsn = TRUE)
write_rds(gem_21, "data/ag-b-00.03-875-gg21/gem_21.Rds")

lake_21 <- st_read("data-raw/ag-b-00.03-875-gg21/ggg_2021-LV95/shp/g1s21.shp") %>%
  select(GMDNR, GMDNAME)

str(lake_21)
# View(st_drop_geometry(lake_21))
plot(st_geometry(lake_21))

# st_write(lake_21, "data/ag-b-00.03-875-gg21/lake_21.shp", delete_dsn = TRUE)
write_rds(lake_21, "data/ag-b-00.03-875-gg21/lake_21.Rds")

canton_21 <- st_read("data-raw/ag-b-00.03-875-gg20/ggg_2020-LV95/shp/g1k20.shp") %>%
  select(KTNR, KTNAME)

str(canton_21)
# View(st_drop_geometry(canton_21))
plot(st_geometry(canton_21))

# st_write(canton_21, "data/ag-b-00.03-875-gg21/canton_21.shp", delete_dsn = TRUE)
write_rds(canton_21, "data/ag-b-00.03-875-gg21/canton_21.Rds")
