---
title: 'Exploring Data Frames & Data frame Manipulation with dplyr '
teaching: 10
exercises: 2
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
- Load external data from a .csv file into a data frame.
- Summarize the contents of a data frame.
- Select certain columns in a data frame with the dplyr function select.
- Select certain rows in a data frame according to filtering conditions with the dplyr function filter.
- Link the output of one dplyr function to the input of another function with the ‘pipe’ operator %>%.
- Add new columns to a data frame that are functions of existing columns with mutate.
- Use the split-apply-combine concept for data analysis.
- Use summarize, group_by, and count to split a data frame into groups of observations, apply a summary statistics for each group, and then combine the results.

::::::::::::::::::::::::::::::::::::::::::::::::


# Exploring Data frames

Now we turn to the bread-and-butter of working with `R`: working with tabular data. In `R` data are stored in a data structure called **data frames**.  

A data frame is a representation of data in the format of a **table** where the columns are **vectors** that all have the **same length**. 


Because columns are vectors, each column must contain a **single type of data** (e.g., characters, numeric, factors). 
For example, here is a figure depicting a data frame comprising a numeric, a character, and a logical vector.

![A data frame](fig/data-frame.svg)
<br><font size="3">*Source*: [Data Carpentry R for Social Scientists ](https://datacarpentry.org/r-socialsci/02-starting-with-data/index.html#what-are-data-frames-and-tibbles)</font>


## Reading data

`read.csv()` is a function used to read coma separated data files (`.csv` format)). There are other functions for files separated with other delimiters. 
We're gonna read in the `gapminder` data set with information about countries' size, GDP and average life expectancy in different years.


```r
gapminder <- read.csv("data/gapminder_data.csv")
```

## Exploring dataset
Let’s investigate the `gapminder` data frame a bit; the first thing we should always do is check out what the data looks like.

It is important to see if all the variables (columns) have the data type that we require. For instance, a column might have numbers stored as characters, which would not allow us to make calculations with those numbers.


```r
str(gapminder) 
```

```output
'data.frame':	1704 obs. of  6 variables:
 $ country  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
 $ continent: chr  "Asia" "Asia" "Asia" "Asia" ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ gdpPercap: num  779 821 853 836 740 ...
```

We can see that the `gapminder` object is a data.frame with 1704 observations (rows) and 6 variables (columns). 

In each line after a `$` sign, we see the name of each column, its type and first few values. 


### First look at the dataset
There are multiple ways to explore a data set. Here are just a few examples:



```r
head(gapminder) # shows first 6  rows of the data set
```

```output
      country year      pop continent lifeExp gdpPercap
1 Afghanistan 1952  8425333      Asia  28.801  779.4453
2 Afghanistan 1957  9240934      Asia  30.332  820.8530
3 Afghanistan 1962 10267083      Asia  31.997  853.1007
4 Afghanistan 1967 11537966      Asia  34.020  836.1971
5 Afghanistan 1972 13079460      Asia  36.088  739.9811
6 Afghanistan 1977 14880372      Asia  38.438  786.1134
```

```r
summary(gapminder) # basic statistical information about each column.
```

```output
   country               year           pop             continent        
 Length:1704        Min.   :1952   Min.   :6.001e+04   Length:1704       
 Class :character   1st Qu.:1966   1st Qu.:2.794e+06   Class :character  
 Mode  :character   Median :1980   Median :7.024e+06   Mode  :character  
                    Mean   :1980   Mean   :2.960e+07                     
                    3rd Qu.:1993   3rd Qu.:1.959e+07                     
                    Max.   :2007   Max.   :1.319e+09                     
    lifeExp        gdpPercap       
 Min.   :23.60   Min.   :   241.2  
 1st Qu.:48.20   1st Qu.:  1202.1  
 Median :60.71   Median :  3531.8  
 Mean   :59.47   Mean   :  7215.3  
 3rd Qu.:70.85   3rd Qu.:  9325.5  
 Max.   :82.60   Max.   :113523.1  
```

