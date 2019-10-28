#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shinythemes)
shinyUI(dashboardPage(
  dashboardHeader(title = "Airbnb"),
  dashboardSidebar(
    sidebarUserPanel("Airbnb Listing", image = "https://images.pexels.com/photos/1123982/pexels-photo-1123982.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
    sidebarMenu(
      menuItem("Map", tabName = "map", icon = icon("map")),
      menuItem("Plot", tabName = "plot1", icon = icon("chart-bar")),
      menuItem("Data", tabName = "data", icon = icon("database")))

  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "map",
              fluidPage(
                
                box(
                  selectizeInput("selected0",
                                 "Select Item to Display",
                                 unique(NYC$neighbourhood_group)),
                  
                  selectizeInput("selected1",
                                 "Select Item to Display",
                                 unique(NYC$neighbourhood)),
                  
                  selectizeInput("selected2",
                                 "Select Item to Display",
                                 unique(NYC$room_type)),
                  leafletOutput("map")),
                  box(
                    plotOutput("plotmap")))),
                
      tabItem(tabName = "plot1",
              fluidRow(
                box(
                  sliderInput("selected3",
                              "Pick a price range", pre = "$",
                              min=1, max= 10000, value = c(1, 10000)),
                  
                  plotOutput('plot1')
              )
              
              )),
      tabItem(tabName = "data",
              fluidPage(dataTableOutput('table')
             )))
)))
