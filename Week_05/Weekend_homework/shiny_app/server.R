#server.R
server <- function(input, output) {
  filtered_data <- reactive({
    game_sales %>%
      filter(year_of_release == input$year_select)
    
      # filter(genre == input$genre_select) %>%
      # filter(platform == input$platform_select) %>%
      # filter(rating == input$rating_select) %>%
      
  })
  
  output$filtered_table <- renderDataTable(
    if(input$genre_select == "all") {
      return(filtered_data())
    } else if(input$platform_select == "all") {
      return(filtered_data())
    } else if (input$rating_select == "all") {
      return(filterred_data())
      
    }
    # filter(genre == input$genre_select)
    # if(input$platform_select == "all") {
    #   return(filtered_data())
    # } else { 
    #   filtered_data() %>%
    #     filter(platform == input$platform_select)
    # }
    
    # filtered_data(), 
    # options = list(searching = FALSE, paging = TRUE)
  )
}