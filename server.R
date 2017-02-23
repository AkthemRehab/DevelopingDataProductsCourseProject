library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

output$plot1 <- renderPlot({
        model1 <- lm(hp ~ mpg, data = mtcars) 
        model2 <- lm(hp ~ mpg + cyl, data = mtcars)
        
        model1pred <- reactive({
                mpgInput <- input$MPGSlide 
                CylInput <- input$CylSlide
                predict(model1, newdata = data.frame(mpg = mpgInput))
        })

        model2pred <- reactive({
                mpgInput <- input$MPGSlide 
                CylInput <- input$CylSlide
                predict(model2, newdata = data.frame(mpg = mpgInput, 
                        cyl = CylInput)) 
        })

        output$plot1 <- renderPlot({
                mpgInput <- input$MPGSlide
                CylInput <- input$CylSlide
                  
                plot(mtcars$mpg, mtcars$hp, col = mtcars$cyl, 
                     xlab = "Miles per Gallon", 
                     ylab = "Horsepower", pch = 16, xlim = c(10,35), 
                     ylim = c(0, 350), bty = "n")

                if(input$ShowModel1){
                        abline(model1, col = "red", lwd = 2)
                }

                if(input$ShowModel2){
                        model2lines2 <- predict(model2, newdata = data.frame(
                                mpg = 10:35, cyl = 4))
                        model2lines4 <- predict(model2, newdata = data.frame(
                                mpg = 10:35, cyl = 6))
                        model2lines6 <- predict(model2, newdata = data.frame(
                                mpg = 10:35, cyl = 8))
                        lines(10:35, model2lines2, col = "blue", lwd = 2)
                        lines(10:35, model2lines4, col = "blue", lwd = 2)
                        lines(10:35, model2lines6, col = "blue", lwd = 2)
                }
                  
                legend(25, 250, unique(mtcars$cyl), 
                         pch = 16, col = mtcars$cyl, bty = "n", cex = 1.2) 
                points(mpgInput, model1pred(), col = "red", pch = 16, cex = 2) 
                points(mpgInput, model2pred(), col = "blue", pch = 16, cex = 2) 
        })
          
        output$pred1 <- renderText({
                model1pred()
        })
          
        output$pred2 <- renderText({
                model2pred()
        })
})
})