import pandas as pd
import numpy as np
# client.tsv
client = pd.read_csv("../data/CLIENT_191102.tsv", encoding='utf-8',delimiter='\t')
client.head()
client.groupby("EE Provider ID").size()
client=client[client["EE Provider ID"]=='Urban Ministries of Durham - Durham County - Singles Emergency Shelter - Private(5838)']
# get the number of unique values of "Client Unique ID"
client["Client Unique ID"].nunique()
# get the number of unique values of "Client Unique ID"
client["Client ID"].nunique()
#drop the "Client Unique ID" and "EE Provider ID"

client = client.drop(['Client Unique ID', 'EE Provider ID'],1)
client.head()
#change "Client doesn't know" "Client refused" and "Data not collected" to NaN
client['Client Primary Race']=client['Client Primary Race'].replace("Client doesn't know (HUD)", np.NaN).replace("Client refused (HUD)", np.NaN).replace("Data not collected (HUD)", np.NaN)
client.groupby("Client Primary Race").size()
client['Client Ethnicity']=client['Client Ethnicity'].replace("Client doesn't know (HUD)", np.NaN).replace("Client refused (HUD)", np.NaN).replace("Data not collected (HUD)", np.NaN)
client.groupby("Client Ethnicity").size()
client['Client Veteran Status']=client['Client Veteran Status'].replace("Data not collected (HUD)", np.NaN)
client.groupby("Client Veteran Status").size()

# entry_exit.csv
entry_exit = pd.read_csv("../data/ENTRY_EXIT_191102.tsv", encoding='utf-8',delimiter='\t')
entry_exit.groupby("EE Provider ID").size()
entry_exit=entry_exit[entry_exit["EE Provider ID"]=='Urban Ministries of Durham - Durham County - Singles Emergency Shelter - Private(5838)']
entry_exit = entry_exit.drop(['Client Unique ID', 'EE Provider ID','Entry Exit Group Id','Entry Exit Household Id','Unnamed: 6','Housing Move-in Date(5584)'],1)
entry_exit['Destination']=entry_exit['Destination'].replace("Client doesn't know (HUD)", np.NaN).replace("Client refused (HUD)", np.NaN).replace("Data not collected (HUD)", np.NaN)
entry_exit.groupby("Destination").size()
entry_exit = entry_exit.drop(['Entry Exit Type','Entry Exit Date Added','Entry Exit Date Updated'],1)
entry_exit[['Entry Date', 'Exit Date']] = entry_exit[['Entry Date', 'Exit Date']].apply(pd.to_datetime)
entry_exit['stay_days']=entry_exit['Exit Date'] - entry_exit['Entry Date']
entry_exit.head()

# ee_udes
ee_udes = pd.read_csv("../data/EE_UDES_191102.tsv", delimiter='\t', encoding='utf-8')
ee_udes.head()
ee_udes=ee_udes[ee_udes["EE Provider ID"]=='Urban Ministries of Durham - Durham County - Singles Emergency Shelter - Private(5838)']
ee_udes = ee_udes.drop(['Client Unique ID', 'EE Provider ID'],1)
ee_udes.head()
ee_udes = ee_udes.drop(['Did you stay less than 7 nights?(5164)', 'Did you stay less than 90 days?(5163)','On the night before did you stay on the streets, ES or SH?(5165)','If yes for Domestic violence victim/survivor, when experience occurred(1917)'],1)
ee_udes.head()
ee_reviews = pd.read_csv("../data/EE_REVIEWS_191102.tsv", delimiter='\t', encoding='utf-8')
ee_reviews.head()
client["EE UID"].nunique()
entry_exit["EE UID"].nunique()
ee_udes["EE UID"].nunique()

# merge data
merged_data=pd.merge(pd.merge(client, entry_exit, how='left', on='EE UID'),ee_udes,how='left', on='EE UID')
merged_data = merged_data.drop(['Client ID_y', 'Client ID'],1)
df.rename(columns={"Client ID_x": "Client ID"})
merged_data
client_first = client.drop_duplicates(subset='Client ID', keep='first')
client_first = client_first.drop(['EE UID'],1)
entry_exit_first=entry_exit.drop_duplicates(subset='Client ID', keep='first')
entry_exit_first = entry_exit_first.drop(['EE UID'],1)
ee_udes_first=ee_udes.drop_duplicates(subset='Client ID', keep='first')
ee_udes_first = ee_udes_first.drop(['EE UID'],1)
merged_data_client=pd.merge(pd.merge(client_first, entry_exit_first, how='left', on='Client ID'),ee_udes_first,how='left', on='Client ID')
merged_data_client

merged_data.to_csv("../data/merged_data.tsv", sep='\t')
merged_data_client.to_csv("../data/merged_data_client.tsv", sep='\t')

# health_ins
health_ins_entry = pd.read_csv("../data/HEALTH_INS_ENTRY_191102.tsv", delimiter='\t', encoding='utf-8')
health_ins_exit = pd.read_csv("../data/HEALTH_INS_EXIT_191102.tsv", delimiter='\t', encoding='utf-8')
health_ins_entry=health_ins_entry[health_ins_entry["EE Provider ID"]=='Urban Ministries of Durham - Durham County - Singles Emergency Shelter - Private(5838)']
health_ins_exit=health_ins_exit[health_ins_exit["EE Provider ID"]=='Urban Ministries of Durham - Durham County - Singles Emergency Shelter - Private(5838)']
health_ins_entry = health_ins_entry.drop(['Client Unique ID', 'EE Provider ID','Recordset ID (4307-recordset_id)','Date Added (4307-date_added)'],1)
health_ins_exit = health_ins_exit.drop(['Client Unique ID', 'EE Provider ID','Recordset ID (4307-recordset_id)','Date Added (4307-date_added)'],1)
health_ins_entry_first=health_ins_entry.drop_duplicates(subset='Client ID', keep='first')
health_ins_entry_first = health_ins_entry_first.drop(['EE UID'],1)
health_ins_exit_first=health_ins_exit.drop_duplicates(subset='Client ID', keep='first')
health_ins_exit_first = health_ins_exit_first.drop(['EE UID'],1)
merged_data_health_ins=pd.merge(health_ins_entry_first, health_ins_exit_first, how='left', on='Client ID')
merged_data_health_ins.to_csv("../data/merged_data_health_ins.tsv", sep='\t')

# income
income_entry = pd.read_csv("../data/INCOME_ENTRY_191102.tsv", delimiter='\t', encoding='utf-8')
income_exit = pd.read_csv("../data/INCOME_EXIT_191102.tsv", delimiter='\t', encoding='utf-8')
income_entry=income_entry[income_entry["EE Provider ID"]=='Urban Ministries of Durham - Durham County - Singles Emergency Shelter - Private(5838)']
income_exit=income_exit[income_exit["EE Provider ID"]=='Urban Ministries of Durham - Durham County - Singles Emergency Shelter - Private(5838)']
income_entry = income_entry.drop(['Client Unique ID', 'EE Provider ID','Recordset ID (140-recordset_id)','Date Added (140-date_added)'],1)
income_exit = income_exit.drop(['Client Unique ID', 'EE Provider ID','Recordset ID (140-recordset_id)','Date Added (140-date_added)'],1)

income_entry_first=income_entry.drop_duplicates(subset='Client ID', keep='first')
income_entry_first = income_entry_first.drop(['EE UID'],1)
income_exit_first=income_exit.drop_duplicates(subset='Client ID', keep='first')
income_exit_first = income_exit_first.drop(['EE UID'],1)
merged_data_income=pd.merge(income_entry_first, income_exit_first, how='left', on='Client ID')
merged_data_income.to_csv("../data/merged_data_income.tsv", sep='\t')
merged_data_income.head()



