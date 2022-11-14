# From Alan Haynes

# I used geofacet::grid_auto and geofacet::grid_design to create the medstat grid. Grid_auto ran for ca 10 hours I think. I then had to spend about 4 hours probably manually rearranging them so that the cantons were (almost) contiguous with grid_design (a nice interactive javascript thing). Grid_auto seems to prioritise overall shape, which had pretty horrible consequences for cantons with many small medstat regions… (parts of Geneva in Wallis, Aargau spread across eastern Switzerland...)
# With the 101 arbeitsmarktregionen I would expect grid_auto to be much faster… and the manual part to be much quicker too. 

library(geofacet)
library(ggplot2)
library(patchwork)

x <- grid_auto(shp, names = "medstat", seed = 100)
grid_preview(x)
x$name_canton <- substr(x$name_MedStat, 1, 2)
x$code_medstat <- x$name_MedStat

ggplot(x, aes(x = col, y = -row, fill = name_canton)) +
  geom_tile() +
  coord_equal() +
  scale_fill_manual(values = as.character(pals::alphabet(26)))

# iterate with grid_design to improve the grid, save the modified grid as medstat_geofacet_edit1.csv
grid_design(x)
x <- read.csv("medstat_geofacet_edit1.csv")

g <- ggplot() +
  geom_tile(data = x, 
            aes(x = col, y = -row, fill = name_canton),
            col = "grey") +
  coord_equal() +
  scale_fill_manual(values = as.character(pals::alphabet(26))) +
  theme(axis.text = element_blank(),
        axis.title = element_blank()) +
  labs(fill = "Canton")

r <- ggplot() +
  geom_sf(data = sfshp, mapping = aes(fill = substring(medstat, 1, 2))) +
  scale_fill_manual(values = as.character(pals::alphabet(26))) +
  theme(axis.text = element_blank()) +
  labs(fill = "Canton")

r / g + 
  plot_annotation(title = "Swiss MedStat regions in reality and as a grid",
                  subtitle = "The grid representation depicts all MedStat regions as the same size\n(similar to it's population - MedStat regions contain ca 10,000 persons)")

