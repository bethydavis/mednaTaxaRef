#' Read species list file
#' 
#' @param filename chr, name of the species list file
#' @param header logi, set=TRUE if file has a header
#' @param encoding chr, define encoding type for reading the file
#' @param sentence chr, option to convert strings to sentence case (first letter capitalized only)
#' @return provides the species list file table of values

# assign defaults in the actual function prototype, not the descriptions (#')
read_spListMeta = function(filename = "C:/Users/bydav/Desktop/SpeciesListMeta.csv", 
                           header = TRUE,
                           encoding = "UTF-8",
                           sentence = TRUE){
  x = readr::read_csv(filename, col_names = header, locale=locale(encoding = encoding), col_types = "cc")
  if(sentence == TRUE){
    x = x |> dplyr::mutate(Species_Name = stringr::str_to_sentence(Species_Name))
  }
  return(x)
}

#' Read config file
#' 
#' @param filename chr, name of the config file
#' @return provides the configuration values

# assign defaults in the actual function prototype, not the descriptions (#')
read_configuration = function(filename = "C:/Users/bydav/Desktop/SpeciesList_Cleaning2024/input/cleaning0.00.yaml"){
  x = charlier::read_config(filename)
  return(x)
}


