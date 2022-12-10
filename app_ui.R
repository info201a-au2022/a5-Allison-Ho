library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)

source("analysis.R")

intro_page <- tabPanel(
  "Overview",
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
  
  p("At first glance, I notice some key values:"),
  
  textOutput("highest")
)

interactive <- tabPanel(
  "Analysis",
  h1("Analysis"),
  h2("Different type of CO2 Emission for each Country for specific year"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("year",
                   label = "Year",
                   choices = unique(per_capita_df$year)
      ),
      
      selectInput("emission_type",
                  label = "CO2 Emission Type",
                  choices = choices
      )
    ),
    
    mainPanel(
      titlePanel("The World Emission for Different Type of CO2 Emission"),
      plotlyOutput("map")
    )
  ),
  
  p("I include this map as I want to see the trend of different CO2 emission across the
  country from 1999 to 2018. Looking at these maps, I can see that most of the European
  and Asian countries has the highest CO2 emission per capita for all of the different
  CO2 type. However, we cannot conclude that European and Asian countries are emitting
  the most CO2 as there can be other factors affecting this high emission."),
  
  h2("Comparing Amount of CO2 Emission for Different Type of Emissiona and GDP for a
     country"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("yearvar",
                   label = "Year",
                   choices = unique(per_gdp$year)
      ),
      
      selectInput("type",
                  label = "CO2 Emission Type",
                  choices = per_gdp_choices
      )
    ),
    
    mainPanel(
      plotlyOutput("scatter")
    )
  ),
  
  p("As I would like to study whether there is any relationship between the gdp and the
  amount of CO2 emission a country emit, I include a scatterplot with the x-axis
  represents the GDP and the y-axis is the CO2 emission. These scatterplot illustrate
  that there is indeed a correlation between GDP and the amount of CO2 Emission a
  country has. Looking at most of the country, there is a linear relationship between
  GDP and CO2 Emission, except for 2 countries, China and the US, which are our two
  outliers. These 2 countries have exceptionally big GDP, so to hav a better
  understanding of the relationship, one possible way is that we can take out these
  2 countries.")
)


ui <- navbarPage(
  "CO2 Emission",
  intro_page,
  interactive
)