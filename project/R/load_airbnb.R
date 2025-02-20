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
  library(dplyr)
  
  # read CSV
  df <- read_csv(file_path, show_col_types = FALSE)
  
  df <- df %>% 
    rename (
      neighborhood = neighbourhood
    ) %>%
    filter(price < 3000) # removes a few errors...
    # ...like $7000 dorm rooms in hostels that should be $70
  
  df$shortNeighborhood <- substr(df$neighborhood, 1, 25)  # add column of short neighborhood names

  return(df)
}
