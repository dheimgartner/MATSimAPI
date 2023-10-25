## code to prepare `full_time_week_dist` dataset goes here

load("./data-raw/wfhmodels.rda")
full_time_week_dist <- MATSimAPI$full_time_week_dist

usethis::use_data(full_time_week_dist, overwrite = TRUE)
