library(dplyr)
library(readr)
library(sf)
library(ggplot2)
library(RColorBrewer)

# #################################################
# statpop figures needed for carto weights

statpop18 <- read_csv("data-raw/statpop-open/ag-b-00.03-vz2018statpop/STATPOP2018_GMDE.csv") %>%
  select(GDENR, B18BTOT) %>%
  rename(GMDNR = GDENR)

str(statpop18)
View(statpop18)

# Staatswald Galm
# C'za Cadenazzo/Monteceneri
# C'za Capriasca/Lugano

# #################################################
# shape files for cartogram input

gem <- st_read("data-raw/ag-b-00.03-875-gg18/ggg_2018-LV95/shp/g1g18.shp",
               options = "ENCODING=WINDOWS-1252") %>%
  select(GMDNR, GMDNAME) %>%
  left_join(statpop18) %>%
  filter(!is.na(B18BTOT))

str(gem)
View(st_drop_geometry(gem))

st_write(gem, "data/ag-b-00.03-875-gg18/gem-statpop-18.shp", delete_dsn = TRUE)

lake <- st_read("data-raw/ag-b-00.03-875-gg18/ggg_2018-LV95/shp/g1s18.shp",
                options = "ENCODING=WINDOWS-1252") %>%
  select(SEENAME)

st_write(lake, "data/ag-b-00.03-875-gg18/lake.shp", delete_dsn = TRUE)

canton <- st_read("data-raw/ag-b-00.03-875-gg20/ggg_2020-LV95/shp/g1k20.shp",
                  options = "ENCODING=WINDOWS-1252") %>%
  select(KTNAME)

st_write(canton, "data/ag-b-00.03-875-gg18/canton.shp", delete_dsn = TRUE)

# #################################################


# #################################################
# shape files from scapetoad

gem_carto <- st_read("data/ag-b-00.03-875-gg18/gem-statpop-18-carto.shp",
                     options = "ENCODING=WINDOWS-1252") %>% 
  select(-B18BTOTDens, -SizeError)

lake_carto <- st_read("data/ag-b-00.03-875-gg18/lake-carto.shp",
                      options = "ENCODING=WINDOWS-1252")

canton_carto <- st_read("data/ag-b-00.03-875-gg18/canton-carto.shp",
                        options = "ENCODING=WINDOWS-1252")

plot(st_geometry(gem_carto))
plot(st_geometry(lake_carto), add = TRUE, col = "lightblue", border = NA)

plot(st_geometry(lake_carto), col = "lightblue", border = NA)
plot(st_geometry(canton_carto), add = TRUE, col = NA, border = "grey40")
