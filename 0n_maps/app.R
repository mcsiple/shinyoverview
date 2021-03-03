library(tidyverse)
library(shiny)
library(leaflet)
library(gamair) # for mack dataset
library(shinythemes)

# User interface
ui <- fluidPage(theme = shinytheme("darkly"),
  titlePanel("Spatial data in leaflet: Mackerel eggs"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "which_var",
                   label = "Which environmental variable to show:",
                   choiceValues = c("salinity","flow","temp.surf"), 
                   choiceNames = c("Salinity", "Flow", "Surface temperature")
                   )
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Map",
                 leafletOutput("mymap"),
                 p()), 
        tabPanel("Correlation", 
                 plotOutput("user_corr"))
      )
      )
    )
  )


server <- function(input, output, session) {
  
  output$mymap <- renderLeaflet({
    data(mack)
    fishpal <- colorNumeric(RColorBrewer::brewer.pal(6,name = "YlOrRd"), mack$var2plot)
 
    var2plot <- mack[,input$which_var]
    
    dat2plot <- mack %>% 
      add_column(var2plot) %>%
      filter(egg.dens>0 & !is.na(var2plot)) 
    
    leaflet(data = dat2plot) %>%
      addTiles() %>%
      addCircleMarkers(
        ~lon,~lat,
        radius = ~egg.dens/30,
        color = ~fishpal(var2plot),
        stroke = FALSE,
        fillOpacity = 0.5
      ) %>%
      addProviderTiles("Esri.WorldImagery")
  })
  
  output$user_corr <- renderPlot({
    data(mack)
    var2plot <- mack[,input$which_var]
    mack %>% 
      add_column(var2plot) %>%
      ggplot(aes(x=egg.dens/30,y = var2plot)) +
      geom_point() +
      xlab(get("input")[["which_var"]]) +
      ylab("Egg density / 30") +
      hrbrthemes::theme_ft_rc()
      
  })
}

shinyApp(ui, server)