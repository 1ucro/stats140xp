#==============================================================================
# File           :  x03_prep_voting_data
# Purpose        :  Load and clean data on county voter registration (2002-2020)
# Notes          :  Selected registration closest to election (usually 15-day)
# Last modified  :  03/02/2023
#==============================================================================

# 1. Load county voter registration ---------------------------------------
# Source: https://www.sos.ca.gov/elections/voter-registration/voter-registration-statistics
voter_reg_02 <- read_excel("data/voter_registration_data/county_2002.xls")[, 1:3]
voter_reg_03 <- read_excel("data/voter_registration_data/county_2003.xls")[, 1:3]
voter_reg_04 <- read_excel("data/voter_registration_data/county_2004.xls")[, 1:3]
voter_reg_05 <- read_excel("data/voter_registration_data/county_2005.xls")[, 1:3]
voter_reg_06 <- read_excel("data/voter_registration_data/county_2006.xls")[, c(1, 3:4)]
voter_reg_07 <- read_excel("data/voter_registration_data/county_2007.xls")[, c(1, 3:4)]
voter_reg_08 <- read_excel("data/voter_registration_data/county_2008.xls")[, c(1, 3:4)]
voter_reg_09 <- read_excel("data/voter_registration_data/county_2009.xls")[, c(1, 3:4)]
voter_reg_10 <- read_excel("data/voter_registration_data/county_2010.xls")[, c(1, 3:4)]
voter_reg_11 <- read_excel("data/voter_registration_data/county_2011.xls")[, c(1, 3:4)]
voter_reg_12 <- read_excel("data/voter_registration_data/county_2012.xls")[, 1:3]
voter_reg_13 <- read_excel("data/voter_registration_data/county_2013.xls")[, 1:3]
voter_reg_14 <- read_excel("data/voter_registration_data/county_2014.xls")[, 1:3]
voter_reg_15 <- read_excel("data/voter_registration_data/county_2015.xls")[, 1:3]
voter_reg_16 <- read_excel("data/voter_registration_data/county_2016.xls")[, 1:3]
voter_reg_17 <- read_excel("data/voter_registration_data/county_2017.xlsx")[, 1:3]
voter_reg_18 <- read_excel("data/voter_registration_data/county_2018.xlsx")[, 1:3]
voter_reg_19 <- read_excel("data/voter_registration_data/county_2019.xlsx")[, 1:3]
voter_reg_20 <- read_excel("data/voter_registration_data/county_2020.xlsx")[, 1:3]

# 2. Clean county voter registration --------------------------------------
# 2.1 Streamline column names ---------------------------------------------
voter_reg_vars <- c("county", "eligible", "registered")
names(voter_reg_02) <- voter_reg_vars
names(voter_reg_03) <- voter_reg_vars
names(voter_reg_04) <- voter_reg_vars
names(voter_reg_05) <- voter_reg_vars
names(voter_reg_06) <- voter_reg_vars
names(voter_reg_07) <- voter_reg_vars
names(voter_reg_08) <- voter_reg_vars
names(voter_reg_09) <- voter_reg_vars
names(voter_reg_10) <- voter_reg_vars
names(voter_reg_11) <- voter_reg_vars
names(voter_reg_12) <- voter_reg_vars
names(voter_reg_13) <- voter_reg_vars
names(voter_reg_14) <- voter_reg_vars
names(voter_reg_15) <- voter_reg_vars
names(voter_reg_16) <- voter_reg_vars
names(voter_reg_17) <- voter_reg_vars
names(voter_reg_18) <- voter_reg_vars
names(voter_reg_19) <- voter_reg_vars
names(voter_reg_20) <- voter_reg_vars

# 2.2 Tidy data -----------------------------------------------------------
fix_format <- function(x) {x |> filter(!(county %in% c(NA, "Percent", "State Total")))}
voter_reg_02 <- fix_format(voter_reg_02)
voter_reg_03 <- fix_format(voter_reg_03)
voter_reg_04 <- fix_format(voter_reg_04)
voter_reg_05 <- fix_format(voter_reg_05)
voter_reg_06 <- fix_format(voter_reg_06)
voter_reg_07 <- fix_format(voter_reg_07)
voter_reg_08 <- fix_format(voter_reg_08)
voter_reg_09 <- fix_format(voter_reg_09)
voter_reg_10 <- fix_format(voter_reg_10)
voter_reg_11 <- fix_format(voter_reg_11)
voter_reg_12 <- fix_format(voter_reg_12)
voter_reg_13 <- fix_format(voter_reg_13)
voter_reg_14 <- fix_format(voter_reg_14)
voter_reg_15 <- fix_format(voter_reg_15)
voter_reg_16 <- fix_format(voter_reg_16)
voter_reg_17 <- fix_format(voter_reg_17)
voter_reg_18 <- fix_format(voter_reg_18)
voter_reg_19 <- fix_format(voter_reg_19)
voter_reg_20 <- fix_format(voter_reg_20)

# 3. Merge county voter registration --------------------------------------
county_voter_reg <- data.frame(
  "county"               =  voter_reg_02$county,
  "county_voter_reg_02"  =  voter_reg_02$registered / voter_reg_02$eligible,
  "county_voter_reg_03"  =  voter_reg_03$registered / voter_reg_03$eligible,
  "county_voter_reg_04"  =  voter_reg_04$registered / voter_reg_04$eligible,
  "county_voter_reg_05"  =  voter_reg_05$registered / voter_reg_05$eligible,
  "county_voter_reg_06"  =  voter_reg_06$registered / voter_reg_06$eligible,
  "county_voter_reg_07"  =  voter_reg_07$registered / voter_reg_07$eligible,
  "county_voter_reg_08"  =  voter_reg_08$registered / voter_reg_08$eligible,
  "county_voter_reg_09"  =  voter_reg_09$registered / voter_reg_09$eligible,
  "county_voter_reg_10"  =  voter_reg_10$registered / voter_reg_10$eligible,
  "county_voter_reg_11"  =  voter_reg_11$registered / voter_reg_11$eligible,
  "county_voter_reg_12"  =  voter_reg_12$registered / voter_reg_12$eligible,
  "county_voter_reg_13"  =  voter_reg_13$registered / voter_reg_13$eligible,
  "county_voter_reg_14"  =  voter_reg_14$registered / voter_reg_14$eligible,
  "county_voter_reg_15"  =  voter_reg_15$registered / voter_reg_15$eligible,
  "county_voter_reg_16"  =  voter_reg_16$registered / voter_reg_16$eligible,
  "county_voter_reg_17"  =  voter_reg_17$registered / voter_reg_17$eligible,
  "county_voter_reg_18"  =  voter_reg_18$registered / voter_reg_18$eligible,
  "county_voter_reg_19"  =  voter_reg_19$registered / voter_reg_19$eligible,
  "county_voter_reg_20"  =  voter_reg_20$registered / voter_reg_20$eligible)

# 4. Clean workspace ------------------------------------------------------
rm(voter_reg_02, voter_reg_03, voter_reg_04, voter_reg_05, voter_reg_06, voter_reg_07,
   voter_reg_08, voter_reg_09, voter_reg_10, voter_reg_11, voter_reg_12, voter_reg_13,
   voter_reg_14, voter_reg_15, voter_reg_16, voter_reg_17, voter_reg_18, voter_reg_19,
   voter_reg_20, fix_format, voter_reg_vars)
