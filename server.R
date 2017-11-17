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

    # Perform a simple linear-fit
    my_fit <- lm(yvar~xvar, data = dataset)
    if(!is.na(input$xval)) {
        my_point <- data.frame(x = input$xval)
    }
    else {
        my_point <- data.frame(x = 0)
    }
    colnames(my_point) <- "xvar"
    my_point <- mutate(my_point, yvar=predict(my_fit,my_point))
    
    # Plotting
    if(!require(ggplot2)) {
        install.packages("ggplot2")
        require(ggplot2)
    }
    
    p <- ggplot(data = dataset, aes(x = xvar, y = yvar, color=color))
    p <- p + geom_point(size = 4, show.legend = TRUE)
    p <- p + geom_point(colour = "white", size = 1.5, show.legend = TRUE)
    p <- p + scale_x_continuous(limits = input$xrange)
    p <- p + scale_y_continuous(limits = input$yrange)
    p <- p + scale_color_gradientn(name = toupper(input$color),colours = rainbow(3))
    p <- p + labs( title  = "2-D Histogram",
                   x = toupper(input$xvariable),
                   y = toupper(input$yvariable))
    p <- p + theme_bw(base_size = 15)
    p <- p + theme(plot.title = element_text(hjust = 0.5))
    if(input$plotfit) {
        p <- p + geom_smooth(method='lm',formula=y~x)
        p <- p + geom_point(aes(x = my_point$xvar, y = my_point$yvar),
                            shape = 18, size=4, colour = "black")
        p <- p + annotate("text",
                          label = paste("Fit input  (x): ",format(round(my_point$xvar, 2), nsmall = 2)),
                          x = 0.60*input$xrange[2], 
                          y = 0.97*input$yrange[2],
                          size = 7,
                          hjust = 0)
        p <- p + annotate("text",
                          label = paste("Fit result (y): ",format(round(my_point$yvar, 2), nsmall = 2)),
                          x = 0.60*input$xrange[2], 
                          y = 0.85*input$yrange[2],
                          size = 7,
                          hjust = 0)
    }
    
    
    return(p)
  })

  
})
