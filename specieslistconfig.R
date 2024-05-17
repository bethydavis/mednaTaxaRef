
# Identify packages to use
packages = list(
  CRAN = c("dplyr", "tidyverse", "beepr", "taxize", "rotl", "stringi"),
  bioc = c(),
  github = c()
)


# Manage installations as needed
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

# Load packages from library, quietly
suppressPackageStartupMessages({
  for (p in packages$CRAN) library(p, character.only = TRUE)
  for (p in packages$bioc) library(p, character.only = TRUE)
  for (p in names(packages$github)) library(p, character.only = TRUE)
})

# Set up output folder and version
  # Set version and date for each time the analysis script is run - SET THIS EVERY TIME
versiondate <- c("3-May02-2024/")
  # base output folder
base_outputs <- "C:/Users/bydav/Desktop/SpeciesListCleaning"

# Combine strings to make a new path
output_version <- paste(base_outputs, versiondate, sep = "/")

# Create version output directory if it doesn't exist - if it does exist, it'll just throw a warning
dir.create(output_version, showWarnings = FALSE)

# Set version output as the output path for items from this run
path_outputs <- output_version

# Set input file:
