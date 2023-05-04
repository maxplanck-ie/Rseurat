.PHONY: *
SHELL := /bin/bash

help: display-warning
	@echo "" && echo 'List of the most relevant available routines:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

display-warning:
	@echo "This makefile is assuming your conda environment is activated and ready."
	@echo "Else, please run:"
	@echo "          mamba env create -n Rseurat -f configs/conda.yml"
	@echo "Plus, any dependencies unavailable through conda channels:"
	@cat .github/workflows/deploy.yml | grep Rscript | sed '$$d'

render:  ## Generate all the HTML files.
	@Rscript -e "rmarkdown::render_site('rmd')"
	@echo "$$ ls -halt rmd/site/" && echo ""

style:  ## Format all code blocks.
	@Rscript -e "styler::style_dir('rmd')"
