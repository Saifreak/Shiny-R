
library(shiny)
library(shinydashboard)
library(DT)
library(data.table)
library(plotly)
library(leaflet)
library(readr)
library(googleVis)
# NYC <- read_csv("~/Downloads/new-york-city-airbnb-open-data/AB_NYC_2019.csv", 
#                                col_types = cols(host_id = col_skip(), 
#                                                 id = col_skip()))
NYC <- read_csv("~/Downloads/new-york-city-airbnb-open-data/AB_NYC_2019.csv", 
                   col_types = cols(host_id = col_skip(), 
                                    host_name = col_skip(), id = col_skip(), 
                                    latitude = col_number(), longitude = col_number(), 
                                    price = col_number()))
rownames(NYC) <- NULL
choice <- colnames(NYC)
# borough_choice <- unique(NYC$neighbourhood_group)
# neighbor_choice <- unique(NYC$neighbourhood)
# room_choice <- unique(NYC$room_type)