library(tidyverse)
library(tidyjson)

# function to ease reading in multiple json files from the python poptimes library
read_places_json <- function(place_type) {
  filename <- paste("btv-", place_type, ".json", sep="")
  return(read_json(filename) %>% gather_array)
}
# read json files
place_files <- c("bar", "cafe", "restaurant", "supermarket")
places_json <- lapply(place_files, read_places_json)
# list of all possible google maps place types
place_types <- scan("place-types.txt", what="", sep="\n")

tidy_places_json <- function(places_json) {
  tidy_df <- as.data.frame(places_json %>%
    spread_all %>% 
    select(array.index, id, name, address)) %>% 
    select(!c(..JSON))
  
  times <- places_json %>% 
    enter_object(populartimes) %>% 
    gather_array %>% 
    enter_object(data) %>% 
    gather_array %>% 
    append_values_number("value") %>% 
    select(!c(document.id))
  
  times_wide <- as.data.frame(times) %>% 
    select(!c(..JSON)) %>% 
    pivot_wider(names_from = c(array.index.2, array.index.3), values_from = value)
  
  time_spent <- places_json %>% 
    enter_object(time_spent) %>% 
    gather_array %>% 
    append_values_number("value") %>% 
    select(!c(document.id))
  
  time_spent_wide <- as.data.frame(time_spent) %>% 
    select(!c(..JSON)) %>% 
    pivot_wider(names_from = array.index.2, names_prefix="time_spent_", values_from = value)
  
  tidy_df[place_types] <- 0
  
  types <- places_json %>% 
    enter_object(types) %>% 
    gather_array() %>% 
    append_values_string("type") %>% 
    select(!c(document.id))
  types <- as.data.frame(types)
  
  rownum <- 0
  for (i in 1:nrow(types)) {
    rownum <- types[i, "array.index"]
    location_num <- types[i, "array.index.2"]
    type <- types[i, "type"]
    if (type %in% colnames(tidy_df)) {
      tidy_df[rownum, type] = location_num
    }
  }
  
  tidy_df <- tidy_df %>% 
    left_join(time_spent_wide, by="array.index") %>% 
    left_join(times_wide, by="array.index") %>% select(-c(array.index))
  
  return(tidy_df)
}

combine_places <- function(tidy_places_vec) {
  tidy_places <- as.data.frame(tidy_places_vec[1])
  for (i in 2:length(tidy_places_vec)) {
    tidy_places <- union(tidy_places, as.data.frame(tidy_places_vec[i]))
  }
  return(tidy_places)
}

tidy_places_vec <- lapply(places_json, tidy_places_json)
tidy_places <- combine_places(tidy_places_vec)

write_csv(tidy_places, "tidy-places.csv")
