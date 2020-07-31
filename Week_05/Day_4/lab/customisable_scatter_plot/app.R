library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)

# UI section

ui <- fluidPage(
    titlePanel("Reaction Time vs. Memory Game"),
    
    sidebarLayout(
      sidebarPanel(
        radioButtons("colour_choice", 
                     "Colour of Points", 
                     choices = c(Blue = "#3891A6", 
                                 Yellow = "#FDE74C", 
                                 Red = "#E3655B")),
        
        sliderInput("transparency",
                    "Transparency Points",
                    min = 0, max = 1, value = 0.5),
        
        selectInput("shape", 
                    "Shape of Points", 
                    choices = c("Square" = 15,
                                "Circle" = 16,
                                "Triangle" = 17)),
        
        textInput("title",
                  "Title of Graph", 
                  value = "Graph Title")
        ),
      
      mainPanel(
        textOutput("title_out"),
        plotOutput("shape_out"),
        
      )
    )
)
# Server section
server <- function(input, output) {
  output$title_out <- renderText({
    input$title
  })
  
  output$shape_out <- renderPlot({
    ggplot(students_big) + 
      geom_point(aes(x = reaction_time , y = score_in_memory_game),
                 alpha = input$transparency, color = input$colour_choice, 
                 shape = as.numeric(input$shape))
  })
}
# Run the app
shinyApp(ui = ui, server = server)
