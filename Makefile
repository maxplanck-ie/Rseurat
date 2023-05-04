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
	@cat .github/workflows/deploy.yml | grep Rscript | grep -v zenodo | sed '$$d'
	@echo "And last, you'd need the manually-curated datasets (available @ deep19):"
	@echo -n "          " && cat rmd/10_PkgInstall.Rmd | grep cp | grep -v pkg

render:  ## Generate all the HTML files.
	@Rscript -e "rmarkdown::render_site('rmd')"
	@echo "$$ ls -halt rmd/site/"

style:  ## Format all code blocks.
	@Rscript -e "styler::style_dir('rmd')"

open-pr:
	@git pull && git push && git pull origin main
	@gh pr create --title "quick upgrade" --fill -B main
	@echo "-- Pull Request OPENED"

merge-pr:
	@CURRENT_BRANCH=$$(git rev-parse --abbrev-ref HEAD)
	@git pull origin main
	@git checkout main
	@git merge $$CURRENT_BRANCH
	@git push -u origin main
	@echo "-- Pull Request MERGED"
	@git checkout $$CURRENT_BRANCH
