## code to prepare `test_data` dataset goes here

library(jsonlite)

devtools::load_all()

rm(list = ls())

test_data_from_model <- function(model, pred_func, wfh = FALSE) {
  out <- list()
  df <- model$apollo_inputs$database

  # only select vars of interest
  if (wfh) {
    vars_ <- sort(unique(pred_func(data = NULL, apollo_list = model, return_vars = TRUE)))
  } else {
    vars_ <- sort(unique(pred_func(data = NULL, model = model$model, return_vars = TRUE)))
  }
  df <- df[, c("ID", vars_)]

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
pred_funcs <- list(ga_predictor, ca_predictor, re_predictor, ht_predictor, cs_predictor, bi_predictor)
td_mto <-
  purrr::map2(MATSimAPI::mtomodels, pred_funcs, function(x, y) {
    test_data_from_model(x, y)
  })

test_data <- append(test_data, td_mto)

# WFH
td_wfh <- list(wfh = test_data_from_model(MATSimAPI::wfhmodels$heckman, wfh_predictor, wfh = TRUE))

test_data <- append(test_data, td_wfh)

usethis::use_data(test_data, overwrite = TRUE)
