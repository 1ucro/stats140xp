#==============================================================================
# File           :  x02_prep_voting_data
# Purpose        :  Load and clean data on local ideological leanings
# Notes          :  See American Ideology Project
# Last modified  :  02/27/2023
#==============================================================================

# County ------------------------------------------------------------------
# Source: https://www.sos.ca.gov/elections/report-registration/15day-gen-2020

# Compile list of all CA counties with 2020 voter registration rates
counties <- read_excel("data/county.xlsx")

# Streamline column names
names(counties) <- str_replace_all(string       =  names(counties)
                                 , pattern      =  " "
                                 , replacement  =  "\\_") |> tolower()

# Make counties data tidy
counties <- counties |> filter(!(county %in% c(NA, "Percent", "State Total")))

# Construct city-county dictionary ----------------------------------------
# Source: https://bythenumbers.sco.ca.gov/Raw-Data/Cities-Raw-Data-for-Fiscal-Years-2020-21/kyrq-f99p
city_to_county <- read_excel("data/CIX_EachDataSet_2020-21_20221009_V9.xlsx")

# Streamline column names
names(city_to_county) <- str_replace_all(string       =  names(city_to_county)
                                       , pattern      =  " "
                                       , replacement  =  "\\_") |> tolower()

city_to_county <- city_to_county |> select(city, county_name, zip, entity_name)


# Add counties to cities in auditor data ----------------------------------
final_data <- left_join(auditor_data, city_to_county, by = c("city_name" = "city"))
final_data <- left_join(final_data, counties, by = c("county_name" = "county"))


