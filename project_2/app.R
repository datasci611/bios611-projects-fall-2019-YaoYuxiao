library(shiny)
library(tidyverse)
library(dplyr)
library(shinydashboard)
library(ggplot2)
library(rsconnect)

source("helper_functions.R")



data=clean('https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-YaoYuxiao/master/project_1/data/UMD_Services_Provided_20190719.tsv')


ui <- fluidPage(
  titlePanel("BIOS611 Project2 - Yuxiao Yao"),
  sidebarPanel(
  h3(helpText('Part 1. Trend Analysis')),
  helpText("Please select client number or any type of service as 
           y-axis and time period from 1998 to 2018 as x-axis."),
  
  selectInput('plot1_y',
               'Client Number/Type of services',
               c('Client Number'='id','Food'='Food', 'Clothing Items'='Clothing', 
                 'Diapers'='Diapers', 'School Kits'='Schoolkits', 'Hygiene Kits'='Hygienekits',
                 'Bus Tickets'='Bus','Financial Support'='Money')),
  
  sliderInput('plot1_x',
              'Years',
              min = 1998,
              max = 2018,
              value = c(1998,2018),
              sep = ''),
  hr(),
  
  h3(helpText('Part 2. Seasonality Analysis')),
  helpText("Please select food pounds or number of clothing items as y-axis and time
           period from 1998 to 2018 of interest."),
  
  radioButtons('plot2_service',
               'Type of services',
               choices = c('Food Pounds'='Food', 'Clothing Items'='Clothing')),
  
  sliderInput('plot2_year',
              'Years',
              min = 1998,
              max = 2018,
              value = c(1998,2018),
              sep = ''),
  hr(),
  
  h3(helpText('Part 3. Correlation Analysis')),
  helpText("Please select two variables as x-axis and y-axis."),
  
  radioButtons('plot3_x',
               'Variale1 (x-axis)',
               choices = c('Diapers'='Diapers', 'School Kits'='Schoolkits'),
               selected='Diapers'),
  
  radioButtons('plot3_y',
               'Variale2 (y-axis)',
               choices = c('Food Pounds'='Food', 'Clothing Items'='Clothing'))),
  
  mainPanel(
    
    plotOutput(outputId = "Plot1"),
    
    plotOutput(outputId = "Plot2a"),
    
    plotOutput(outputId = "Plot2b"),
    
    tableOutput(outputId = "Table2b"),
    
    plotOutput(outputId = "Plot3")
    
    # TODO tableOutput(outputId = "Table2b")

))



server <- function(input, output) { 
  # part1
  
  output$Plot1 <- renderPlot({
  
    plot1(data,input$plot1_y,input$plot1_x)
    
  })
  
  # part2
  
  output$Plot2a <- renderPlot({
   
    plot2a(data,input$plot2_service,input$plot2_year)
    
  })
  
  output$Plot2b <- renderPlot({
   
    plot2b(data,input$plot2_service,input$plot2_year)
    
  })
  
  output$Table2b <- renderTable({
    
    table2b(data,input$plot2_service,input$plot2_year)
    
  })
  
  # part3
  
  output$Plot3 <- renderPlot({
    
    plot3(data,input$plot3_x,input$plot3_y)
    
  })
  
  
}

shinyApp(ui, server)
