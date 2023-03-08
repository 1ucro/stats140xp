#==============================================================================
# File           :  x05_prep_econ_data
# Purpose        :  Load and clean data on county employment levels (2000-2021)
# Notes          :  Original xlsx data of employment levels copied to new sheet
#                   ("formatted_ca_data") and limited to CA entries
# Last modified  :  03/07/2023
#==============================================================================

# 1. Load employment data -------------------------------------------------
# Source: https://www.ers.usda.gov/data-products/county-level-data-sets/county-level-data-sets-download-data/
# Focus on percent unemployed to facilitate cross-county comparisons
unemployment <- read_xlsx(path       =  "data/econ_research_data/Unemployment_edited.xlsx"
                        , sheet      =  "formatted_ca_data"
                        , col_names  =  TRUE) |>
  select(starts_with("Area") | contains("rate"))

# Streamline column names
names(unemployment) <- c("county", tolower(str_remove(names(unemployment)[-1], "rate_")))

# Remove "County" in county name to facilitate join by county
unemployment$county <- str_remove(unemployment$county, " County, CA")

# Fix SF city-county naming to ensure correct merger
unemployment$county[unemployment$county == "San Francisco County/city, CA"] <- "San Francisco"

# Remove state-level rows (can always manually compute)
rm_ca_obs <- function(x) {x[x$county != "California", ]}
unemployment <- rm_ca_obs(unemployment)

# Emphasize values are percents by dividing values by 100
unemployment[, -1] <- unemployment[, -1] / 100

# Retain just average 5-yr county unemployment
unemployment <- data.frame("county" = unemployment |> select(county)
    , "county_avg_unemployed_00_04" = unemployment |> select(unemployment_2000:unemployment_2004) |> rowMeans()
    , "county_avg_unemployed_05_09" = unemployment |> select(unemployment_2005:unemployment_2009) |> rowMeans()
    , "county_avg_unemployed_10_04" = unemployment |> select(unemployment_2010:unemployment_2014) |> rowMeans()
    , "county_avg_unemployed_15_20" = unemployment |> select(unemployment_2015:unemployment_2020) |> rowMeans())

# 2. Load GDP data --------------------------------------------------------
# Source: https://apps.bea.gov/regional/downloadzip.cfm
# Ideas: share of state GDP, growth over time, etc.
gdp <- read_csv("data/bea_data/CAGDP1/CAGDP1_CA_2001_2021.csv") |>
  select("county" = GeoName, "info" = Description, "2001":"2020")

# Remove ", CA" phrase from county names to facilitate merger by county
gdp$county <- str_remove(gdp$county, ", CA")

# Focus on real GDP (in 2012 dollars) to streamline cross-county comparison
gdp <- gdp |>
  filter(str_detect(info, "Real GDP")) |>
  select(county, "2001":"2020")

# Remove state-level rows (can always manually compute)
gdp <- rm_ca_obs(gdp)

# Rename columns for greater clarity
names(gdp)[-1] <- paste0("county_gdp_", str_remove(names(gdp)[-1], "20"))

# 3. Load wage and income data --------------------------------------------
# Source: https://apps.bea.gov/regional/downloadzip.cfm
# Ideas: which ccounties (sum of cities) have more jobs than people? private pension vs public pension?
wages <- read_csv("data/bea_data/CAINC30/CAINC30_CA_1969_2021.csv") |>
  select("county" = GeoName, "info" = Description, "2000":"2020")

# Remove state-level rows (can always manually compute)
wages <- rm_ca_obs(wages)

# Remove ", CA" phrase from county names to facilitate merger by county
wages$county <- str_remove(wages$county, ", CA")

# Focus on real GDP (2012 dollars --> allow for accurate comparison)
wages <- wages |>
  filter(str_detect(info, "(Pop)|(Per cap.* pers.* income)|(Per cap.* div)|(Tot.* employ)|(Av.* wage)")) |>
  select(county, info, "2000":"2020")

# Tidy data by expanding along distinct descriptions in info column
wages <- pivot_wider(wages, names_from = info, values_from = c("2000":"2020"))

# Fix column names after pivot
var_loc <- "county_"
var_info <- c("pop_", "per_cap_income_", "per_cap_1099_income_", "n_jobs_", "avg_wage_")
var_yr <- c(paste0(0, rep(0:9, each = 5)), rep("10":"20", each = 5))
names(wages)[-1] <- paste0(var_loc, var_info, var_yr)

# 4. Merge county economic data -------------------------------------------
county_econ <- left_join(unemployment, left_join(gdp, wages, by = "county"), by = "county")

# Retain per capita GDP instead of absolute GPD (in 2012 dollars)
with(county_econ, {
  # Compute county per capita GDP by dividing GDP by population for each year
  x <- county_econ
  gdp_raw <- x |> select(contains("gdp") | (contains("pop") & !contains("00")))
  gdp_adj <- matrix(nrow = nrow(x), ncol = ncol(gdp_raw) / 2)
  for (i in seq_len(ncol(gdp_adj))) {
    gdp_adj[, i] <- gdp_raw[, i] / gdp_raw[, i + (ncol(gdp_raw) / 2)]
  }

  # Update GDP columns in original data with adjusted values
  gdp_cols <- str_detect(names(x), "gdp")
  county_econ[, gdp_cols] <<- gdp_adj
  names(county_econ)[gdp_cols] <<- str_replace(names(x)[gdp_cols], "gdp", "per_cap_gdp")
})

# 5. Clean workspace ------------------------------------------------------
rm(unemployment, gdp, wages, var_info, var_loc, var_yr, rm_ca_obs)

