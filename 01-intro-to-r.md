---
title: 'Introduction to R and RStudio'
teaching: 45
exercises: 5 
---



:::::::::::::::::::::::::::::::::::::: questions 

- How can I find my way around RStudio?
- How can I manage projects in R?
- How can I install packages?
- How can I interact with R?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After completing this episode, participants should be able to…

- Create self-contained projects in RStudio
- Install additional packages using R code.
- Manage packages
- Define a variable
- Assign data to a variable
- Call functions


::::::::::::::::::::::::::::::::::::::::::::::::

# Project management in RStudio  

RStudio is an integrated development environment (IDE), which means 
it provides a (much prettier) interface for the R software. For RStudio to work, 
you need to have R installed on your computer. But R is integrated into RStudio,
so you never actually have to open R software.

RStudio provides a useful feature: creating projects - 
self-contained working space (i.e. working directory), to which R will refer to,
when looking for and saving files. 
You can create projects in existing directories (folders) or create a new one. 

## Creating RStudio Project 

We’re going to create a project in RStudio in a new directory.
To create a project, go to: 

- `File` 
- `New Project` 
- `New directory` 
- Place the project that you will easily find on your laptop and name the project `data-carpentry`
- `Create project`


## Organising working directory

Creating an RStudio project is a good first step towards good project management. 
However, most of the time it is a good idea to organize working space further. 
This is one suggestion of how your R project can look like.
Let's go ahead and create the other folders:

- `data/` - should be where your raw data is. **READ ONLY**
- `data_output/` - should be where your data output is saved **READ AND WRITE**
- `documents/` - all the documentation associated with the project (e.g. cookbook)
- `fig_output/` - your figure outputs go here **WRITE ONLY**
- `scripts/` - all your code goes here **READ AND WRITE**

