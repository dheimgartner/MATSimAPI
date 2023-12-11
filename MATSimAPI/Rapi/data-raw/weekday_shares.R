## code to prepare `weekday_shares` dataset goes here

load("./data-raw/wfhmodels.rda")
weekday_shares <- MATSimAPI$weekday_shares

usethis::use_data(weekday_shares, overwrite = TRUE)
