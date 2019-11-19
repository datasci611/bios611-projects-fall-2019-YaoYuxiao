library(tidyverse)
#---------data preparation-----------------

#merged_data_client<-read.delim('https://github.com/datasci611/bios611-projects-fall-2019-YaoYuxiao/blob/master/project_3/data/merged_data_client.tsv', sep="\t", header=TRUE)
merged_data_client = read_tsv("C:/Users/yaoyu/OneDrive/Documents/bios611-projects-fall-2019-YaoYuxiao/project_3/data/merged_data_client.tsv")
merged_data=read_tsv("C:/Users/yaoyu/OneDrive/Documents/bios611-projects-fall-2019-YaoYuxiao/project_3/data/merged_data.tsv")
# clean column names
names(merged_data)<-make.names(names(merged_data))
names(merged_data_client)<-make.names(names(merged_data_client))

str(merged_data_client)

#-----------demographics--------------
demographic_data = merged_data_client %>%
  select(Client.ID,Client.Age.at.Entry,Client.Gender,Client.Primary.Race,Client.Ethnicity,Client.Veteran.Status)

demographic_data
#--------plot1: age and gender-------------

male_sub=subset(demographic_data,(Client.Gender == "Male"))
male_sub
male_sub = male_sub%>%
  group_by(Client.Age.at.Entry) %>%
  summarise(count= -1 * n())

male_sub

plot1.1=ggplot(demographic_data,mapping=aes(x=Client.Age.at.Entry))+
  geom_bar(subset(demographic_data,(Client.Gender == "Female")),mapping=aes(x=Client.Age.at.Entry),fill='pink2') + 
  geom_bar(male_sub,mapping=aes(x=Client.Age.at.Entry,y=count),stat = "identity",fill='skyblue2') +
  coord_flip()
  
plot1.1

#--------plot2,3: race and ethnicity-------------
race=demographic_data %>%
  drop_na()%>%
  group_by(Client.Primary.Race) %>%
  summarise(count= n())
race
# TODO remove (HUD)
plot1.2<- ggplot(race, aes(x="", y=count, fill=Client.Primary.Race))+
  geom_bar(width = 1, stat = "identity")+
  coord_polar("y", start=0)+
  scale_fill_brewer(palette = "YlGnBu") 
plot1.2

eth=demographic_data %>%
  drop_na()%>%
  group_by(Client.Ethnicity) %>%
  summarise(count= n())
eth
plot1.3<- ggplot(eth, aes(x="", y=count, fill=Client.Ethnicity))+
  geom_bar(width = 1, stat = "identity")+
  coord_polar("y", start=0)+
  scale_fill_brewer(palette = "YlGnBu") 
plot1.3

#--------plot4: veteran------------------
veteran=demographic_data %>%
  drop_na()%>%
  group_by(Client.Veteran.Status) %>%
  summarise(count= n())

veteran

plot1.4<- ggplot(veteran, aes(x="", y=count, fill= Client.Veteran.Status))+
  geom_bar(width = 1, stat = "identity")+
  coord_polar("y", start=0)+
  scale_fill_brewer(palette = "YlGnBu") 
plot1.4

#-----------entry and exit--------------
ee_data = merged_data %>%
  select(Client.ID,Entry.Date,Exit.Date,Destination,Reason.for.Leaving,stay_days)
ee_data
#------------------plot1: line of entry time------------
client_monthly=ee_data %>%
  separate(Entry.Date, sep = "-", into = c("Year", "Month", "Day"))%>%
  group_by(Year,Month) %>%
  summarise(client_sum=n())

client_monthly
client_monthly$yearmonth<-as.factor(paste(client_monthly$Year,client_monthly$Month,sep="-"))
client_monthly
plot2.1=ggplot(client_monthly,aes(as.numeric(yearmonth),client_sum))+
  geom_point()+
  geom_text(aes(label=client_sum),vjust=-0.8,size=3)+
  geom_line(size=1,color='skyblue3') +
  labs(x="Month",y="Client Number",title = "Fig2.1 Number of Clients Changes by Month")
plot2.1
# TODO set scale_x_continuous breaks
#--------------plot2: ---------------

