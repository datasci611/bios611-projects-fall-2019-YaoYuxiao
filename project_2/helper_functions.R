library(tidyverse)

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
    filter(Date>="1998-01-01" & Date<="2018-12-31")
}


# ---------------- part A : trends-------------------------

data1= function(data,service,year){
  
  

}

plot1=function(data,service,year){
  service_var=switch(service,'Client Number'='id','Food'='Food', 'Clothing Items'='Clothing', 
                     'Diapers'='Diapers', 'School Kits'='Schoolkits', 'Hygiene Kits'='Hygienekits',
                     'Bus Tickets'='Bus','Financial Support'='Money')
  service_yearly= data %>%
    select(Date,service)%>%
    drop_na() %>%
    separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
    filter(between(year,year[1],year[2]))%>%
    group_by(Year) %>%
    summarise(sum=n())
  
  
  p=ggplot(service_yearly,aes(as.numeric(Year),sum))+
    geom_point()+
    geom_text(aes(label=sum),vjust=-0.5,size=3)+
    geom_line(size=1,color='darkgreen') +
    labs(x="Year",y= paste('Number of',service,sep=''),
         title = paste('Number of',service,'Changes from',min(year),' to ',max(year),sep=''))
  return(p)
}
# ---------------- part B : seasonalities-------------------------
data2= function(data,service,year){
  
  
  
}
plot2a=function(data,service,year){
  
  
}
plot2b=function(data,service){
  
  
}
table2b=function(data){
  
}

# ---------------- part C : correlations-------------------------
data3= function(data,variable1,variable2){
  
  
  
}
plot3=function(data,variable1,variable2){
  
  
}

# TODO table3=function(data,variable1,variable2){}
