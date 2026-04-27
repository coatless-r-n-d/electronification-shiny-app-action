library(shiny)

ui <- fluidPage(
  titlePanel("Electronification demo"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("n", "Number of points:", min = 50, max = 1000, value = 250),
      sliderInput("sd", "Standard deviation:", min = 0.1, max = 5, value = 1, step = 0.1),
      helpText(
        "This is a tiny Shiny app packaged as an Electron desktop ",
        "installer by the coatless-actions/shiny-to-electron action."
      )
    ),
    mainPanel(
      plotOutput("histogram"),
      verbatimTextOutput("summary")
    )
  )
)

server <- function(input, output, session) {
  data <- reactive({
    rnorm(input$n, mean = 0, sd = input$sd)
  })

  output$histogram <- renderPlot({
    hist(
      data(),
      breaks = 30,
      col = "#3b82f6",
      border = "white",
      main = sprintf("rnorm(n = %d, sd = %.1f)", input$n, input$sd),
      xlab = "value"
    )
  })

  output$summary <- renderPrint({
    summary(data())
  })
}

shinyApp(ui, server)
