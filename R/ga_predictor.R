#' GA predictor
#'
#' @param data `data.frame` with data to predict probability of having GA subscription
#' @param model Apollo model
#' @param fix Named vector. Fix coefficients to certain values
#' @param cc Calibration constant (cutoff parameter[s])
#'
#' @return `data.frame` with probability vectors
#' @export
ga_predictor <- function(data, model, fix = NULL, cc = NULL, return_vars = FALSE) {
  est <- model$estimate
  excl <- c("b_wfa", "b_pt_class_1", "b_wfh_x_wfa", "b_pt_fixed_cost", "b_pt_class_x_cost", "c1", "c2", "scale")

  if (is.null(cc)) {
    c1 <- est["c1"]
  } else {
    c1 <- cc
  }

  est <- est[!(names(est) %in% excl)]

  if (!is.null(fix)) {
    est[names(fix)] <- fix
  }

  v <- vars_from_beta(est)

  if (return_vars) {
    return(v)
  }

  db <- data %>%
    select(all_of(v)) %>%
    as.matrix()

  y_star <- -c1 + db %*% est # NOTE: -c1
  p1 <- pnorm(y_star)
  p0 <- 1 - p1
  p <- data.frame(p0 = p0, p1 = p1)
  return(p)
}
