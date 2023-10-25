MTO_MODELS := ../mtomodel/data/MATSimAPI.rda
MTO_FULL := ../mtomodel/data/full_db.rda
WFH_MODELS := ../wfhmodel/data/MATSimAPI.rda
WFH_FULL := ../wfhmodel/data/full_db.rda


.PHONY: build unbuild update_mto_models update_wfh_models

build:
	mkdir _build
	cd _build
	Rscript -e "devtools::build(path = './_build')"
	ls ./_build | xargs -I {} Rscript -e "install.packages('./_build/{}')"

unbuild:
	Rscript -e "remove.packages('MATSimAPI')"
	rm -rf _build

update_mto_models:
	cp $(MTO_MODELS) ./data-raw/mtomodels.rda
	cp $(MTO_FULL) ./data-raw/mtodata_full.rda
	Rscript --vanilla ./data-raw/mtomodels.R
	Rscript --vanilla ./data-raw/test_data.R

update_wfh_models:
	cp $(WFH_MODELS) ./data-raw/wfhmodels.rda
	cp $(WFH_FULL) ./data-raw/wfhdata_full.rda
	Rscript --vanilla ./data-raw/wfhmodels.R
	Rscript --vanilla ./data-raw/test_data.R
