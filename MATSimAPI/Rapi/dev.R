devtools::load_all()

df_wfh <- test_data$wfh$df

apollo_list <- wfhmodels$heckman

out <- wfh_predictor(df_wfh, apollo_list)
