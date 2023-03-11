# Stats 140XP Project

To recreate the data, run the R scripts above. All data sources (URLs) should be listed in the script files as comments. The full data set that focuses on 2008-2018 comparisons can be accessed directly by downloading *final_data_18.csv*.

## Next steps
...

## Data
- [CA auditor (2016-2020)](https://www.auditor.ca.gov/local_high_risk/dashboard-csa) 
- [CA county voter registration (2002-2020)](https://www.sos.ca.gov/elections/voter-registration/voter-registration-statistics) 
- [CA city-county dictionary (2020)](https://bythenumbers.sco.ca.gov/Raw-Data/Cities-Raw-Data-for-Fiscal-Years-2020-21/kyrq-f99p)
- [CA county education levels (2000-2020)](https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/)
- [CA county employment levels (2000-2020)](https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/)
- *incomplete list: will add latest links by Monday*

*Important disclaimer*: Most of our external data describe county-level socioeconomic trends. While models we build using this data may be less precise than models built on city-level data, we expect that demographic and economic variables associated with city fiscal health do not occur in isolation. Cities located in the same county are likely impacted by socioeconomic trends in neighboring cities. By utilizing county-level data, we can average out potential city-level interactions and thereby focus on identifying (generalizable) significant predictors of CA cities' fiscal health. 

## Notes
1. (02/23) I doownloaded all the data and organized them into a data folder within the R project. As such, you may need to revise some of the code if you run it on your own computer. Let me know if I can clarify any components.

2. (03/06) I manually edited the education and employment data (from ERS) within Excel before loading it into R by creating new sheets (named *formatted_ca_data*) within the existing workbooks that contains just CA data. For transparency, I have uploaded these modified Excel workbooks to our repo as well (see *Education_edited.xlsx* and *Unemployment_edited.xlsx*).

3. (03/06) Removed ~60 variables from the previous *final_data_ip.csv* file by
	- taking the average unemployment per county over 5 years (instead of annually);
	- focusing on bachelor's attainment rates per county (instead of all levels of education [*e.g.*, less than HS, HS, some college, college and above];
	- collapsing eligible voters and registered voters per county into one *registration_rate* variable

4. (03/07) Added ~120 economic, gender, and age county-level variables (most in the 2000-2020 period). Removed median income (AMI) variable since wage info now covered with other datasets. Unless we think of new variables, data expansion is complete.

5. (03/09) We decided to focus on fiscal health (measured by pension burden metrics) from 2018 as our outcome and voter registration and demographic variables from 2008 as our predictors. Note that Ventura (the city and corresponding county) is officially known as San Buenaventura. As of now, we have verified that the city-county datasets have merged correctly, but keep in mind that we call the city "Ventura."

6. (03/11) Added 2008 county voter registration and precinct variables. Fixed issue where 2008 county unemployment was removed from final data. Uploaded updated R scripts incorporating these changes.
