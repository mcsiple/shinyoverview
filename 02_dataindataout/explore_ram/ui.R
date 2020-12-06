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
            # sliderInput("bins",
            #             "Number of bins:",
            #             min = 1,
            #             max = 50,
            #             value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            #plotOutput("distPlot"),
            tableOutput("bioparamHead")
            
        )
    )
))
