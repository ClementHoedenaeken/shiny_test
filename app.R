library(shiny)
library(ggplot2)
library(data.table)

choice_axis = c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width")

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Analyse du dataset Iris"),
  fluidRow(
    column(
      width = 3,
      selectInput(
        inputId = "select_x",
        label = "Choose the x-axis",
        choices = choice_axis,
        selected = "Sepal.Length"
      )
    ),
    column(
      width = 3,
      selectInput(
        inputId = "select_y",
        label = "Choose the y-axis",
        choices = choice_axis,
        selected = "Sepal.Length"
      )
    ),
    column(
      width = 3,
      sliderInput(inputId = "slider1",
                  label = "Taille des points", 
                  min = 0, 
                  max = 10, 
                  value = 2)  
    ),
    column(
      width = 3,
      numericInput(
        inputId = "nbr_lignes",
        label ="Nombre de lignes du tableau",
        value = 10,
        min = 1,
        max = 50,
        step = 1
      )
    )
  ),
  
  hr(),
  fluidRow(
    titlePanel("Mise en graphique"),
    plotOutput("plot")
  ),
  hr(),
  fluidRow(
    titlePanel("Extrait du tableau"),
    tableOutput("tableau")
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
  
  output$tableau <- renderTable({
    head(data.table(iris),input$nbr_lignes)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
