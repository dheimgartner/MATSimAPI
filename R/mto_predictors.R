#' Base predictor
#'
#' @param data `data.frame` with data to predict probability of having GA subscription
#' @param model Apollo model
#' @param excl Coefficient vector to exclude (`c("c1", "c2", "scale")` will always be excluded)
#' @param fix Named vector. Fix coefficients to certain values
#' @param cc Calibration constant (cutoff parameter)
#'
#' @return `data.frame` with probability vectors
#' @export
base_predictor <- function(data, model, excl, fix = NULL, cc = NULL, return_vars = FALSE) {
  est <- model$estimate
  excl <- c(excl, "c1", "c2", "scale")

  if (is.null(cc)) {
    c1 <- est["c1"]
  } else {
    c1 <- cc
  }

  est <- est[names(est) %!in% excl]

  if (!is.null(fix)) {
    est[names(fix)] <- fix
  }

  v <- vars_from_beta(est)

  if (return_vars) {
    return(v)
  }

  db <-
    data %>%
    select(all_of(v)) %>%
    as.matrix()

  y_star <- -c1 + db %*% est
  p1 <- pnorm(y_star)
  p0 <- 1 - p1
  p <- data.frame(p0 = p0, p1 = p1)
  return(p)
}




#' GA predictor
#'
#' @param data `data.frame` with data to predict probability of having GA subscription
#' @param model Apollo model
#' @param fix Named vector. Fix coefficients to certain values
#' @param cc Calibration constant (cutoff parameter)
#'
#' @return `data.frame` with probability vectors
#'
#' @seealso [base_predictor()]
#' @export
ga_predictor <- function(data, model, fix = NULL, cc = NULL, return_vars = FALSE) {
  excl <- c("b_wfa", "b_pt_class_1", "b_wfh_x_wfa", "b_pt_fixed_cost", "b_pt_class_x_cost")
  base_predictor(data = data, model = model, excl = excl, fix = fix, cc = cc, return_vars = return_vars)
}




#' Car predictor
#'
#' @param data `data.frame` with data to predict probability of owning a car
#' @param model Apollo model
#' @param fix Named vector. Fix coefficients to certain values
#' @param cc Calibration constant (cutoff parameter)
#'
#' @return `data.frame` with probability vectors
#'
#' @seealso [base_predictor()]
#' @export
ca_predictor <- function(data, model, fix = NULL, cc = NULL, return_vars = FALSE) {
  excl <- c("b_wfh_x_wfa", "b_ca_fixed_cost", "b_ca_type_1", "b_ca_type_2", "b_ca_type_3", "b_ca_type_4")
  base_predictor(data = data, model = model, excl = excl, fix = fix, cc = cc, return_vars = return_vars)
}




#' Regional PT-subscription predictor
#'
#' @param data `data.frame` with data to predict probability of owning a regional subscription (PT)
#' @param model Apollo model
#' @param fix Named vector. Fix coefficients to certain values
#' @param cc Calibration constant (cutoff parameter)
#'
#' @return `data.frame` with probability vectors
#'
#' @seealso [base_predictor()]
#' @export
re_predictor <- function(data, model, fix = NULL, cc = NULL, return_vars = FALSE) {
  excl <- c("b_wfh_x_wfa")
  base_predictor(data = data, model = model, excl = excl, fix = fix, cc = cc, return_vars = return_vars)
}




#' Half-fare card (HT) predictor
#'
#' @param data `data.frame` with data to predict probability of owning a HT
#' @param model Apollo model
#' @param fix Named vector. Fix coefficients to certain values
#' @param cc Calibration constant (cutoff parameter)
#'
#' @return `data.frame` with probability vectors
#'
#' @seealso [base_predictor()]
#' @export
ht_predictor <- function(data, model, fix = NULL, cc = NULL, return_vars = FALSE) {
  excl <- c("b_wfh_x_wfa")
  base_predictor(data = data, model = model, excl = excl, fix = fix, cc = cc, return_vars = return_vars)
}




#' Car-sharing predictor
#'
#' @param data `data.frame` with data to predict probability of having a car-sharing subscription
#' @param model Apollo model
#' @param fix Named vector. Fix coefficients to certain values
#' @param cc Calibration constant (cutoff parameter)
#'
#' @return `data.frame` with probability vectors
#'
#' @seealso [base_predictor()]
#' @export
cs_predictor <- function(data, model, fix = NULL, cc = NULL, return_vars = FALSE) {
  excl <- c("b_wfh_x_wfa")
  base_predictor(data = data, model = model, excl = excl, fix = fix, cc = cc, return_vars = return_vars)
}




#' Bicycle predictor
#'
#' @param data `data.frame` with data to predict probability of owning a bicycle
#' @param model Apollo model
#' @param fix Named vector. Fix coefficients to certain values
#' @param cc Calibration constant (cutoff parameter)
#'
#' @return `data.frame` with probability vectors
#'
#' @seealso [base_predictor()]
#' @export
bi_predictor <- function(data, model, fix = NULL, cc = NULL, return_vars = FALSE) {
  excl <- c("b_wfh_x_wfa")
  base_predictor(data = data, model = model, excl = excl, fix = fix, cc = cc, return_vars = return_vars)
}


