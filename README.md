# Stats 140XP Project

*Is there a significant correlation between the fiscal health of CA cities and past civic engagement?*

To access the data for this project, download *final_data_18.csv* (2008-2018), *final_data_19.csv* (2009-2019), or *final_data_ip.csv* (2000-2020). To recreate the data, download and run the R scripts in *stats140_proj_code.zip*.

## Next steps
- (03/14) Team meeting with Vivian Lew
- (03/16) Team presentation (in-class)

## Data
- [CA auditor (2016-2020)](https://www.auditor.ca.gov/local_high_risk/dashboard-csa) 
- [CA county voter registration (2002-2020)](https://www.sos.ca.gov/elections/voter-registration/voter-registration-statistics) 
- [CA county voter turnout levels (1990-2022](https://www.sos.ca.gov/elections/statistics/voter-participation-stats-county)
- [CA city-county dictionary (2020)](https://bythenumbers.sco.ca.gov/Raw-Data/Cities-Raw-Data-for-Fiscal-Years-2020-21/kyrq-f99p)
- [CA county education levels (2000-2020)](https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/)
- [CA county employment levels (2000-2020)](https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/)

Most of our external data describe county-level socioeconomic trends. While models we build using this data may be less precise than models built on city-level data, we expect that demographic and economic variables associated with city fiscal health do not occur in isolation. Cities located in the same county are likely impacted by socioeconomic trends in neighboring cities. By utilizing county-level data, we can average out potential city-level interactions and thereby focus on identifying (generalizable) significant predictors of CA cities' fiscal health. 

## Notes
1. (02/23) The R script files assume most data sources are downloaded and organized into a data folder. As such, you may need to revise some of the code if you run it on your own computer.

2. (03/06) I manually edited the education and employment data (from ERS) within Excel by creating new sheets (named *formatted_ca_data*) within the existing workbooks that contains just CA data.

4. (03/07) Added economic, gender, and age county-level variables (most in the 2000-2020 period). Removed median income (AMI) variable since wage info now covered with other datasets.

5. (03/09) Note that Ventura (the city and corresponding county) is officially known as San Buenaventura. We have verified that the city-county datasets have merged correctly, but keep in mind that we call the city "Ventura."

6. (03/11) Added 2008 county voter ***turnout*** and precinct variables. Fixed issue where 2008 county unemployment was removed from final data. Note that 2009-2019 data also relies on 2008 voter turnout since 2008 is the general election closest to 2009.

7. (03/13) All R scripts are now in one zip folder (*stats140_proj_code.zip*).
