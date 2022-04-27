function(input, output) {
  
  dFill <- reactive({
    d <- data.frame(x = rep(seq(-2.5, 2.5, 0.25), 16),
                    y = seq(0.015, 0.4, 0.025))
    d$y <- ifelse(d$y < dnorm(d$x, 0, 1) - input$bellBorder, d$y, NA)
    d <- d[!is.na(d$y), ]
    d$col <- ifelse(d$x > qnorm(input$q1q2[ 1 ]), input$shapePosCol, input$shapeNegCol)
    d$label <- fontawesome("fa-male")
    d
  })
  
  PRS <- reactive({
    qnorm(input$PRS/100)
  })
  
  plotObjBell <- reactive({
    
  ggplot(plotDat, aes(x, y)) +
    geom_hline(yintercept = 0, col = "#ADAFAF") +
    geom_line(size = input$bellLineSize) +
    geom_ribbon(data = plotDat[ plotDat$x > qnorm(input$q1q2[ 1 ]) &
                                  plotDat$x < qnorm(input$q1q2[ 2 ]), ],
                aes(ymax = y, fill = input$shadeCol), ymin = 0,
                colour = NA, alpha = 0.5, show.legend = FALSE) +
    geom_text(aes(x, y, col = col, label = label),
              data = dFill(), 
              size = input$shapeSize,
              family = "fontawesome-webfont",
              show.legend = FALSE) +
  #Patient PRS
  geom_segment(x = PRS(), y = 0, xend = PRS(), yend = 0.39,
               col = input$prsCol, size = input$prsLineSize) + #,linetype = "dashed") +
  geom_text(aes(x = PRS(), y = 0.4,
                label = paste0(pnorm(PRS()) * 100, "%"), size = 1),
            col = input$prsCol, show.legend = FALSE) +
  #theme
  scale_colour_identity() +
  scale_fill_identity() +
  scale_y_continuous(name = NULL, breaks = NULL) +
  scale_x_continuous(name = NULL, breaks = xb, labels = xl) +
  theme_minimal() +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_line(colour = "#ADAFAF",
                                        linetype = "dashed" ))
  
  })
  
    output$plot <- renderPlot({
      print(plotObjBell())
  })
  
}