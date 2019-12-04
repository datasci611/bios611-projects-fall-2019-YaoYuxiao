# bios611-project3: Data Analysis - UMD
Yuxiao Yao

## Background 
Non-profit Urban Ministries of Durham (UMD) connects poor and homeless neighbors to food, shelter and a future. 
They connect with the community to end homelessness and fight poverty by offering food, shelter and a future to neighbors in need. 
Here is the official website of UMD: http://www.umdurham.org/. This project is aiming to help UMD to improve their services and get prepared for future works. 

## Datasets
Datasets are provided by UMD, which includes clients' information, entry and exit information, clients' health insurance conditions, income conditions and disability conditions at entry and at exit, provider information.  
Some variables are shown below:  
* CLIENT: Client ID, Client Age at Entry, Client Gender, Client Primary Race, Client Ethnicity, Client Veteran Status
* ENTRY_EXIT: Entry Date, Exit Date, Destination, Reason for Leaving
* EE_UDES: Client Location, Relationship to Head of Household, Prior Living Situation, Length of Stay in Previous Place
* HEALTH_INS_ENTRY: Covered (Entry), Health Insurance Type (Entry), Health Insurance Start Date (Entry)
* HEALTH_INS_EXIT: Covered (Exit), Health Insurance Type (Exit), Health Insurance Start Date (Exit)
* INCOME_ENTRY: Receiving Income (Entry), Income Source (Entry), Monthly Amount (Entry)
* INCOME_EXIT: Receiving Income (Exit), Income Source (Exit), Monthly Amount (Exit)


## Questions
Here are some questions I am interested in:
1. Demographics
  + What are characteristics of the client population at entry?
  + What are their health insurance and income conditions at entry and at exit?
  
2. Entry and Exit
  + How many clients entried the UMD? What is the distribution of their entry time?
  + How long did they stay at the UMD?
  + Why did they leave the UMD?

  

## Methods
This will begin by building a docker container, then sequentially process the data using Python, generate the figures using R, and format the HTML document using Rmd. The project flow is controlled by Make.

To re-produce the figures and HTML output, run:
git clone https://github.com/datasci611/bios611-projects-fall-2019-YaoYuxiao.git
cd bios611-projects-fall-2019-YaoYuxiao/project_3
make results/proj3_report.html

