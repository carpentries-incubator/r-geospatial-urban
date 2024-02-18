---
title: 'Explore and plot by vector layer attributes'
teaching: 30
exercises: 20
---




:::::::::::::::::::::::::::::::::::::: questions 

- How can I examine the attributes of a vector layer?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After completing this episode, participants should be able to…

- Query attributes of a vector object.

- Subset vector objects using specific attribute values.

- Plot a vector feature, colored by unique attribute values.

::::::::::::::::::::::::::::::::::::::::::::::::

# Query Vector Feature Metadata

Let's have a look at the content of the loaded data, starting with `lines_Delft`. In essence, an `"sf"` object is a data.frame with a "sticky" geometry column and some extra metadata, like the CRS, extent and geometry type we examined earlier.


```r
lines_Delft
```

```{.output}
Simple feature collection with 11244 features and 2 fields
Geometry type: LINESTRING
Dimension:     XY
Bounding box:  xmin: 81759.58 ymin: 441223.1 xmax: 89081.41 ymax: 449845.8
Projected CRS: Amersfoort / RD New
First 10 features:
    osm_id  highway                       geometry
1  4239535 cycleway LINESTRING (86399.68 448599...
2  4239536 cycleway LINESTRING (85493.66 448740...
3  4239537 cycleway LINESTRING (85493.66 448740...
4  4239620  footway LINESTRING (86299.01 448536...
5  4239621  footway LINESTRING (86307.35 448738...
6  4239674  footway LINESTRING (86299.01 448536...
7  4310407  service LINESTRING (84049.47 447778...
8  4310808    steps LINESTRING (84588.83 447828...
9  4348553  footway LINESTRING (84527.26 447861...
10 4348575  footway LINESTRING (84500.15 447255...
```

This means that we can examine and manipulate them as data frames. For instance, we can look at the number of variables (columns in a data frame) with `ncol()`.


```r
ncol(lines_Delft)
```

```{.output}
[1] 3
```

In the case of `point_Delft` those columns are `"osm_id"`, `"highway"` and `"geometry"`. We can check the names of the columns with the base R function `names()`.


```r
names(lines_Delft)
```

```{.output}
[1] "osm_id"   "highway"  "geometry"
```

::: callout

Note that in R the geometry is just another column and counts towards the number
returned by `ncol()`. This is different from GIS software with graphical user 
interfaces, where the geometry is displayed in a viewport not as a column in the 
attribute table.

:::

We can also preview the content of the object by looking at the first 6 rows with the `head()` function, which in the case of an `sf` object is similar to examining the object directly.


```r
head (lines_Delft)
```

```{.output}
Simple feature collection with 6 features and 2 fields
Geometry type: LINESTRING
Dimension:     XY
Bounding box:  xmin: 85107.1 ymin: 448400.3 xmax: 86399.68 ymax: 449076.2
Projected CRS: Amersfoort / RD New
   osm_id  highway                       geometry
1 4239535 cycleway LINESTRING (86399.68 448599...
2 4239536 cycleway LINESTRING (85493.66 448740...
3 4239537 cycleway LINESTRING (85493.66 448740...
4 4239620  footway LINESTRING (86299.01 448536...
5 4239621  footway LINESTRING (86307.35 448738...
6 4239674  footway LINESTRING (86299.01 448536...
```


## Explore values within one attribute

Using the `$` operator, we can examine the content of a single field of our lines feature. 

We can see the contents of the `highway` field of our lines feature:


```r
head(lines_Delft$highway, 10)
```

```{.output}
 [1] "cycleway" "cycleway" "cycleway" "footway"  "footway"  "footway" 
 [7] "service"  "steps"    "footway"  "footway" 
```

To see only unique values within the `highway` field, we can use the `unique()` function. This function extracts all possible values of a character variable. 


```r
unique(lines_Delft$highway)
```

```{.output}
 [1] "cycleway"       "footway"        "service"        "steps"         
 [5] "residential"    "unclassified"   "construction"   "secondary"     
 [9] "busway"         "living_street"  "motorway_link"  "tertiary"      
[13] "track"          "motorway"       "path"           "pedestrian"    
[17] "primary"        "bridleway"      "trunk"          "tertiary_link" 
[21] "services"       "secondary_link" "trunk_link"     "primary_link"  
[25] "platform"       "proposed"       NA              
```

