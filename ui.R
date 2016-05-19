
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel(textOutput("title")),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("path", "Dataset", list("Bitcoins" = "priceofbitcoin.csv", "Bitcoins Weekly" = "priceofbitcoin.csv.weekly",
                                          "Fans of HBO" = 'hboPageFansTotal.csv', "Fans of HBO Weekly" = 'hboPageFansTotal.csv.weekly',
                                          "Price of Gold" = 'priceofgoldsince2015.csv',
                                          "Australian Beer Production" = "beer.csv.monthly"),),
      checkboxInput("log", "Log Data?", FALSE),
      checkboxInput("diff", "Diff Data?", FALSE)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      plotOutput("acf"),
      plotOutput("pacf"),
      plotOutput("forecast"),
      plotOutput("errorPlot")
    )
  )
))
