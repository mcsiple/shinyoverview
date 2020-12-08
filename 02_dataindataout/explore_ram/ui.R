#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# This app loads data from the RAM legacy stock assessment database and provides the option for users to download a CSV of the filtered data.

library(tidyverse)
library(shiny)
library(shinythemes)

source(here::here(
  "02_dataindataout",
  "explore_ram",
  "data",
  "loadDBdata[asmt][v4.491].r"
))

# Define UI
shinyUI(
  fluidPage(
    theme = shinytheme("cosmo"), # define theme
    titlePanel("Explore the RAM legacy database"),

    # Sidebar with options for what to display and download
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "which_stocklong",
          label = "Select a stock:",
          choices = unique(timeseries_values_views$stocklong)
        ),

        checkboxGroupInput(
          inputId = "which_ts",
          label = "Select a time series to display:",
          choiceNames = c(
            "Total biomass",
            "Total catch",
            "Exploitation rate"
          ),
          choiceValues = c("TBbest", "TCbest", "ERbest"),
          selected = "TBbest"
        ) # /checkboxGroupInput
      ), # /sidebarPanel

      mainPanel(
        h3("Your stock from RAM"),
        plotOutput("ts_plot"),
        h3("Estimates in RAM for your stock"),
        tableOutput("bioparamHead"),
        h3("Download a CSV"),
        p("Want to download the RAM legacy database entries for your stock of choice? Click below."),
        downloadButton(
          outputId = "summary",
          label = "Download CSV"
        )
      ) # /mainPanel <-- mark the ends of your ui components
    ) # /sidebarLayout
  )
)
