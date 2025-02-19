#' Read and Clean Airbnb CSV Data
#'
#' This function reads a CSV file containing Airbnb data and returns a cleaned dataframe.
#'
#' @param file_path The path to the CSV file. Defaults to the package's `inst/extdata/` folder.
#' @return A cleaned dataframe with selected columns.
#' @export
#'
#' @examples
#' df <- read_airbnb_csv()
read_airbnb_csv <- function(file_path = system.file("extdata", "airbnb_data.csv", package = "DC_property_data")) {
  library(readr)
  
  # read CSV
  df <- read_csv(file_path, show_col_types = FALSE)

  return(df)
}
