#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)
library(shinythemes)

load(here::here("02_dataindataout",
                "explore_ram",
                "data",
                "DBdata[asmt][v4.491].RData"))

# Define UI
shinyUI(fluidPage(
    theme = shinytheme("cosmo"), # define theme here
    titlePanel("Explore the RAM legacy database"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "which_stocklong",
                        label = "Select a stock:",
                        choices = unique(timeseries_values_views$stocklong)
                        ),
            
            checkboxGroupInput(inputId = "which_ts",
                               label = "Select a time series to display:",
                               choiceNames = c("Total biomass",
                                               "Total catch",
                                               "Exploitation rate"),
                               choiceValues = c("TBbest", "TCbest", "ERbest"),
                               selected = "TBbest"
            ) #/checkboxGroupInput
        ), # /sidebarPanel
        
        mainPanel(
            h2("Your stock from RAM"),
            plotOutput("ts_plot"),
            h2("Preview of your RAM estimates"),
            tableOutput("bioparamHead"),
            h2("Download a CSV"),
            downloadButton(outputId = "summary",
                           label = "Download CSV")
        ) # /mainPanel <-- mark the ends of your ui components
    ) # /sidebarLayout
))
