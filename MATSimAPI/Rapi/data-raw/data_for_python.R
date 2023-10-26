## code to prepare `data_for_python` dataset goes here

devtools::load_all()

library(tidyverse)
library(jsonlite)

rm(list = ls())

dat <-
  test_data %>%
  map(function(x) {
    x$json
  })

dat$dummy <- NULL

# Greate one large json
dat_ <-
  dat %>%
  map(function(x) {
    jsonlite::fromJSON(x)
  })

data_for_python <- jsonlite::toJSON(dat_, pretty = TRUE)

jsonlite::write_json(dat_, path = "../data/model_data.json", pretty = TRUE)

usethis::use_data(data_for_python, overwrite = TRUE)
