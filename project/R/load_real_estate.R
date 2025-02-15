#' Read and Clean Real Estate JSON Data
#'
#' This function reads a JSON file containing real estate data, flattens nested structures, and returns a cleaned dataframe.
#'
#' @param file_path The path to the JSON file. Defaults to the package's `inst/extdata/` folder.
#' @return A cleaned dataframe with selected columns.
#' @export
#'
#' @examples
#' df <- read_real_estate_json()
read_real_estate_json <- function(file_path = system.file("extdata", "washington_dc_real_estate.json", package = "DC_property_data")) {
  library(jsonlite)
  
  # Read and flatten JSON
  data <- fromJSON(file_path, flatten = TRUE)
  df <- as.data.frame(data)
  
  # drop unwanted columns
  # df_dropped <- df[ , !(names(df) %in% c("column_to_drop1", "column_to_drop2"))]
  
  # select specific columns to keep
  df_selected <- df[ , c("zpid", "id", "rawHomeStatusCd", "marketingStatusSimplifiedCd")]
  
  return(df_selected) # Change to df_dropped if you prefer dropping instead
}