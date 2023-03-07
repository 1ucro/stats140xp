#==============================================================================
# File           :  x04_prep_education_data
# Purpose        :  Load and clean data on county employment levels (2000-2021)
# Notes          :  Original xlsx data copied to new sheet ("formatted_ca_data")
#                   and limited to CA entries
# Last modified  :  03/06/2023
#==============================================================================

# 1. Load employment data -------------------------------------------------
# Source: https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/
# Focus on percent unemployed to facilitate cross-county comparisons
county_jobs <- read_xlsx(path       =  "data/econ_research_data/Unemployment_edited.xlsx"
                       , sheet      =  "formatted_ca_data"
                       , col_names  =  TRUE) |>
  select(starts_with("Area") | contains("rate"))

# 2. Organize employment data ---------------------------------------------
# Streamline column names
names(county_jobs)[1] <- "name"
names(county_jobs) <- tolower(paste0("county_", str_replace_all(names(county_jobs), "rate_", "")))

# Remove "County" in county name to facilitate join by county
county_jobs$county_name <- str_replace_all(string       =  county_jobs$county_name
                                         , pattern      =  " County, CA"
                                         , replacement  =  "")

# Fix SF city-county naming to ensure correct merger
county_jobs$county_name[county_jobs$county_name == "San Francisco County/city, CA"] <- "San Francisco"


# 3. Remove statewide average ---------------------------------------------
county_jobs <- county_jobs |> filter(county_name != "California")

# Emphasize values are percents by dividing values by 100
county_jobs[, -1] <- county_jobs[, -1] / 100

