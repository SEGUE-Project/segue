calculate_group_shares <- function(data) {

  counts <- sf::st_drop_geometry(data)[
    c("group_a", "group_b", "group_c")
  ]

  # Expected errors
  if (anyNA(counts) | any(as.matrix(counts) < 0)) {
    stop(
      "Group counts must be non-missing and non-negative.",
      call. = FALSE
    )
  }

  total <- rowSums(counts)

  data$share_a <- data$group_a / total
  data$share_b <- data$group_b / total
  data$share_c <- data$group_c / total

  data
}
