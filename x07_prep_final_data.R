#==============================================================================
# File           :  x07_prep_final_data
# Purpose        :  Merge voting, socioeconomic, and auditor data
# Notes          :
# Last modified  :  03/07/2023
#==============================================================================

# 1. Construct city-county dictionary -------------------------------------
# Source: https://bythenumbers.sco.ca.gov/Raw-Data/Cities-Raw-Data-for-Fiscal-Years-2020-21/kyrq-f99p
city_to_county <- read_xlsx("data/city_to_county_data/CIX_EachDataSet_2020-21_20221009_V9.xlsx")

# Streamline column names
names(city_to_county) <- str_replace_all(names(city_to_county), " ", "\\_") |> tolower()

# Retain relevant variables
city_to_county <- city_to_county |> select(city, "county" =  county_name, "zipcode" = zip)

# Strip sub-zipcodes from city zipcodes for easier linkage with external data
city_to_county$zipcode <- str_remove(city_to_county$zipcode, "\\-\\d*")

# Merge auditor data with city-county dictionary
final_data <- left_join(auditor_data, city_to_county, by = "city")

# Manually insert county for 4 cities that are lacking in dictionary
# Source: City websites
final_data$county[final_data$city == "Carmel-by-the-Sea"] <- "Monterey"
final_data$county[final_data$city == "Gustine"] <- "Merced"
final_data$county[final_data$city == "Paso Robles"] <- "San Luis Obispo"
final_data$county[final_data$city == "Ventura"] <- "Ventura"

# Manually insert zipcode for 4 cities that are lacking in dictionary
# Source: First zipcode associated with city on Wikipedia
final_data$zipcode[final_data$city == "Carmel-by-the-Sea"] <- "93921"
final_data$zipcode[final_data$city == "Gustine"] <- "95322"
final_data$zipcode[final_data$city == "Paso Robles"] <- "93446"
final_data$zipcode[final_data$city == "Ventura"] <- "93001"

# 2. Merge external data with auditor data --------------------------------
final_data <- final_data |>
  left_join(county_voter_reg, by = "county") |>
  left_join(county_ed, by = "county") |>
  left_join(county_econ, by = "county") |>
  left_join(county_demos, by = "county")

# 3. Export model input ---------------------------------------------------
# Place geographical columns (city, county, zipcode) in beginning for clarity
loc_vars <- c("city", "county", "zipcode")
final_data <- data.frame(final_data |> select(all_of(loc_vars)), final_data |> select(!all_of(loc_vars)))

# Store local copy of model input
write_csv(final_data, "final_data_ip.csv")

# -------------------------------------------------------------------------
# 4. In-progress -------------------------------------------------------------
# Topics: imputation, additional demographic variables
# -------------------------------------------------------------------------

# Determine spread of missing values
prop_na_orig <- mean(is.na(final_data))
prop_na_orig_cols <- apply(final_data, 2, function(x) {mean(is.na(x))})

# 5. Clean workspace ------------------------------------------------------
rm(city_to_county, county_voter_reg, auditor_data, county_ed, county_econ,
   county_demos, loc_vars)

