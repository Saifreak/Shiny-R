shinyServer(function(input, output,session){

   observe({
    selected1=unique(NYC[NYC$neighbourhood_group==input$selected0,'neighbourhood'])
    updateSelectizeInput(
      session,'selected1',
      choices = selected1,
      selected = selected1[1]
    )
  })
  
  
   listingNYC <- reactive({
    selected0 = input$selected0
    selected1 = input$selected1
    selected2 = input$selected2
    NYC %>%
      select(neighbourhood_group, neighbourhood,room_type, longitude,latitude,price) %>%
      filter(neighbourhood_group == selected0 & neighbourhood == selected1 & room_type == selected2)
  })  
  output$map <- renderLeaflet({
    leaflet()%>% setView(lng = -73.9059, lat = 40.7128, zoom = 11) %>% 
      addTiles() %>% addMarkers(lng = listingNYC()$longitude, lat = listingNYC()$latitude)
  })
  
  output$plotmap <- renderPlot({
    ggplot(listingNYCplot %>% filter(neighbourhood_group == input$selected0 & neighbourhood == input$selected1), aes(price, color=room_type)) + geom_freqpoly()
  })

  listingNYCplot <- NYC %>%
      select(neighbourhood_group, neighbourhood, room_type, price, minimum_nights)

  output$plot1 <- renderPlot({
    ggplot(listingNYCplot %>% filter(minimum_nights >= input$selected4[1] & minimum_nights <= input$selected4[2] &
                                     price >= input$selected3[1] & price <= input$selected3[2]), aes(neighbourhood_group)) + 
      geom_bar(aes(fill=room_type), position = position_dodge())
  })

  output$plot2 <- renderPlot({
    # listingNYCplot %>% group_by(neighbourhood_group) %>% su
    ggplot(listingNYCplot %>% filter(minimum_nights >= input$selected6[1] & minimum_nights <= input$selected6[2]),
                                     aes(neighbourhood_group, price)) + 
      geom_bar(aes(fill=room_type), position = position_dodge(),stat = "identity")
  })
  output$plot3 <- renderPlot({
    ggplot(listingNYCplot %>% filter(minimum_nights >= input$selected5[1] & minimum_nights <= input$selected5[2] & neighbourhood_group == input$selected7),
           aes(neighbourhood, price)) + 
      geom_bar(aes(fill=room_type), position = position_dodge(),stat = "identity") +
      theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
  })
  output$table <- DT::renderDataTable({
    datatable(NYC, rownames=FALSE)
  })
})