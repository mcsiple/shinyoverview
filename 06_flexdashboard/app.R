# Shiny overview
# Example 6
# Making dashboards

# This is a "basic" dashboard

library(shiny)
library(shinydashboard)
library(palmerpenguins) #install.packages("palmerpenguins")
library(tidyverse)

ui <- dashboardPage(
  skin="purple", #"skins" are themes for your dashboard.
  dashboardHeader(title = "Penguins"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Tab 1", tabName = "tab1", icon = icon("heart")),
      menuItem("Tab 2", tabName = "tab2", icon = icon("feather")) 
    )
  ), #/dashboardSidebar
  dashboardBody(
    # Boxes need to be put in a row (or column)
    tabItems(
      tabItem(tabName = "tab1",
          fluidPage(
            fluidRow(
      box(width = 12, plotOutput("plot1", height = 300))),
      fluidRow(
        infoBox("Chinstrap", 
                penguins %>% filter(species=="Chinstrap") %>% count(),
                color = "purple", icon = icon("plus"))
      ,
      infoBox("Adelie", 
              penguins %>% filter(species=="Adelie") %>% count(),
              color = "orange", icon = icon("plus"))
      ,
      infoBox("Gentoo", 
              penguins %>% filter(species=="Gentoo") %>% count(),
              color = "aqua", icon = icon("plus"))
          ) #/fluidPage
      )

    ),# /tabItem
      
    tabItem(tabName = "tab2",
            h2("Widgets tab content")
    )
    
    ) #/tabItems
)  # /dashboardBody
) # /dashboardPage

server <- function(input, output) {

  output$plot1 <- renderPlot({
    mass_flipper <- ggplot(data = penguins, 
                           aes(x = flipper_length_mm,
                               y = body_mass_g)) +
      geom_point(aes(color = species, 
                     shape = species),
                 size = 3,
                 alpha = 0.8) +
      scale_color_manual(values = c("orange","purple","cyan")) +
      labs(title = "Penguin size, Palmer Station LTER",
           subtitle = "Flipper length and body mass for Adelie, Chinstrap and Gentoo Penguins",
           x = "Flipper length (mm)",
           y = "Body mass (g)",
           color = "Penguin species",
           shape = "Penguin species") +
      theme(legend.position = c(0.2, 0.7),
            plot.title.position = "plot",
            plot.caption = element_text(hjust = 0, face= "italic"),
            plot.caption.position = "plot") +
      theme_light()
    
    mass_flipper
  })
}

shinyApp(ui, server)