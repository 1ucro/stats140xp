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
county_unemployment <- read_xlsx(path       =  "data/econ_research_data/Unemployment_edited.xlsx"
                               , sheet      =  "formatted_ca_data"
                               , col_names  =  TRUE) |>
  select(starts_with("Area") | contains("rate"))

# 2. Organize employment data ---------------------------------------------
# Streamline column names
names(county_unemployment) <- c("county", tolower(str_replace_all(names(county_unemployment)[-1], "rate_", "")))

# Remove "County" in county name to facilitate join by county
county_unemployment$county <- str_replace_all(county_unemployment$county, " County, CA", "")

# Fix SF city-county naming to ensure correct merger
county_unemployment$county[county_unemployment$county == "San Francisco County/city, CA"] <- "San Francisco"

# 3. Remove statewide average ---------------------------------------------
county_unemployment <- county_unemployment |> filter(county != "California")

# Emphasize values are percents by dividing values by 100
county_unemployment[, -1] <- county_unemployment[, -1] / 100

# Retain just average 5-year unemployment trend per county
county_unemployment <- data.frame("county" = county_unemployment |> select(county)
  , "county_avg_unemployment_2000_04" = county_unemployment |> select(unemployment_2000:unemployment_2004) |> rowMeans()
  , "county_avg_unemployment_2005_09" = county_unemployment |> select(unemployment_2005:unemployment_2009) |> rowMeans()
  , "county_avg_unemployment_2010_04" = county_unemployment |> select(unemployment_2010:unemployment_2014) |> rowMeans()
  , "county_avg_unemployment_2015_20" = county_unemployment |> select(unemployment_2015:unemployment_2020) |> rowMeans()
)