```r
# Information format differes by data type.

nrow(gapminder) # returns number of rows in a dataset
```

```output
[1] 1704
```

```r
ncol(gapminder) # returns number of columns in a dataset
```

```output
[1] 6
```

### Dollar sign ($)

When you're analyzing a data set, you often need to access its specific columns.

One handy way to access a column is using it's name and a dollar sign `$`: 

```r
# This notation means: From dataset gapminder, give me column country. You can
# see that the column accessed in this way is just a vector of characters.
country_vec <- gapminder$country

head(country_vec)
```

```output
[1] "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan"
[6] "Afghanistan"
```
Note that the calling a column with a `$` sign will return a *vector*, it's not a data frame anymore.


# Data frame Manipulation with dplyr

## Select
Let's start manipulating the data. 

First, we will adapt our data set, by keeping only the columns we're interested in, using the `select()` function from the `dplyr` package:


```r
year_country_gdp <- select(gapminder, year, country, gdpPercap)

head(year_country_gdp)
```

```output
  year     country gdpPercap
1 1952 Afghanistan  779.4453
2 1957 Afghanistan  820.8530
3 1962 Afghanistan  853.1007
4 1967 Afghanistan  836.1971
5 1972 Afghanistan  739.9811
6 1977 Afghanistan  786.1134
```

## Pipe
Now, this is not the most common notation when working with `dplyr` package. `dplyr` offers an operator `%>%` called a pipe, which allows you build up very complicated commands in a readable way.


In newer installation of `R` you can also find a notation `|>` . This pipe works in a similar way. The main difference is that you don't need to load any packages to have it available.


The `select()` statement with pipe would look like that:


```r
year_country_gdp <- gapminder %>%
  select(year, country, gdpPercap)

head(year_country_gdp)
```

```output
  year     country gdpPercap
1 1952 Afghanistan  779.4453
2 1957 Afghanistan  820.8530
3 1962 Afghanistan  853.1007
4 1967 Afghanistan  836.1971
5 1972 Afghanistan  739.9811
6 1977 Afghanistan  786.1134
```

First we define data set, then - with the use of pipe we pass it on to the `select()` function. This way we can chain multiple functions together, which we will be doing now. 

## Filter

We already know how to select only the needed columns. But now, we also want to filter the rows of our data set via certain conditions with `filter()` function. Instead of doing it in separate steps, we can do it all together. 

In the `gapminder` data set, we want to see the results from outside of Europe for the 21st century. 

```r
year_country_gdp_euro <- gapminder %>%
  filter(continent != "Europe" & year >= 2000) %>%
  select(year, country, gdpPercap)
# '&' operator (AND) - both conditions must be met

head(year_country_gdp_euro)
```

```output
  year     country gdpPercap
1 2002 Afghanistan  726.7341
2 2007 Afghanistan  974.5803
3 2002     Algeria 5288.0404
4 2007     Algeria 6223.3675
5 2002      Angola 2773.2873
6 2007      Angola 4797.2313
```

::: challenge

##  Challenge: filtered data frame

Write a single command (which can span multiple lines and includes pipes) that will produce a data frame that has the values for life expectancy, country and year, only for Eurasia. How many rows does your data frame have and why? 

::: solution


```{.r .bg-info}
year_country_gdp_eurasia <- gapminder %>%
  filter(continent == "Europe" | continent == "Asia") %>%
  select(year, country, gdpPercap)
# '|' operator (OR) - one of the conditions must be met

nrow(year_country_gdp_eurasia)
```

```output
[1] 756
```

:::

:::

## Group and summarize
So far, we have provided summary statistics on the whole dataset, selected columns, and filtered the observations. But often instead of doing that, we would like to know statistics about all of the continents, presented by group.


```r
gapminder %>% # select the dataset
  group_by(continent) %>% # group by continent
  summarize(avg_gdpPercap = mean(gdpPercap)) # create basic stats
```

