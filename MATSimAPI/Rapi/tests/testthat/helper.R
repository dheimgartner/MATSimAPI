.wfh_predictor <- function() {
  input <- test_data$wfh$df
  N <- nrow(input)
  apollo_list <- wfhmodels$heckman
  out <- wfh_predictor(input, apollo_list)
  return(out)
}