:::::::::::::::::::::::: callout 

R is also able to handle categorical variables called factors. With factors, we can use the `levels()` function to show unique values. To examine unique values of the `highway` variable this way, we have to first transform it into a factor with the `factor()` function:


```r
levels(factor(lines_Delft$highway))
```

```{.output}
 [1] "bridleway"      "busway"         "construction"   "cycleway"      
 [5] "footway"        "living_street"  "motorway"       "motorway_link" 
 [9] "path"           "pedestrian"     "platform"       "primary"       
[13] "primary_link"   "proposed"       "residential"    "secondary"     
[17] "secondary_link" "service"        "services"       "steps"         
[21] "tertiary"       "tertiary_link"  "track"          "trunk"         
[25] "trunk_link"     "unclassified"  
```
Note that this way the values are shown by default in alphabetical order and `NA`s are not displayed, whereas using `unique()` returns unique values in the order of their occurrence in the data frame and it also shows `NA` values.

::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: challenge 

## Challenge: Attributes for different spatial classes
<!-- 3 minutes -->

Explore the attributes associated with the `point_Delft` spatial object.

1. How many attributes does it have?
2. What types of leisure points do the points represent? Give three examples.
3. Which of the following is NOT an attribute of the `point_Delft` data object?

  A) location B) leisure C) osm_id

:::::::::::::::::::::::: solution 

1. To find the number of attributes, we use the `ncol()` function:


```r
ncol(point_Delft)
```

```{.output}
[1] 3
```

2. The types of leisure point are in the column named `leisure`.

Using the `head()` function which displays 6 rows by default, we only see two values and `NA`s. 


```r
head(point_Delft)
```

```{.output}
Simple feature collection with 6 features and 2 fields
Geometry type: POINT
Dimension:     XY
Bounding box:  xmin: 83839.59 ymin: 443827.4 xmax: 84967.67 ymax: 447475.5
Projected CRS: Amersfoort / RD New
     osm_id      leisure                  geometry
1 472312297 picnic_table POINT (84144.72 443827.4)
2 480470725       marina POINT (84967.67 446120.1)
3 484697679         <NA> POINT (83912.28 447431.8)
4 484697682         <NA> POINT (83895.43 447420.4)
5 484697691         <NA>   POINT (83839.59 447455)
6 484697814         <NA> POINT (83892.53 447475.5)
```

We can increase the number of rows with the n argument (e.g., `head(n = 10)` to show 10 rows) until we see at least three distinct values in the leisure column. Note that printing an `sf` object will also display the first 10 rows.


```r
head(point_Delft, 10)  
```

```{.output}
Simple feature collection with 10 features and 2 fields
Geometry type: POINT
Dimension:     XY
Bounding box:  xmin: 82485.72 ymin: 443827.4 xmax: 85385.25 ymax: 448341.3
Projected CRS: Amersfoort / RD New
       osm_id       leisure                  geometry
1   472312297  picnic_table POINT (84144.72 443827.4)
2   480470725        marina POINT (84967.67 446120.1)
3   484697679          <NA> POINT (83912.28 447431.8)
4   484697682          <NA> POINT (83895.43 447420.4)
5   484697691          <NA>   POINT (83839.59 447455)
6   484697814          <NA> POINT (83892.53 447475.5)
7   549139430        marina POINT (84479.99 446823.5)
8   603300994 sports_centre POINT (82485.72 445237.5)
9   883518959 sports_centre POINT (85385.25 448341.3)
10 1148515039    playground    POINT (84661.3 446818)
```

```r
# you might be lucky to see three distinct values
```

We have our answer (`sports_centre` is the third value), but in general this is not a good approach as the first rows might still have many `NA`s and three distinct values might still not be present in the first `n` rows of the data frame. To remove `NA`s, we can use the function `na.omit()` on the leisure column to remove `NA`s completely. Note that we use the `$` operator to examine the content of a single variable.


