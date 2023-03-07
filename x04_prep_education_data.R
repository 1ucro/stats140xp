#==============================================================================
# File           :  x04_prep_education_data
# Purpose        :  Load and clean data on county education levels (1970-2021)
# Notes          :  Original xlsx data copied to new sheet ("formatted_ca_data")
#                   and limited to CA entries
# Last modified  :  03/06/2023
#==============================================================================

# 1. Load education data ---------------------------------------------------
# Source: https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/
# Focus on percent values to facilitate cross-county comparisons
county_ed <- read_xlsx(path       =  "data/econ_research_data/Education_edited.xlsx",
                       sheet      =  "formatted_ca_data",
                       col_names  =  TRUE) |>
  select(starts_with("Area") | contains("Percent"))

# 2. Organize education data ----------------------------------------------
# Streamline column names
ed_cats <- c("prop_less_hs", "prop_only_hs", "prop_some_college", "prop_college")
names(county_ed) <- c("county_name", paste0("county_1970_", ed_cats),
                      paste0("county_1980_", ed_cats),
                      paste0("county_1990_", ed_cats),
                      paste0("county_2000_", ed_cats),
                      paste0("county_2008_12_", ed_cats),
                      paste0("county_2017_21_", ed_cats))

# Remove "County" in county name to facilitate join by county
county_ed$county_name <- str_replace_all(string       =  county_ed$county_name
                                       , pattern      =  " County"
                                       , replacement  =  "")

# 3. Create new variables -------------------------------------------------
# Extract statewide row to compare counties with state average
ca_ed <- county_ed |> filter(county_name == "California")
county_ed <- county_ed |> filter(county_name != "California")

# Emphasize values are percents by dividing values by 100
county_ed[, -1] <- county_ed[, -1] / 100

# Determine whether counties are above or below state college completion average
county_ed$county_1970_ca_relative_college <- if_else(county_ed$county_1970_prop_college >= ca_ed$county_1970_prop_college, 1, 0)
county_ed$county_1980_ca_relative_college <- if_else(county_ed$county_1980_prop_college >= ca_ed$county_1980_prop_college, 1, 0)
county_ed$county_1990_ca_relative_college <- if_else(county_ed$county_1990_prop_college >= ca_ed$county_1990_prop_college, 1, 0)
county_ed$county_2000_ca_relative_college <- if_else(county_ed$county_2000_prop_college >= ca_ed$county_2000_prop_college, 1, 0)
county_ed$county_2008_12_ca_relative_college <- if_else(county_ed$county_2008_12_prop_college >= ca_ed$county_2008_12_prop_college, 1, 0)
county_ed$county_2017_21_ca_relative_college <- if_else(county_ed$county_2017_21_prop_college >= ca_ed$county_2017_21_prop_college, 1, 0)

# 4. Clean workspace ------------------------------------------------------
rm(ed_cats, ca_ed)

