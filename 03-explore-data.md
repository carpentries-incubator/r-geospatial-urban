---
title: 'Exploring Data Frames & Data frame Manipulation with dplyr '
teaching: 25
exercises: 10
---



:::::::::::::::::::::::::::::::::::::: questions 

- What is a data frame?
- How can I read data in R?
- How can I get basic summary information about my data set?
- How can I select specific rows and/or columns from a data frame?
- How can I combine multiple commands into a single command?
- How can I create new columns or remove existing columns from a data frame?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After completing this episode, participants should be able to…

- Describe what a data frame is.
- Load external data from a `.csv` file into a data frame.
- Summarize the contents of a data frame.
- Select certain columns in a data frame with the `dplyr` function `select()`.
- Select certain rows in a data frame according to filtering conditions with the `dplyr` function `filter()`.
- Link the output of one dplyr function to the input of another function with the ‘pipe’ operator `|>`.
- Add new columns to a data frame based on existing columns with mutate.
- Use `summarize()`, `group_by()`, and `count()` to split a data frame into groups of observations, apply a summary statistics to each group, and then combine the results.

::::::::::::::::::::::::::::::::::::::::::::::::


# Exploring Data frames

Now we turn to the bread-and-butter of working with `R`: working with tabular data. In `R` data are stored in a data structure called **data frames**.  

A data frame is a representation of data in the format of a **table** where the columns are **vectors** that all have the **same length**. 


Because columns are vectors, each column must contain a **single type of data** (e.g., characters, numeric, factors). 
For example, here is a figure depicting a data frame comprising a numeric, a character, and a logical vector.

![A data frame](fig/data-frame.svg)
<br><font size="3">*Source*: [Data Carpentry R for Social Scientists ](https://datacarpentry.org/r-socialsci/02-starting-with-data/index.html#what-are-data-frames-and-tibbles)</font>


## Reading data

`read.csv()` is a function used to read comma separated data files (`.csv` format)). There are other functions for files separated with other delimiters. 
We read in the `gapminder` data set with information about countries' size, GDP and average life expectancy in different years.


``` r
gapminder <- read.csv(here("data", "gapminder-data.csv"))
```

## Exploring dataset
Let’s investigate the `gapminder` data frame a bit; the first thing we should always do is check out what the data looks like.

It is important to see if all the variables (columns) have the data type that we require. For instance, a column might have numbers stored as characters, which would not allow us to make calculations with those numbers.


``` r
str(gapminder)
```

``` output
'data.frame':	2316 obs. of  6 variables:
 $ continent     : chr  "Africa" "Africa" "Africa" "Africa" ...
 $ country       : chr  "Algeria" "Algeria" "Algeria" "Algeria" ...
 $ year          : int  1962 1967 1972 1977 1982 1987 1992 1997 2002 2007 ...
 $ pop           : int  11800771 12876118 14427072 17015994 19872348 23443624 26628568 29579301 31750835 34189416 ...
 $ perc_urban_pop: num  34.5 39.1 39.8 40.8 44.8 ...
 $ gdp_per_capita: num  3211 4258 5537 6554 8316 ...
```

We can see that the `gapminder` object is a data.frame with 2316 observations (rows) and 6 variables (columns). 

In each line after a `$` sign, we see the name of each column, its type and first few values. 


### First look at the dataset
There are multiple ways to explore a data set. Here are just a few examples:



``` r
# Show first 6 rows of the data set
head(gapminder)
```

``` output
  continent country year      pop perc_urban_pop gdp_per_capita
1    Africa Algeria 1962 11800771       34.51176       3210.708
2    Africa Algeria 1967 12876118       39.10168       4257.662
3    Africa Algeria 1972 14427072       39.81607       5536.876
4    Africa Algeria 1977 17015994       40.77373       6553.959
5    Africa Algeria 1982 19872348       44.75414       8315.723
6    Africa Algeria 1987 23443624       49.73254       9299.413
```

``` r
# Basic statistical information about each column
# Information format differs by data type.
summary(gapminder) 
```

``` output
     continent         country          year           pop           
 Length   :2316   Length   :2316   Min.   :1962   Min.   :4.979e+03  
 N.unique :   4   N.unique : 193   1st Qu.:1976   1st Qu.:1.178e+06  
 N.blank  :   0   N.blank  :   0   Median :1990   Median :5.134e+06  
 Min.nchar:   4   Min.nchar:   3   Mean   :1990   Mean   :2.733e+07  
 Max.nchar:   8   Max.nchar:  30   3rd Qu.:2003   3rd Qu.:1.608e+07  
                                   Max.   :2017   Max.   :1.412e+09  
 perc_urban_pop    gdp_per_capita    
 Min.   :  2.014   Min.   :   316.1  
 1st Qu.: 28.718   1st Qu.:  2861.9  
 Median : 47.968   Median :  7405.4  
 Mean   : 48.744   Mean   : 15343.1  
 3rd Qu.: 67.857   3rd Qu.: 17848.8  
 Max.   :100.000   Max.   :352820.4  
```

