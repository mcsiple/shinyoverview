#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# This app loads data from the RAM legacy stock assessment database and provides the option for users to download a CSV of the filtered data.

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
    
    # Plot of the time series selected by the user
    output$ts_plot <- renderPlot({
        # provide a nice error message that does not strike panic into the user's heart:
        validate( 
            need(input$which_ts != "",
                 "Please select a time series to display")
        )
        
        df <- subsetted_data() %>% # Here, we access the "reactive object" subsetted_data
            select(year, input$which_ts) %>%
            pivot_longer(cols = input$which_ts)
        
        df %>% 
            ggplot(aes(x = year, y = value, colour = name) ) +
            geom_line(lwd = 1.1) +
            scale_colour_viridis_d("Time series") +
            xlab("Year") +
            ylab("Value of estimate") +
            facet_wrap(~name, scales = "free_y") +
            theme_minimal(base_size = 16) +
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
