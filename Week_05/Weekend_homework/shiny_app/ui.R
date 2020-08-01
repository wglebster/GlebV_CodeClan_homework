#ui.R
ui <- fluidPage(
  titlePanel(tags$h1("Gamer's Paradise",
                     tags$h5("Thank you for using Gamer's Paradise dashboard,
                     here you can browse a selection of vintage and modern games 
                     we have in our database.
                     We hope this Shiny dashboard will make it easier for you to
                     choose your perfect game!"))
             ),
  sidebarLayout(
    sidebarPanel(width = 4,
                 sliderInput("year_select",
                             "Select years of release",
                             min = min_slider,
                             max = max_slider,
                             value = c(min_slider, max_slider),
                             sep = "",
                             ticks = FALSE  
                            ),
                 selectInput("genre_select",
                             "Select genre", 
                             choices = genre_choice,
                             selected = "all"
                             ),
                 selectInput("platform_select",
                             "Select your platform",
                             choices = platform_choice,
                             selected = "all"
                             ),
                 radioButtons("rating_select",
                              "Select age rating",
                              choices = rating_choice,
                              inline = TRUE, 
                              selected = "all"
                              ),
                 #actionButton("update_all",
                  #            "Show me my Games!")
                 ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Your list of Games",
                 dataTableOutput("filtered_table")
                 ),
        tabPanel("Some visual Stats"
                 )
      )
    )
  )
)
