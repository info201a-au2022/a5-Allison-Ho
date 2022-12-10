library(shiny)

source("analysis.R")

server <- function(input, output){
  output$highest <- renderText({
    return(paste0("the country with the highest emission of CO2 in
                  2018 (which is the latest year in my dataset) is ", highest_country,
                  " with ", highest_co2, " million tonnes. The country with the lowest
                  emission of CO2 in 2018 is ", lowest_country, ", with ",
                  lowest_co2, " million tonnes. As for the CO2 per capita, I also found
                  that the mean of CO2 per capita for every country in 2018 is around ",
                  mean_co2, " tonnes per person. Looking at the US, we emit ", us_1999,
                  " million tonnes in 1999. This number went up to ", us_2018,
                  " million tonnes in 2018, which has increased by 194.161 million tonnes."))
  })
  
  output$map <- renderPlotly({
    return(make_map(input$year, input$emission_type))
  })
  
  output$scatter <- renderPlotly({
    return(make_scatter(input$yearvar, input$type))
  })
}