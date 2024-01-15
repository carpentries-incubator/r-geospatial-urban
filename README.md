# Data Carpentry for Geospatial Data in Urbanism

A Data Carpentry workshop aims to teach researchers basic concepts, skills and tools for working with data, so that they can get more done in less time and with less pain.

The Data Carpentry for Geospatial Data in Urbanism is a two full days hands-on workshop (live coding and exercises), which covers:

- Introduction to R for Geospatial Data (e.g. Import data into R, calculate summary statistics, and create publication-quality graphics)  
- Introduction to Geospatial Vector and Raster Data with R (e.g. Open, work with, and plot vector and raster-format spatial data in R)  

Participants must have access to a computer with a Mac, Linux, or Windows operating system (not a tablet, Chromebook, etc.) that they have administrative privileges on. They should have a few specific software packages installed (listed here). No previous knowledge of the tools that will be presented in the workshop is required.



# The Carpentries Workbench Template R Markdown Lesson

This lesson is a template lesson that uses [The Carpentries Workbench][workbench].

## Create a new repository from this template

To use this template to start a new lesson repository, 
make sure you're logged into Github.   
Visit https://github.com/carpentries/workbench-template-rmd/generate
and follow the instructions.
Checking the 'Include all branches' option will save some time waiting for the first website build
when your new repository is initialised.

If you have any questions, contact [@zkamvar](https://github.com/zkamvar)

## Configure a new lesson

Follow the steps below to
complete the initial configuration of a new lesson repository built from this template:

1. **Make sure GitHub Pages is activated:**
   navigate to _Settings_,
   select _Pages_ from the left sidebar,
   and make sure that `gh-pages` is selected as the branch to build from.
   If no `gh-pages` branch is available, check _Actions_ to see if the first
   website build workflows are still running.
   The branch should become available when those have completed.
1. **Adjust the `config.yaml` file:**
   this file contains global parameters for your lesson site.
   Individual fields within the file are documented with comments (beginning with `#`)
   At minimum, you should adjust all the fields marked 'FIXME':
   - `title`
   - `created`
   - `keywords`
   - `life_cycle` (the default, _pre-alpha_, is the appropriate for brand new lessons)
   - `contact`
1. **Annotate the repository** with site URL and topic tags:
   navigate back to the repository landing page and
   click on the gear wheel/cog icon (similar to ⚙️) 
   at the top-right of the _About_ box.
   Check the "Use your GitHub Pages website" option,
   and [add some keywords and other annotations to describe your lesson](https://cdh.carpentries.org/the-carpentries-incubator.html#topic-tags)
   in the _Topics_ field.
   At minimum, these should include:
   - `lesson`
   - the life cycle of the lesson (e.g. `pre-alpha`)
   - the human language the lesson is written in (e.g. `deutsch`)
1. **Adjust the name of the `.Rproj` file.**
   It is simplest to make this match the name of the repository.
1. **Adjust the 
   `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, and `LICENSE.md` files**
   as appropriate for your project.
   -  `CODE_OF_CONDUCT.md`: 
      if you are using this template for a project outside The Carpentries,
      you should adjust this file to describe 
      who should be contacted with Code of Conduct reports,
      and how those reports will be handled.
   -  `CONTRIBUTING.md`:
      depending on the current state and maturity of your project,
      the contents of the template Contributing Guide may not be appropriate.
      You should adjust the file to help guide contributors on how best
      to get involved and make an impact on your lesson.
   -  `LICENSE.md`:
      in line with the terms of the CC-BY license,
      you should ensure that the copyright information 
      provided in the license file is accurate for your project.
1. **Update this README with 
   [relevant information about your lesson](https://carpentries.github.io/lesson-development-training/collaborating-newcomers.html#readme)**
   and delete this section.

[workbench]: https://carpentries.github.io/sandpaper-docs/
