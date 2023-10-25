## code to prepare `variables` dataset goes here

devtools::load_all()

library(tidyverse)

rm(list = ls())

# Load full db for imputation values
load("./data-raw/mtodata_full.rda")
mto_full <- full_db

load("./data-raw/wfhdata_full.rda")
wfh_full <- full_db

full_db <- append(mto_full, wfh_full)

df_full <-
  full_db %>%
  reduce(bind_rows) %>%
  group_by(ID) %>%
  slice(1) %>%
  ungroup()

# Init
dat <- test_data[names(test_data) %!in% "dummy"]

dat <-
  dat %>%
  map(function(x) {
    x$df
  })

modes <- names(dat)[names(dat) != "wfh"]
funcs <- list(ga_predictor, ca_predictor, re_predictor, ht_predictor, cs_predictor, bi_predictor)
get_mto_vars <- function(mode, func) {
  func(data = NULL, model = mtomodels[[mode]]$model, return_vars = TRUE)
}

mto_vars <-
  map2(modes, funcs, function(x, y) {
    get_mto_vars(x, y)
  })

wfh_vars <-
  wfh_predictor(NULL, wfhmodels$heckman, return_vars = TRUE)

all_vars <- mto_vars
all_vars$wfh <- wfh_vars

all_vars <-
  all_vars %>%
  reduce(c) %>%
  unique()

all_vars <- c("ID", all_vars) # ID is always required

df <- df_full[, all_vars]

# Compute mean values for all (even for dummies -> market share)
sel <- all_vars[all_vars != "ID"]
imp <-
  df %>%
  select(all_of(sel)) %>%
  map_vec(function(x) {
    mean(x, na.rm = TRUE)
  }) %>%
  sort()

df_imp <-
  data.frame(imp) %>%
  rownames_to_column("variable")

variables <-
  data.frame(variable = all_vars, description = NA, type = NA, unit = NA) %>%
  arrange(variable) %>%
  left_join(df_imp, by = "variable")

# Manual labour
path <- "./data-raw/variables.xlsx"
if (!file.exists(path)) { # init
  xlsx::write.xlsx(variables, path, row.names = FALSE)
}

# Save
variables <- readxl::read_xlsx(path)

usethis::use_data(variables, overwrite = TRUE)
