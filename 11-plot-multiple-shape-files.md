---
title: 'Plot multiple shapefiles'
teaching: 30
exercises: 5
---



:::::::::::::::::::::::::::::::::::::: questions 

- How can I create map compositions with custom legends using ggplot?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After completing this episode, participants should be able to…

- Plot multiple vector layers in the same plot.
- Apply custom symbols to spatial objects in a plot.

::::::::::::::::::::::::::::::::::::::::::::::::

This episode builds upon the [previous episode](../episodes/10-explore-and-plot-by-vector-layer-attributes.Rmd) to work with vector layers in R and explore how to plot multiple vector layers.


## Load the data

To work with vector data in R, we use the `sf` library. Make sure that it is loaded.

We will continue to work with the three ESRI shapefiles that we loaded in the [Open and Plot Vector Layers](../episodes/09-open-and-plot-vector-layers.Rmd) episode.



## Plotting Multiple Vector Layers

So far we learned how to plot information from a single shapefile and do some plot customization. What if we want to create a more complex plot with many shapefiles and unique symbols that need to be represented clearly in a legend?

We will create a plot that combines our leisure locations (`point_Delft`), municipal boundary (`boundary_Delft`) and streets (`lines_Delft`) spatial objects. We will need to build a custom legend as well.

To begin, we will create a plot with the site boundary as the first layer. Then layer the leisure locations and street data on top using `+`.


```r
ggplot() +
  geom_sf(
    data = boundary_Delft,
    fill = "lightgrey",
    color = "lightgrey"
  ) +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway),
    size = 1
  ) +
  geom_sf(data = point_Delft) +
  labs(title = "Mobility network of Delft") +
  coord_sf(datum = st_crs(28992))
```

<img src="fig/11-plot-multiple-shape-files-rendered-unnamed-chunk-1-1.png" style="display: block; margin: auto;" />

Next, let’s build a custom legend using the functions `scale_color_manual()` and `scale_fill_manual()`.


```r
leisure_colors <- rainbow(15)
point_Delft$leisure <- factor(point_Delft$leisure)

ggplot() +
  geom_sf(
    data = boundary_Delft,
    fill = "lightgrey",
    color = "lightgrey"
  ) +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway),
    size = 1
  ) +
  geom_sf(
    data = point_Delft,
    aes(fill = leisure),
    shape = 21
  ) +
  scale_color_manual(
    values = road_colors,
    name = "Road Type"
  ) +
  scale_fill_manual(
    values = leisure_colors,
    name = "Lesiure Location"
  ) +
  labs(title = "Mobility network and leisure in Delft") +
  coord_sf(datum = st_crs(28992))
```

<img src="fig/11-plot-multiple-shape-files-rendered-unnamed-chunk-2-1.png" style="display: block; margin: auto;" />


```r
ggplot() +
  geom_sf(
    data = boundary_Delft,
    fill = "lightgrey",
    color = "lightgrey"
  ) +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway),
    size = 1
  ) +
  geom_sf(
    data = point_Delft,
    aes(fill = leisure),
    shape = 22
  ) +
  scale_color_manual(
    values = road_colors,
    name = "Line Type"
  ) +
  scale_fill_manual(
    values = leisure_colors,
    name = "Leisure Location"
  ) +
  labs(title = "Mobility network and leisure in Delft") +
  coord_sf(datum = st_crs(28992))
```

<img src="fig/11-plot-multiple-shape-files-rendered-unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

We notice that there are quite some playgrounds in the residential parts of Delft, whereas on campus there is a concentration of picnic tables. So that is what our next challenge is about.


::::::::::::::::::::::::::::::::::::: challenge 

## Challenge: Visualising multiple layers with a custom legend

Create a map of leisure locations only including `playground` and `picnic_table`, with each point colored by the leisure type. Overlay this layer on top of the `lines_Delft` layer (the streets). Create a custom legend that applies line symbols to lines and point symbols to the points.

Modify the plot above. Tell R to plot each point, using a different symbol of shape value.

:::::::::::::::::::::::: solution 


```r
leisure_locations_selection <- st_read("data/delft-leisure.shp") %>%
  filter(leisure %in% c("playground", "picnic_table"))
```

```output
Reading layer `delft-leisure' from data source 
  `/home/runner/work/r-geospatial-urban/r-geospatial-urban/site/built/data/delft-leisure.shp' 
  using driver `ESRI Shapefile'
Simple feature collection with 298 features and 2 fields
Geometry type: POINT
Dimension:     XY
Bounding box:  xmin: 81863.21 ymin: 442621.1 xmax: 87370.15 ymax: 449345.1
Projected CRS: Amersfoort / RD New
```


```r
levels(factor(leisure_locations_selection$leisure))
```

```output
[1] "picnic_table" "playground"  
```


```r
blue_orange <- c("cornflowerblue", "darkorange")
```


```r
ggplot() +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway)
  ) +
  geom_sf(
    data = leisure_locations_selection,
    aes(fill = leisure),
    shape = 21
  ) +
  scale_color_manual(
    name = "Line Type",
    values = road_colors,
    guide = guide_legend(override.aes = list(
      linetype = "solid",
      shape = NA
    ))
  ) +
  scale_fill_manual(
    name = "Soil Type",
    values = blue_orange,
    guide = guide_legend(override.aes = list(
      linetype = "blank",
      shape = 21,
      colour = NA
    ))
  ) +
  labs(title = "Traffic and leisure") +
  coord_sf(datum = st_crs(28992))
```

<img src="fig/11-plot-multiple-shape-files-rendered-unnamed-chunk-7-1.png" style="display: block; margin: auto;" />


```r
ggplot() +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway),
    size = 1
  ) +
  geom_sf(
    data = leisure_locations_selection,
    aes(fill = leisure, shape = leisure),
    size = 2
  ) +
  scale_shape_manual(
    name = "Leisure Type",
    values = c(21, 22)
  ) +
  scale_color_manual(
    name = "Line Type",
    values = road_colors
  ) +
  scale_fill_manual(
    name = "Leisure Type",
    values = rainbow(15),
    guide = guide_legend(override.aes = list(
      linetype = "blank",
      shape = c(21, 22),
      color = "black"
    ))
  ) +
  labs(title = "Road network and leisure") +
  coord_sf(datum = st_crs(28992))
```

<img src="fig/11-plot-multiple-shape-files-rendered-unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::: keypoints 

- Use the `+` operator to add multiple layers to a ggplot.
- A plot can be a combination of multiple vector layers.
- Use the `scale_color_manual()` and `scale_fill_manual()` functions to set legend colors.

::::::::::::::::::::::::::::::::::::::::::::::::

