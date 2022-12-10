library(dplyr)
library(stringr)
library(tidyverse)
library(plotly)

#load data
co2_data <- read.csv('co2.txt', header = TRUE, stringsAsFactors = FALSE)

#clean data
#omit any country with NAs
co2_data <- co2_data %>% 
  na.omit

#countries in dataset -> 44 countries
countries <- unique(co2_data$country)

#year in use -> 1990 - 2018
#get all the column for different typ of co2 per capita
column_names <- colnames(co2_data)
per_capita <- co2_data[c(str_detect(column_names, "per_capita"))]

choices <- colnames(per_capita)

per_capita_df <- co2_data %>% 
  select(country, year, iso_code, population, gdp, cement_co2_per_capita) 

per_capita_df <- left_join(per_capita_df, per_capita, by = "cement_co2_per_capita")

#interactive graph to see the different type of co2 emission per capita for each
#country

#map
make_map <- function(year, type) {
  g <- list(
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  emission_map <- plot_geo(per_capita_df, locationmode = 'ISO-3') %>%
    add_trace(
      type = "chloropleth",
      z = per_capita_df[,type], text = ~iso_code, locations = ~iso_code,
      color = per_capita_df[,type], colors = "Purples") %>%
    colorbar(title = "Emission") %>%
    layout(
      title = str_to_title(type),
      geo = g
    ) 
  
  return(emission_map)
}

#a dataframe with the mean emission for each type over the year (1999 - 2018) for each
#country
#bar chart


#create a scatterplot to see if there is relationship between one type of co2 emission and
#and gdp for each country
per_gdp <- co2_data %>% 
  filter(country != "World") %>% 
  select(country, year, iso_code, gdp, co2, cement_co2, co2_including_luc,
         coal_co2, consumption_co2, flaring_co2, gas_co2, methane,
         nitrous_oxide, oil_co2, other_industry_co2, trade_co2)

per_gdp_choices <- per_gdp %>% 
  select(co2, cement_co2, co2_including_luc,
         coal_co2, consumption_co2, flaring_co2, gas_co2, methane,
         nitrous_oxide, oil_co2, other_industry_co2, trade_co2) %>% 
  colnames()

make_scatter <- function(yearvar, emission) {
  data <- per_gdp %>% 
    filter(year == yearvar) %>% 
    select(emission, gdp)
  
  scatter <- plot_ly(data, x = ~gdp,
                     y = data[,emission], 
                     type = "scatter",
                     mode="markers") %>% 
    layout(xaxis = list(title = "GDP"), 
           yaxis = list(title = emission)
    )
  return(scatter)
}

#create a pie chart that shows the percentage of each co2 emission type based on
#the total greenhouse gases for the world + each country for each year
share <- co2_data[c(str_detect(column_names, "share_"))]
share_df <- co2_data %>% 
  select(country, year, share_global_co2)
share_df <- left_join(share_df, share, by = "share_global_co2") %>% 
  group_by(country) %>% 
  group_by(year)


#country with the highest mean emission for each type
highest <- co2_data %>% 
  filter(year == max(year)) %>% 
  filter(country != "World") %>% 
  filter(co2 == max(co2))

highest_country <- highest %>% 
  pull(country)

highest_co2 <- highest %>% 
  pull(co2)

lowest <- co2_data %>% 
  filter(year == max(year)) %>% 
  filter(country != "World") %>% 
  filter(co2 == min(co2))

lowest_country <- lowest %>% 
  pull(country)

lowest_co2 <- lowest %>% 
  pull(co2)

mean_co2_df <- co2_data %>% 
  filter(year == max(year)) %>% 
  filter(country != "World")

mean_co2 <- round(mean(mean_co2_df$co2_per_capita), digits = 3)

iso <- unique(co2_data$iso_code)

print(iso)

us_1999 <- co2_data %>% 
  filter(iso_code == "USA") %>% 
  filter(year == min(year)) %>% 
  pull(co2)

us_2018 <- co2_data %>% 
  filter(iso_code == "USA") %>% 
  filter(year == max(year)) %>% 
  pull(co2)
