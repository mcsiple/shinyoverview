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
    
    output$bioparamHead <- renderTable({
        x <- timeseries_values_views
        head(x)
    })
    
    output$ts_plot <- renderPlot({
        stocks_w_data <- timeseries_values_views %>% 
            filter_at(vars(TBbest,TCbest, ERbest), any_vars(!is.na(.)))
        
        df <- stocks_w_data %>%
            filter(stocklong == input$which_stocklong) %>%
            select(year, input$which_ts) %>%
            pivot_longer(cols = input$which_ts)
        
        df %>% 
            ggplot(aes(x = year, y = value, colour = name) ) +
            geom_line(lwd = 1.1) +
            scale_colour_viridis_d("Time series") +
            labs(title = "Time series selected") +
            xlab("Year") +
            ylab("Value of estimate") +
            facet_wrap(~name) +
            theme_minimal() +
            theme(legend.position = 'none')
        
    })

})
