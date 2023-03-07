## Stats 140XP Project

To recreate the data, please download and run the R script files. All data sources (URLs) should be listed in the script files as comments. The (in-progress) final data set (final_data_ip.csv) can also be accessed directly by downloading it from this repo.

Next steps (Tuesday): 
- (Tuesday-Wednesday) Add gender and age demographic variables
- (Wednesday-Thursday) Complete EDA and variable selection 

**Data**:
- [CA auditor (2016-2020)](https://www.auditor.ca.gov/local_high_risk/dashboard-csa) 
- [CA county voter registration (2002-2020)](https://www.sos.ca.gov/elections/voter-registration/voter-registration-statistics) 
- [CA city-county dictionary](https://bythenumbers.sco.ca.gov/Raw-Data/Cities-Raw-Data-for-Fiscal-Years-2020-21/kyrq-f99p)
- [CA median county income (2022)](https://data.ca.gov/dataset/income-limits-by-county)
- [CA county education levels (*edited*) (1970-2020)](https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/)
- [CA county employment levels (*edited*) (2000-2020)](https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/)

**Notes**:

1. (02/23) I downloaded all the data and organized them into a data folder within the R project. As such, you may need to revise some of the code if you run it on your own computer. Let me know if I can clarify any components.

2. (03/06) I manually edited the education and employment data (from ERS) within Excel before loading it into R by creating new sheets (named *formatted_ca_data*) within the existing workbooks that contains just CA data. For transparency, I have uploaded these modified Excel workbooks to our repo as well (see *Education_edited.xlsx* and *Unemployment_edited.xlsx*).

3. (03/06) I have removed ~60 variables from the previous *final_data_ip.csv* file by
- taking the average unemployment per county over 5 years (instead of annually);
- focusing on bachelor's attainment rates per county (instead of all levels of education [*e.g.*, less than HS, HS, some college, college and above];
- collapsing eligible voters and registered voters per county into one *registration_rate* variable
