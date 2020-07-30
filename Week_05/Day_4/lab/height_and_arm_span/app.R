library(shiny)
library(dplyr)
library(CodeClanData)

#View(students_big)

# UI section
ui <- fluidPage(
    fluidRow(
        column(12, 
               radioButtons("age", 
                            label = NULL,
                            choices = sort(unique(students_big$ageyears)),
                            inline = TRUE))
    ),
    fluidRow(
        column(5, 
               plotOutput("height")),
        column(5, 
               plotOutput("arm_span"))
    )
)

# Server section
server <- function(input, output) {
    
    filtered_data <- reactive({
        students_big %>%
            filter(ageyears == input$age)
    })
    
    output$height <- renderPlot({
        ggplot(filtered_data()) +
            geom_bar(aes(x = height))
    })
    output$arm_span <- renderPlot({
        ggplot(filtered_data()) + 
            geom_bar(aes(x = arm_span))
    })
}
# Run the app
shinyApp(ui = ui, server = server)