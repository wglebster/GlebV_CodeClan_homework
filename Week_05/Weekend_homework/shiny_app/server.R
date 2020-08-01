#server.R
server <- function(input, output) {
  filtered_data <- reactive({
    game_sales %>%
      filter(year_of_release == input$year_select) %>%
      filter(genre == input$genre_select) %>%
      filter(platform == input$platform_select) %>%
      filter(rating == input$rating_select)
  })
  
  output$filtered_table <- renderDataTable(
  
    filtered_data(), 
    options = list(searching = FALSE, paging = TRUE)
    
    # filter(genre == input$genre_select) %>%
    #   filter(platform == input$platform_select) %>%
    #   filter(rating == input$rating_select)
  )
}