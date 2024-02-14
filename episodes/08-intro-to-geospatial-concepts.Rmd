---
title: 'Introduction to Geospatial Concepts'
teaching: 10
exercises: 2
bibliography: references.bib
zotero: true
---

::: questions
-   How ...
:::

::: objectives
-   Describe ...
:::

## The shape of the Earth

The shape of the Earth is approximately a sphere which is slightly wider than it is tall, and which is called **ellipsoid**. The true shape of the Earth is an irregular ellipsoid, the so-called **geoid** (@fig-earth).

![The shape of the Earth. Source: United Nations Statistics Division and International Cartographic Association (2012a)](https://unstats.un.org/unsd/geoinfo/ungegn/docs/_data_icacourses/_ImagesModules/_selfstudy/S06_images/S06_03_a00.jpg){#fig-earth}

The most common and basic representation of the position of points on the Earth is the combination of the **geographical latitude and longitude**.

![Geographical latitude and longitude. Source: van der Marel (2014).](fig/latlon.png)

**Meridians** are **vertical** circles with constant longitude, called **great circles**, which run from the North Pole to the South Pole. **Parallels** are **horizontal** circles with constant latitude, which are called **small circles**. Only the equator (the largest parallel) is also a great circle.

The black lines in @fig-latlon show the equator and the prime meridian running through Greenwich, with latitude and longitude labels. The red dotted lines show the meridian and parallel running through Karachi, Pakistan (25°45’N, 67°01’E).

## Map projection

**Map projection** is a systematic transformation of the latitudes and longitudes of locations on the surface of an ellipsoid into locations on a plane. It is a transformation of the three-dimensional Earth’s surface into its two-dimensional representation on a sheet of paper or computer screen (see @fig-projection for a comparison with flattening of an orange peel).

![Map projection represented as flattening an orange peel. Source: Data Carpentry (2023)](https://datacarpentry.org/organization-geospatial/fig/orange-peel-earth.jpg){#fig-projection}

Many different map projections are in use for different purposes. Generally, they can be categorised into the following groups: cylindrical, conic, and azimuthal (see @fig-projections).

![Cylindrical, conic, and azimuthal map projections. Source: Knippers (2009)](https://kartoweb.itc.nl/geometrics/Bitmaps/Intro%201.9a.gif){#fig-projections}

Each map projection introduces a **distortion** in geometrical elements – **distance**, **angle**, and **area**. Depending on which of these geometrical elements are more relevant for a specific map, we can choose an appropriate map projection. **Conformal projections** are the best for preserving angles between any two curves; **equal area (equivalent) projections** preserve the area or scale; **equal distance (conventional) projections** are the best for preserving distances.

## Coordinate reference systems (CRS)

A **coordinate reference system (CRS)** is a coordinate-based local, regional or global system for locating geographical entities, which uses a specific map projection. It defines how the two-dimensional, projected map relates to real places on the Earth.

All coordinate reference systems are included in a public registry called the **EPSG Geodetic Parameter Dataset (EPSG registry)**, initiated in 1985 by a member of the European Petroleum Survey Group (EPSG). Each CRS has a unique **EPSG code**, which makes it possible to easily identify them among the large number of CRS. This is particularly important for transforming spatial data from one CRS to another.

Some of the most commonly used CRS in the Netherlands are the following:

-   **World Geodetic System 1984 (WGS84)** is the best known global reference system (EPSG:4326).
-   **European Terrestrial Reference System 1989 (ETRS89)** is the standard coordinate system for Europe (EPSG:4258).
-   The most popular projected CRS in the Netherlands is ‘Stelsel van de Rijksdriehoeksmeting (RD)’ registered in EPSG as **Amersfoort / RD New (EPSG:28992)**.

The main parameters of each CRS are the following:

-   **Datum** is a model of the shape of the Earth, which specifies how a coordinate system is linked to the Earth, e.g. how to define the origin of the coordinate axis – where (0,0) is. It has angular units (degrees).
-   **Projection** is mathematical transformation of the angular measurements on the Earth to linear units (e.g. meters) on a flat surface (paper or a computer screen).
-   **Additional parameters**, such as a definition of the centre of the map, are often necessary to create the full CRS.

In this workshop, we use two CRS shown in @tbl-crs.

|                | WGS 84 (EPSG:4326)                                       | Amersfoort / RD New (EPSG:28992)                |
|-----------------|----------------------------|----------------------------|
| Units          | degrees                                                  | meters                                          |
| Projection     | Geographic (uses latitude and longitude for coordinates) |                                                 |
|                | Dynamic (relies on a datum which is not plate-fixed)     | Static (relies on a datum which is plate-fixed) |
| Celestial body | Earth                                                    |                                                 |
| Datum          | World Geodetic System 1984 ensemble                      | Amersfoort                                      |
| Method         | Lat/long (Geodetic alias)                                | Oblique Stereographic Alternative               |
| Prime meridian | Greenwich                                                |                                                 |
| Ellipsoid      |                                                          | Bessel 1841                                     |

: Main properties of WGS 84 and Amersfoort / RD New coordinate reference systems {#tbl-crs}

## Map scale

**Map scale** measures the ratio between distance on a map and the corresponding distance on the ground. For example, on a 1:100 000 scale map, 1cm on the map equals 1km (100 000 cm) on the ground. Map scale can be expressed in the following three ways:

-   Verbal: 1 centimetre represents 250 meters
-   Fraction: 1:25000
-   Graphic:

::: callout
# Useful resources

-   Campbell, J., Shin, M. E. (2011). Essentials of Geographic Information Systems. Textbooks. 2. <https://digitalcommons.liberty.edu/textbooks/2> (Accessed 22-01-2024)

-   Data Carpentry (2023): Introduction to Geospatial Concepts. Coordinate Reference Systems. <https://datacarpentry.org/organization-geospatial/03-crs.html> (Accessed 22-01-2024)

-   GeoRepository (2024): EPSG Geodetic Parameter Dataset <https://epsg.org/home.html> (Accessed 22-01-2024)

-   Klokan Technologies GmbH (2022) <https://epsg.io/> (Accessed 22-01-2024)

-   United Nations Statistics Division and International Cartographic Association (2012b): UNGEGN-ICA webcourse on Toponymy. <https://unstats.un.org/unsd/geoinfo/ungegn/docs/_data_icacourses/2012_Home.html> (Accessed 22-01-2024)
:::

::: keypoints
-   Use `.md` files for episodes when you want static content
-   Use `.Rmd` files for episodes when you need to generate output
-   Run `sandpaper::check_lesson()` to identify any issues with your lesson
-   Run `sandpaper::build_lesson()` to preview your lesson locally
:::
