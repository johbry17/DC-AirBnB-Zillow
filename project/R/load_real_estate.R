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
  suppressPackageStartupMessages(library(dplyr)) # eliminate print out in R Markdown
  
  # read and flatten JSON (for nested columns)
  data <- fromJSON(file_path, flatten = TRUE)
  df <- as.data.frame(data)
  
  # select specific columns to keep
  df_selected <- df[ , c(
    "zpid", 
    "rawHomeStatusCd", 
    "marketingStatusSimplifiedCd", 
    "unformattedPrice",
    "latLong.latitude", 
    "latLong.longitude",
    "beds",
    "baths",
    "area",
    "zestimate",
    "hdpData.homeInfo.rentZestimate",
    "hdpData.homeInfo.taxAssessedValue",
    "detailUrl"
  )]
  
  # rename columns
  df_selected <- df_selected %>%
    rename(
      homeStatus = rawHomeStatusCd,
      marketingStatus = marketingStatusSimplifiedCd,
      price = unformattedPrice,
      latitude = latLong.latitude,
      longitude = latLong.longitude,
      rentZestimate = hdpData.homeInfo.rentZestimate,
      taxAssessedValue = hdpData.homeInfo.taxAssessedValue,
      url = detailUrl
    )
  
  return(df_selected)
}