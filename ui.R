#load libraries

library(shiny)
library(shinythemes)
library(ggplot2)
library(readxl)
library(dplyr)


#define user interface

ui <- fluidPage(
  
  
  #choose theme from shinythemes
  
  theme = shinytheme('journal'),
  
  
  #add title
  
  titlePanel('BULLSEYE PLOT'),
  br(),
  
  #sidebar layout
  
  sidebarLayout(
    
    
    #inputs on sidebar panel
    
    sidebarPanel(
      
      selectInput('mode','Mode',c('9 mm','Foc Central','Lliure','Standard','Aire'))
      
    ),
    
    
    #outputs on main panel
    
    mainPanel (
      
      
      #tabset panels with plot output and table output
      
      tabsetPanel(
        
        type='tabs',
        
        tabPanel('Bullseye Plot',
                 
                 plotOutput('bullseye')
                 
                 ),
        
        tabPanel('Gun Summary',
                 
                 tableOutput('gun')
                 
                 )
        
      )
      
    ) 
    
  )
  
  
  
)