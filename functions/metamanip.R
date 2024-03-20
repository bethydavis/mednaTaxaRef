#' Capitalize
#' 
#' @param string description




#' Collapse to unique species
#' 
#' @param x a table of species metadata with multiple sources
#' @return a collapsed table preserving all sources

consol_source <- function(x){
  r = x |> 
    dplyr::group_by(Species_Name) |>
    dplyr::group_map(
      function(tbl, key){
        s = unique(tbl$Source) |>
          paste(collapse = ";")
        tbl = tbl |> 
          dplyr::slice(1) |> 
          dplyr::mutate(Source = s)
        return(tbl)
      }, .keep = TRUE) |> 
    dplyr::bind_rows()
  return(r)
}