```r
head(na.omit(point_Delft$leisure))  # this is better
```

```{.output}
[1] "picnic_table"  "marina"        "marina"        "sports_centre"
[5] "sports_centre" "playground"   
```

To show only unique values, we can use the `levels()` function on a factor to only see the first occurrence of each distinct value. Note `NA`s are dropped in this case and that we get the first three of the unique alphabetically ordered values.


```r
head(levels(factor(point_Delft$leisure)), n = 3)   
```

```{.output}
[1] "dance"       "dog_park"    "escape_game"
```

```r
# this is even better
```

3. To see a list of all attribute names, we can use the `names()` function.


```r
names(point_Delft)
```

```{.output}
[1] "osm_id"   "leisure"  "geometry"
```

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::


## Subset features

We can use the `filter()` function to select a subset of features from a spatial object, just like with data frames. Let's select only cycleways from our street data. 


```r
cycleway_Delft <- lines_Delft %>%  
  filter(highway == "cycleway")
```

Our subsetting operation reduces the number of features from 11244 to 1397.


```r
nrow(lines_Delft)
```

```{.output}
[1] 11244
```

```r
nrow(cycleway_Delft)
```

```{.output}
[1] 1397
```

This can be useful, for instance, to calculate the total length of cycleways.


```r
cycleway_Delft <- cycleway_Delft %>% 
  mutate(length = st_length(.))

cycleway_Delft %>%
  summarise(total_length = sum(length))
```

```{.output}
Simple feature collection with 1 feature and 1 field
Geometry type: MULTILINESTRING
Dimension:     XY
Bounding box:  xmin: 81759.58 ymin: 441227.3 xmax: 87326.76 ymax: 449834.5
Projected CRS: Amersfoort / RD New
  total_length                       geometry
1 115550.1 [m] MULTILINESTRING ((86399.68 ...
```

Now we can plot only the cycleways.


```r
ggplot(data = cycleway_Delft) +
  geom_sf() +
  labs(title = "Slow mobility network in Delft", 
       subtitle = "Cycleways"
      ) +
  coord_sf(datum = st_crs(28992))
```

<div class="figure" style="text-align: center">
<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-17-1.png" alt="Map of cycleways in Delft."  />
<p class="caption">Map of cycleways in Delft.</p>
</div>

::: challenge
<!-- 7 minutes -->

Challenge: Now with motorways (and pedestrian streets)

1. Create a new object that only contains the motorways in Delft. 
2. How many features does the new object have?
3. What is the total length of motorways?
4. Plot the motorways.
5. Extra: follow the same steps with pedestrian streets. 

::: solution

1. To create the new object, we first need to see which value of the `highway` column holds motorways. There is a value called `motorway`.


```r
unique(lines_Delft$highway)
```

```{.output}
 [1] "cycleway"       "footway"        "service"        "steps"         
 [5] "residential"    "unclassified"   "construction"   "secondary"     
 [9] "busway"         "living_street"  "motorway_link"  "tertiary"      
[13] "track"          "motorway"       "path"           "pedestrian"    
[17] "primary"        "bridleway"      "trunk"          "tertiary_link" 
[21] "services"       "secondary_link" "trunk_link"     "primary_link"  
[25] "platform"       "proposed"       NA              
```
We extract only the features with the value `motorway`.


```r
motorway_Delft <- lines_Delft %>% 
  filter(highway == "motorway")

motorway_Delft
```

```{.output}
Simple feature collection with 48 features and 2 fields
Geometry type: LINESTRING
Dimension:     XY
Bounding box:  xmin: 84501.66 ymin: 442458.2 xmax: 87401.87 ymax: 449205.9
Projected CRS: Amersfoort / RD New
First 10 features:
      osm_id  highway                       geometry
1    7531946 motorway LINESTRING (87395.68 442480...
2    7531976 motorway LINESTRING (87401.87 442467...
3   46212227 motorway LINESTRING (86103.56 446928...
4  120945066 motorway LINESTRING (85724.87 447473...
5  120945068 motorway LINESTRING (85710.31 447466...
6  126548650 motorway LINESTRING (86984.12 443630...
7  126548651 motorway LINESTRING (86714.75 444772...
8  126548653 motorway LINESTRING (86700.23 444769...
9  126548654 motorway LINESTRING (86716.35 444766...
10 126548655 motorway LINESTRING (84961.78 448566...
```

