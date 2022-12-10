library(shiny)
library(stringr)

intro_page <- fluidPage(
  h1("CO2 Emission Reprt"),
  
  h2("Overview"),
  
  p("CO2 Emiission is one of the leading cause of global warming, which is becoming a
    heated debate topic. As global warming becomes more intense, countries around the
    world are working towards lowering their own CO2 emission in hope of halting global
    warming. To better understand the big picture of the contribution of CO2 emission
    from each country, I will analyze the CO2 emission dataset collected by Our World
    in Data. Specifically, I will study the emission of different type of CO2 per capita
    for each contry from 199 to 2018. From this data, I can better understand which type
    of CO2 emission is dominating along with which country contribute the most to global
    warming. Besides that, I also look at the proportion of each country contribution
    to the shared emission of different type of CO2 emission."),
  
  p("At first glance, I notice some key values, which is represented in the table
    below:"),
  
  table <- tabsetPanel(
    type = "tabs",
    tabPanel("highest_mean", textOutput("highest_mean")),
    tabPanel("highest_year", textOutput("highest_year")),
    tabPanel("trend", plotlyOutput("plot"))
  )
)