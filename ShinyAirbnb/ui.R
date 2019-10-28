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
      menuItem("Intro", tabName = "intro", icon = icon("image")),
      menuItem("Map", tabName = "map", icon = icon("map")),
      menuItem("Bar Plot", tabName = "plot1", icon = icon("chart-bar")),
      menuItem("Price Chart", tabName = "price", icon = icon("chart-line")),
      menuItem("Data", tabName = "data", icon = icon("database")),
      menuItem("About Me", tabName = "me", icon = icon("user-circle")))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "intro",
              HTML('<img src="https://images.pexels.com/photos/1525612/pexels-photo-1525612.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260" width=500 height=700>')
                  ),
      
              tabItem(tabName = "map",
              fluidPage(
                
                box(

                  title = "listing based on search",
                  leafletOutput("map"),
                  selectizeInput("selected0",
                               "Select Item to Display",
                               unique(NYC$neighbourhood_group)),
                
                  selectizeInput("selected1",
                               "Select Item to Display",
                               unique(NYC$neighbourhood)),
                
                  selectizeInput("selected2",
                               "Select Item to Display",
                               unique(NYC$room_type))),
                  box(
                    title = "Frquency of room types based on Price",
                    plotOutput("plotmap"),
                    dataTableOutput('table1')
                    ))),
                
      tabItem(tabName = "price",
              tabsetPanel(type= "tabs",
                          tabPanel("Borough",
                              fluidRow(
                              plotOutput('plot2'),
                              box(
                                sliderInput("selected6",
                                "Pick minimum nights",
                                min = 1, max = 1250, value = c(1,1250))
                                )
                              )
                          ),
                          tabPanel("Neighborhood",
                                   fluidRow(
                                     plotOutput('plot3'),
                                     box(
                                         selectizeInput("selected7",
                                                        "Select Borough",
                                                        unique(NYC$neighbourhood_group)),
                                         sliderInput("selected5",
                                                     "Pick minimum nights",
                                                     min = 1, max = 1250, value = c(1,1250))
                                     )
                                   ))
              
              )),
      
      tabItem(tabName = "plot1",
              fluidRow(
                # box(
                plotOutput('plot1'),
                box(sliderInput("selected3",
                                "Pick a price range", pre = "$",
                                min=1, max= 10000, value = c(1, 10000)),
                    sliderInput("selected4",
                                "Pick minimum nights",
                                min = 1, max = 1250, value = c(1,1250))
                )
                
              )),
      
      tabItem(tabName = "data",
              fluidPage(dataTableOutput('table')
             )),
      tabItem(tabName = "me",
              fluidPage(
                h4("Dong-Hwi Kim is currently a student at NYC Data Science Academy.", br(),
                   "He holds a B.S. in Applied Mathematics and Statistics from Stony Brook University with study in actuarial science."),
                h4(a(icon= icon("github"),"Github Link", href="https://github.com/donghwikim21"))
                
                )

    

      )
))))