``` r
# Return number of rows in a dataset
nrow(gapminder)
```

``` output
[1] 2316
```

``` r
# Return number of columns in a dataset
ncol(gapminder) 
```

``` output
[1] 6
```

### Dollar sign ($)

When you're analyzing a data set, you often need to access its specific columns.

One handy way to access a column is using it's name and a dollar sign `$`: 

``` r
# This notation means: From dataset gapminder, give me column country. You can
# see that the column accessed in this way is just a vector of characters.
country_vec <- gapminder$country

head(country_vec)
```

``` output
[1] "Algeria" "Algeria" "Algeria" "Algeria" "Algeria" "Algeria"
```

Now you can explore distinct values from a vector with the unique() function:

``` r
head(unique(country_vec), 10)
```

``` output
 [1] "Algeria"                  "Angola"                  
 [3] "Benin"                    "Botswana"                
 [5] "Burkina Faso"             "Burundi"                 
 [7] "Cameroon"                 "Cape Verde"              
 [9] "Central African Republic" "Chad"                    
```
Note that the calling a column with a `$` sign will return a *vector* - it's not a data frame anymore.


# Data frame Manipulation with dplyr

## Select
Let's start manipulating the data. 

First, we will adapt our data set, by keeping only the columns we're interested in, using the `select()` function from the `dplyr` package:


``` r
year_country_urb <- select(gapminder, year, country, perc_urban_pop)

head(year_country_urb)
```

``` output
  year country perc_urban_pop
1 1962 Algeria       34.51176
2 1967 Algeria       39.10168
3 1972 Algeria       39.81607
4 1977 Algeria       40.77373
5 1982 Algeria       44.75414
6 1987 Algeria       49.73254
```

## Pipe
Now, this is not the most common notation when working with `dplyr` package.
`R` offers an operator `|>` called a pipe, which allows you to build up complicated commands in a readable way.


::: callout

# The pipe

The `|>` operator, also called the "native pipe", was introduced in `R` version 4.1.0. 
Before that, the `%>%` operator from the `magrittr` package was widely used. 
The two pipes work in similar ways. 
The main difference is that you don't need to load any packages to have the native pipe available.

:::

The `select()` statement with a pipe would look like that:


``` r
year_country_urb <- gapminder |>
  select(year, country, perc_urban_pop)

head(year_country_urb)
```

``` output
  year country perc_urban_pop
1 1962 Algeria       34.51176
2 1967 Algeria       39.10168
3 1972 Algeria       39.81607
4 1977 Algeria       40.77373
5 1982 Algeria       44.75414
6 1987 Algeria       49.73254
```

First we define the dataset, then with the use of the pipe we pass it on to the `select()` function. 
This way we can chain multiple functions together. 

## Filter

We already know how to select only the needed columns. 
But now, we also want to filter the rows of our data set on certain conditions
with the `filter()` function. Instead of doing it in separate steps, we can do it all together. 

In the `gapminder` dataset, we want to see the results from outside of Europe for the 21st century. 


``` r
year_country_urb_noneuro <- gapminder |>
  filter(continent != "Europe" & year >= 2000) |>
  select(year, country, perc_urban_pop)
# '&' operator (AND) - both conditions must be met

head(year_country_urb_noneuro)
```

``` output
  year country perc_urban_pop
1 2002 Algeria       61.38127
2 2007 Algeria       65.16908
3 2012 Algeria       68.34213
4 2017 Algeria       71.32279
5 2002  Angola       52.89262
6 2007  Angola       57.75646
```

Let's now focus only on North American countries  

``` r
year_urb_namerica <- year_country_urb_noneuro |>
  filter(country == "Canada" |  country == "Mexico" | country == "United States") 

# '|' operator (OR) - at least one of the conditions must be met

head(year_urb_namerica)
```

``` output
  year country perc_urban_pop
1 2002  Canada       79.09902
2 2007  Canada       80.44256
3 2012  Canada       81.15135
4 2017  Canada       81.40189
5 2002  Mexico       75.68408
6 2007  Mexico       76.50473
```

::: challenge

##  Challenge: filtered data frame

Write a single command (which can span multiple lines and includes pipes) 
that will produce a data frame that has the values for **GDP per capita**, 
**country** and **year**, only for **EurAsia**. 

How many rows does your data frame have and why? 

::: solution


```{.r .bg-info}
year_country_gdp_eurasia <- gapminder |>
  filter(continent == "Europe" | continent == "Asia") |>
  select(year, country, gdp_per_capita)
# '|' operator (OR) - one of the conditions must be met

nrow(year_country_gdp_eurasia)
```

``` output
[1] 1248
```

:::

:::

