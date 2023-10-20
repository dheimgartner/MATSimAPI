#* @apiTitle Plumber MATSim test API
#* @apiDescription For testing and pinging...

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  out <- echo(msg = msg)
  out
}
