library(shiny)
library(ggplot2)

choice_axis = c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width")

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Analyse du dataset Iris"),
  fluidRow(
    column(
      width = 4,
      selectInput(
        inputId = "select_x",
        label = "Choose the x-axis",
        choices = choice_axis,
        selected = "Sepal.Length"
      )
    ),
    column(
      width = 4,
      selectInput(
        inputId = "select_y",
        label = "Choose the y-axis",
        choices = choix_axes,
        selected = "Sepal.Length"
      )
    ),
    column(
      width = 4,
      sliderInput(inputId = "slider1",
                  label = "Taille des points", 
                  min = 0, 
                  max = 10, 
                  value = 2)  
    )
  ),
  
  hr(),
  fluidRow(
    plotOutput("plot")
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$plot <- renderPlot({
    ggplot(data=iris,
           aes(x=get(input$select_x),
               y=get(input$select_y),
               color=Species))+
      geom_point(size=input$slider1)+
      theme_light()+
      labs(x = input$select_x,
           y=input$select_y)
  })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
