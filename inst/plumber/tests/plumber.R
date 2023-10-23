#* @apiTitle Plumber MATSim test API
#* @apiDescription For testing and pinging...

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  out <- echo(msg = msg)
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
