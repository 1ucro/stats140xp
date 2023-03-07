#==============================================================================
# File           :  x03_prep_voting_data
# Purpose        :  Load and clean data on county voter registration (2002-2020)
# Notes          :  Selected registration closest to election (usually 15-day)
# Last modified  :  03/02/2023
#==============================================================================

# 1. Load county voter registration ---------------------------------------
# Source: https://www.sos.ca.gov/elections/voter-registration/voter-registration-statistics
counties_voter_reg_02 <- read_excel("data/voter_registration_data/county_2002.xls")[, 1:3]
counties_voter_reg_03 <- read_excel("data/voter_registration_data/county_2003.xls")[, 1:3]
counties_voter_reg_04 <- read_excel("data/voter_registration_data/county_2004.xls")[, 1:3]
counties_voter_reg_05 <- read_excel("data/voter_registration_data/county_2005.xls")[, 1:3]
counties_voter_reg_06 <- read_excel("data/voter_registration_data/county_2006.xls")[, c(1, 3:4)]
counties_voter_reg_07 <- read_excel("data/voter_registration_data/county_2007.xls")[, c(1, 3:4)]
counties_voter_reg_08 <- read_excel("data/voter_registration_data/county_2008.xls")[, c(1, 3:4)]
counties_voter_reg_09 <- read_excel("data/voter_registration_data/county_2009.xls")[, c(1, 3:4)]
counties_voter_reg_10 <- read_excel("data/voter_registration_data/county_2010.xls")[, c(1, 3:4)]
counties_voter_reg_11 <- read_excel("data/voter_registration_data/county_2011.xls")[, c(1, 3:4)]
counties_voter_reg_12 <- read_excel("data/voter_registration_data/county_2012.xls")[, 1:3]
counties_voter_reg_13 <- read_excel("data/voter_registration_data/county_2013.xls")[, 1:3]
counties_voter_reg_14 <- read_excel("data/voter_registration_data/county_2014.xls")[, 1:3]
counties_voter_reg_15 <- read_excel("data/voter_registration_data/county_2015.xls")[, 1:3]
counties_voter_reg_16 <- read_excel("data/voter_registration_data/county_2016.xls")[, 1:3]
counties_voter_reg_17 <- read_excel("data/voter_registration_data/county_2017.xlsx")[, 1:3]
counties_voter_reg_18 <- read_excel("data/voter_registration_data/county_2018.xlsx")[, 1:3]
counties_voter_reg_19 <- read_excel("data/voter_registration_data/county_2019.xlsx")[, 1:3]
counties_voter_reg_20 <- read_excel("data/voter_registration_data/county_2020.xlsx")[, 1:3]

# 2. Clean county voter registration --------------------------------------
# 2.1 Streamline column names ---------------------------------------------
names(counties_voter_reg_02) <- c("county", "eligible", "registered")
names(counties_voter_reg_03) <- c("county", "eligible", "registered")
names(counties_voter_reg_04) <- c("county", "eligible", "registered")
names(counties_voter_reg_05) <- c("county", "eligible", "registered")
names(counties_voter_reg_06) <- c("county", "eligible", "registered")
names(counties_voter_reg_07) <- c("county", "eligible", "registered")
names(counties_voter_reg_08) <- c("county", "eligible", "registered")
names(counties_voter_reg_09) <- c("county", "eligible", "registered")
names(counties_voter_reg_10) <- c("county", "eligible", "registered")
names(counties_voter_reg_11) <- c("county", "eligible", "registered")
names(counties_voter_reg_12) <- c("county", "eligible", "registered")
names(counties_voter_reg_13) <- c("county", "eligible", "registered")
names(counties_voter_reg_14) <- c("county", "eligible", "registered")
names(counties_voter_reg_15) <- c("county", "eligible", "registered")
names(counties_voter_reg_16) <- c("county", "eligible", "registered")
names(counties_voter_reg_17) <- c("county", "eligible", "registered")
names(counties_voter_reg_18) <- c("county", "eligible", "registered")
names(counties_voter_reg_19) <- c("county", "eligible", "registered")
names(counties_voter_reg_20) <- c("county", "eligible", "registered")

# 2.2 Tidy data -----------------------------------------------------------
fix_format <- function(x) {x |> filter(!(county %in% c(NA, "Percent", "State Total")))}

