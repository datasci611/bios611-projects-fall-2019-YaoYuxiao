
library(tidyverse)
library(ggplot2)
library(dplyr)

clean = function(data_path){
  # read raw data
  raw = read_tsv(data_path)
  
  # convert the data type into Date
  raw$Date<-as.Date(raw$Date,format="%m/%d/%Y")
  raw
  #preparation: rename variables ,remove unused variables and filter by time
  data=raw %>%
    rename('id'='Client File Number',
           'Bus'='Bus Tickets (Number of)',
           'Food'='Food Pounds',
           'Clothing'='Clothing Items',
           'Schoolkits'='School Kits',
           'Money'='Financial Support',
           'Hygienekits' = 'Hygiene Kits')%>%
    select(-'Client File Merge',-(Field1:Field3))%>%
    filter(Date>="1998-01-01" & Date<="2018-12-31")%>%
    filter(Date!="2018-06-12")%>%# remove abnormal data in Food
    filter(Date!="2018-01-26"&Date!="2014-04-30")# remove abnormal data in Diapers
}


# ---------------- part A : trends-------------------------



plot1=function(data,service,year){
  
  service_yearly= data %>%
    select(Date,service)%>%
    drop_na() %>%
    separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
    filter(Year>=year[1]&Year<=year[2])%>%
    group_by(Year) %>%
    summarise(sum=n())
  
  p=ggplot(service_yearly,aes(as.numeric(Year),sum))+
    geom_point()+
    geom_text(aes(label=sum),vjust=-0.5,size=3)+
    geom_line(size=1,color='darkgreen') +
    scale_x_continuous(breaks = seq(year[1],year[2],2))+
    labs(x="Year",y= paste('Number of',service,sep=''),
         title = paste('Number of Visit Times',service,' Changes from ',min(year),' to ',max(year)))
  
 
  return(p)
}
# ---------------- part B : seasonalities-------------------------


data2=function(data,service,year){
  data2= data %>%
    select(Date,service)%>%
    drop_na() %>%
    separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
    group_by(Year,Month)%>%
    filter(Year>=year[1]&Year<=year[2])%>%
    drop_na(service) %>%
    summarise(num=n(),mean=mean(get(service)))%>%
    mutate(sum=num*mean)
  
  return(data2)
}

# monthly--facet by year
plot2a=function(data,service,year){
  data2=data2(data,service,year)
  
 p= ggplot(data2,aes(as.numeric(Month),sum))+
    geom_line(size=0.7,color='purple4')+
   scale_x_continuous(breaks = c(1,2,3,4,5,6,7,8,9,10,11,12))+
    labs(x="Month",y=paste('Number of ',service),
         title = paste(service,' Changes from ',min(year),' to ',max(year)))+
    facet_wrap(vars(Year))
 return(p)
}

#pie chart
plot2b=function(data,service,year){
  data2b=data2(data,service,year)%>%
    group_by(Month)%>%
    summarise(sum_monthly=mean(sum)*12)%>%   
    mutate(prop=sum_monthly/sum(sum_monthly))
  
  p=ggplot(data2b,aes(x="",y=prop,fill=Month))+ # TODO fill=season? geom_text?
    geom_bar(stat="identity",width=1)+
    coord_polar(theta = "y")+ 
    labs(title = paste(service,' by Month from ',min(year),' to ',max(year)))
return(p)
}

#table 
table2b=function(data,service,year){
  table2b=data2(data,service,year)%>%
    group_by(Month)%>%
    summarise(sum_monthly=mean(sum)*12)%>%
    arrange(Month)%>%
    mutate(prop=sum_monthly/sum(sum_monthly))
  
  return(table2b)
}

# ---------------- part C : correlations-------------------------

plot3=function(data,variable1,variable2){
  corr_data=data%>%
    select(Date,variable1,variable2)%>%
    drop_na()
  
 p=ggplot(corr_data,aes(x=get(variable1),y=get(variable2)))+
    geom_point(alpha=0.5)+
    geom_smooth(method = "lm")+
    labs(x=variable1,y=variable2,
         title=paste("Correlation between ",variable1," and ",variable2))
 
   #  scale_x_continuous(limits=c(0,60)) # set limits to avoid two abnormal data TODO -->data cleaning
 
  return(p)
}

# TODO table3=function(data,variable1,variable2){}
