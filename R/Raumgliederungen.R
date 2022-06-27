library(readr)
library(readxl)
library(dplyr)
library(janitor)

raum_18 <- read_xlsx("data-raw/Raumgliederungen/2018-01-01_raumgliederungen.xlsx", 
                     skip = 1, 
                      col_types = c("numeric", "text", "numeric", 
                                    "text", "numeric", "text", "numeric", 
                                    "numeric", "text", "numeric", "numeric")) %>% 
  clean_names() %>% 
  remove_empty() %>% 
  filter(!is.na(bfs_gde_nummer))

View(raum_18)

write_rds(raum_18, "data/Raumgliederungen/raum_18.Rds")

raum_20 <- read_xlsx("data-raw/Raumgliederungen/2020-01-01_raumgliederungen.xlsx", 
                     skip = 1, 
                     col_types = c("numeric", "text", "numeric", 
                                   "text", "numeric", "text", "numeric", 
                                   "numeric", "text", "numeric", "numeric")) %>% 
  clean_names() %>% 
  remove_empty() %>% 
  filter(!is.na(bfs_gde_nummer))

View(raum_20)

write_rds(raum_20, "data/Raumgliederungen/raum_20.Rds")

agglo_21 <- read_excel("data-raw/Raumgliederungen/2021-04-18_agglo.xlsx", 
                       col_types = c("numeric", "text", "numeric", 
                                     "text", "numeric", "text", "numeric"),
                       skip = 1) %>% 
  clean_names() %>% 
  remove_empty() %>% 
  filter(!is.na(bfs_gde_nummer))

View(agglo_21)

write_rds(agglo_21, "data/Raumgliederungen/agglo_21.Rds")
