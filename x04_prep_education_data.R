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
ed_cats <- c("less_hs", "only_hs", "some_college", "college")
names(county_ed) <- c("county", paste0("county_", ed_cats, "_1970"),
                      paste0("county_", ed_cats, "_1980"),
                      paste0("county_", ed_cats, "_1990"),
                      paste0("county_", ed_cats, "_2000"),
                      paste0("county_", ed_cats, "_2008_12"),
                      paste0("county_", ed_cats, "_2017_21"))

# Remove "County" in county name to facilitate join by county
county_ed$county <- str_replace_all(string       =  county_ed$county
                                  , pattern      =  " County"
                                  , replacement  =  "")

# 3. Create new variables -------------------------------------------------
# Remove statewide row (can always compute avg)
county_ed <- county_ed |> filter(county != "California")

# Emphasize values are percents by dividing values by 100
county_ed[, -1] <- county_ed[, -1] / 100

# Focus on college (or higher) education levels since 2000
recent_college_plus <- c("college_2000", "college_2008", "college_2017")
county_ed <- county_ed |> select(county, contains(c(recent_college_plus)) & !contains("some"))

# 4. Clean workspace ------------------------------------------------------
rm(ed_cats, recent_college_plus)

