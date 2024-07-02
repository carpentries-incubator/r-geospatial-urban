---
title: Setup
---

# Overview

This workshop is designed to be run on your local machine. For this, you need to (i) download the geospatial data we use in the workshop and (ii) set up your machine with the software required to analyse and process the data. We provide installation instructions below for these steps. Please read carefully before installing anything!

## Data

Download the [data zip file](https://surfdrive.surf.nl/files/index.php/s/G2zgWK7SrHsSOSh) and unzip it to your Desktop. The file is 67.5 MB.

## Software

We provide quick instructions below for installing the various software needed for this workshop. They assume minimal familiarity with the command line and with installation in general. As there are different operating systems and many different versions of operating systems and environments, these may not work on your computer. If an installation doesn't work for you, please refer to the installation instructions for that software listed in the table on the bottom of this page.

If you have previously installed these software on your computer, please make sure the versions used in the workshop match your installation. Using the latest versions of R, RStudio, R packages and external dependencies indicated in the setup instructions will ensure that the software we use behaves the same way on all computers during the workshop.

Note for MacOS users: The workshop is only testes for macOS 11 and above. If you have an older version please contact the workshop providers prior to the start of the workshop. 

::::::::::::::::::::::::::::::::::::::: discussion

### GDAL, GEOS, and PROJ.4

The installation of the geospatial libraries GDAL, GEOS, and PROJ.4 varies significantly based on operating system. These are all dependencies for `sf`, the `R` package that we will be using for spatial data operations throughout this workshop. If you already have one of these libaries in your system, please make sure to uninstall it before following the instructions below. Otherwise you might have conflicts between your libraries. If uninstallation is not possible, please join to the pre-workshop installation meeting. 

:::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::: solution

### Windows

To install the geospatial libraries GDAL, GEOS, and PROJ.4, install Rtools version 4.4 [RTools](https://cran.r-project.org/bin/windows/Rtools/)

:::::::::::::::::::::::::

:::::::::::::::: solution

### MacOS

Install the geospatial libraries GDAL, GEOS, and PROJ.4 individually using [homebrew](https://brew.sh). Open Terminal.app and run the following commands:

```bash
$ brew tap osgeo/osgeo4mac && brew tap --repair
$ brew install proj
$ brew install geos
$ brew install gdal
```
:::::::::::::::::::::::::


:::::::::::::::: solution

### Linux

Steps for installing the geospatial libraries will vary based on which form of Linux you are using. These instructions are adapted from the [`sf` package's `README`](https://github.com/r-spatial/sf).

For **Ubuntu**:

```bash
$ sudo add-apt-repository ppa:ubuntugis
$ sudo apt-get update
$ sudo apt-get install libgdal-dev libgeos-dev libproj-dev
```

For **Fedora**:

```bash
$ sudo dnf install gdal-devel proj-devel geos-devel
```

For **Arch**:

```bash
$ pacman -S gdal proj geos
```

For **Debian**: The [rocker geospatial](https://github.com/rocker-org/geospatial) Dockerfiles may be helpful. Ubuntu Dockerfiles are found [here](https://github.com/r-spatial/sf/tree/master/inst/docker). These may be helpful to get an idea of the commands needed to install the necessary dependencies.

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::: discussion

### UDUNITS

Linux users will have to install UDUNITS separately. Like the geospatial libraries discussed above, this is a dependency for the `R` package `sf`. Due to conflicts, it does not install properly on Linux machines when installed as part of the `sf` installation process. It is therefore necessary to install it using the command line ahead of time.


:::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::: solution

### Linux

Steps for installing the geospatial will vary based on which form of Linux you are using. These instructions are adapted from the [`sf` package's `README`](https://github.com/r-spatial/sf).

For **Ubuntu**:

```bash
$ sudo apt-get install libudunits2-dev
```

For **Fedora**:

```bash
$ sudo dnf install udunits2-devel
```

For **Arch**:

```bash
$ pacaur/yaourt/whatever -S udunits
```

For **Debian**:

```bash
$ sudo apt-get install -y libudunits2-dev
```
:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::: discussion

### R

Participants who do not already have `R` installed should download and install the latest version. For those who already have R installed, make sure to have at least version 4.4.0. If not, please upgrade. You can check your R version by typing the following code in your R console. 
```R
version[['version.string']]
``` 


:::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::: solution

### Windows

To install `R`, Windows users should select "Download R for Windows" from RStudio and CRAN's [cloud download page](https://cloud.r-project.org), which will automatically detect a CRAN mirror for you to use. Select the `base` subdirectory after choosing the Windows download page. A `.exe` executable file containing the necessary components of base R can be downloaded by clicking on "Download R for Windows".

:::::::::::::::::::::::::

:::::::::::::::: solution

## MacOS

To install `R`, macOS users should select "Download R for macOS" from RStudio and CRAN's [cloud download page](https://cloud.r-project.org), which will automatically detect a CRAN mirror for you to use. A `.pkg` file containing the necessary components of base R can be downloaded by clicking on the first available link (this will be the most recent), which will read `R-4.x.x-arm64.pkg` for Apple silicon (M1/M2) Macs and `R-4.x.x-x86_64.pkg` for older Intel Macs.

:::::::::::::::::::::::::

:::::::::::::::: solution

## Linux

To install `R`, Linux users should select "Download R for Linux" from RStudio and CRAN's [cloud download page](https://cloud.r-project.org), which will automatically detect a CRAN mirror for you to use. Instructions for a number of different Linux operating systems are available.

:::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::: discussion

### RStudio

RStudio is a GUI for using `R` that is available for Windows, macOS, and various Linux operating systems. It can be downloaded [here](https://www.rstudio.com/products/rstudio/download/). You will need the **free** Desktop version for your computer. *In order to address issues with `ggplot2`, learners and instructors should run a recent version of RStudio (v1.2 or greater).*

:::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::: discussion

### R Packages

The following `R` packages are used in the various geospatial lessons.

- [`tidyverse`](https://cran.r-project.org/package=tidyverse) v.2.0 - this is a collection of packages for data science that contains the `dplyr` and `ggplot2` packages we will use throughout the lessons.
- [`terra`](https://cran.r-project.org/package=terra) v.1.7
- [`sf`](https://cran.r-project.org/package=sf) v1.0

To install these packages in RStudio, do the following:  
1\. Open RStudio by double-clicking the RStudio application icon. You should see something like this:

![](https://raw.githubusercontent.com/datacarpentry/geospatial-workshop/main/fig/01-rstudio.png){alt='RStudio layout'}

2\. Type the following into the console and hit enter.

```r
install.packages(c("tidyverse", "terra", "sf"))
```

You should see a status message starting with:

```output
trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.3/tidyverse_2.0.0.tgz'
Content type 'application/x-gzip' length 428470 bytes (418 KB)
==================================================
downloaded 418 KB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.3/terra_1.7-55.tgz'
Content type 'application/x-gzip' length 97482563 bytes (93.0 MB)
==================================================
downloaded 93.0 MB

trying URL 'https://cran.rstudio.com/bin/macosx/big-sur-arm64/contrib/4.3/sf_1.0-14.tgz'
Content type 'application/x-gzip' length 86848420 bytes (82.8 MB)
==================================================
downloaded 82.8 MB
```

When the installation is complete, you will see a status message like:

```output
The downloaded binary packages are in
/var/folders/hk/0c_kwgjs1zlgczjlszxgq348281j_b/T//RtmpTmRDrL/downloaded_packages
```

:::::::::::::::::::::::::::::::::::::::::::::::::::

You are now ready for the workshop!

Below is a summary table of what have been installed in your machine after following the instructions above. Please use this summary for reference and DO NOT install the software from it unless you encounter issues with the installation above. The links in the table provide more detailed software- and platform-specific information.

| Software | Install | Manual | Available for         | Description                                                   | 
| -------- | ------- | ------ | --------------------- | ------------------------------------------------------------- |
| [GDAL](https://www.gdal.org)         | [Link](https://gdal.org/download.html)        | [Link](https://gdal.org)       | Linux, MacOS, Windows | Geospatial model for reading and writing a variety of formats | 
| [GEOS](https://trac.osgeo.org/geos)         | [Link](https://trac.osgeo.org/geos)        | [Link](https://geos.osgeo.org/doxygen/)       | Linux, MacOS, Windows | Geometry models and operations                                | 
| [PROJ.4](https://proj4.org)         | [Link](https://proj4.org/install.html)        | [Link](https://proj4.org/index.html)       | Linux, MacOS, Windows | Coordinate reference system transformations                   | 
| [R](https://www.r-project.org)         | [Link](https://cloud.r-project.org)        | [Link](https://cloud.r-project.org)       | Linux, MacOS, Windows | Software environment for statistical and scientific computing | 
| [RStudio](https://www.rstudio.com)         | [Link](https://www.rstudio.com/products/rstudio/download/#download)        |        | Linux, MacOS, Windows | GUI for R                                                     | 
| [UDUNITS](https://www.unidata.ucar.edu/software/udunits/)         | [Link](https://www.unidata.ucar.edu/downloads/udunits/index.jsp)        | [Link](https://www.unidata.ucar.edu/software/udunits/#documentation)       | Linux, MacOS, Windows | Unit conversions                                              | 

