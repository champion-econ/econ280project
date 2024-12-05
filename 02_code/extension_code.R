library(tidyverse)
library(haven) # read in .dta files
library(estimatr) # linear regression with robust SEs
library(modelsummary) # for clean tables

data <- read_dta("01_data/clean/GerberHuberWashington_APSR_2010_AnonymizedReplicationFile_intermediate_data.dta")

# Checking the count of black individuals
data %>% 
  filter(R_STRATACOAFILTER==0 & (pid7==3 | pid7==5)) %>% 
  group_by(pt_black) %>% 
  summarise(count = n())
# Lol I know this is a bad idea empirically but I just need something to make this project work
  
col_1_black = lm_robust(pt_voteevalalignindex ~ pt_black + treat + treat*pt_black + pre_lean_dem + age + age2 + regyear + regyearmissing + twonames + combined_female + voted2006 + voted2004 + voted2002 + voted2000 + voted1998 + voted1996 + interest + pre_aligned_vh + pre_direct_unemp + pre_direct_econ + pre_direct_bushap + pre_direct_congapp,
                      data = (data %>% 
                                # The paper used the same filter on the data
                                filter(R_STRATACOAFILTER==0 & (pid7==3 | pid7==5),
                                       # adding a filter to remove obs where no race is recorded
                                       !is.na(pt_black))),
                      se_type = "stata") 

col_2_black = iv_robust(pt_voteevalalignindex ~ pre_lean_dem + age + age2 + regyear + regyearmissing + twonames + combined_female + voted2006 + voted2004 + voted2002 + voted2000 + voted1998 + voted1996 + interest + pre_aligned_vh + pre_direct_unemp + pre_direct_econ + pre_direct_bushap + pre_direct_congapp + pt_black + pt_id_with_lean + pt_id_with_lean*pt_black
                      | pre_lean_dem + age + age2 + regyear + regyearmissing + twonames + combined_female + voted2006 + voted2004 + voted2002 + voted2000 + voted1998 + voted1996 + interest + pre_aligned_vh + pre_direct_unemp + pre_direct_econ + pre_direct_bushap + pre_direct_congapp + pt_black + treat + treat*pt_black,
                      data = (data %>% 
                                filter(R_STRATACOAFILTER==0 & (pid7==3 | pid7==5),
                                       # adding a filter to remove obs where no race is recorded
                                       !is.na(pt_black))),
                      se_type = "HC0")

col_3_black = iv_robust(pt_voteevalalignindex ~ pre_lean_dem + age + age2 + regyear + regyearmissing + twonames + combined_female + voted2006 + voted2004 + voted2002 + voted2000 + voted1998 + voted1996 + interest + pre_aligned_vh + pre_direct_unemp + pre_direct_econ + pre_direct_bushap + pre_direct_congapp + pt_black + pt_direct_pid7 + pt_direct_pid7*pt_black
                        | pre_lean_dem + age + age2 + regyear + regyearmissing + twonames + combined_female + voted2006 + voted2004 + voted2002 + voted2000 + voted1998 + voted1996 + interest + pre_aligned_vh + pre_direct_unemp + pre_direct_econ + pre_direct_bushap + pre_direct_congapp + pt_black + treat + treat*pt_black,
                        data = (data %>% 
                                  filter(R_STRATACOAFILTER==0 & (pid7==3 | pid7==5),
                                         # adding a filter to remove obs where no race is recorded
                                         !is.na(pt_black))),
                        se_type = "HC0")


models = list("OLS" = col_1_black,
              "ATT (Identified with Pre-Survey Latent Party)" = col_2_black,
              "ATT (Post-Survey Directional Party ID Relative to Pre-Survey Latent Party)" = col_3_black)

table_1 = modelsummary(models,
             stars = FALSE,
             gof_omit = "IC|Adj|F|RMSE|Log",
             coef_omit = c(1,4:22),
             coef_rename = c(pt_black = "Black",
                             treat = "Sent Mail",
                             "pt_black:treat" = "Sent Mail x Black",
                             pt_id_with_lean = "Post-survey identified with pre-survey latent party",
                             "pt_black:pt_id_with_lean" = "Post ID w/ Party x Black",
                             pt_direct_pid7 = "Post-Survey Directional Party ID Relative to Pre-Survey Latent Party",
                             "pt_black:pt_direct_pid7" = "Post Directional ID x Black"),
             title = "The effect of being sent mail on party alignment interacted with race",
             add_rows = tibble(var_name = "Controls", ols = "X", att_id = "X", att_dir = "X")) %>% 
  theme_tt("resize", width = 1) %>% 
  group_tt(j = list("Voting and Party Alignment Scale (-4 to 6)" = 2:4))

saveRDS(table_1, file = "02_code/table_1.rds")



