#' Home office predictor
#'
#' @param data `data.frame` with data to predict probability for selection and frequency model components
#' @param apollo_list Here we also need to have access to the `apollo_probabilities()` function
#' @param fix Passed to `apollo_fixed`
#' @param cc Named vector. One or multiple of `c`, `tau1`, `tau2`, `tau3`, `tau4`, `tau5`
#' @param return_vars Boolean. If `TRUE` returns vars as required by `data`
#'
#' @return List of `data.frame`s. One for selection component and one for frequency component
#' @export
wfh_predictor <- function(data, apollo_list, fix = NULL, cc = NULL, return_vars = FALSE) {
  attach(apollo_list, name = "apollo_list")
  on.exit(detach("apollo_list"))

  if (return_vars) {
    est <- apollo_inputs$apollo_beta_names
    excl <- c("c", "tau1", "tau2", "tau3", "tau4", "tau5", "s_sigma", "f_sigma")
    est <- est[est %!in% excl]
    v <- stringr::str_remove(est, "^f_|^s_")
    return(sort(unique(v)))
  }

  database <- data

  # These variables are required by the model (but do not influence the prediction)
  database$wfh_can <- 0
  database$wfh_n_now <- 0
  database$FREQMODEL <- 1

  # Unpack for apollo_validateInputs
  apollo_fixed <- apollo_inputs$apollo_fixed
  apollo_control <- apollo_inputs$apollo_control
  apollo_control$outputDirectory <- NULL  # otherwise writes to inst...
  apollo_draws <- apollo_inputs$apollo_draws
  apollo_randCoeff <- apollo_inputs$apollo_randCoeff

  # fix
  if (!is.null(fix)) {
    apollo_fixed <- c(apollo_fixed, fix)
  }

  # cc
  if (!is.null(cc)) {
    # c, tau1, tau2, tau3, tau4, tau5
    model$estimate[names(cc)] <- cc
  }

  capture.output(
    apollo_inputs_ <-
      apollo::apollo_validateInputs( # needs to be explicitly passed (as it searches globalenv...)
        apollo_beta = apollo_beta,
        apollo_fixed = apollo_fixed,
        database = database,
        apollo_control = apollo_control,
        apollo_draws = apollo_draws,
        apollo_randCoeff = apollo_randCoeff,
        silent = TRUE # does not silence...
      )
  )

  prediction_settings <- list(silent = TRUE)
  p <- apollo::apollo_prediction(model, apollo_probabilities, apollo_inputs_, prediction_settings = prediction_settings)
  selection <- p$selection
  frequency <- p$frequency

  # Restructure to be consistent with mto predictors
  dfs <- data.frame(
    p0 = selection$X0,
    p1 = selection$X1
  )

  dff <- data.frame(
    p0 = frequency$X0,
    p1 = frequency$X1,
    p2 = frequency$X2,
    p3 = frequency$X3,
    p4 = frequency$X4,
    p5 = frequency$X5
  )

  out <- list()
  out$selection = dfs
  out$frequency = dff

  return(out)
}
