packages = list(
  CRAN = c("beepr", "dplyr", "tidyverse", "taxize", "rotl", "stringi"),
  bioc = NULL,
  github = c("charlier" = "BigelowLab")
)


# manage installations as needed
installed = installed.packages() |> rownames()
for (pkg in packages$CRAN){
  if (!pkg %in% installed) install.packages(pkg, repos = "https://cloud.r-project.org/", update = FALSE)
  
}
for (pkg in packages$bioc){
  if (!pkg %in% installed) BiocManager::install(pkg, update = FALSE)
  
}
for (pkg in names(packages$github)){
  if (!pkg %in% installed) remotes::install_github(file.path(packages$github[pkg], pkg), update = FALSE)
}

# load packages from library
suppressPackageStartupMessages({
  for (p in packages$CRAN) library(p, character.only = TRUE)
  for (p in packages$bioc) library(p, character.only = TRUE)
  for (p in names(packages$github)) library(p, character.only = TRUE)
})

# source functions
ff = list.files("functions", full.names = TRUE, pattern = "^.*\\.R$")
for (f in ff) source(f)