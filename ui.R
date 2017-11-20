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
  titlePanel("Interactive Plotting and Linear Regression"),
  
  p("In this Shiny App, we analyze the Motor Trend Car Road Tests dataset ",strong("(mtcars)."),br(),
    "In a nutshell, the application allows user to make a 2-dimensional scatter plot, ",
    "perform linear regression in the simple form of (y~x) and overlay the model information.",br(),br(),
    "The x/y-axis variables to be plotted can be chosen from the dropdown menus: ",
    strong("Plot variable (x/y)."),br(),
    "The range of the axes can be chosen from the slider inputs: ",
    strong("Plot range (x/y)."),br(),
    "User can also choose the varible that'll be used for the coloring of the markers from the dropdown menu: ",
    strong("Color variable."),br(),br(),
    "Moreover, user can specify an x-value that will be input into the model to get a prediction for the y-value: ",
    strong("Input x-value for the fit."),br(),
    "This last variable can be of numeric type (user can also use up/down arrows for increments). ",br(),
    "Its value is shown on the plot in the legend after 'Fit input (x)' and ", 
    "the predicted y-value obtained from the linear model is shown after 'Fit result (y)'.",br(),
    "A diamond shaped marker is also shown on the plot that corresponds to these coordinates.",br(),
    "The last switch controls plotting (or not) the linear model and prediction information on the plot: ",
    strong("Plot linear fit and prediction."),br(),br(),
    "By default the milage per US gallon (mpg) as a function of the weight (wt) (in 1000 lbs) is shown. ",br(),
    "A linear model that predicts mpg from wt is built and plotted. ",br(),
    "The mpg for a car that is 2.5 (*1000) lbs is predicted using the model and its details are shown.",br(),br(),
    tagList("The source code can be found at: ",
            a("https://github.com/amete/Shiny-Application-and-Reproducible-Pitch-Course-Project", 
              href="https://github.com/amete/Shiny-Application-and-Reproducible-Pitch-Course-Project")),br(),br(),
    align = "center"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("xvariable",
                   "Plot variable (x):",
                   c("Weight (1000 lbs)" = "wt",
                     "Gross horsepower" = "hp",
                     "Number of cylinders" = "cyl",
                     "Miles/(US) gallon" = "mpg")),
       selectInput("yvariable",
                   "Plot variable (y):",
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
       selectInput("color",
                   "Color variable:",
                   c("Number of cylinders" = "cyl",
                     "Gross horsepower" = "hp",
                     "Weight (1000 lbs)" = "wt",
                     "Miles/(US) gallon" = "mpg")),
       numericInput("xval",
                    "Input x-value for the fit:",
                    2.5,
                    min=0,
                    max=250,
                    step=0.5),
       radioButtons("plotfit",
                    "Plot linear fit and prediction:",
                    c("Yes" = TRUE,
                      "No" = FALSE))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
