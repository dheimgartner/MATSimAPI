# do not rerun!

devtools::load_all()

out <- .wfh_predictor()

saveRDS(out, test_path("fixtures", "wfh_predictor_data.rds"))