## Group and summarize
So far, we have provided summary statistics on the whole dataset, selected columns, and filtered the observations. But often instead of doing that, we would like to know statistics by group. Let's calculate the average percentage of urban population by continent.


``` r
gapminder |> # select the dataset
  group_by(continent) |> # group by continent
  summarize(avg_perc_urban_pop = mean(perc_urban_pop)) # create basic stats
```

``` output
# A tibble: 4 × 2
  continent avg_perc_urban_pop
  <chr>                  <dbl>
1 Africa                  32.0
2 Americas                56.0
3 Asia                    47.1
4 Europe                  64.6
```

::: challenge

## Challenge: highest and lowest GDP per capita

Calculate the average GDP per capita per country. Which country has the highest average GDP per capita and which has the lowest?

<strong>Hint</strong> Use `max()`  and `min()` functions to find minimum and maximum.

::: solution


```{.r .bg-info}
gapminder |>
  group_by(country) |>
  summarize(avg_gdp_per_capita = mean(gdp_per_capita)) |>
  filter(avg_gdp_per_capita == min(avg_gdp_per_capita) |
           avg_gdp_per_capita == max(avg_gdp_per_capita))
```

``` output
# A tibble: 2 × 2
  country    avg_gdp_per_capita
  <chr>                   <dbl>
1 Monaco                182409.
2 Mozambique               773.
```

:::

:::

### Multiple groups and summary variables
You can also group by multiple columns:


``` r
gapminder |>
  group_by(continent, year) |>
  summarize(avg_perc_urban_pop = mean(perc_urban_pop))
```

``` output
# A tibble: 48 × 3
# Groups:   continent [4]
   continent  year avg_perc_urban_pop
   <chr>     <int>              <dbl>
 1 Africa     1962               16.8
 2 Africa     1967               19.7
 3 Africa     1972               23.1
 4 Africa     1977               26.1
 5 Africa     1982               28.7
 6 Africa     1987               31.7
 7 Africa     1992               34.7
 8 Africa     1997               36.4
 9 Africa     2002               38.3
10 Africa     2007               40.5
# ℹ 38 more rows
```

On top of this, you can also make multiple summaries of those groups:

``` r
urb_pop_bycontinents_byyear <- gapminder |>
  group_by(continent, year) |>
  summarize(
    avg_perc_urban_pop = mean(perc_urban_pop),
    sd_perc_urban_pop = sd(perc_urban_pop),
    avg_pop = mean(pop),
    sd_pop = sd(pop),
    n_obs = n()
  )

head(urb_pop_bycontinents_byyear)
```

``` output
# A tibble: 6 × 7
# Groups:   continent [1]
  continent  year avg_perc_urban_pop sd_perc_urban_pop   avg_pop    sd_pop n_obs
  <chr>     <int>              <dbl>             <dbl>     <dbl>     <dbl> <int>
1 Africa     1962               16.8              12.1  5509400.  8109418.    54
2 Africa     1967               19.7              12.8  6246703.  9144160.    54
3 Africa     1972               23.1              14.0  7124157. 10348870.    54
4 Africa     1977               26.1              15.1  8185263. 11830845.    54
5 Africa     1982               28.7              15.8  9485037. 13673487.    54
6 Africa     1987               31.7              16.2 10958077. 15757881.    54
```

## Frequencies

If you need only a number of observations per group, you can use the `count()` function

``` r
gapminder |>
  count(continent)
```

``` output
  continent   n
1    Africa 648
2  Americas 420
3      Asia 684
4    Europe 564
```
 

## Mutate

Frequently you’ll want to create new columns based on the values in existing columns. For example, instead of only having the GDP per capita, we might want to create a new GDP variable and convert its units into Billions. For this, we’ll use `mutate()`.


``` r
gapminder_gdp <- gapminder |>
  mutate(gdp_billion = gdp_per_capita * pop / 10^9)

head(gapminder_gdp)
```

``` output
  continent country year      pop perc_urban_pop gdp_per_capita gdp_billion
1    Africa Algeria 1962 11800771       34.51176       3210.708    37.88882
2    Africa Algeria 1967 12876118       39.10168       4257.662    54.82216
3    Africa Algeria 1972 14427072       39.81607       5536.876    79.88092
4    Africa Algeria 1977 17015994       40.77373       6553.959   111.52213
5    Africa Algeria 1982 19872348       44.75414       8315.723   165.25294
6    Africa Algeria 1987 23443624       49.73254       9299.413   218.01195
```


::::::::::::::::::::::::::::::::::::: keypoints 

- We can use the `select()` and `filter()` functions to select certain columns in a data frame and to subset it based a specific conditions.
- With `mutate()`, we can create new columns in a data frame with values based on existing columns.
- By combining `group_by()` and `summarize()` in a pipe (`|>`) chain,  we can generate summary statistics for each group in a data frame.

::::::::::::::::::::::::::::::::::::::::::::::::

