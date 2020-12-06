# Introduction to Shiny

Scripts for a presentation on Shiny and its utility, originally written for the Fay lab at UMassD.

***

If you want to try out the app examples, you should install the following packages:

```{r}
# Basics
library(tidyverse)

# Shiny
library(shiny)
library(shinyjs) # for javascript 
library(shiny.i18n) #for translation

# Maps and plotting
library(leaflet) # interactive maps
library(plotly) # interactive plots

# Making tutorials
library(learnr) # interactive tutorials
# remotes::install_github("rstudio-education/gradethis")
library(gradethis)
```

This talk will introduce Shiny and its glorious abilities, with the assumption that you have heard of Shiny but haven't necessarily used it yet. Because there are tons of great examples online, I have highlighted tools that I have found useful and fun. The talk structure will be, more or less:

1. The building blocks: basic `shiny` functionality
2. Getting data into and out of `shiny`
3. Translating `shiny` apps
4. Shiny as a teaching tool using `learnr` 
