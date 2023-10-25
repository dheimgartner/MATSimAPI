#' Get variable descriptions
#'
#' @param model One of `c("all", "ga", "ca", "ht", "re", "cs", "bi", "wfh")`
#' @param vars Select variables of interest. Only pass if `model = "all"`
#'
#' @return `data.frame`
#' @export
variable_description <- function(model = c("all", "ga", "ca", "ht", "re", "cs", "bi", "wfh"), vars = NULL) {
  model <- match.arg(model)
  vars_ <- variables$variable

  # Checks
  flag <- (model != "all" & !is.null(vars))
  assertthat::assert_that(!flag,
                          msg = "If you pass `vars`, set `model = 'all'`")

  if (!is.null(vars)) {
    assertthat::assert_that(vars %in% vars_,
                            msg = glue::glue("variable must be one of {vars_}"))
  } else {
    vars <- vars_
  }

  # Prep
  funcs <- list(ga = ga_predictor,
                ca = ca_predictor,
                ht = ht_predictor,
                re = re_predictor,
                cs = cs_predictor,
                bi = bi_predictor,
                wfh = wfh_predictor)

  model_obj <- list(ga = mtomodels$ga$model,
                    ca = mtomodels$ca$model,
                    ht = mtomodels$ht$model,
                    re = mtomodels$re$model,
                    cs = mtomodels$cs$model,
                    bi = mtomodels$bi$model,
                    wfh = wfhmodels$heckman)  # for wfh model we need the whole apollo stuff

  filter_vars <- function(vars) {
    out <- variables[variables$variable %in% vars, ]
    out
  }

  if (model == "all") {
    out <- filter_vars(vars = vars)
  } else {
    func <- funcs[[model]]
    obj <- model_obj[[model]]
    model_vars <- func(data = NULL, obj, return_vars = TRUE)
    if (model == "wfh") {
      model_vars <- c("ID", model_vars) # apollo pred func requires ID...
    }
    out <- filter_vars(vars = model_vars)
  }

  return(out)
}
