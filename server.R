#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    if(!require(dplyr)) {
        install.packages("dplyr")
        require(dplyr)
    }

    # Building-up the dataset for plotting
    dataset_x <- select(mtcars,c(input$xvariable))
    names(dataset_x) <- "xvar"
    dataset_y <- select(mtcars,c(input$yvariable))
    names(dataset_y) <- "yvar"
    dataset_c <- select(mtcars,c(input$color))
    names(dataset_c) <- "color"
    dataset <- cbind(dataset_x,dataset_y,dataset_c) 
 
    # Plotting
    if(!require(ggplot2)) {
        install.packages("ggplot2")
        require(ggplot2)
    }
    
    p <- ggplot(data = dataset, aes(x = xvar, y = yvar, color=color))
    p <- p + geom_point(size = 4, show.legend = TRUE)
    p <- p + geom_point(colour = "black", size = 1.5, show.legend = TRUE)
    p <- p + scale_x_continuous(limits = input$xrange)
    p <- p + scale_y_continuous(limits = input$yrange)
    p <- p + scale_color_gradientn(name = toupper(input$color),colours = rainbow(3))
    p <- p + labs( title  = "2-D Histogram",
                   x = toupper(input$xvariable),
                   y = toupper(input$yvariable))
    p <- p + theme(plot.title = element_text(hjust = 0.5))
    if(input$plotfit) {
        p <- p + geom_smooth(method='lm',formula=y~x)
    }
    
    return(p)
  })
  
})
