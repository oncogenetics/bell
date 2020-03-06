fluidPage(
  titlePanel("Bell"),
  sidebarLayout(
    sidebarPanel(
      #PRS
      sliderInput("PRS", label = "PRS", min = 0, 
                  max = 100, value = 95),
      sliderInput("prsLineSize", label = "PRS line size", min = 0, 
                  max = 10, value = 1.4, step = 0.2),
      colourInput("prsCol", "PRS line colour", "#ff6600"),
      #Shade
      sliderInput("q1q2", label = "Shade Q1-Q2", 
                  min = 0, max = 0.999999,
                  value = c(0.9, 0.999999)),
      colourInput("shadeCol", "Shade colour", "#ffd1b3"),
      sliderInput("shapeSize", label = "Shape size", 
                  min = 1, max = 15,
                  value = 8),
      #Shape
      colourInput("shapePosCol", "Positive colour", "#ff6600"),
      colourInput("shapeNegCol", "Negative colour", "#b3b3b3"),
      #Bell
      sliderInput("bellBorder", label = "Bell border", 
                  min = 0, max = 0.05, step = 0.0005,
                  value = 0.0135),
      sliderInput("bellLineSize", label = "Bell line size", min = 0, 
                  max = 10, value = 1.2, step = 0.2),
      br()
      
    ),
  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel("Plot",
                         plotOutput("plot")),
                tabPanel("Help"))
  )
  )
  
)
