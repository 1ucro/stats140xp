#==============================================================================
# File           :  x06_prep_final_data
# Purpose        :  Merge voting, demographic, and auditor data
# Notes          :
# Last modified  :  03/02/2023
#==============================================================================

# 1. Construct city-county dictionary -------------------------------------
# Source: https://bythenumbers.sco.ca.gov/Raw-Data/Cities-Raw-Data-for-Fiscal-Years-2020-21/kyrq-f99p
city_to_county <- read_xlsx("data/city_to_county_data/CIX_EachDataSet_2020-21_20221009_V9.xlsx")

# Streamline column names
names(city_to_county) <- str_replace_all(names(city_to_county), " ", "\\_") |> tolower()

# Retain relevant variables
city_to_county <- city_to_county |> select(city, county_name, zip)

# Rename city column to city_name to serve as merger key
names(city_to_county)[names(city_to_county) == "city"] <- "city_name"

# 2. Add counties and zip to auditor data ---------------------------------
# Merge auditor data and city-county dictionary to define county key
final_data <- left_join(auditor_data, city_to_county, by = "city_name")

# Manually insert county for 4 cities that are lacking in dictionary
# Source: City websites
final_data[final_data$city_name == "Carmel-by-the-Sea", "county_name"] <- "Monterey"
final_data[final_data$city_name == "Gustine", "county_name"] <- "Merced"
final_data[final_data$city_name == "Paso Robles", "county_name"] <- "San Luis Obispo"
final_data[final_data$city_name == "Ventura", "county_name"] <- "Ventura"

# Manually insert zipcode for 4 cities that are lacking in dictionary
# Source: First zipcode associated with city on Wikipedia
final_data[final_data$city_name == "Carmel-by-the-Sea", "zip"] <- "93921"
final_data[final_data$city_name == "Gustine", "zip"] <- "95322"
final_data[final_data$city_name == "Paso Robles", "zip"] <- "93446"
final_data[final_data$city_name == "Ventura", "zip"] <- "93001"

# Merge auditor and voter registration data by county key
final_data <- left_join(final_data, county_voter_reg, by = "county_name")

# 3. Add demographic variables to auditor data ----------------------------
## 3.1 Area median income (AMI) by county ---------------------------------
# Source: https://data.ca.gov/dataset/income-limits-by-county
county_income <- read_csv("data/census_data/2022-income-limits.csv") |> select(County, AMI)
final_data <- left_join(final_data, county_income, by = c("county_name" = "County"))

## 3.2 County relative education levels over time -------------------------
# Source: https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/
final_data <- left_join(final_data, county_ed, by = "county_name")

## 3.2 County unemployment levels over time -------------------------------
# Source: https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/
final_data <- left_join(final_data, county_jobs, by = "county_name")

# In-progress -------------------------------------------------------------

# Determine spread of missing values
prop_na_orig <- mean(is.na(final_data))
prop_na_orig_cols <- apply(final_data, 2, function(x) {mean(is.na(x))})

# Impute missing voter registration by averaging out city-specific patterns

# Local business patterns
# Add demographic variables by zipcode
industry_zip <- read.table("data/census_data/zbp20detail.txt", nrows = 100, row.names = NULL)

# 5. Clean workspace ------------------------------------------------------
write_csv(final_data, "final_data_ip.csv")
rm(city_to_county, county_income, county_voter_reg, auditor_data, county_ed,
   county_jobs, industry_zip)

