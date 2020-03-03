# About -------------------------------------------------------------------
# 26/02/2020
#
# bell for BARCODE report
# - reproduce Excel sheet bell
# - maybe wrap it into a shiny

# Workspace ---------------------------------------------------------------
library(ggplot2)
library(emojifont)
setwd("C:/Users/tdadaev/Desktop/Work/BARCODE_bell")

# Data --------------------------------------------------------------------
x <- curve(dnorm, from = -5, to = 5)
plotDat <- data.frame(x)

# oncofunco::ICRcolours(, plot = TRUE)
#oncofunco::ICRcolours()
# [1] "#FFFFFF" "#000000" "#C9DD03" "#FFD602" "#F9A100" "#EE7EA6" "#A71930" "#616365"
# oncofunco::ICRcolours(col = "secondary", plot = T)
# [1] "#726E20" "#6E273D" "#F00034" "#ADAFAF" "#003D4C"

xx <- c(1,5,10,25,50,75,90,95,99)
xb <- qnorm(xx/100)
xl <- paste0(xx, "%")
q1 <- qnorm(0.9)
q2 <- qnorm(0.999999)
PRS <- qnorm(0.9)

# random males
d <- data.frame(x = rep(seq(-2.5, 2.5, 0.25), 16),
                y = seq(0.015, 0.4, 0.025))
d$y <- ifelse(d$y < dnorm(d$x, 0, 1) - 0.0145, d$y, NA)
plot(d)
d <- d[!is.na(d$y), ]
d$col <- ifelse(d$x > q1, "#ff6600", "grey70")
#d$col <- "grey"
d$label <- fontawesome("fa-male")

# v2 ----------------------------------------------------------------------
gg <- ggplot(plotDat, aes(x, y)) +
  geom_hline(yintercept = 0, col = "#ADAFAF") +
  #geom_line(col = "blue", size = 1) +
  geom_line(size = 1.2) +
  geom_ribbon(data = subset(plotDat, x > q1 & x < q2),
              aes(ymax = y, fill = "#ffd1b3"), ymin = 0,
              colour = NA, alpha = 0.5, show.legend = FALSE) +
  geom_text(aes(x, y, col = col, label = label),
            data = d, size = 8, family = "fontawesome-webfont",
            show.legend = FALSE) +
  #Patient PRS
  #geom_vline(xintercept = PRS, col = "#F00034", size = 1,linetype = "dashed") +
  geom_segment(x = PRS, y = 0, xend = PRS, yend = 0.39,
               col = "#ff6600", size = 1.4) + #,linetype = "dashed") +
  geom_text(aes(x = PRS, y = 0.4, 
                label = paste0(pnorm(PRS) * 100, "%"), size = 1), 
             col = "#ff6600", show.legend = FALSE) +
  #theme
  scale_colour_identity() +
  scale_fill_identity() +
  scale_y_continuous(name = NULL, breaks = NULL) +
  scale_x_continuous(name = NULL, breaks = xb, labels = xl) +
  theme_minimal() +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_line(colour = "#ADAFAF", 
                                        linetype = "dashed" ))

  
jpeg("BARCODE_bell.png", width = 1600, height = 800,
     pointsize = 12, quality = 100)
print(gg)
dev.off()

pdf("BARCODE_bell.pdf", width = 16, height = 8)
    #  pointsize = 12, quality = 100)
print(gg)
dev.off()



# testing -----------------------------------------------------------------
# v1 ----------------------------------------------------------------------
# random males
# n <- 10000
# d <- data.frame(x = runif(n, -5, 5),
#                 tx = runif(n, min = 0, max = 0.4))
# d$tx <- ifelse(d$tx <= dnorm(d$x, 0, 1), d$tx, NA)
# d <- d[!is.na(d$tx), ]
# d <- d[1:100, ]
# #d$col <- ifelse(d$x > q1, "#616365", "#C9DD03")
# d$col <- "grey"
# d$label <- fontawesome("fa-male")
# gg <- ggplot(plotDat, aes(x, y)) +
#   geom_hline(yintercept = 0, col = "#ADAFAF") +
#   geom_line(col = "#6E273D", size = 1.2) +
#   geom_ribbon(data = subset(plotDat, x > q1 & x < q2),
#               aes(ymax = y, fill = "#616365"), ymin = 0,
#               colour = NA, alpha = 0.5, show.legend = FALSE) +
#   #random 100
#   #geom_point(aes(x, tx, col = col), data = d, size = 4, show.legend = FALSE) +
#   geom_text(aes(x, tx, col = col, label = label),
#             data = d, size = 10, family = "fontawesome-webfont",
#             show.legend = FALSE) +
#   #Patient PRS
#   geom_vline(xintercept = PRS, col = "#F00034",
#              size = 1, linetype = "dashed") +
#   geom_label(aes(x = PRS, y = max(plotDat$y)/1.25, 
#                  label = paste0(pnorm(PRS)*100, "%"),size = 1.2), 
#              col = "#F00034", show.legend = FALSE) +
#   #theme
#   scale_y_continuous(name = NULL, breaks = NULL) +
#   scale_x_continuous(name = NULL, breaks = xb, labels = xl) +
#   theme_minimal() +
#   theme(panel.grid.minor = element_blank(),
#         panel.grid.major = element_line(colour = "#ADAFAF") )




