---
title: 'Data Structures'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What are the basic data types in R?
- How do I represent categorical information in R?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After completing this episode, participants should be able to…

- To be aware of the different types of data.
- To begin exploring data frames, and understand how they are related to vectors, factors and lists.
- To be able to ask questions from R about the type, class, and structure of an object.

::::::::::::::::::::::::::::::::::::::::::::::::

## Vectors 
So far we've looked on individual values. Now we will move to a data structure 
called vectors. Vectors are arrays of values of the same data type. 

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: callout

### Data types 

Data type refers to a type of information that is stored by a value. 
It can be:

- `numerical` (a number)
- `integer` (a number without information about decimal points)
- `logical` (a boolean - are values TRUE or FALSE?)
- `character` (a text/ string of characters)
- `complex` (a complex number)
- `raw` (raw bytes)

We won't discuss `complex` or `raw` data type in the workshop.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: callout

### Data structures

Vectors are the most common and basic data structure in R but you will come 
across other data structures such as data frames, lists and matrices as well.
In short:

- data.frames is a two-dimensional data structure in which columns are vectors of the same length that can have different data types. We will use this data structure in this lesson.
- lists can have an arbitrary structure and can mix data types;
- matrices are two-dimensional data structures containing elements of the same data type.

For a more detailed description, see [Data Types and Structures](https://swcarpentry.github.io/r-novice-inflammation/13-supp-data-structures.html).

Note that vector data in the geospatial context is different from vector data types. More about vector data in a [later lesson](../episodes/09-open-and-plot-vector-layers.Rmd)!

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

You can create a vector with a `c()` function. 


```r
# vector of numbers - numeric data type.
numeric_vector <- c(2, 6, 3) 
numeric_vector
```

```output
[1] 2 6 3
```

```r
# vector of words - or strings of characters- character data type
character_vector <- c('Amsterdam', 'London', 'Delft') 
character_vector
```

```output
[1] "Amsterdam" "London"    "Delft"    
```

```r
# vector of logical values (is something true or false?)- logical data type.
logical_vector <- c(TRUE, FALSE, TRUE) 
logical_vector
```

```output
[1]  TRUE FALSE  TRUE
```

### Combining vectors 

The combine function, `c()`, will also append things to an existing vector:


```r
ab_vector <- c('a', 'b')
ab_vector
```

```output
[1] "a" "b"
```

```r
abcd_vector <- c(ab_vector, 'c', 'd')
abcd_vector
```

```output
[1] "a" "b" "c" "d"
```

### Missing values

::::::::::::::::::::::::::::::::::::: challenge 

### Challenge: combining vectors 

Combine the `abcd_vector` with the `numeric_vector` in R. What is the data type of this new vector and why?

:::::::::::::::::::::::: solution 

```
combined_vector <- c(abcd_vector, numeric_vector)
combined_vector
```
The combined vector is a character vector. Because vectors can only hold one data type and `abcd_vector` cannot be interpreted as numbers, the numbers in `numeric_vector` are _coerced_ into characters.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

A common operation you want to perform is to remove all the missing values 
(in R denoted as `NA`). Let's have a look how to do it: 


```r
with_na <- c(1, 2, 1, 1, NA, 3, NA ) # vector including missing value
```

First, let's try to calculate mean for the values in this vector

```r
mean(with_na) # mean() function cannot interpret the missing values
```

```output
[1] NA
```

```r
# You can add the argument na.rm=TRUE to calculate the result while
# ignoring the missing values.
mean(with_na, na.rm = T) 
```

```output
[1] 1.6
```

However, sometimes, you would like to have the `NA` 
permanently removed from your vector. 
For this you need to identify which elements of the vector hold missing values 
with `is.na()` function. 


```r
is.na(with_na) # This will produce a vector of logical values, 
```

```output
[1] FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE
```

```r
# stating if a statement 'This element of the vector is a missing value'
# is true or not

!is.na(with_na) # The ! operator means negation, i.e. not is.na(with_na)
```

```output
[1]  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE
```

We know which elements in the vectors are `NA`.
Now we need to retrieve the subset of the `with_na` vector that is not `NA`.
Sub-setting in `R` is done with square brackets`[ ]`. 


```r
without_na <- with_na[ !is.na(with_na) ] # this notation will return only
# the elements that have TRUE on their respective positions

without_na
```

```output
[1] 1 2 1 1 3
```


## Factors 

Another important data structure is called a **factor**. 
Factors look like character data, but are used to represent categorical information.

Factors create a structured relation between the different levels (values) of a
categorical variable, such as days of the week or responses to a question in a
survey. While factors look (and often behave) like character vectors, they are 
actually treated as numbers by `R`, which is useful for computing summary 
statistics about their distribution, running regression analysis, etc.
So you need to be very careful when treating them as strings.

### Create factors
Once created, factors can only contain a pre-defined set of values, 
known as levels. 


```r
nordic_str <- c('Norway', 'Sweden', 'Norway', 'Denmark', 'Sweden')
nordic_str # regular character vectors printed out
```

```output
[1] "Norway"  "Sweden"  "Norway"  "Denmark" "Sweden" 
```

```r
# factor() function converts a vector to factor data type
nordic_cat <- factor(nordic_str)
nordic_cat # With factors, R prints out additional information - 'Levels'
```

```output
[1] Norway  Sweden  Norway  Denmark Sweden 
Levels: Denmark Norway Sweden
```

### Inspect factors
R will treat each unique value from a factor vector as a **level** and (silently)
assign numerical values to it. 
This can come in handy when performing statistical analysis. 
You can inspect and adapt levels of the factor. 


```r
levels(nordic_cat) # returns all levels of a factor vector.  
```

```output
[1] "Denmark" "Norway"  "Sweden" 
```

```r
nlevels(nordic_cat) # returns number of levels in a vector
```

```output
[1] 3
```

### Reorder levels
Note that `R` sorts the levels in the alphabetic order, 
not in the order of occurrence in the vector. `R` assigns value of:

- 1 to level 'Denmark',
- 2 to 'Norway' 
- 3 to 'Sweden'.

This is important as it can affect e.g. the order in which categories are 
displayed in a plot or which category is taken as a baseline in a statistical model.

You can reorder the categories using `factor()` function. This can be useful, for instance, to select a reference category (first level) in a regression model or for ordering legend items in a plot, rather than using the default category systematically (i.e. based on alphabetical order).


```r
nordic_cat <- factor(
  nordic_cat,
  levels = c(
    "Norway",
    "Denmark",
    "Sweden"
  )
)

# now Norway will be the first category, Denmark second and Sweden third
nordic_cat
```

```output
[1] Norway  Sweden  Norway  Denmark Sweden 
Levels: Norway Denmark Sweden
```


:::::::::::::::::::::::::::::::::::::::::::::::::::::: callout 
There is more than one way to reorder factors. Later in the lesson,
we will use `fct_relevel()` function from `forcats` package to do the reordering.


```r
library(forcats)

nordic_cat <- fct_relevel(
  nordic_cat,
  "Norway",
  "Denmark",
  "Sweden"
) # With this, Norway will be  first category,
# Denmark second and Sweden third

nordic_cat
```

```output
[1] Norway  Sweden  Norway  Denmark Sweden 
Levels: Norway Denmark Sweden
```
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


You can also inspect vectors with `str()` function. In factor vectors, 
it shows the underlying values of each category. 
You can also see the structure in the environment tab of RStudio.


```r
str(nordic_cat) 
```

```output
 Factor w/ 3 levels "Norway","Denmark",..: 1 3 1 2 3
```

:::::::::::::::::::::::::::::::::::::::::::::::::::: callout 

### Note of caution 

Remember that once created, factors can only contain a pre-defined set of values,
known as levels. It means that whenever you try to add something to the factor
outside of this set, it will become an unknown/missing value detonated by
`R` as `NA`.



```r
nordic_str
```

```output
[1] "Norway"  "Sweden"  "Norway"  "Denmark" "Sweden" 
```

```r
nordic_cat2 <- factor(
  nordic_str,
  levels = c("Norway", "Denmark")
)

# because we did not include Sweden in the list of
# factor levels, it has become NA.
nordic_cat2
```

```output
[1] Norway  <NA>    Norway  Denmark <NA>   
Levels: Norway Denmark
```
::::::::::::::::::::::::::::::::::::::::::::::::::::



::::::::::::::::::::::::::::::::::::: keypoints 

- The mostly used basic data types in R are `numeric`, `integer`, `logical`, and `character`
- Use factors to represent categories in R.

::::::::::::::::::::::::::::::::::::::::::::::::

