# Stats 140XP Project

*Is there a significant correlation between the fiscal health of CA cities and local levels of civic engagement?*

In this project, we analyze the relationship between local civic engagement (*e.g.*, voter turnout and registration) and the fiscal health of California cities between 2008 and 2018. Overall, we find that there is limited (significant) correlation between voter behavior and cities' fiscal outcomes. For more details, please access the *stats140_project_report* and *stats140_project_poster* files above.

## Data
- [CA auditor (2016-2020)](https://www.auditor.ca.gov/local_high_risk/dashboard-csa) 
- [CA county voter registration (2002-2020)](https://www.sos.ca.gov/elections/voter-registration/voter-registration-statistics) 
- [CA county voter turnout levels (1990-2022](https://www.sos.ca.gov/elections/statistics/voter-participation-stats-county)
- [CA city-county dictionary (2020)](https://bythenumbers.sco.ca.gov/Raw-Data/Cities-Raw-Data-for-Fiscal-Years-2020-21/kyrq-f99p)
- [CA county education levels (2000-2020)](https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/)
- [CA county employment levels (2000-2020)](https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/)

To access the data for this project, download *final_data_18.csv*. To recreate this dataset, download and run the R scripts in *stats140_proj_code.zip*. To view our EDA and results, refer to *3_14_23 QQ Plots and Test Outputs.zip* and *test_outputs.csv*.

*Disclaimer*: Most of our external data describe county-level socioeconomic trends. While the correlation tests we run using this data may be less precise than those based on city-level data, we expect that demographic and economic factors associated with city fiscal health do not occur in isolation. Municipalities located in the same county are likely impacted by socioeconomic trends in neighboring cities. By utilizing county-level data, we can (1) incorporate additional data sources and (2) average out potential city-level interactions and thereby focus on identifying (generalizable) significant factors associated with the fiscal health of CA communities.

## Notes
1. The R script files assume that the data files are downloaded and organized into a "data" folder located within the same parent directory. As such, you may need to revise some of the code if you run it on your own computer.

2. Note that Ventura, CA (the city and corresponding county) is officially known as San Buenaventura. We have verified that the city-county datasets have merged correctly, but keep in mind that we call the city "Ventura" in our final dataset.