2. There are 48 features with the value `motorway`.


```r
motorway_Delft_length <- motorway_Delft %>% 
  mutate(length = st_length(.)) %>% 
  select(everything(), geometry) %>%
  summarise(total_length = sum(length))
```

3. The total length of motorways is 14877.4361477941.


```r
nrow(motorway_Delft)
```

```{.output}
[1] 48
```

4. Plot the motorways.


```r
ggplot(data = motorway_Delft) + 
  geom_sf(linewidth = 1.5) +
  labs(title = "Fast mobility network", 
       subtitle = "Motorways"
       ) + 
  coord_sf(datum = st_crs(28992))
```

<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-22-1.png" style="display: block; margin: auto;" />

5. Follow the same steps with pedestrian streets.


```r
pedestrian_Delft <- lines_Delft %>% 
  filter(highway == "pedestrian")

pedestrian_Delft %>% 
  mutate(length = st_length(.)) %>% 
  select(everything(), geometry) %>%
  summarise(total_length = sum(length))
```

```{.output}
Simple feature collection with 1 feature and 1 field
Geometry type: MULTILINESTRING
Dimension:     XY
Bounding box:  xmin: 82388.15 ymin: 444400.2 xmax: 85875.95 ymax: 447987.8
Projected CRS: Amersfoort / RD New
  total_length                       geometry
1 12778.84 [m] MULTILINESTRING ((85538.03 ...
```

```r
nrow(pedestrian_Delft)
```

```{.output}
[1] 234
```


```r
ggplot() +
  geom_sf(data = pedestrian_Delft) +
  labs(title = "Slow mobility network", 
       subtitle = "Pedestrian"
       ) + 
  coord_sf(datum = st_crs(28992))
```

<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-24-1.png" style="display: block; margin: auto;" />

:::

:::

## Customize plots

Let's say that we want to color different road types with different colors and that we want to determine those colors.


```r
unique(lines_Delft$highway)
```

```{.output}
 [1] "cycleway"       "footway"        "service"        "steps"         
 [5] "residential"    "unclassified"   "construction"   "secondary"     
 [9] "busway"         "living_street"  "motorway_link"  "tertiary"      
[13] "track"          "motorway"       "path"           "pedestrian"    
[17] "primary"        "bridleway"      "trunk"          "tertiary_link" 
[21] "services"       "secondary_link" "trunk_link"     "primary_link"  
[25] "platform"       "proposed"       NA              
```

If we look at all the unique values of the highway field of our street network we see more than 20 values. Let's focus on a subset of four values to illustrate the use of distinct colors. We use a piped expression in which we only filter the rows of our data frame that have one of the four given values `"motorway"`, `"primary"`, `"secondary"`, and `"cycleway"`. Note that we do this with the `%in` operator which is a more compact equivalent of a series of conditions joined by the `|` (or) operator. We also make sure that the highway column is a factor column.


```r
road_types <- c("motorway", "primary", "secondary", "cycleway")

lines_Delft_selection <- lines_Delft %>% 
  filter(highway %in% road_types) %>% 
  mutate(highway = factor(highway, levels = road_types))
```

Next we define the four colors we want to use, one for each type of road in our vector object. Note that in R you can use named colors like `"blue"`, `"green"`, `"navy"`, and `"purple"`. If you are using RStudio, you will see the named colors previewed in line. A full list of named colors can be listed with the `colors()` function.


```r
road_colors <- c("blue", "green", "navy", "purple")
```

We can use the defined color palette in ggplot.


```r
ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway)) + 
  scale_color_manual(values = road_colors) +
  labs(color = 'Road Type',
       title = "Road network of Delft", 
       subtitle = "Roads & Cycleways") + 
  coord_sf(datum = st_crs(28992))
```

<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-28-1.png" style="display: block; margin: auto;" />

## Adjust line width

