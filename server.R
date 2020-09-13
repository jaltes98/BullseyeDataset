#load libraries

library(shiny)
library(ggplot2)
library(readxl)
library(dplyr)


#define server

server <- function(input,output){

    
  #load data
  
  dades <- read_excel('BullseyeShooting.xlsx','Punts')
  
  
  #column to distinguish competition to training
  
  dades$competi <- dades$`COMPETICIÓ`!='Entrenament'
  
  
  #the main output is the bullseye plot
  
  output$bullseye <- renderPlot(
    
    ggplot()+
      
      #reverse polar coordinates such that the center is the maximum (600 points)
      
      labs(title = 'Evolució de les tirades')+
      scale_y_reverse(limits = c(600,500),expand=c(0,0),breaks=c(600,575,550,525,500))+
      scale_x_datetime(limits = c(as.POSIXct('2008-06-01','UTC'),as.POSIXct('2019-07-17','UTC')),date_breaks = '1 year',date_labels = '%Y')+
      scale_color_manual(labels=c('Entrenament','CompeticiÃ³'),values = c('#ffd999','#f5abf4'))+
      scale_fill_manual(labels=c('Entrenament','CompeticiÃ³'),values = c('#f5b342','#f542f2'))+
      coord_polar(theta = 'x')+
      
      #decreasing tones of grey to distinguish the years
      
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2008-06-01','UTC'),xmax=as.POSIXct('2008-12-30','UTC')),fill='grey87')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2008-12-30','UTC'),xmax=as.POSIXct('2009-12-30','UTC')),fill='grey88')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2009-12-30','UTC'),xmax=as.POSIXct('2010-12-30','UTC')),fill='grey89')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2010-12-30','UTC'),xmax=as.POSIXct('2011-12-30','UTC')),fill='grey90')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2011-12-30','UTC'),xmax=as.POSIXct('2012-12-30','UTC')),fill='grey91')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2012-12-30','UTC'),xmax=as.POSIXct('2013-12-30','UTC')),fill='grey92')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2013-12-30','UTC'),xmax=as.POSIXct('2014-12-30','UTC')),fill='grey93')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2014-12-30','UTC'),xmax=as.POSIXct('2015-12-30','UTC')),fill='grey94')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2015-12-30','UTC'),xmax=as.POSIXct('2016-12-30','UTC')),fill='grey95')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2016-12-30','UTC'),xmax=as.POSIXct('2017-12-30','UTC')),fill='grey96')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2017-12-30','UTC'),xmax=as.POSIXct('2018-12-30','UTC')),fill='grey97')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2018-12-30','UTC'),xmax=as.POSIXct('2019-12-30','UTC')),fill='grey98')+
      geom_rect(mapping=aes(ymin=600,ymax=500,xmin=as.POSIXct('2019-12-30','UTC'),xmax=as.POSIXct('2019-07-17','UTC')),fill='grey99')+
      
      #center of the bullseye
      
      geom_rect(mapping=aes(ymin=600,ymax=575,xmin=as.POSIXct('2008-06-01','UTC'),xmax=as.POSIXct('2019-07-17','UTC')),fill='Black')+
      
      #manually create grid so it can override the rectangles
      
      geom_hline(yintercept = c(550,525,500), colour = "Black", size = 1.1)+
      
      #adjust theme and guides
      
      theme_minimal()+
      guides(colour = guide_legend(override.aes = list(size=3)))+
      theme(panel.grid = element_blank(),
            panel.ontop = T,
            legend.position = 'bottom',
            axis.title = element_blank(),
            axis.line.x = element_blank(),
            legend.title = element_blank(),
            axis.ticks.y = element_line(size = 1.1),
            title = element_text(size = 17),
            legend.text = element_text(size = 13,face = 2),
            axis.text.y = element_text(size = 13),
            axis.text.x = element_text(face = 2,size=10))+
      
      #add the points corresponding to the desired mode (through input)
      
      geom_point(data = dades[(dades$MODALITAT==input$mode & !is.na(dades$ARMA)),],aes(x=DATA,y=TOTAL,fill=competi,col=competi),size=2,shape=21,stroke=0.5)
      
  )
  
  
  #secondary output is a table with used guns and some descriptives for the selected mode
  
  output$gun <- renderTable(
    
    summarise(group_by(dades[(dades$MODALITAT==input$mode & !is.na(dades$ARMA)),],ARMA,CALIBRE), Count= n(), Max=max(TOTAL, na.rm=TRUE), Median=median(TOTAL, na.rm=TRUE),Mean=mean(TOTAL,na.rm=T))
    
  )
  
}