# Introduction to Shiny

Scripts for a presentation on Shiny and its utility. The presentation and material have been adapted for many different uses-- hopefully yours is below!

Slides for various presentations are linked below.

***

If you want to try out the app examples, install the following packages:

```{r}
# Basics
library(tidyverse)
library(kableExtra) # nice tables

# Shiny
library(shiny)
library(shinythemes) # bootstrap themes

# Interactive plots
library(plotly) 

# Making tutorials
library(learnr) # interactive tutorials
# remotes::install_github("rstudio-education/gradethis")
library(gradethis)

# Visualizing reactivity
library(reactlog)
```

This talk will introduce Shiny and its glorious abilities, with the assumption that you have heard of Shiny but haven't necessarily used it yet. Because there are tons of great examples online, I have highlighted tools that I have found useful and fun. The talk structure will be, more or less:

1. The building blocks: basic `shiny` functionality
2. Getting data into and out of `shiny`
3. Lessons I learned during the app development process

These latter two sections are optional but materials are included for you to explore on your own:

4. Translating `shiny` apps using `{shiny.18n}`
5. Shiny as a teaching tool using `{learnr}` 
