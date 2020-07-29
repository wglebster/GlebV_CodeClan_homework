library(CodeClanData)
library(shiny)
library(tidyverse)
library(shinythemes)

# UI section
ui <- fluidPage(
    
    theme = shinytheme("spacelab"),

    titlePanel("Medals by Teams"),
    
    tabsetPanel(
        tabPanel("Plot",
                 plotOutput("medal_plot"),
                 tags$br(textOutput("dummy_text"))
                 ),
        tabPanel("Selectors",
                 fluidRow(
                     column(3,
                            radioButtons("season", 
                                         "Select season:", 
                                         choices = c("Summer", "Winter"))
                            ),
                     column(3,
                            radioButtons("team",
                                         "Select team:",
                                         choices = c("United States",
                                                     "Soviet Union",
                                                     "Germany",
                                                     "Italy",
                                                     "Great Britain"))
                            )
                 )
        ),
        tabPanel("Raw Data",
                 mainPanel(
                     dataTableOutput("table")
                         )
                 )
    )
)




# Server section
server <- function(input, output) {
    
    output$dummy_text <- renderText("This is an explanation of the graph in dummy text:
                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                                    Donec massa urna, faucibus id ornare at, efficitur in odio.
                                    Sed sed pulvinar dui. Proin consequat consequat risus, 
                                    nec malesuada enim viverra at. Donec eget ipsum viverra, 
                                    euismod neque ut, tristique tortor. 
                                    Fusce aliquam neque mollis malesuada blandit. 
                                    Suspendisse ornare in augue at sollicitudin. 
                                    Nulla eu fringilla eros. Duis gravida lectus at convallis 
                                    egestas. Vivamus porttitor dapibus magna. 
                                    Integer et ante risus.")
    
    output$table <- renderDataTable(olympics_overall_medals)
    
    output$medal_plot <- renderPlot({
        
        olympics_overall_medals %>%
            filter(team == input$team) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = medal, y = count) +
            geom_col()
    })
} 
# Run the app
shinyApp(ui = ui, server = server)