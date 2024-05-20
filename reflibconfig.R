# Identify packages to use
packages = list(
  CRAN = c("taxizedb", "rentrez", "AnnotationBustR", "beepr", "reutils", "ape", "ggplot2", "dplyr", "tidyr"),
  bioc = c("BiocManager", "Biostrings", "GenomicFeatures", "VariantAnnotation"),
  github = c()
)
  ## Note: genbankr will need to be loaded manually using Tools > Install Packages > Install from Package Archive File > select the tar.gz

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


# Set up input folder and files
path_input <- "C:/Users/bydav/Desktop/RefDB_Dev/input"

  # Entrez key - replace the path with the path to your own entrez key
entrez <- read.table(file = "C:/Users/bydav/Desktop/RefDB_Dev/input/entrez_key.txt", header = FALSE)
entrez_key <- as.character(entrez)

  # Species list input
specieslist <- readRDS("C:/Users/bydav/Desktop/RefDB_Dev/input/GNRMaineSpecies_May2024.RDS")

  # Order list input
orderlist <- read.csv("C:/Users/bydav/Desktop/RefDB_Dev/input/MetazoaSpeciesByOrder_2023-09-19.csv")

  # Family list input
familylist <- read.csv("C:/Users/bydav/Desktop/RefDB_Dev/input/MetazoaSpeciesByFamily_2023-09-19.csv")

# Set up output folder and version
  # Set version and date for each time the analysis script is run - SET THIS EVERY TIME
versiondate <- c("3-May19-2024/")
  # base output folder
base_outputs <- "C:/Users/bydav/Desktop/RefDB_Dev/output"

# Combine strings to make a new path
output_version <- paste(base_outputs, versiondate, sep = "/")

# Create version output directory if it doesn't exist - if it does exist, it'll just throw a warning
dir.create(output_version, showWarnings = FALSE)

# Set version output as the output path for items from this run
path_outputs <- output_version