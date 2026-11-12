# Example tests:
# Test 1: the shares calculated by the calculate_group_shares are correct
testthat::test_that("group shares are calculated correctly", {

  result <- calculate_group_shares(synth_data)

  # Shares correctly calculated
  testthat::expect_equal(result$share_a, c(0.2, 0.2, 0, 0.6, 0.2, 0.2, 0, 0.6, 0.2, 0.2))
  testthat::expect_equal(result$share_b, c(0.3, 0.4, 0.25, 0.2, 0.3, 0.4, 0.25, 0.2, 0.3, 0.4))
  testthat::expect_equal(result$share_c, c(0.5, 0.4, 0.75, 0.2, 0.5, 0.4, 0.75, 0.2, 0.5, 0.4))

})

# Test 2: function rejects invalid group counts (negative and missing values)
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

# Test 3: Class and geometry in output preserved
testthat::test_that("class and geometry are preserved in output", {

  result <- calculate_group_shares(synth_data)

  # Class and geometry preserved
  testthat::expect_s3_class(result, "sf")
  testthat::expect_equal(sf::st_geometry(result), sf::st_geometry(synth_data))

})

# Make as many copies of the test block as you need
test_that("not so sure what to ask yet", {
  # Test to be added here
})
