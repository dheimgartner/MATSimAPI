## code to prepare `variables` dataset goes here

devtools::load_all()

library(tidyverse)

rm(list = ls())

# Init
dat <- test_data[names(test_data) %!in% "dummy"]

dat <-
  dat %>%
  map(function(x) {
    x$df
  })

df <-
  dat %>%
  reduce(bind_rows)

modes <- names(dat)[names(dat) != "wfh"]
funcs <- list(ga_predictor, ca_predictor, re_predictor, ht_predictor, cs_predictor, bi_predictor)
get_mto_vars <- function(mode, func) {
  func(data = NULL, model = mtomodels[[mode]]$model, return_vars = TRUE)
}

all_vars <-
  map2(modes, funcs, function(x, y) {
    get_mto_vars(x, y)
  })

all_vars <-
  all_vars %>%
  reduce(c) %>%
  unique()

all_vars <- c("ID", all_vars) # ID is always required

df <- df[, all_vars]

variables <-
  data.frame(variable = all_vars, description = NA, type = NA, unit = NA) %>%
  arrange(variable)

# Manual labour
path <- "./data-raw/variables.xlsx"
if (!file.exists(path)) { # init
  xlsx::write.xlsx(variables, path, row.names = FALSE)
}

# Save
variables <- readxl::read_xlsx(path)

usethis::use_data(variables, overwrite = TRUE)
