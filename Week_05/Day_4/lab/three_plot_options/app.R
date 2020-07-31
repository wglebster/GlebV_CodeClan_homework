library(CodeClanData)
library(shiny)
library(ggplot2)
library(tidyverse)

# UI section
ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            radioButtons("plot_type",
                         "Plot Type",
                         choices = c("Bar", "Pie Chart", "Stacked Bar"))
        ),
        mainPanel( 
            plotOutput("plot_output")
        )
    )
)
# Server section
server <- function(input, output) {
  
  filtered_data <- reactive({
    students_big %>%
      group_by(gender)%>%
      summarise(count = n())
  })
  
  output$plot_output <- renderPlot({
    if(input$plot_type == "Bar") { #Bar_plot
      return(
        ggplot(filtered_data()) + 
        geom_bar(aes(x = gender, y = count, fill = gender), stat = "identity")
      )
    }
    if(input$plot_type == "Pie Chart") { 
      # Pie Chart
      return(
        ggplot(filtered_data()) + 
          aes(x = "", y = count, fill = gender) + 
          geom_bar(width = 1, stat = "identity") +
          coord_polar("y", start = 0)
        )
    }
    if(input$plot_type == "Stacked Bar") {
      #Stacked Bar
      return(
          ggplot(filtered_data()) + 
            aes(x = "", y = count, fill = gender) + 
          geom_bar(width = 1, stat = "identity")
      )
    }
  })
}
# Run the app
shinyApp(ui = ui, server = server)

