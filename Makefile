.PHONY: format, build, clean

format:
	@black MATSimAPI/

build:
	@bash scripts/build.sh

clean:
	@rm -rf _build