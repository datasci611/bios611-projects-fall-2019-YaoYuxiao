library(tidyverse)

raw = read_tsv("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-YaoYuxiao/master/project_1/data/UMD_Services_Provided_20190719.tsv")

# convert the data type into Date
raw$Date<-as.Date(raw$Date,format="%m/%d/%Y")
raw
#preparation: rename variables and filter by time
data=raw %>%
  rename('id'='Client File Number','Food'='Food Pounds','Clothing'='Clothing Items',
         'Schoolkits'='School Kits','Money'='Financial Support')%>%
  filter(Date>="1998-01-01" & Date<="2018-12-31")
data

#--------------------problem1----------------------------------------------------------
# prepare data for p1 
client= data %>%
  select(Date, id)%>%
  drop_na() %>%
 distinct(id, .keep_all = TRUE)%>%
  arrange(Date)

client_yearly=client %>%
  separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
  group_by(Year) %>%
  summarise(client_sum=n())%>%
  mutate(ave=ave(client_sum))

client_yearly

# plot the data

ggplot(client_yearly,aes(as.numeric(Year),client_sum))+
  geom_point()+
  geom_text(aes(label=client_sum),vjust=-0.5,size=3)+
  geom_line(size=1,color='darkgreen') +
  labs(x="Year",y="Client Number",title = "Number of Clients Changes by Year")
 # scale_x_continuous(limits=c('1998','2018'))
 # TODO set breaks for x axis

#-----------p2------------------------------------------
food_group= data %>%
  select(Date, 'Food')%>%
  drop_na() %>%
  filter(Date>="2008-01-01"&Date<="2017-12-31")%>% # focus on ten years(2008-2017)，because of abnormal data in June 2018
  separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
  group_by(Year,Month)%>%
  summarise(num=n(),mean=mean(Food))%>%
  mutate(sum=num*mean)%>%
  arrange(desc(Year))


food_group


ggplot(food_group,aes(as.numeric(Month),sum))+
 # geom_bar(mapping = aes(x = Month, y = sum), stat = "identity") +
  geom_line(size=0.7,color='darkgreen')+
  labs(x="Month",y="Food Pounds",title = "Food Pounds Provided from 2008 to 2017")+
  facet_wrap(vars(Year)) #TODO change to 3*3
# TODO set breaks for x axis


#-----------p3--------------------------------------------------------------

clothing_group= data %>%
  select(Date, 'Clothing')%>%
  drop_na() %>%
  filter(Date>="2008-01-01"&Date<="2017-12-31")%>% # focus on ten years(2008-2017)，because of abnormal data in June 2018
  separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
  group_by(Year,Month)%>%
  summarise(num=n(),mean=mean(Clothing))%>%
  mutate(sum=num*mean)%>%
  arrange(desc(Year))


clothing_group


ggplot(clothing_group,aes(as.numeric(Month),sum))+
  # geom_bar(mapping = aes(x = Month, y = sum), stat = "identity") +
  geom_line(size=0.7,color='darkblue')+
  labs(x="Month",y="Clothing Items",title = "Food Pounds Provided from 2008 to 2017")+
  facet_wrap(vars(Year)) #TODO change to 3*3
# TODO set breaks for x axis

#-----------p4--------------------------------------------------------------

corr_data=data%>%
  select(Date,Diapers,Clothing,Money)%>%
  drop_na()%>%
  arrange(desc(Diapers))
# replace NA with 0
# corr_data[is.na(corr_data)]<-0 
corr_data

  ggplot(corr_data,aes(Diapers,Clothing))+ # D&S D&C D&F
    geom_point(alpha=0.5)+
    geom_smooth(method = "lm")+
    scale_x_continuous(limits=c(0,60))+ # set limits to avoid two abnormal data
  labs(x="Number of Packs of Diapers",y="Number of Clothing Items",title="Fig6: Correlations between Diampers and Clothing Items")

  