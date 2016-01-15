library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Statistical Power Calculator using the t-distribution*"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      tags$head( tags$script(src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML-full", type = 'text/javascript'),
                 tags$script( "MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}});", type='text/x-mathjax-config')),
      withMathJax(),
      "Interactive calculator for illustrating power of a statistical hypothesis test", 
      sliderInput("alpha", 
                  HTML("<br> </br>", "alpha $\\alpha$ :"), 
                  min = 0.01, 
                  max = 0.2,
                  value = 0.05),
      sliderInput("mualt", 
                  HTML("Difference in mean $\\delta_a$ :"), 
                  min = 0.1, 
                  max = 2, 
                  value = 0.5, 
                  step = 0.001),
      sliderInput("size", 
                  HTML("Sample size in each group :"),
                  min = 30, 
                  max = 200, 
                  value = 50),
      sliderInput("stdev",
                  HTML("Standard deviation :"), 
                  min = 0.2, 
                  max = 3, 
                  value = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"), 
       br(), 
       h6("*plot adapted from",  a(href = "http://www.springer.com/us/book/9781461412373", "Behavioral Research Data Analysis with R"))
    )
  )
))
