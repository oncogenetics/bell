fluidPage(
  titlePanel("Bell"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("PRS", label = h3("PRS"), min = 0, 
                  max = 100, value = 95),
      sliderInput("q1q2", label = h3("Shade Q1-Q2"), 
                  min = 0, max = 0.999999,
                  value = c(0.9, 0.999999)),
      sliderInput("shapeSize", label = h3("Shape size"), 
                  min = 1, max = 15,
                  value = 8),
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
