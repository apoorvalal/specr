#' Summarise specification curve results
#'
#' This function allows to inspect results of the specification curves by returning a comparatively simple summary of the results. These results can be returned for specific analytical choices.
#'
#' @param df a data frame containing the choices and results of each specification (resulting from \code{run_specs}).
#' @param var which variable should be evaluated? Defaults to estimate (the effect sizes computed by \code{run_specs}). No need to use closures.
#' @param stats list object (\code{lst()}) of summary functions.
#' @param group a grouping factor (e.g., "subsets"). Several grouping variables can be passed. Defaults to NULL.

#'
#' @return
#' @export
#'
#' @examples
#' # Run specification curve analysis
#' results <- run_specs(df = example_data,
#'                      y = c("y1", "y2"),
#'                      x = c("x1", "x2"),
#'                      model = c("lm"),
#'                      controls = c("c1", "c2"),
#'                      subsets = list(group1 = unique(example_data$group1),
#'                                     group2 = unique(example_data$group2)))
#'
#' # Basic example
#' summarise_specs(results)
#'
#' # Summary of specific analytical choices
#' print(summarise_specs(results, group = c("subsets", "x")), n = 24)
#'
#' # Summare of other estimates
#' summarise_specs(results, var = "p.value", group = "controls")
summarise_specs <- function(df,
                            var = estimate,
                            stats = lst(median, mad, min, max,
                                        q25 = function(x) quantile(x, prob = .25),
                                        q75 = function(x) quantile(x, prob = .75)),
                            group = NULL) {

  require(dplyr, quietly = TRUE)

  summary_specs <- function(df) {
    var <- enquo(var)
    df %>%
      summarize_at(vars(!!var), stats)
  }

  if (rlang::is_null(group)) {
     bind_cols(
       df %>%
         summary_specs,
       df %>%
         summarize(obs = median(obs))
     )
  } else {
    group <- lapply(group, as.symbol)
    suppressWarnings(
    suppressMessages(
    left_join(
      df %>%
        group_by_(.dots = group) %>%
        summary_specs,
      df %>%
        group_by_(.dots = group) %>%
        summarize(obs = median(obs))
    )))
  }
}
