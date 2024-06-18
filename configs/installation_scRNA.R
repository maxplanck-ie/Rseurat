# CRAN snapshot matching release date (+1) for Bioc 3.16 and R 4.2
# https://bioconductor.org/about/release-announcements/
options(
  repos = c(CRAN = "https://rspm.ie-freiburg.mpg.de/prod-cran/__linux__/jammy/2024-03-20"),
  BioC_mirror = "https://rspm.ie-freiburg.mpg.de/bioconductor"
)


retrieve_namespaces <- function(list_of_packages) {
  lapply(list_of_packages,
         function(x) {
           if (!x %in% installed.packages()) {
             suppressMessages(BiocManager::install(
               x, ask = FALSE, update = FALSE))
           }
         })
  TRUE
}


if (!"BiocManager" %in% installed.packages()) install.packages("BiocManager")
BiocManager::install(version = "3.16", ask=FALSE)

retrieve_namespaces(
  list_of_packages = c(
    # Core
    "remotes",
    "tidyverse",
    "future",
    "Seurat",
    "sctransform",
    # DE
    "metap",
    "multtest",
    "DESeq2",
    "limma",
    "MAST",
    "enrichR",
    "glmGamPoi",
    # Viz
    "RColorBrewer",
    "patchwork",
    "pheatmap"
  )
)


## This one failed on the first try... re-run:
#BiocManager::install("glmGamPoi", ask=FALSE)
## same with quantreg? check.


# Oops! We require this for SCTransform/ glmGamPoi to work
remotes::install_github("Bioconductor/MatrixGenerics@RELEASE_3_18")
## This is replicated in `dependency_downgrade` code block at 31 Rmd


if (!"SeuratData" %in% installed.packages()) remotes::install_github("satijalab/seurat-data")
install.packages("/scratch/local/rseurat/datasets/seuratdata/pbmc3k.SeuratData_3.1.4.tar.gz", repos = NULL, type = "source")
install.packages("/scratch/local/rseurat/datasets/seuratdata/ifnb.SeuratData_3.1.0.tar.gz", repos = NULL, type = "source")
