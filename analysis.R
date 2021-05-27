library(tidyverse)

poptimes <- read_csv("tidy-places.csv")
poi <- c("bar", "restaurant", "supermarket", "church", "gym", "shopping_mall", "store", "department_store")

filter_poi <- function(type, max_level) {
  return(poptimes %>% filter(poptimes[type] != 0 & poptimes[type] <= max_level))
}

bars <- filter_poi("bar", 2)
restaurant <- filter_poi("restaurant", 2)

p <- poptimes %>% filter(poptimes$bar > 0 & poptimes$restaurant == 0)
