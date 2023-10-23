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




#* DCM for GA ownership
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

#* Required variables for GA model
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




#* DCM for car ownership
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

#* Required variables for car model
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




#* DCM for regional subscription ownership
#* @post /predict/re
#* @serializer json
#* @param data:data.frame Data to predict on (required vars: `/vars/re`)
#* @param fix:dbl Fix one or more coefficients
#* @param cc:dbl Calibration constant
#* @param debug:bool
function(data, fix = NULL, cc = NULL, debug = FALSE) {
  if (debug) {
    browser()
  }
  data <- as.data.frame(data)
  out <- re_predictor(
    data = data,
    model = MATSimAPI::mtomodels$re$model,
    fix = fix,
    cc = cc,
    return_vars = FALSE
  )
  out
}

#* Required variables for regional subscription model
#* @get /vars/re
#* @serializer json
function() {
  out <- re_predictor(
    data = NULL,
    model = MATSimAPI::mtomodels$re$model,
    fix = NULL,
    cc = NULL,
    return_vars = TRUE
  )
  out
}




#* DCM for half-fare card ownership
#* @post /predict/ht
#* @serializer json
#* @param data:data.frame Data to predict on (required vars: `/vars/ht`)
#* @param fix:dbl Fix one or more coefficients
#* @param cc:dbl Calibration constant
#* @param debug:bool
function(data, fix = NULL, cc = NULL, debug = FALSE) {
  if (debug) {
    browser()
  }
  data <- as.data.frame(data)
  out <- ht_predictor(
    data = data,
    model = MATSimAPI::mtomodels$ht$model,
    fix = fix,
    cc = cc,
    return_vars = FALSE
  )
  out
}

#* Required variables for half-fare card model
#* @get /vars/ht
#* @serializer json
function() {
  out <- ht_predictor(
    data = NULL,
    model = MATSimAPI::mtomodels$ht$model,
    fix = NULL,
    cc = NULL,
    return_vars = TRUE
  )
  out
}




#* DCM for car-sharing subscription ownership
#* @post /predict/cs
#* @serializer json
#* @param data:data.frame Data to predict on (required vars: `/vars/cs`)
#* @param fix:dbl Fix one or more coefficients
#* @param cc:dbl Calibration constant
#* @param debug:bool
function(data, fix = NULL, cc = NULL, debug = FALSE) {
  if (debug) {
    browser()
  }
  data <- as.data.frame(data)
  out <- cs_predictor(
    data = data,
    model = MATSimAPI::mtomodels$cs$model,
    fix = fix,
    cc = cc,
    return_vars = FALSE
  )
  out
}

#* Required variables for car-sharing model
#* @get /vars/cs
#* @serializer json
function() {
  out <- cs_predictor(
    data = NULL,
    model = MATSimAPI::mtomodels$cs$model,
    fix = NULL,
    cc = NULL,
    return_vars = TRUE
  )
  out
}




#* DCM for bicycle ownership
#* @post /predict/bi
#* @serializer json
#* @param data:data.frame Data to predict on (required vars: `/vars/bi`)
#* @param fix:dbl Fix one or more coefficients
#* @param cc:dbl Calibration constant
#* @param debug:bool
function(data, fix = NULL, cc = NULL, debug = FALSE) {
  if (debug) {
    browser()
  }
  data <- as.data.frame(data)
  out <- bi_predictor(
    data = data,
    model = MATSimAPI::mtomodels$bi$model,
    fix = fix,
    cc = cc,
    return_vars = FALSE
  )
  out
}

#* Required variables for bicycle model
#* @get /vars/bi
#* @serializer json
function() {
  out <- bi_predictor(
    data = NULL,
    model = MATSimAPI::mtomodels$bi$model,
    fix = NULL,
    cc = NULL,
    return_vars = TRUE
  )
  out
}


