% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mto_predictors.R
\name{re_predictor}
\alias{re_predictor}
\title{Regional PT-subscription predictor}
\usage{
re_predictor(data, model, fix = NULL, cc = NULL, return_vars = FALSE)
}
\arguments{
\item{data}{\code{data.frame} with data to predict probability of owning a regional subscription (PT)}

\item{model}{Apollo model}

\item{fix}{Named vector. Fix coefficients to certain values}

\item{cc}{Calibration constant (cutoff parameter)}

\item{return_vars}{Boolean. If \code{TRUE} returns vars as required by \code{data}}
}
\value{
\code{data.frame} with probability vectors
}
\description{
Regional PT-subscription predictor
}
\seealso{
\code{\link[=base_predictor]{base_predictor()}}
}