counties_voter_reg_02 <- fix_format(counties_voter_reg_02)
counties_voter_reg_03 <- fix_format(counties_voter_reg_03)
counties_voter_reg_04 <- fix_format(counties_voter_reg_04)
counties_voter_reg_05 <- fix_format(counties_voter_reg_05)
counties_voter_reg_06 <- fix_format(counties_voter_reg_06)
counties_voter_reg_07 <- fix_format(counties_voter_reg_07)
counties_voter_reg_08 <- fix_format(counties_voter_reg_08)
counties_voter_reg_09 <- fix_format(counties_voter_reg_09)
counties_voter_reg_10 <- fix_format(counties_voter_reg_10)
counties_voter_reg_11 <- fix_format(counties_voter_reg_11)
counties_voter_reg_12 <- fix_format(counties_voter_reg_12)
counties_voter_reg_13 <- fix_format(counties_voter_reg_13)
counties_voter_reg_14 <- fix_format(counties_voter_reg_14)
counties_voter_reg_15 <- fix_format(counties_voter_reg_15)
counties_voter_reg_16 <- fix_format(counties_voter_reg_16)
counties_voter_reg_17 <- fix_format(counties_voter_reg_17)
counties_voter_reg_18 <- fix_format(counties_voter_reg_18)
counties_voter_reg_19 <- fix_format(counties_voter_reg_19)
counties_voter_reg_20 <- fix_format(counties_voter_reg_20)

# 3. Merge county voter registration --------------------------------------
county_voter_reg <- data.frame("county_name"      =  counties_voter_reg_02$county,
                               "eligible_2002"    =  counties_voter_reg_02$eligible,
                               "registered_2002"  =  counties_voter_reg_02$registered,
                               "eligible_2003"    =  counties_voter_reg_03$eligible,
                               "registered_2003"  =  counties_voter_reg_03$registered,
                               "eligible_2004"    =  counties_voter_reg_04$eligible,
                               "registered_2004"  =  counties_voter_reg_04$registered,
                               "eligible_2005"    =  counties_voter_reg_05$eligible,
                               "registered_2005"  =  counties_voter_reg_05$registered,
                               "eligible_2006"    =  counties_voter_reg_06$eligible,
                               "registered_2006"  =  counties_voter_reg_06$registered,
                               "eligible_2007"    =  counties_voter_reg_07$eligible,
                               "registered_2007"  =  counties_voter_reg_07$registered,
                               "eligible_2008"    =  counties_voter_reg_08$eligible,
                               "registered_2008"  =  counties_voter_reg_08$registered,
                               "eligible_2009"    =  counties_voter_reg_09$eligible,
                               "registered_2009"  =  counties_voter_reg_09$registered,
                               "eligible_2010"    =  counties_voter_reg_10$eligible,
                               "registered_2010"  =  counties_voter_reg_10$registered,
                               "eligible_2011"    =  counties_voter_reg_11$eligible,
                               "registered_2011"  =  counties_voter_reg_11$registered,
                               "eligible_2012"    =  counties_voter_reg_12$eligible,
                               "registered_2012"  =  counties_voter_reg_12$registered,
                               "eligible_2013"    =  counties_voter_reg_13$eligible,
                               "registered_2013"  =  counties_voter_reg_13$registered,
                               "eligible_2014"    =  counties_voter_reg_14$eligible,
                               "registered_2014"  =  counties_voter_reg_14$registered,
                               "eligible_2015"    =  counties_voter_reg_15$eligible,
                               "registered_2015"  =  counties_voter_reg_15$registered,
                               "eligible_2016"    =  counties_voter_reg_16$eligible,
                               "registered_2016"  =  counties_voter_reg_16$registered,
                               "eligible_2017"    =  counties_voter_reg_17$eligible,
                               "registered_2017"  =  counties_voter_reg_17$registered,
                               "eligible_2018"    =  counties_voter_reg_18$eligible,
                               "registered_2018"  =  counties_voter_reg_18$registered,
                               "eligible_2019"    =  counties_voter_reg_19$eligible,
                               "registered_2019"  =  counties_voter_reg_19$registered,
                               "eligible_2020"    =  counties_voter_reg_20$eligible,
                               "registered_2020"  =  counties_voter_reg_20$registered)

# 4. Clean workspace ------------------------------------------------------
rm(counties_voter_reg_02, counties_voter_reg_03, counties_voter_reg_04,
   counties_voter_reg_05, counties_voter_reg_06, counties_voter_reg_07,
   counties_voter_reg_08, counties_voter_reg_09, counties_voter_reg_10,
   counties_voter_reg_11, counties_voter_reg_12, counties_voter_reg_13,
   counties_voter_reg_14, counties_voter_reg_15, counties_voter_reg_16,
   counties_voter_reg_17, counties_voter_reg_18, counties_voter_reg_19,
   counties_voter_reg_20, fix_format)
