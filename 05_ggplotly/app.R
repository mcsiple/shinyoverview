#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# This app shows an interactive plot of landings data in Alaska from NMFS: https://foss.nmfs.noaa.gov/

library(shiny)
library(plotly)
library(shinythemes)

source("00_initializeapp.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = shinytheme("cosmo"),
    
    # Application title
    titlePanel("West Coast crab landings"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons("state_select",
                         "Select a state:",
                         choices = unique(crabs$State),
                         selected = NULL
            )
        ),
        
        
        # Show a plot of the generated distribution
        mainPanel(
            plotlyOutput("interactive_plot")
        )
    )
)

# Server logic
server <- function(input, output) {
    output$interactive_plot <- renderPlotly({
        # plot an area plot of the data
        pl <- crabs %>%
            filter(State == input$state_select) %>%
            ggplot(aes(x = Year, y = Pounds / 1e6, fill = NMFS.Name)) +
            geom_area() +
            geom_area(aes(text = paste0(
                "<b>", "Year: ", "</b>", Year,
                "<br>",
                "<b>", "Product name: ", "</b>", NMFS.Name,
                "<br>",
                "<b>", "Dollar value: $", "</b>", format(round(Dollars, 0), big.mark = ",")
            ))) +
            ylab("Landings (Millions of pounds)") +
            ghibli::scale_fill_ghibli_d(name = "MononokeLight") +
            theme_classic()
        
        ggp <- ggplotly(p = pl, tooltip = "text") %>%
            style(hoveron = "points") %>%
            layout(xaxis = list( # add "spikes" along x axis
                showspikes = TRUE,
                spikemode = "across",
                spikedash = "solid",
                spikethickness = 1,
                hovermode = "compare"
            ))
        
        ggp
    })
}

# Run the application
shinyApp(ui = ui, server = server)
