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
       sliderInput("mu",
                   HTML("Null Distribution mean $\\mu_1$ :"),
                   # HTML("Null Distribution mean $$ \\mu_1 $$"),
                   min = 0,
                   max = 2,
                   value = 0, 
                   step = 0.001),
      sliderInput("mualt", 
                  HTML("Sample Distribution mean $\\mu_2$ :"), 
                  min = 0.1, 
                  max = 2, 
                  value = 0.5, 
                  step = 0.001)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"), 
       br(), 
       h6("*plot adapted from",  a(href = "http://www.springer.com/us/book/9781461412373", "Behavioral Research Data Analysis with R"))
    )
  )
))
