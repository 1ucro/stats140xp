#==============================================================================
# File           :  x00_control_scripts
# Purpose        :  Control work flow for Stats 140XP final project
# Notes          :
# Last modified  :  02/27/2023
#==============================================================================

# 1. Prepare global environment -------------------------------------------
rm(list = ls())

# 2. Load libraries -------------------------------------------------------
source("x01_load_libraries.R")

# 3. Prepare data ---------------------------------------------------------
## 3.1 Prepare auditor data -----------------------------------------------
source("x02_prep_auditor_data.R")

## 3.2 Prepare voter turnout data -----------------------------------------
source("x03_prep_voting_data.R")

## 3.3 Prepare final data ------------------------------------------------
source("x04_prep_final_data.R")

# 4. Build model ----------------------------------------------------------
# source("x03_build_model.R") - Future

# 5. Test -----------------------------------------------------------------
source("x99_test.R")



