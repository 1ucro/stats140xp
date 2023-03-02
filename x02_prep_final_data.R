#==============================================================================
# File           :  x02_prep_voter_data
# Purpose        :  Merge voting, demographic, and auditor data
# Notes          :
# Last modified  :  03/02/2023
#==============================================================================

# Remove redundant vars from auditor data ---------------------------------
final_data <- final_data |>
  select(!ends_with("rank"))

# Add demographics vars to auditor data -----------------------------------

# Median area income
# Source: https://data.ca.gov/dataset/income-limits-by-county
county_income <- read_csv("data/census_demographics/2022-income-limits.csv") |>
  select(County, AMI)
final_data <- left_join(final_data, county_income, by = c("county_name" = "County"))


# In-progress -------------------------------------------------------------

# Local business patterns
# Add demographic variables by zipcode
# industry_zip <- read.table("data/census_demographics/zbp20detail.txt")
#
# # Add demographic variables by county
# industry_county <- read.table("data/census_demographics/cbp20co.txt")


