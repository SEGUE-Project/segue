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

# Tests:
# Make as many copies of the test block as you need
test_that("YOUR STATEMENT HERE", {
	# Some change
  # Another schange
})
