#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Motor Trend Car Road Tests Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       radioButtons("xvariable",
                    "Plot variable (x)",
                    c("Weight (1000 lbs)" = "wt",
                      "Gross horsepower" = "hp",
                      "Number of cylinders" = "cyl",
                      "Miles/(US) gallon" = "mpg")),
       radioButtons("yvariable",
                    "Plot variable (y)",
                    c("Miles/(US) gallon" = "mpg",
                      "Number of cylinders" = "cyl",
                      "Gross horsepower" = "hp",
                      "Weight (1000 lbs)" = "wt")),
       sliderInput("xrange",
                   "Plot range (x):",
                   min = 0,
                   max = 250,
                   value = c(0,7)),
       sliderInput("yrange",
                   "Plot range (y):",
                   min = 0,
                   max = 250,
                   value = c(0,40)),
       radioButtons("color",
                    "Color variable:",
                    c("Number of cylinders" = "cyl",
                      "Gross horsepower" = "hp",
                      "Weight (1000 lbs)" = "wt",
                      "Miles/(US) gallon" = "mpg")),
       radioButtons("plotfit",
                    "Plot linear fit:",
                    c("Yes" = TRUE,
                      "No" = FALSE))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
