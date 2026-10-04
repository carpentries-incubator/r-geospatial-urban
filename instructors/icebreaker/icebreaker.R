#### 
###
### Write your favourite locations (place, country) between the quotation marks below:

Place_1 <- "Rotterdam, Netherlands"
Place_2 <- "Nyanga, Zimbabwe"
Place_3 <- "Munich, Germany"
Place_4 <- "Shanghai, China"

#### select the all the text in this document and click "Run" above (or Cmd+Enter).

library(osmdata)
library(tidyverse)
library(sf)
library(leaflet)

extract_central_coordinates <- function(place_name){
  bb <- getbb(place_name) |>
    as_tibble() |>
    mutate(med = (min + max)/2) |>
    select(med) |>
    as.list() 
}

coord_1 <- extract_central_coordinates(Place_1) 
location_1 <- st_point(coord_1$med)
coord_2 <- extract_central_coordinates(Place_2) 
location_2 <- st_point(coord_2$med)
coord_3 <- extract_central_coordinates(Place_3) 
location_3 <- st_point(coord_3$med)
coord_4 <- extract_central_coordinates(Place_4) 
location_4 <- st_point(coord_4$med)

all_places <- st_sfc(location_1, location_2, location_3, location_4) |>
  st_set_crs(4326) 

all_places_sf <- all_places |>
  st_sf() |>
  st_cast() 

polygon_all_places <- all_places_sf %>% 
  st_bbox() %>% 
  st_as_sfc()

central_location <- st_centroid(polygon_all_places)

leaflet() |>
  addTiles() |>
  addCircleMarkers(data=all_places_sf,
                   radius = 10,
                   color = "#0052D6",
                   stroke = FALSE, fillOpacity = 0.5) |>
  addCircleMarkers(data=central_location,
                   radius = 10,
                   color = "#FFA500",
                   stroke = FALSE, fillOpacity = 0.5)
  

