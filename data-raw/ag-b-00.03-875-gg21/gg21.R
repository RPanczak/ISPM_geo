library(dplyr)
library(sf)

gem_21 <- st_read("data-raw/ag-b-00.03-875-gg21/ggg_2021-LV95/shp/g1g21_21042021.shp") %>%
  select(GMDNR, GMDNAME) 

str(gem_21)
View(st_drop_geometry(gem_21))
plot(st_geometry(gem_21))

st_write(gem_21, "data/ag-b-00.03-875-gg21/gem_21.shp", delete_dsn = TRUE)

lake <- st_read("data-raw/ag-b-00.03-875-gg21/ggg_2021-LV95/shp/g1s21.shp") %>%
  select(GMDNR, GMDNAME)

str(lake)
View(st_drop_geometry(lake))
plot(st_geometry(lake))

st_write(lake, "data/ag-b-00.03-875-gg21/lake.shp", delete_dsn = TRUE)

canton <- st_read("data-raw/ag-b-00.03-875-gg20/ggg_2020-LV95/shp/g1k20.shp") %>%
  select(KTNAME)

str(canton)
View(st_drop_geometry(canton))
plot(st_geometry(canton))

st_write(canton, "data/ag-b-00.03-875-gg21/canton.shp", delete_dsn = TRUE)
