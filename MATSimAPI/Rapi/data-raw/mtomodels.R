## code to prepare `mtomodels` dataset goes here

# see Makefile, rule update_mto_modles

load("./data-raw/mtomodels.rda")
mtomodels <- MATSimAPI


usethis::use_data(mtomodels, overwrite = TRUE)
