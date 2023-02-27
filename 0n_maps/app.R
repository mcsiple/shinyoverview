library(tidyverse)
library(shiny)
library(leaflet)
library(gamair) # for mackerel dataset
library(shinythemes)

# User interface
ui <- fluidPage(
  theme = shinytheme("darkly"),
  titlePanel("Spatial data in leaflet: Mackerel eggs"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "which_var",
        label = "Which environmental variable to show:",
        choiceValues = c("salinity", "flow", "temp.surf"),
        choiceNames = c("Salinity", "Flow", "Surface temperature")
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Map",
          leafletOutput("mymap"),
          p()
        ),
        tabPanel(
          "Correlation",
          plotOutput("user_corr")
        )
      )
    )
  )
)


server <- function(input, output, session) {
  output$mymap <- renderLeaflet({
    data(mack)
    fishpal <- colorNumeric(RColorBrewer::brewer.pal(6, name = "YlOrRd"), mack$var2plot)

    var2plot <- mack[, input$which_var]

    dat2plot <- mack %>%
      add_column(var2plot) %>%
      filter(egg.dens > 0 & !is.na(var2plot))

    leaflet(data = dat2plot) %>%
      addTiles() %>%
      addCircleMarkers(
        ~lon, ~lat,
        radius = ~ egg.dens / 30,
        color = ~ fishpal(var2plot),
        stroke = FALSE,
        fillOpacity = 0.5
      ) %>%
      addProviderTiles("Esri.WorldImagery")
  })

  output$user_corr <- renderPlot({
    data(mack)
    var2plot <- mack[, input$which_var] # mack[,"salinity"]#
    mack %>%
      add_column(var2plot) %>%
      ggplot(aes(x = egg.dens / 30, y = var2plot)) +
      geom_point() +
      xlab("Egg density / 30") +
      ylab(stringr::str_to_sentence(get("input")[["which_var"]])) +
      hrbrthemes::theme_ft_rc() +
      theme(
        axis.title.x = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        axis.text = element_text(size = 16),
        plot.background = element_rect(fill = "#222222"),
        panel.background = element_rect(fill = "#222222")
      )
  })
}

shinyApp(ui, server)