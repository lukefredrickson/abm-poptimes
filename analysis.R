library(tidyverse)

poptimes <- read_csv("tidy-places.csv")
poi <- c("bar", "restaurant", "supermarket", "church", "gym", "shopping_mall", "store", "department_store")

filter_poi <- function(type) {
  max_level <- 2
  return(poptimes %>% filter(poptimes[type] != 0 & poptimes[type] <= max_level))
}

filtered <- lapply(poi, filter_poi)

bar <- as.data.frame(filtered[match("bar", poi)])
restaurant <- as.data.frame(filtered[match("restaurant", poi)])
supermarket <- as.data.frame(filtered[match("supermarket", poi)])
gym <- as.data.frame(filtered[match("gym", poi)])
shopping_mall <- as.data.frame(filtered[match("shopping_mall", poi)])
department_store <- as.data.frame(filtered[match("department_store", poi)])
store <- union(shopping_mall, department_store)