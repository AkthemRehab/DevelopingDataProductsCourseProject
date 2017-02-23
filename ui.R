library(shiny)

# Define UI for the application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Horse Power"),
  
  # Sidebar with a slider input 
  sidebarLayout(
    sidebarPanel(
       sliderInput("MPGSlide", "What is the car MPG?", min = 10, max = 35, 
                   value = 20, step = 1),
       sliderInput("CylSlide", "What is the car Cylinder?", min = 4, max = 8, 
                   value = 4, step = 2),
       checkboxInput("ShowModel1", "Show/hide model predicting based on miles per gallon", value = FALSE),
       checkboxInput("ShowModel2", "Show/hide Model predicting for each cylinder type", value = FALSE),
       submitButton("Submit")
       ),
    
    # Show a plot of the generated model(s)
    mainPanel(
        plotOutput("plot1"),
        h4("This interactive plot attempts to demonstrate the prediction of horsepower 
using two regression models. The first one looks only at the MPG while the second 
           takes the Car cylinder into consideration. The second model is represented by 
           3 lines to show the prediction for each cylinder value. This will help you visualize the impact of fixing the 
           cylinder value versus using the regression value depicted by the blue point."),
        h3("Predicted Horsepower from Model Predicting Based on Miles Per Gallon:"),
        textOutput("pred1"),
        h3("Predicted Horsepower from Model Predicting for Each Cylinder Type:"),
        textOutput("pred2")
        )
    )
))