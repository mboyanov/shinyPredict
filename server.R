
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(forecast)


sepByPath <- list("priceofbitcoin.csv" = '', "hboPageFansTotal.csv"='\t', "priceofbitcoin.csv.weekly"='')

getData <- function(path) {
  s<-sepByPath[path]
  data <- read.csv(path)
  ts(data[,2])
  
}

shinyServer(function(input, output) {
  
  output$title <- renderText("Hello Shiny ;)")
  output$distPlot <- renderPlot({
    t <- getData(input$path);
    if (input$log){
      t <- log(t)
    }
    if (input$diff)
    {
      t <- diff(t)
    }
    plot(t) 
  })
  output$acf <- renderPlot({
    t <- getData(input$path);
    
    if (input$log){
      t <- log(t)
    }
    if (input$diff)
    {
      t <- diff(t)
    }
    plot(acf(t)) 
  })
  output$pacf <- renderPlot({
    t <- getData(input$path);
    
    if (input$log){
      t <- log(t)
    }
    if (input$diff)
    {
      t <- diff(t)
    }
    plot(pacf(t)) 
  })
  output$forecast <- renderPlot({
    
    t <- getData(input$path);
    
    if (input$log){
      t <- log(t)
    }
    if (input$diff)
    {
      t <- diff(t)
    }
    train<-t[1:floor(length(t)*9/10)]
    test<-t[ceiling(length(t)*9/10):length(t)]
    f <- auto.arima(train)
    predicted <-forecast(f, h=length(test))
    print(test)
    err <- sqrt(sum((test - predicted$mean) * (test-predicted$mean))/length(test))
    print(err)
    plot(predicted, col='blue') 
    lines(t, col='black')
  })
  
  output$errorPlot <- renderPlot({
    
    t <- getData(input$path);
    
    if (input$log){
      t <- log(t)
    }
    if (input$diff)
    {
      t <- diff(t)
    }
    train<-t[1:floor(length(t)*9/10)]
    test<-t[ceiling(length(t)*9/10):length(t)]
    f <- auto.arima(train)
    predicted <-forecast(f, h=length(test))
    err <- sqrt(sum((test - predicted$mean) * (test-predicted$mean))/length(test))
    plot(predicted$mean, col='blue') 
    lines(test, col='black')
  })
  

})
