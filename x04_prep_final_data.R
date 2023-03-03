#==============================================================================
# File           :  x04_prep_final_data
# Purpose        :  Merge voting, demographic, and auditor data
# Notes          :
# Last modified  :  03/02/2023
#==============================================================================

# 1. Construct city-county dictionary -------------------------------------
# Source: https://bythenumbers.sco.ca.gov/Raw-Data/Cities-Raw-Data-for-Fiscal-Years-2020-21/kyrq-f99p
city_to_county <- read_excel("data/city_to_county_data/CIX_EachDataSet_2020-21_20221009_V9.xlsx")

# Streamline column names
names(city_to_county) <- str_replace_all(names(city_to_county), " ", "\\_") |> tolower()

# Retain relevant variables
city_to_county <- city_to_county |> select(city, county_name, zip)

# Rename city column to city_name to serve as merger key
names(city_to_county)[names(city_to_county) == "city"] <- "city_name"

# 2. Add counties and zip to auditor data ---------------------------------
final_data <- left_join(auditor_data, city_to_county, by = "city_name")
final_data <- left_join(final_data, county_voter_reg, by = "county_name")

# 3. Add demographic variables to auditor data ----------------------------
## 3.1 Area median income (AMI) by county ---------------------------------
# Source: https://data.ca.gov/dataset/income-limits-by-county
county_income <- read_csv("data/census_data/2022-income-limits.csv") |> select(County, AMI)
final_data <- left_join(final_data, county_income, by = c("county_name" = "County"))

# In-progress -------------------------------------------------------------

# Local business patterns
# Add demographic variables by zipcode
# industry_zip <- read.table("data/census_demographics/zbp20detail.txt")
#
# # Add demographic variables by county
# industry_county <- read.table("data/census_demographics/cbp20co.txt")

# 5. Clean workspace ------------------------------------------------------
rm(city_to_county, county_income, county_voter_reg, auditor_data)
