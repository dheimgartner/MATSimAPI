MTO_MODELS := ../mtomodels/data/MATSimAPI.rda


.PHONY: build, unbuild, update_mto_models

build:
	mkdir _build
	cd _build
	Rscript -e "devtools::build(path = './_build')"
	ls ./_build | xargs -I {} Rscript -e "install.packages('./_build/{}')"

unbuild:
	Rscript -e "remove.packages('MATSimAPI')"
	rm -rf _build

update_mto_models:
	cp $(MTO_MODELS) ./data/
