#* @apiTitle Plumber MATSim DCM predictor API
#* @apiDescription Returns probability vectors for home office choice and frequency as well as mobility tool ownership.
#* @apiContact Daniel Heimgartner `daniel.heimgartner@ivt.baug.ethz.ch`

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  out <- echo(msg = msg)
  out
}

#* DCM for GA subscription
#* @post /predict/ga
#* @serializer json
#* @param data:data.frame Data to predict on (make sure to include the required variables) -> TODO: add get request
#* @param fix:dbl Fix one or more coefficients
#* @param cc:dbl Calibration constant
#* @param debug:bool
function(data, fix = NULL, cc = NULL, debug = FALSE) {
  if (debug) {
    browser()
  }
  data <- as.data.frame(data)
  out <- ga_predictor(
    data = data,
    model = MATSimAPI::MATSimAPI$ga$model,
    fix = fix,
    cc = cc,
    return_vars = FALSE
  )
  out
}

#* Required variables for GA subscription
#* @get /predict/ga/vars
#* @serializer json
function() {
  out <- ga_predictor(
    data = NULL,
    model = MATSimAPI::MATSimAPI$ga$model,
    fix = NULL,
    cc = NULL,
    return_vars = TRUE
  )
  out
}

#* Pass data in and out
#* @post /test/data
#* @param data:data.frame Data to pass in and out
#* @param debug:bool
function(data, debug = FALSE) {
  if (debug) {
    browser()
  }
  df <- as.data.frame(data)
  df[1, ]
  return(df)
}


