# Synthetic data for testing
synth_data <- sf::st_sf(
  unit_id = paste0("cell_", 1:10),
  group_a = c(20, 10, 0, 30, 20, 10, 0, 30, 20, 10),
  group_b = c(30, 20, 10, 10, 30, 20, 10, 10, 30, 20),
  group_c = c(50, 20, 30, 10, 50, 20, 30, 10, 50, 20),
  geometry = sf::st_make_grid(
    sf::st_as_sfc(sf::st_bbox(
      c(xmin = 92000, ymin = 435000,
        xmax = 93000, ymax = 437500),
      crs = sf::st_crs(28992) # CRS of the Netherlands
    )),
    cellsize = 500
  )
)

# Example tests:
# Test 1: the shares are correct and the geometry is preserved
testthat::test_that("group shares are calculated correctly", {
  result <- calculate_group_shares(synth_data)

  # Shares correctly calculated
  testthat::expect_equal(result$share_a, c(0.2, 0.2, 0, 0.6, 0.2, 0.2, 0, 0.6, 0.2, 0.2))
  testthat::expect_equal(result$share_b, c(0.3, 0.4, 0.25, 0.2, 0.3, 0.4, 0.25, 0.2, 0.3, 0.4))
  testthat::expect_equal(result$share_c, c(0.5, 0.4, 0.75, 0.2, 0.5, 0.4, 0.75, 0.2, 0.5, 0.4))

  # Class and geometry preserved
  testthat::expect_s3_class(result, "sf")
  testthat::expect_equal(sf::st_geometry(result), sf::st_geometry(synth_data))

})

# Test 2: function rejects invalid group counts (negative values)
testthat::test_that("invalid group counts are rejected", {

  # Copy data to modify it with negative values
  negative_data <- synth_data
  negative_data$group_a[1] <- -1

  # Expected error from the function: function should flag negative values when calculating shares
  testthat::expect_error(
    calculate_group_shares(negative_data),
    "non-negative"
  )

  # Copy data to modify it with missing values
  missing_data <- synth_data
  missing_data$group_a[1] <- NA

  # Expected error from the function: function should flag missing values when calculating shares
  testthat::expect_error(
    calculate_group_shares(missing_data),
    "missing"
  )

})
