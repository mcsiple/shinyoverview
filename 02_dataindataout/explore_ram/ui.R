#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

load(here::here("02_dataindataout",
                "explore_ram",
                "data",
                "DBdata[asmt][v4.491].RData"))

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Explore the RAM legacy database"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "which_stocklong",
                        label = "Select a stock:",
                        choices = unique(timeseries_values_views$stocklong)),
            
            checkboxGroupInput(inputId = "which_ts",
                        label = "Select a time series to display:",
                        choiceNames = c("Total biomass",
                        "Total catch",
                        "Exploitation rate"),
                        choiceValues = c("TBbest","TCbest","ERbest")
                        )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tableOutput("bioparamHead"),
            plotOutput("ts_plot")
        )
    )
))
