# bios611-project1:Shiny Dashboard - Urban Ministries of Durham
Yuxiao Yao

## Background 
Non-profit Urban Ministries of Durham (UMD) connects poor and homeless neighbors to food, shelter and a future. 
They connect with the community to end homelessness and fight poverty by offering food, shelter and a future to neighbors in need. 
Here is the official website of UMD: http://www.umdurham.org/.This project is aiming to help UMD to improve their services and get prepared for future works. 

## Datasets
The dataset is provided by UMD, which contains a collection of data with 79838 observations from 1990's to 2019. It has more than 10 variables including Client File Number, Client File Merge, Bus Tickets (Number of), Notes of Service, Food Provided for, Food Pounds, Clothing Items, Diapers, School Kits, Hygiene Kits, Referrals, and Financial Support.

## Plots in Shiny Dashboard
* Trend Analysis
A line chart shows numbers of clients or a type of service over years.   
Users can select client number or any type of service as y-axis and time period from 1983 to 2019 as x-axis.
* Seasonality Analysis
1) Line charts by year shows monthly amount of food pounds or number of clothing items.   
Users can select food pounds or clothing items as y-axis and time period from 1998 to 2018 of interest.
2) A pie chart and a table show the total amount and its percentage every month during the time period.  
Users can select food pounds or clothing items as y-axis and time period from 1998 to 2018 of interest.
* Correlation Analtsis
A point plot shows the data distribution of two variables, and a line shows the result of fitting linear regression models.  
Users can select two variables as x-axis and y-axis.

## Project URL
