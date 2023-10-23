## code to prepare `wfhmodels` dataset goes here

# see Makefile, rule update_wfh_modles

load("./data-raw/wfhmodels.rda")
wfhmodels <- MATSimAPI


usethis::use_data(wfhmodels, overwrite = TRUE)
