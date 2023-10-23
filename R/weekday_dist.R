#' Home office distribution over weekdays
#'
#' Conditional on the home office frequency as well as full-time, multi part-time or part-time
#'
#' @param wfh Home office frequency (numeric)
#' @param weekday In English and lowercase (optional)
#' @param emp One of `c("full_time", "mult_part_time", "part_time")`
#'
#' @return `data.frame`
#' @export
weekday_dist <- function(wfh,
                         weekday = NULL,
                         emp = c("full_time", "mult_part_time", "part_time")) {

  if (wfh %!in% 1:5) stop("`wfh` not in 1:5")
  emp <- match.arg(emp)

  if (!is.null(weekday)) {
    flag <- weekday %in% c("monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday")
    if (!flag) stop("`weekday` must be one of monday, tuesday, wednesday, thursday, friday, saturday, sunday")
  }

  out <-
    MATSimAPI::full_time_week_dist %>%
    mutate(wfh_n_now = as.numeric(as.character(wfh_n_now))) %>%
    filter(wfh_n_now == wfh,
           full_time == emp) %>%
    select(weekday, perc)

  if (!is.null(weekday)) {
    out <- out[out$weekday == weekday, ]
  }

  return(out)
}