Earlier we adjusted the line width universally. We can also adjust line widths for every factor level. Note that in this case the `size` argument, like the `color` argument, are within the `aes()` mapping function. This means that the values of that visual property will be mapped from a variable of the object that is being plotted.


```r
line_widths <- c(1, 0.75, 0.5, 0.25)
```


```r
ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway, linewidth = highway)) +
  scale_color_manual(values = road_colors) +
  labs(color = 'Road Type',
       linewidth = 'Road Type',
       title = "Mobility network of Delft",
       subtitle = "Roads & Cycleways") +
  scale_linewidth_manual(values = line_widths) +
  coord_sf(datum = st_crs(28992))
```

<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-30-1.png" style="display: block; margin: auto;" />

::: challenge

# Challenge: Plot line width by attribute

In the example above, we set the line widths to be 1, 0.75, 0.5, and 0.25. In our case line thicknesses are consistent with the hierarchy of the selected road types, but in some cases we might want to show a different hierarchy.

Let’s create another plot where we show the different line types with the following thicknesses:

- motorways linewidth = 0.25
- primary linewidth = 0.75
- secondary linewidth =  0.5
- cycleway linewidth = 1

::: solution


```r
levels(factor(lines_Delft_selection$highway))
```

```{.output}
[1] "motorway"  "primary"   "secondary" "cycleway" 
```


```r
line_width <- c(0.25, 0.75, 0.5, 1)
```


```r
ggplot(data = lines_Delft_selection) +
  geom_sf(aes(linewidth = highway)) +
  scale_linewidth_manual(values = line_width) +
  labs(title = "Mobility network of Delft",
       subtitle = "Roads & Cycleways - Line width varies"
       ) + 
  coord_sf(datum = st_crs(28992))
```

<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-33-1.png" style="display: block; margin: auto;" />

:::

:::


## Add plot legend

Let’s add a legend to our plot. We will use the `road_colors` object that we created above to color the legend. We can customize the appearance of our legend by manually setting different parameters.


```r
p1 <- ggplot(data = lines_Delft_selection) + 
  geom_sf(aes(color = highway), linewidth = 1.5) +
  scale_color_manual(values = road_colors) +
  labs(color = 'Road Type') + 
  labs(title = "Mobility network of Delft", 
       subtitle = "Roads & Cycleways - Default Legend") + 
  coord_sf(datum = st_crs(28992))

# show plot
p1
```

<div class="figure" style="text-align: center">
<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-34-1.png" alt="Mobility network in Delft using thicker lines than the previous example."  />
<p class="caption">Mobility network in Delft using thicker lines than the previous example.</p>
</div>


```r
p2 <- p1 +
  theme(legend.text = element_text(size = 20), 
        legend.box.background = element_rect(linewidth = 1))

# show plot
p2
```

<div class="figure" style="text-align: center">
<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-35-1.png" alt="Map of the mobility network in Delft with large-font and border around the legend."  />
<p class="caption">Map of the mobility network in Delft with large-font and border around the legend.</p>
</div>

::: challenge

# Challenge: Plot lines by attributes
<!-- 5 minutes -->

Create a plot that emphasizes only roads where bicycles are allowed. To emphasize this, make the lines where bicycles are not allowed THINNER than the roads where bicycles are allowed. Be sure to add a title and legend to your map. You might consider a color palette that has all bike-friendly roads displayed in a bright color. All other lines can be black.

::: solution


```r
class(lines_Delft_selection$highway)
```

```{.output}
[1] "factor"
```


```r
levels(factor(lines_Delft$highway))
```

```{.output}
 [1] "bridleway"      "busway"         "construction"   "cycleway"      
 [5] "footway"        "living_street"  "motorway"       "motorway_link" 
 [9] "path"           "pedestrian"     "platform"       "primary"       
[13] "primary_link"   "proposed"       "residential"    "secondary"     
[17] "secondary_link" "service"        "services"       "steps"         
[21] "tertiary"       "tertiary_link"  "track"          "trunk"         
[25] "trunk_link"     "unclassified"  
```


