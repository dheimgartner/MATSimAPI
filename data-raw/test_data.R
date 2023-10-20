## code to prepare `test_data` dataset goes here

library(jsonlite)

df <- head(iris)
js <- jsonlite::toJSON(list(data = as.list(df)), pretty = TRUE)

test_data <- list()
test_data$dummy <- df
test_data$dummy_json <- js

ga <- MATSimAPI::MATSimAPI$ga
ga <- ga$apollo_inputs$database
ga_json <- jsonlite::toJSON(list(data = as.list(ga)), pretty = TRUE)

test_data$ga <- ga
test_data$ga_json <- ga_json

usethis::use_data(test_data, overwrite = TRUE)
