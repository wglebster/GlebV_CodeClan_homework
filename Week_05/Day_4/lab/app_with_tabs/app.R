library(CodeClanData)
library(tidyverse)
library(shiny)

# UI section
ui <- fluidPage(
    
    titlePanel("Comparing Importance of Internet Access vs. Reducing Pollution"),
    
    sidebarLayout(
        sidebarPanel(
            
            selectInput("gender_select",
                        "Gender",
                        choices = c("Male", "Female")
                        ),
            selectInput("region_select", 
                        "Region", 
                        choices = sort(unique(students_big$region))
                        ), #remove students_big later
            actionButton("update_all",
                         "Generate Plots and Table")
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Plots",
                         column(6,
                         plotOutput("importance_internet_access"),#plot1
                         ),
                         column(6,
                         plotOutput("importance_reducing_pollution")#plot2
                         )
                         ),
                tabPanel("Table",
                         tableOutput("filtered_table")
                         ) #table
           )
        )
    )
)
# Server section
server <- function(input, output) {
    filtered_data <- eventReactive(input$update_all, {
        students_big %>%
            filter(gender <= input$gender_select) %>%
            filter(region <= (input$region_select))
    })
    
    output$importance_internet_access <- renderPlot({
        ggplot(filtered_data()) + 
            aes(x = importance_internet_access) + 
            geom_histogram()
    })
    
    output$importance_reducing_pollution <- renderPlot({
        ggplot(filtered_data()) + 
            aes(importance_reducing_pollution) + 
            geom_histogram()
    })
 
    output$filtered_table <- renderTable(
        filtered_data()
    )
}
# Run the app
shinyApp(ui = ui, server = server)
