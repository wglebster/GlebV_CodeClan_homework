library(shiny)
library(dplyr)
library(ggplot2)

choices_shapes <- list("Square" = as.integer(15),
                       "Circle" = as.integer(16),
                       "Triangle" = as.integer(17))
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
                    choices = choices_shapes),
        
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
  output$shape_out <- renderTable({
    shapes <- as.data.frame(input$shape)
    ggplot(shapes) + 
      aes(x = input$shape, y = input$shape[input]) + 
      geom_point(position = "jitter")
    
  })
}
# Run the app
shinyApp(ui = ui, server = server)