```output
# A tibble: 5 × 2
  continent avg_gdpPercap
  <chr>             <dbl>
1 Africa            2194.
2 Americas          7136.
3 Asia              7902.
4 Europe           14469.
5 Oceania          18622.
```

::: challenge

## Challenge: longest and shortest life expectancy

Calculate the average life expectancy per country. Which country has the longest average life expectancy and which has the shortest average life expectancy?

<strong>Hint</strong> Use `max()`  and `min()` functions to find minimum and maximum.

::: solution


```{.r .bg-info}
gapminder %>%
  group_by(country) %>%
  summarize(avg_lifeExp = mean(lifeExp)) %>%
  filter(avg_lifeExp == min(avg_lifeExp) |
    avg_lifeExp == max(avg_lifeExp))
```

```output
# A tibble: 2 × 2
  country      avg_lifeExp
  <chr>              <dbl>
1 Iceland             76.5
2 Sierra Leone        36.8
```

:::

:::

### Multiple groups and summary variables
You can also group by multiple columns:


```r
gapminder %>%
  group_by(continent, year) %>%
  summarize(avg_gdpPercap = mean(gdpPercap))
```

```output
# A tibble: 60 × 3
# Groups:   continent [5]
   continent  year avg_gdpPercap
   <chr>     <int>         <dbl>
 1 Africa     1952         1253.
 2 Africa     1957         1385.
 3 Africa     1962         1598.
 4 Africa     1967         2050.
 5 Africa     1972         2340.
 6 Africa     1977         2586.
 7 Africa     1982         2482.
 8 Africa     1987         2283.
 9 Africa     1992         2282.
10 Africa     1997         2379.
# ℹ 50 more rows
```

On top of this, you can also make multiple summaries of those groups:

```r
gdp_pop_bycontinents_byyear <- gapminder %>%
  group_by(continent, year) %>%
  summarize(
    avg_gdpPercap = mean(gdpPercap),
    sd_gdpPercap = sd(gdpPercap),
    avg_pop = mean(pop),
    sd_pop = sd(pop),
    n_obs = n()
  )
```

## Frequencies

If you need only a number of observations per group, you can use the `count()` function

```r
gapminder %>%
  group_by(continent) %>%
  count()
```

```output
# A tibble: 5 × 2
# Groups:   continent [5]
  continent     n
  <chr>     <int>
1 Africa      624
2 Americas    300
3 Asia        396
4 Europe      360
5 Oceania      24
```
 

## Mutate

Frequently you’ll want to create new columns based on the values in existing columns. For example, instead of only having the GDP per capita, we might want to create a new GDP variable and convert its units into Billions. For this, we’ll use `mutate()`.


```r
gapminder_gdp <- gapminder %>%
  mutate(gdpBillion = gdpPercap * pop / 10^9)

head(gapminder_gdp)
```

```output
      country year      pop continent lifeExp gdpPercap gdpBillion
1 Afghanistan 1952  8425333      Asia  28.801  779.4453   6.567086
2 Afghanistan 1957  9240934      Asia  30.332  820.8530   7.585449
3 Afghanistan 1962 10267083      Asia  31.997  853.1007   8.758856
4 Afghanistan 1967 11537966      Asia  34.020  836.1971   9.648014
5 Afghanistan 1972 13079460      Asia  36.088  739.9811   9.678553
6 Afghanistan 1977 14880372      Asia  38.438  786.1134  11.697659
```


::::::::::::::::::::::::::::::::::::: keypoints 

- We can use the `select()` and `filter()` functions to select certain columns in a data frame and to subset it based a specific conditions.
- With `mutate()`, we can create new columns in a data frame with values based on existing columns.
- By combining `group_by()` and `summarize()` in a pipe (`%>%`) chain,  we can generate summary statistics for each group in a data frame.

::::::::::::::::::::::::::::::::::::::::::::::::

