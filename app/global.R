# Author: Tokhir Dadaev
# License: MIT + file LICENSE.txt

# Workspace ---------------------------------------------------------------
library(shiny)
library(ggplot2)
library(emojifont)
library(colourpicker)

# Data --------------------------------------------------------------------
x <- curve(dnorm, from = -5, to = 5)
plotDat <- data.frame(x)


xx <- c(1,5,10,25,50,75,90,95,99)
xb <- qnorm(xx/100)
xl <- paste0(xx, "%")


