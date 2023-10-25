#' Run the plumber API
#'
#' @param port which listens
#'
#' @export
run <- function(api = "main", port = 8000) {
  api_path <- system.file("plumber", api, "plumber.R", package = "MATSimAPI")
  if (api_path == "") {
    stop("API script not found.")
  }

  plumber::plumb(api_path) %>%
    plumber::pr_run(port = port)
}