# ggsave("BARCODE_bell_example2.png", plot = gg,
#        width = 16, height = 8, units = "cm", dpi = 320)
# search_emoji('male')
# 
# emoji(search_emoji('smile'))
# 
# d <- data.frame(x=1:10, y=1:10,
#                 label = fontawesome("fa-male"))
# 
# ggsave("test1.pdf",
# ggplot(d, aes(x, y, label = label)) +
#   geom_text(family = "fontawesome-webfont", size = 6)
# )
# 
# 
# 
# fa <- fontawesome(c('fa-github', 'fa-weibo', 'fa-twitter', 'fa-android', 'fa-coffee'))
# d <- data.frame(x=rnorm(20),
#                 y=rnorm(20),
#                 label=sample(fa, 20, replace=T))
# 
# ggsave("test.pdf",
# ggplot(d, aes(x, y, color=label, label=label)) +
#   geom_text(family='fontawesome-webfont', size=6)+
#   xlab(NULL)+ylab(NULL) +
#   theme(legend.text=element_text(family='fontawesome-webfont'))
# )

# q1 <- quantile(plotDat$x, 0.75)
# q2 <- quantile(plotDat$x, 0.95)

# ggplot(data = data.frame(x = c(-5, 5)), aes(x)) +
#   stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 1)) + 
#   geom_hline(yintercept = 0) +
#   scale_y_continuous(name = NULL, breaks = NULL) +
#   scale_x_continuous(name = NULL, 
#                      breaks = qnorm(c(1,5,10,25, 50, 75,90,95,99)/100),
#                      labels = paste0(c(1,5,10,25, 50, 75,90,95,99), "%")) +
#   theme_minimal() +
#   theme(panel.grid.major = NULL, panel.grid.minor = NULL)
# 
# 
# dnorm(d$y, mean = 0, sd = 1, log = FALSE)
# pnorm(d$y, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
# qnorm(d$y, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
# rnorm(d$y, mean = 0, sd = 1)
# 
# 
# require(graphics)
# 
# dnorm(0) == 1/sqrt(2*pi)
# dnorm(1) == exp(-1/2)/sqrt(2*pi)
# dnorm(1) == 1/sqrt(2*pi*exp(1))
# 
# ## Using "log = TRUE" for an extended range :
# par(mfrow = c(2,1))
# plot(function(x) dnorm(x, log = TRUE), -60, 50,
#      main = "log { Normal density }")
# curve(log(dnorm(x)), add = TRUE, col = "red", lwd = 2)
# mtext("dnorm(x, log=TRUE)", adj = 0)
# mtext("log(dnorm(x))", col = "red", adj = 1)
# 
# plot(function(x) pnorm(x, log.p = TRUE), -50, 10,
#      main = "log { Normal Cumulative }")
# curve(log(pnorm(x)), add = TRUE, col = "red", lwd = 2)
# mtext("pnorm(x, log=TRUE)", adj = 0)
# mtext("log(pnorm(x))", col = "red", adj = 1)
# 
# ## if you want the so-called 'error function'
# erf <- function(x) 2 * pnorm(x * sqrt(2)) - 1
# ## (see Abramowitz and Stegun 29.2.29)
# ## and the so-called 'complementary error function'
# erfc <- function(x) 2 * pnorm(x * sqrt(2), lower = FALSE)
# ## and the inverses
# erfinv <- function (x) qnorm((1 + x)/2)/sqrt(2)
# erfcinv <- function (x) qnorm(x/2, lower = FALSE)/sqrt(2)
