#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# This particular app has a translation feature so that users can switch between languages

library(shiny)
library(shiny.i18n)

i18n <- Translator$new(
    translation_json_path = here::here("04_translation",
                                          "translateapp",
                                          "translationkey.json"))
i18n$set_translation_language("en") # set default language

# Define UI
ui <- fluidPage(
    shiny.i18n::usei18n(i18n),
    titlePanel(i18n$t("Hello Shiny!"), windowTitle = NULL),
    sidebarLayout(
        sidebarPanel(
            radioButtons(
                inputId = "selected_language",
                label = "Language",
                choiceNames = c("English", "Español", "Français"),
                choiceValues = i18n$get_languages(), #c("en","es","fr"),
                selected = i18n$get_key_translation(),
                inline = FALSE
            ),
            sliderInput("bins",
                        i18n$t("Number of bins:"), # the i18n$t() wrapper tells shiny that you want to translate that text object
                        min = 1,
                        max = 50,
                        value = 30)
        ),
        mainPanel(
            plotOutput("distPlot"),
            p(i18n$t("Here is a plot with some data."))
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) { #need the "session" at the end
    # The "observeEvent()" part tells Shiny to observe the input 'selected_language' and change the translation settings based on user input:
    observeEvent(input$selected_language, {
        print(paste("Language change:",
                    input$selected_language))
        update_lang(session, input$selected_language)
    })
    
    output$page_content <- renderUI({
        tagList(
            sidebarLayout(
                sidebarPanel(
                    sliderInput(inputId = "bins",
                                label = i18n$t("Number of bins:"),
                                min = 1,
                                max = 50,
                                value = 30),
                    radioButtons(
                        inputId = "selected_language",
                        label = "Language",
                        choiceNames = c("English", "Español", "Français"),
                        choiceValues = i18n$get_languages(),
                        selected = i18n$get_key_translation(),
                        inline = FALSE
                    )
                ),
                
                # Show a plot of the generated distribution
                mainPanel(
                    plotOutput("distPlot")
                )
            )
        ) #end of tagList
    }) # end of renderUI
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white', main = '')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
