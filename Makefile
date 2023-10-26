.PHONY: format, requirements, build, clean

format:
	@black MATSimAPI/

requirements:
	@pipreqs --force

build:
	@bash scripts/build.sh

clean:
	@rm -rf _build