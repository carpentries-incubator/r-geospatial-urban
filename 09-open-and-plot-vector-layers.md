---
title: "Open and Plot Vector Layers"
teaching: 25
exercises: 5
---

:::::::::::::::::::::::::::::::::::::: questions 

- How can I read, examine and visualize point, line and polygon vector data in R?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Know the difference between point, line, and polygon vector data.
- Load vector data into R.
- Access the attributes of a vector object in R.

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Make sure that the `sf` package and its dependencies are installed before the 
workshop. The installation can take quite some time, so allocate enough extra
time before the workshop for solving installation problems. We recommend one
or two installation 'walk-in' hours on a day before the workshop and 15-30 
minutes at the beginning of the first workshop day should be enough to tackle 
installation issues.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::: prereq

If you have not installed the `sf` package yet, run `install.packages("sf")` first. Note that the `sf` package has some external dependencies, namely GEOS, PROJ.4, GDAL and UDUNITS, which need to be installed beforehand. Follow the workshop [setup instructions]() for the installation of `sf` and its dependencies.

:::

First we need to load the packages we will use in this lesson. We will use the packages `tidyverse` and `here` with which you are already familiar from the previous lesson. In addition, we need to load the [`sf`](https://r-spatial.github.io/sf/) package for working with spatial vector data. 


```r
library(tidyverse)  # tools for wrangling, reshaping and visualizing data
library(here)       # managing paths
library(sf)         # work with spatial vector data
```

::: callout

# The `sf` package

`sf` stands for Simple Features which is a standard defined by the Open Geospatial Consortium for storing and accessing geospatial vector data. PostGIS uses the same standard; so those of you who used PostGIS, might find some resemblances with the functions used by the `sf` package. 

:::

## Import shapefiles

Let's start by opening a shapefile. Shapefiles a common file format to store spatial vector data used in GIS software. We will read a shapefile with the administrative boundary of Delft with the function `st_read()` from the `sf` package. 


```r
boundary_Delft <- st_read("data/delft-boundary.shp")
```

::: callout

# All `sf` functions start with `st_`

Note that all functions from the `sf` package start with the standard prefix `st_` which stands for Spatial Type. This is helpful in at least two ways: (1) it  makes the interaction with or translation to/from software using the simple features standard like PostGIS easy, and (2) it allows for easy autocompletion of function names in RStudio.

:::

## Spatial Metadata

The `st_read()` function gave us a message with a summary of metadata about the file that was read in. To examine the metadata in more detail, we can use other, more specialised, functions from the `sf` package. The `st_geometry_type()` function, for instance, gives us information about the geometry type, which in this case is `POLYGON`.


```r
st_geometry_type(boundary_Delft)
```

```{.output}
[1] POLYGON
18 Levels: GEOMETRY POINT LINESTRING POLYGON MULTIPOINT ... TRIANGLE
```

The `st_crs()` function returns the coordinate reference system (CRS) used by the shapefile, which in this case is `WGS84` and has the unique reference code `EPSG: 4326`. 


```r
st_crs(boundary_Delft)
```

```{.output}
Coordinate Reference System:
  User input: WGS 84 
  wkt:
GEOGCRS["WGS 84",
    DATUM["World Geodetic System 1984",
        ELLIPSOID["WGS 84",6378137,298.257223563,
            LENGTHUNIT["metre",1]]],
    PRIMEM["Greenwich",0,
        ANGLEUNIT["degree",0.0174532925199433]],
    CS[ellipsoidal,2],
        AXIS["latitude",north,
            ORDER[1],
            ANGLEUNIT["degree",0.0174532925199433]],
        AXIS["longitude",east,
            ORDER[2],
            ANGLEUNIT["degree",0.0174532925199433]],
    ID["EPSG",4326]]
```

::: callout

# Examining the output of `st_crs()`

As the output of `st_crs()` can be long, you can use `$Name` and `$epsg` after the `crs()` call to extract the projection name and EPSG code respectively.

:::

The `st_bbox()` function shows the extent of the layer. As `WGS84` is a **geographic CRS**, the extent of the shapefile is displayed in degrees.


```r
st_bbox(boundary_Delft)
```

```{.output}
     xmin      ymin      xmax      ymax 
 4.320218 51.966316  4.407911 52.032599 
```

We need a **projected CRS**, which in the case of the Netherlands is typically the Amersfort / RD New projection. To reproject our shapefile, we will use the `st_transform()` function. For the `crs` argument we can use the EPSG code of the CRS we want to use, which is `28992` for the `Amersfort / RD New` projection. 


```r
boundary_Delft <- st_transform(boundary_Delft, 28992)
st_crs(boundary_Delft)
```

```{.output}
Coordinate Reference System:
  User input: EPSG:28992 
  wkt:
PROJCRS["Amersfoort / RD New",
    BASEGEOGCRS["Amersfoort",
        DATUM["Amersfoort",
            ELLIPSOID["Bessel 1841",6377397.155,299.1528128,
                LENGTHUNIT["metre",1]]],
        PRIMEM["Greenwich",0,
            ANGLEUNIT["degree",0.0174532925199433]],
        ID["EPSG",4289]],
    CONVERSION["RD New",
        METHOD["Oblique Stereographic",
            ID["EPSG",9809]],
        PARAMETER["Latitude of natural origin",52.1561605555556,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8801]],
        PARAMETER["Longitude of natural origin",5.38763888888889,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8802]],
        PARAMETER["Scale factor at natural origin",0.9999079,
            SCALEUNIT["unity",1],
            ID["EPSG",8805]],
        PARAMETER["False easting",155000,
            LENGTHUNIT["metre",1],
            ID["EPSG",8806]],
        PARAMETER["False northing",463000,
            LENGTHUNIT["metre",1],
            ID["EPSG",8807]]],
    CS[Cartesian,2],
        AXIS["easting (X)",east,
            ORDER[1],
            LENGTHUNIT["metre",1]],
        AXIS["northing (Y)",north,
            ORDER[2],
            LENGTHUNIT["metre",1]],
    USAGE[
        SCOPE["Engineering survey, topographic mapping."],
        AREA["Netherlands - onshore, including Waddenzee, Dutch Wadden Islands and 12-mile offshore coastal zone."],
        BBOX[50.75,3.2,53.7,7.22]],
    ID["EPSG",28992]]
```

Notice that the bounding box is measured in meters after the transformation.


```r
st_bbox(boundary_Delft)
```

```{.output}
     xmin      ymin      xmax      ymax 
 81743.00 442446.21  87703.78 449847.95 
```

We confirm the transformation by examining the reprojected shapefile.


```r
boundary_Delft
```

```{.output}
Simple feature collection with 1 feature and 1 field
Geometry type: POLYGON
Dimension:     XY
Bounding box:  xmin: 81743 ymin: 442446.2 xmax: 87703.78 ymax: 449848
Projected CRS: Amersfoort / RD New
  osm_id                       geometry
1 324269 POLYGON ((87703.78 442651, ...
```

::: callout

More about CRS in [Handling Spatial Projection & CRS]().

:::



## Plot a vector layer

Now, let's plot this shapefile. You are already familiar with the `ggplot2` package from [Introduction to Visualisation](). `ggplot2` has special `geom_` functions for spatial data. We will use the `geom_sf()` function for `sf` data.


```r
ggplot(data = boundary_Delft) +
  geom_sf(size = 3, color = "black", fill = "cyan1") +
  labs(title = "Delft Administrative Boundary") +
  coord_sf(datum = st_crs(28992))  # this is needed to display the axes in meters
```

<img src="fig/09-open-and-plot-vector-layers-rendered-unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

::::::::::::::::::::::::::::::::::::: challenge 

### Challenge 1: Import line and point vector layers

Read in `delft-streets.shp` and `delft-leisure.shp` and assign them to `lines_Delft` and `point_Delft` respectively. Answer the following questions:

1. What type of R spatial object is created when you import each layer?
2. What is the CRS and extent for each object?
3. Do the files contain points, lines, or polygons?
4. How many features are in each file?

:::::::::::::::::::::::: solution 


```r
lines_Delft <- st_read("data/delft-streets.shp")
point_Delft <- st_read("data/delft-leisure.shp")
```

We can check the type of data with the `class()` function from base R. Both `lines_Delft` and `point_Delft` are objects of class `"sf"`, which extends the `"data.frame"` class. 


```r
class(lines_Delft)
```

```{.output}
[1] "sf"         "data.frame"
```

```r
class(point_Delft)
```

```{.output}
[1] "sf"         "data.frame"
```

`lines_Delft` and `point_Delft` are in the correct CRS.


```r
st_crs(lines_Delft)$epsg
```

```{.output}
[1] 28992
```

```r
st_crs(point_Delft)$epsg
```

```{.output}
[1] 28992
```

When looking at the bounding boxes with the `st_bbox()` function, we see the spatial extent of the two objects in a projected CRS using meters as units. `lines_Delft()` and `point_Delft` have similar extents.


```r
st_bbox(lines_Delft)
```

```{.output}
     xmin      ymin      xmax      ymax 
 81759.58 441223.13  89081.41 449845.81 
```

```r
st_bbox(point_Delft)
```

```{.output}
     xmin      ymin      xmax      ymax 
 81863.21 442621.15  87370.15 449345.08 
```

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::



::::::::::::::::::::::::::::::::::::: keypoints 

- Metadata for vector layers include geometry type, CRS, and extent.
- Load spatial objects into R with the `st_read()` function.
- Spatial objects can be plotted directly with `ggplot` using the `geom_sf()` function. No need to convert to a data frame.

::::::::::::::::::::::::::::::::::::::::::::::::
