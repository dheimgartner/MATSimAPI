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




#* DCM for GA (ga) subscription
#* @post /predict/ga
#* @serializer json
#* @param data:data.frame Data to predict on (required vars: `/vars/ga`)
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
    model = MATSimAPI::mtomodels$ga$model,
    fix = fix,
    cc = cc,
    return_vars = FALSE
  )
  out
}

#* Required variables for GA (ga) model
#* @get /vars/ga
#* @serializer json
function() {
  out <- ga_predictor(
    data = NULL,
    model = MATSimAPI::mtomodels$ga$model,
    fix = NULL,
    cc = NULL,
    return_vars = TRUE
  )
  out
}




#* DCM for car (ca) ownership
#* @post /predict/ca
#* @serializer json
#* @param data:data.frame Data to predict on (required vars: `/vars/ca`)
#* @param fix:dbl Fix one or more coefficients
#* @param cc:dbl Calibration constant
#* @param debug:bool
function(data, fix = NULL, cc = NULL, debug = FALSE) {
  if (debug) {
    browser()
  }
  data <- as.data.frame(data)
  out <- ca_predictor(
    data = data,
    model = MATSimAPI::mtomodels$ca$model,
    fix = fix,
    cc = cc,
    return_vars = FALSE
  )
  out
}

#* Required variables for car (ca) model
#* @get /vars/ca
#* @serializer json
function() {
  out <- ca_predictor(
    data = NULL,
    model = MATSimAPI::mtomodels$ca$model,
    fix = NULL,
    cc = NULL,
    return_vars = TRUE
  )
  out
}





