#' @export
vars_from_beta <- function(apollo_beta) {
  nm <- names(apollo_beta)
  vars <- stringr::str_remove(nm, "^b_")
  return(vars)
}


#' @export
`%!in%` <- function(x, y) {
  !(x %in% y)
}
