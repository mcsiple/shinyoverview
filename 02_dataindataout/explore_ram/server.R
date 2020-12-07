#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    subsetted_data <- reactive({
        df <- timeseries_values_views %>% 
            filter_at(vars(TBbest,TCbest, ERbest), any_vars(!is.na(.))) %>%
            filter(stocklong == input$which_stocklong) 
        df
    })
    
    output$bioparamHead <- renderTable({
        x <- subsetted_data()
        head(x)
    })
    
    # Time series that the user has selected
    output$ts_plot <- renderPlot({
        df <- subsetted_data() %>% # Here, we access the "reactive object" subsetted_data
            select(year, input$which_ts) %>%
            pivot_longer(cols = input$which_ts)
        
        df %>% 
            ggplot(aes(x = year, y = value, colour = name) ) +
            geom_line(lwd = 1.1) +
            scale_colour_viridis_d("Time series") +
            xlab("Year") +
            ylab("Value of estimate") +
            facet_wrap(~name) +
            theme_minimal(base_size = 14) +
            theme(legend.position = 'none')
    })
    
    # Downloadable csv of subsetted data
    output$summary <- downloadHandler(
        filename = function() {
            paste(input$which_stocklong, ".csv", sep = "")
        },
        content = function(file) {
            write.csv(x = subsetted_data(),
                      file,
                      row.names = FALSE)
        }
    )
    
})
