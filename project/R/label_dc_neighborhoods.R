#' Assigns neighborhood labels to properties based on latitude and longitude
#'
#' This function takes a dataframe with latitude and longitude columns and assigns
#' each property a neighborhood based on a provided GeoJSON file. Properties
#' outside any defined neighborhood are labeled as "Unknown".
#'
#' @param df A dataframe containing `latitude` and `longitude` columns.
#' @param geojson_path The file path to the GeoJSON file with neighborhood boundaries.
#'
#' @return A dataframe with an additional column `neighborhood` indicating the assigned neighborhood.
#' @export
#'
#' @examples
#' \dontrun{
#' df <- data.frame(latitude = c(38.9, 38.85), longitude = c(-77.0, -76.95))
#' geojson_path <- "neighbourhoods_cleaned.geojson"
#' df <- assign_neighborhood(df, geojson_path)
#' }
assign_neighborhood <- function(df, geojson_path = system.file("extdata", "neighbourhoods_cleaned.geojson", package = "DC_property_data")) {
  suppressPackageStartupMessages(library(sf))
  library(dplyr)
  
  # load GeoJSON neighborhood data
  neighborhoods <- st_read(geojson_path, quiet = TRUE)
  
  # validate and clean the geometries - solves a problem of degenerate edges (duplicate vertices forming invalid polygons in GeoJSON)
  neighborhoods <- st_make_valid(neighborhoods)
  
  # filter out rows with NA's in latitude or longitude (there are only 6)
  df <- df %>% filter(!is.na(latitude) & !is.na(longitude))
  
  # save latitude and longitude columns
  lat_long <- df %>% select(latitude, longitude)
  
  # convert df to sf object
  # crs = 4326 sets Coordinate Reference System to WGS 84, the standard for lat/long used by GPS and mapping apps
  df_sf <- st_as_sf(df, coords = c("longitude", "latitude"), crs = 4326)
  
  # spatial join to find which neighborhood each property belongs to
  df_sf <- st_join(df_sf, neighborhoods, left = TRUE)
  
  # add neighborhood column, assigning "Unknown" where no neighborhood match is found
  df_sf$neighborhood <- ifelse(is.na(df_sf$neighbourhood), "Unknown", df_sf$neighbourhood)
  
  df_sf$shortNeighborhood <- substr(df_sf$neighborhood, 1, 25)  # add column of short neighborhood names
  
  # convert back to regular df
  df <- as.data.frame(df_sf) %>%
    select(-geometry, -neighbourhood, -neighbourhood_group) %>%
    bind_cols(lat_long)  # add latitude and longitude back
  
  return(df)
}
