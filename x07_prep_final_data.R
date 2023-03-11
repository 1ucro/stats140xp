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
# Note: city-to-dictionary has Ventura listed as San Buenaventura
final_data$county[final_data$city == "Ventura"] <- "Ventura"

# Manually insert zipcode for 4 cities that are lacking in dictionary
# Source: First zipcode associated with city on Wikipedia
final_data$zipcode[final_data$city == "Carmel-by-the-Sea"] <- "93921"
final_data$zipcode[final_data$city == "Gustine"] <- "95322"
final_data$zipcode[final_data$city == "Paso Robles"] <- "93446"
final_data$zipcode[final_data$city == "Ventura"] <- "93001"

# 2. Merge external data with auditor data --------------------------------
final_data <- final_data |>
  # Likely ignore voter registration (no significant association)
  left_join(county_voter_reg, by = "county") |>
  left_join(county_voter_turnout, by = "county") |>
  left_join(county_ed, by = "county") |>
  left_join(county_econ, by = "county") |>
  left_join(county_demos, by = "county")

# 3. Export model input ---------------------------------------------------
# Select subset of data used for model building
final_data <- final_data |>
  # Focus on 2018 auditor data (non-pandemic data)
  filter(fy_end == 2018) |>
  # Focus on predictors from 2008 (decade before 2018 and recession)
  select(c(city, county, zipcode, overall_risk:net_opeb_liability_or_asset, contains("08"))) |>
  # Remove redundant variables in 2018 auditor data
  select(!c(population, unemployment_rate, contains("age_m"), contains("age_f"), contains("prop_f")))

# Simplify variable names by removing year component
names(final_data) <- str_remove(names(final_data), "_08")

# Build new features
final_data$county_per_cap_precints <- final_data$county_n_precincts / final_data$county_pop
final_data$good_pension_health <- final_data$pension_funding_ratio >= 0.8
couty_job_density <- (final_data$county_n_jobs / ((1 - final_data$county_unemployment) * final_data$county_pop))
final_data$is_county_job_center <- (couty_job_density > median(couty_job_density))

# Rearrange order of columns
first_vars <- c("city", "county", "zipcode", "overall_risk", "overall_points",
                "county_voter_reg", "county_voter_turnout", "county_prop_mail_vote",
                "county_n_precincts")
final_data <- final_data |>
  select(c(all_of(first_vars), !all_of(first_vars)))

# Store local copy of model input
write_csv(final_data, "final_data_18.csv")

# -------------------------------------------------------------------------
# 4. In-progress -------------------------------------------------------------
# Topics: imputation, additional demographic variables
# -------------------------------------------------------------------------

# Determine spread of missing values
prop_na_orig <- mean(is.na(final_data))
prop_na_orig_cols <- apply(final_data, 2, function(x) {mean(is.na(x))})

# Add
## Counties with more jobs than residents
## Tax base
## Ethnicity

# 5. Clean workspace ------------------------------------------------------
rm(auditor_data, city_to_county, county_voter_reg, county_voter_turnout,
   county_ed, county_econ, county_demos, first_vars, couty_job_density)

