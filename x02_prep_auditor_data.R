#==============================================================================
# File           :  x02_prep_auditor_data
# Purpose        :  Load and clean CA auditor data (FY 2016-2020)
# Notes          :  https://www.auditor.ca.gov/local_high_risk/dashboard-csa
# Last modified  :  03/02/2023
#==============================================================================

# 1. Load data ---------------------------------------------------------------
# Data from fiscal year 2016-2017
fiscal_17 <- cbind(read_csv("./data/auditor_data/fy2016-17.csv"), "fy_end" = 2017)

# Data from fiscal year 2017-2018
fiscal_18 <- cbind(read_csv("./data/auditor_data/fy2017-18.csv"), "fy_end" = 2018)

# Data from fiscal year 2018-2019
fiscal_19 <- cbind(read_csv("./data/auditor_data/fy2018-19.csv"), "fy_end" = 2019)

# Data from fiscal year 2019-2020
fiscal_20 <- cbind(read_csv("./data/auditor_data/fy2019-20.csv"), "fy_end" = 2020)

# 2. Merge data --------------------------------------------------------------
# Note: Not all cities are present in each year
auditor_data <- rbind(fiscal_17, fiscal_18, fiscal_19, fiscal_20)
names(auditor_data) <- tolower(names(auditor_data))

# 3. Remove redundant variables -------------------------------------------
auditor_data <- auditor_data |> select(!ends_with("rank"))
auditor_risk <- auditor_data |> select(overall_risk, overall_points)
auditor_data <- auditor_data |> select(!ends_with("risk")) |> select(!ends_with("points"))
auditor_data <- data.frame("city" = auditor_data$city_name, auditor_risk, auditor_data[, -1])

# 4. Clean workspace ---------------------------------------------------------
rm(fiscal_17, fiscal_18, fiscal_19, fiscal_20, auditor_risk)