```r
# First, create a data frame with only roads where bicycles 
# are allowed
lines_Delft_bicycle <- lines_Delft %>% 
  filter(highway == "cycleway")

# Next, visualise it using ggplot
ggplot(data = lines_Delft) +
  geom_sf() +
  geom_sf(data = lines_Delft_bicycle, 
          aes(color = highway), 
          linewidth = 1
          ) +
  scale_color_manual(values = "magenta") +
  labs(title = "Mobility network in Delft", 
       subtitle = "Roads dedicated to Bikes"
       ) +
  coord_sf(datum = st_crs(28992))
```

<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-38-1.png" style="display: block; margin: auto;" />

:::

:::

::: challenge

# Challenge: Plot polygon by attribute
<!-- 5 minutes -->

Create a map of the municipal boundaries in the Netherlands using the data located in your data folder: `nl-gemeenten.shp`. Apply a line color to each state using its region value. Add a legend.

::: solution


```r
municipal_boundaries_NL <- st_read("data/nl-gemeenten.shp")
```

```{.output}
Reading layer `nl-gemeenten' from data source 
  `/home/runner/work/r-geospatial-urban/r-geospatial-urban/site/built/data/nl-gemeenten.shp' 
  using driver `ESRI Shapefile'
Simple feature collection with 344 features and 6 fields
Geometry type: MULTIPOLYGON
Dimension:     XY
Bounding box:  xmin: 10425.16 ymin: 306846.2 xmax: 278026.1 ymax: 621876.3
Projected CRS: Amersfoort / RD New
```


```r
str(municipal_boundaries_NL)
```

```{.output}
Classes 'sf' and 'data.frame':	344 obs. of  7 variables:
 $ identifica: chr  "GM0014" "GM0034" "GM0037" "GM0047" ...
 $ naam      : chr  "Groningen" "Almere" "Stadskanaal" "Veendam" ...
 $ code      : chr  "0014" "0034" "0037" "0047" ...
 $ ligtInProv: chr  "20" "24" "20" "20" ...
 $ ligtInPr_1: chr  "Groningen" "Flevoland" "Groningen" "Groningen" ...
 $ fuuid     : chr  "gemeentegebied.ee21436e-5a2d-4a8f-b2bf-113bddd028fc" "gemeentegebied.6e4378d7-0905-4dff-b351-57c1940c9c90" "gemeentegebied.515fbfe4-614e-463d-8b8c-91d35ca93b3b" "gemeentegebied.a3e71341-218c-44bf-ba12-01e2251ea2f6" ...
 $ geometry  :sfc_MULTIPOLYGON of length 344; first list element: List of 1
  ..$ :List of 1
  .. ..$ : num [1:4749, 1:2] 238742 238741 238740 238738 238735 ...
  ..- attr(*, "class")= chr [1:3] "XY" "MULTIPOLYGON" "sfg"
 - attr(*, "sf_column")= chr "geometry"
 - attr(*, "agr")= Factor w/ 3 levels "constant","aggregate",..: NA NA NA NA NA NA
  ..- attr(*, "names")= chr [1:6] "identifica" "naam" "code" "ligtInProv" ...
```

```r
levels(factor(municipal_boundaries_NL$ligtInPr_1))
```

```{.output}
 [1] "Drenthe"       "Flevoland"     "Fryslân"       "Gelderland"   
 [5] "Groningen"     "Limburg"       "Noord-Brabant" "Noord-Holland"
 [9] "Overijssel"    "Utrecht"       "Zeeland"       "Zuid-Holland" 
```


```r
ggplot(data = municipal_boundaries_NL) +
  geom_sf(aes(color = ligtInPr_1), linewidth = 1) +
  labs(title = "Contiguous NL Municipal Boundaries") + 
  coord_sf(datum = st_crs(28992))
```

<img src="fig/10-explore-and-plot-by-vector-layer-attributes-rendered-unnamed-chunk-41-1.png" style="display: block; margin: auto;" />

:::

:::


::::::::::::::::::::::::::::::::::::: keypoints 

- Spatial objects in `sf` are similar to standard data frames and can be manipulated using the same functions.

- Almost any feature of a plot can be customized using the various functions and options in the `ggplot2` package.

::::::::::::::::::::::::::::::::::::::::::::::::

