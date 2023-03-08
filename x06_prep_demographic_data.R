#==============================================================================
# File           :  x06_prep_demographic_data
# Purpose        :  Process data on age and gender distributions by zipcode
# Notes          :
# Last modified  :  03/07/2023
#==============================================================================

# Load demographic data ---------------------------------------------------
# Source: https://www.census.gov/data/tables/time-series/demo/popest/2010s-counties-detail.html
county_demos <- read_csv("https://www2.census.gov/programs-surveys/popest/datasets/2010-2019/counties/asrh/cc-est2019-agesex-06.csv") |>
  select("county"            =  CTYNAME
       , "year"              =  YEAR # Up till 2019
       , "pop"               =  POPESTIMATE
       , "pop_m"             =  POPEST_MALE
       , "pop_f"             =  POPEST_FEM
       , "county_med_age"    =  MEDIAN_AGE_TOT
       , "county_med_age_m"  =  MEDIAN_AGE_MALE
       , "county_med_age_f"  =  MEDIAN_AGE_FEM) |>
  mutate("county_prop_m" = pop_m / pop, "county_prop_f" = pop_f / pop) |>
  select(contains("county"), year)

# Remove "County" in county name to facilitate join by county
county_demos$county <- str_remove(county_demos$county, " County")

# Clarify meaning of values in year column (2019 - 12 + i)
county_demos$year <- str_remove(county_demos$year + 2007, "20")

# Tidy data by expanding along county-year
county_demos <- pivot_wider(county_demos, names_from = year, values_from = c("county_med_age":"county_prop_f"))
