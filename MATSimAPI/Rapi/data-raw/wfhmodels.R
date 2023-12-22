## code to prepare `wfhmodels` dataset goes here

# see Makefile, rule update_wfh_modles

load("./data-raw/wfhmodels.rda")
wfhmodels <- list(heckman_base = MATSimAPI$heckman,  # as estimated (not calibrated)
                  heckman = MATSimAPI$calibrated)  # calibrated to synpop zurich


usethis::use_data(wfhmodels, overwrite = TRUE)
