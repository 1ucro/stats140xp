#==============================================================================
# File           :  x02_prep_auditor_data
# Purpose        :  Load and clean CA auditor data (FY 2016-2020)
# Notes          :
# Last modified  :  02/27/2023
#==============================================================================

# Load data ---------------------------------------------------------------
# Data from fiscal year 2016-2017
fiscal_17 <- cbind(read_csv("./data/auditor_data/fy2016-17.csv"), "end_year" = 2017)

# Data from fiscal year 2017-2018
fiscal_18 <- cbind(read_csv("./data/auditor_data/fy2017-18.csv"), "end_year" = 2018)

# Data from fiscal year 2018-2019
fiscal_19 <- cbind(read_csv("./data/auditor_data/fy2018-19.csv"), "end_year" = 2019)

# Data from fiscal year 2019-2020
fiscal_20 <- cbind(read_csv("./data/auditor_data/fy2019-20.csv"), "end_year" = 2020)

# Merge data --------------------------------------------------------------
auditor_data <- rbind(fiscal_17, fiscal_18, fiscal_19, fiscal_20)
names(auditor_data) <- tolower(names(auditor_data))

# Idea:
  # Gather demographic and election data for each city
  # Treat each city-election as one observation

# Summarize data ----------------------------------------------------------

# Clean workspace ---------------------------------------------------------
rm(fiscal_17, fiscal_18, fiscal_19, fiscal_20)




# Data info ---------------------------------------------------------------
# https://www.auditor.ca.gov/local_high_risk/dashboard-csa

