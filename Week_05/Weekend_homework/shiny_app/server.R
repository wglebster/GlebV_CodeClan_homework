#server.R
server <- function(input, output){
  filtered_data <- reactive({
    game_sales %>%
      filter(between(year_of_release,
                     input$year_select[1],
                     input$year_select[2]
                     )) %>%
      filter(genre == input$genre_select) %>%
      filter(platform == input$platform_select) #%>%
    #   filter(rating == input$rating_select)
  })
    # 
    # if(input$genre_select != "all") {
    #   (filtered_data() %>% 
    #      filter(genre == input$genre_select))
    # } else if(input$platform_select != "all") {
    #   (filtered_data() %>%
    #      filter(platform == input$platform_select))
    # } else if (input$rating_select != "all") {
    #   (filterred_data() %>% 
    #      filter(rating == input$rating_select))
    # } else {
    #   filter(year_of_release == input$year_select)
    # }
    
    
    output$filtered_table <- renderDataTable({
      filtered_data() 
      #options = list(searching = FALSE, paging = TRUE)
  })
  
}