![R project organization](fig/rstudio_project_files.jpeg){alt="RStudio 
project logo with five lines, each leading from the logo towards 
one of the five boxes with texts: 'data/', 'data_output/',  'documents/',
'fig_output/', 'scripts/'"}


You can create these folders as you would any other folders on your laptop, but 
R and RStudio offer handy ways to do it directly in your RStudio session.

You can use RStudio interface to create a folder in your project by going to
lower-bottom pane, files tab, and clicking on Folder icon. 
A dialog box will appear, 
allowing you typing a name of a folder you want to create.

An alternative solution is to create the folders using R command `dir.create()`. 
In the console type: 


```r
dir.create("data")
dir.create("data_output")
dir.create("documents")
dir.create("fig_output")
dir.create("scripts")
```

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

In interest of time, focus on one way of creating the folders. You can showcase 
an alternative method with just one example. 

Once you have finished, ask the participants if they have managed to create a 
R Project and get the same folder structure. 
To do this, use green and red stickers.

This will become important, as we use relative paths together with `here`
package to read and write objects. 

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

## Two main ways to interact with R

There are two main ways to interact with R through RStudio: 

- test and play environment within the interactive **R console** 
- write and save an **R script (`.R` file)**  

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: callout

When you open the RStudio or create the Rstudio project, you will see Console 
window on the left by default. Once you create an R script, 
it is placed in the upper left pane. 
The Console is moved to the bottom left pane.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


Each of the modes o interactions has its advantages and drawbacks. 
    
|        | Console | R script|
|--------|---------|---------|
|**Pros**|Immediate results| Complete record of your work |
|**Cons**| Work lost once you close RStudio  | Messy if you just want to print things out|
 


## Creating a script

During the workshop we will mostly use an `.R` script to have a full documentation 
of what has been written. This way we will also be able to reproduce the results.
Let's create one now and save it in the `scripts` directory.

- `File` 
- `New File` 
- `R Script` 
- A new `Untitled` script will appear in the source pane. 
- Save it using floppy disc icon. 
- Select the `scripts/` folder as the file location
- Name the script `intro-to-r.R`


## Running the code

Note that all code written in the script can be also executed at a spot in the  
interactive console. 
We will now learn how to run the code both in the console and the script.

- In the Console you run the code by hitting <kbd>Enter</kbd> 
  at the end of the line
- In the R script there are two way to execute the code:
   + You can use the `Run` button on the top right of the script window. 
   + Alternatively, you can use a keyboard shortcut: <kbd>Ctrl</kbd>  +
     <kbd>Enter</kbd> or <kbd>Command</kbd> + <kbd>Return</kbd> for MAC users.
     
In both cases, the active line (the line where your cursor is placed) or a 
highlighted snippet of code will be executed. A common source of error in scripts,
such as a previously created object not found, is code that has not been executed in 
previous lines: make sure that all code has been executed as described above. 
To run all lines before the active line, you can use the keyboard shortcut 
<kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>B</kbd> on Windows/Linux or 
<kbd>Command</kbd> + <kbd>option</kbd> + <kbd>B</kbd> on Mac.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: callout

### Escaping

The console shows it's ready to get new commands with `>` sign. 
It will show `+` sign if it still requires input for the command to be executed.

Sometimes you don't know what is missing/ you change your mind and 
want to run something else, or your code is running much too long 
and you just want it to stop. 
The way to do it is to press <kbd>Esc</kbd>.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

## Packages 

A great power of R lays in **packages: add-on sets of functions** that are build
by the community and once they go through a quality process they are available to
download from a repository called `CRAN`. They need to be explicitly activated. 
Now, we will be using `tidyverse` package, 
which is actually a collection of useful packages. 
Another package that we will use is `here`.

You were asked to install `tidyverse` package in the preparation for the workshop.
You need to install a package only once, so you won't have to do it again. 
We will however need to install the `here` package. To do so, please go to your 
script and type:


```r
install.packages("here")
```

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: callout

If you are not sure if you have `tidyverse` packaged installed, you can check it
in the `Packages` tab in the bottom right pane. 
In the search box start typing '`tidyverse`'  and see if it appears in the list 
of installed packages. If not, you will need to install it by writing in 
the script:


```r
install.packages('tidyverse')
```

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: callout

### Commenting your code

Now we have a bit of an issue with our script. As mentioned, the packages need to 
be installed only once, but now, they will be installed each time we run the script, 
which can take a lot of time if we're installing a large package like `tidyverse`.

To keep a trace of you installing the packages, without executing it, you can use
a comment. In `R`, anything that is written after a has sign `#`, is ignored in 
execution. Thanks to this feature, you can annotate your code. 
Let's adapt our script by changing the first lines into comments: 


```r
# install.packages('here')
# install.packages('tidyverse')
```

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


Installing packages is not sufficient to work with them. You will need to load 
them each time you want to use them. To do that you use `library()` command:


```r
# Load packages
library(tidyverse)
library(here)
```

## Handling paths 

You have created a project which is your working directory, 
and a few sub-folders, that will help you organise your project better. 
But now, each time you will save or retrieve a file from those folders,
you will need to specify the path from the folder you are in 
(most likely the `scripts/` folder) to those files. 

That can become complicated and might cause a reproducibility problem,
if the person using your code (including future you) 
is working in a different sub-folder. 


We will use the `here()` package to tackle this issue. This package converts relative
paths from the root (main folder) of your project to absolute paths (the exact 
location on your computer). For instance, instead of writing out the full path like 
"C:/Users/YourName/Documents/r-geospatial-urban/data/file.csv" or 
"~/Documents/r-geospatial-urban/data/file.csv", you can use the `here()` function 
to create a path relative to your project's main directory. This makes your code 
more portable and reproducible, as it doesn't depend on a specific location of 
your project on your computer.

It might be confusing, so let's see how it works. We will use the `here()` function
from the `here` package. In the console, we write:


```r
here()
here('data')
```

You all probably have something different printed out. And this is fine, because
`here` adapts to your computer's specific situation. 


## Download files  

We still need to download data for the first part of the workshop. 
You can do it with the function `download.file()`. 
We will save it in the `data/` folder, where the **raw** data should go. 
In the script, we will write: 


```r
# Download the data
download.file(
  "https://bit.ly/geospatial_data",
  here("data", "gapminder_data.csv")
)
```

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: callout

# Importing data into R

Three of the most common ways of importing data in R are:

- loading a package with pre-installed data;
- downloading data from a URL;
- reading a file from your computer.

For larger datasets, database connections or API requests are also possible. We
will not cover these in the workshop.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Introduction to R

You can use R as calculator, you can for example write:


```r
1 + 100
1 * 100
1 / 100
```


## Variables and assignment

However, what's more useful is that in R we can store values and
use them whenever we need to. 
We using the assignment operator `<-`, like this:


```r
x <- 1 / 40
```

Notice that assignment does not print a value. Instead, we've stored it for later 
in something called a variable. `x` variable now contains the value `0.025`:

```r
x
```

Look for the `Environment` tab in the upper right pane of RStudio. 
You will see that `x` and its value have appeared in the list of Values. 
Our variable `x` can be used in place of a number in any calculation that expects
a number, e.g. when calculating a square root:


```r
sqrt(x)
```

Variables can be also reassigned. This means that we can assign a new value to 
variable `x`:

```r
x <- 100
x
```

You can use one variable to create a new one:

```r
y <- sqrt(x) # you can use value stored in object x to create y
y
```



::::::::::::::::::::::::::::::::::::: keypoints 

- Use RStudio to write and run R programs.
- Use `install.packages()` to install packages.
- Use `library()` to load packages.

::::::::::::::::::::::::::::::::::::::::::::::::

