#server.R
server <- function(input, output){
  filtered_data <- reactive({
    game_sales %>%
      filter(between(year_of_release,
                     input$year_select[1],
                     input$year_select[2]
                     )) %>%
      filter(genre == input$genre_select) %>%
      filter(platform == input$platform_select)
  })
  plot_stats <- reactive({
    game_sales %>%
      slice(1:10)
  })

    output$filtered_table <- renderDataTable({
      filtered_data() 
      #options = list(searching = FALSE, paging = TRUE)
  })
    
    output$popularity_plot <- renderPlot({
      if(input$stats_selection == "Top 10 critic rated games"){ 
        return(
          ggplot(plot_stats()) +
            geom_col(aes(x = reorder(name, critic_score), y = critic_score)) +
            theme(axis.text = element_text(angle = 90)) +
            labs(title = "Top 10 critic rated games",
                 x = "game name",
                 y = "critic rating")
        )
      }
      if(input$stats_selection == "Top 10 user rated games"){ 
        return(
          ggplot(plot_stats()) +
            geom_col(aes(x = reorder(name, user_score), y = user_score)) +
            theme(axis.text = element_text(angle = 90)) +
            labs(title = "Top 10 user rated games",
                 x = "game name",
                 y = "user rating")
        )
      }
      })
  
}