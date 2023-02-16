# Shiny overview
# Example 1 SOLUTION
# Basic functionality

# **** solutions! ***** #
# 1) Change the dog breed selectInput() to radio buttons.
# 2) See how the dogs dataframe is filtered the same way in each output object? Turn the filtered dogs dataframe into a reactive object instead, using rdogs <- reactive().

library(tidyverse)
library(kableExtra)
library(shiny)

load(here::here("01_basics", "ZurichDogs.RData"))

# Define UI
ui <- fluidPage(

  # Application title
  titlePanel("Dogs of Zurich"),

  # Sidebar with a dropdown menu for breed
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "breed",
        label = "Breed:",
        choices = c(
          "Mischling klein",
          "Chihuahua",
          "Labrador Retriever",
          "Jack Russel Terrier"
        ),
        selected = "Mischling klein"
      ),
    ),

    # Show a plot of the city-wide distribution
    mainPanel(
      h3("District-level patterns"),
      column(
        6, # column() modifies the layout (# is the column width - full-page width is 12)
        plotOutput("distPlot")
      ),
      p(), # a line break
      p(),
      column(
        6,
        plotOutput("birthdayPlot")
      )
    ) # /mainPanel
  )
) # /fluidPage


# Server logic
server <- function(input, output) {
  rdogs <- reactive(dogs %>%
    filter(BREED == input$breed & !is.na(DISTRICT)))

  output$distPlot <- renderPlot({
    # count of chosen breed x by district
    rdogs() %>%
      ggplot(aes(x = factor(DISTRICT))) +
      geom_bar(fill = "#74CEB7") +
      xlab("District") +
      ylab("Number of dogs") +
      ggtitle(paste0("Count of ", input$breed, "s \n in each district")) +
      theme_light(base_size = 16)
  })

  # use inputs here to subset the data to the user's district of choice:
  # breed = "Shih Tzu"

  output$birthdayPlot <- renderPlot({
    rdogs() %>%
      filter(DOG_BIRTHDAY < 2020) %>%
      ggplot(aes(
        x = factor(DISTRICT),
        y = DOG_BIRTHDAY
      )) +
      geom_boxplot() +
      xlab("District") +
      ylab("Dog's birth year") +
      ggtitle(paste0("Birthdays of \n", input$breed, "s")) +
      theme_light(base_size = 16)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
