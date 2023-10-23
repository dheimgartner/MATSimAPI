## code to prepare `test_data` dataset goes here

library(jsonlite)

devtools::load_all()

rm(list = ls())

test_data_from_model <- function(model) {
  out <- list()
  df <- model$apollo_inputs$database
  js <- jsonlite::toJSON(list(data = as.list(df)), pretty = TRUE)
  out$df <- df
  out$json <- js
  return(out)
}

# Dummy
df <- head(iris)
js <- jsonlite::toJSON(list(data = as.list(df)), pretty = TRUE)

dummy <- list()
dummy$df <- df
dummy$json <- js

test_data <- list()
test_data$dummy <- dummy

# MTO
td_mto <-
  purrr::map(MATSimAPI::mtomodels, function(x) {
    test_data_from_model(x)
  })

test_data <- append(test_data, td_mto)

# WFH
td_wfh <- list(wfh = test_data_from_model(MATSimAPI::wfhmodels$heckman))

test_data <- append(test_data, td_wfh)

usethis::use_data(test_data, overwrite = TRUE)
