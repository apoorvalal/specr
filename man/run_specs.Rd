% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_specs.r
\name{run_specs}
\alias{run_specs}
\title{Run specification curve analysis}
\usage{
run_specs(df, y, x, model, controls = NULL, subsets = NULL,
  conf.level = 0.95, keep.results = FALSE)
}
\arguments{
\item{df}{a data frame that includes all relevant variables}

\item{y}{a vector of the dependent variables}

\item{x}{a vector of the dependent variables}

\item{model}{a vector of the type of models that should be estimated.}

\item{controls}{a vector of the control variables that should be included. Defaults to none.}

\item{subsets}{a list that includes named vectors}

\item{conf.level}{the confidence level to use for the confidence interval. Must be strictly greater than 0 and less than 1. Defaults to 0.95, which corresponds to a 95 percent confidence interval.}

\item{keep.results}{a logical value indicating whether the complete model object should be kept.}
}
\description{
This is the central function of the package. It can be used to run the specification curve analyses. It takes the data frame and vectors for analytical choices related to the dependent variable, the independent variable, the type of models that should be estimated, the set of covariates that should be included (none, each individually, and all together), as well as a named list of potential subsets. It returns a "result frame" which includes relevant statistics for each model as well as the analytical choices as factorial variables.
}
\examples{
# run specification curve analysis
results <- run_specs(df = example_data,
                     y = c("y1", "y2"),
                     x = c("x1", "x2"),
                     model = c("lm"),
                     controls = c("c1", "c2"),
                     subsets = list(group1 = unique(example_data$group1),
                                    group2 = unique(example_data$group2)))

# Check results frame
results
}
