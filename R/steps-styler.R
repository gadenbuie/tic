#' @include steps-styler.R
StylePkg = R6Class(
  "StylePkg",
  inherit = TicStep,

  public = list(
    initialize = function(pkg = ".", ..., style = styler::tidyverse_style,
      transformers = style(...), filetype = "R",
      exclude_files = "R/RcppExports.R", include_roxygen_examples = TRUE) {

      private$style = style
      private$transformers = transformers
      private$filetype = filetype
      private$exclude_files = exclude_files
      private$include_roxygen_examples = include_roxygen_examples

      private$super$initialize()
    },

    run = function() {
      remotes::install_local(".")
      styler::style_pkg(
        style = private$style,
        transformers = private$transformers,
        filetype = filetype,
        exclude_files = exclude_files,
        include_roxygen_examples = include_roxygen_examples
        )
    },

    prepare = function() {
      verify_install(c("styler", "remotes"))
      super$prepare()
    }),

  private = list(
    ... = NULL,
    style = NULL,
    transformers = NULL,
    filetype = NULL,
    exclude_files = NULL,
    include_roxygen_examples = NULL
  )
)

#' Step: Style package using the `styler` package
#' Styles a R package using `styler::style_pkg()`
#'
#' @param ... Ignored, used to enforce naming of arguments.
#' @param pkg Path to package.
#' @param style A function that creates a style guide to use, by default
#'   `tidyverse_style()` (without the parentheses). Not used
#'   further except to construct the argument `transformers`. See
#'   `style_guides()` for details.
#' @param transformers A set of transformer functions. This argument is most
#'   conveniently constructed via the `style` argument and `...`. See
#'   'Examples'.
#' @param filetype Vector of file extensions indicating which file types should
#'   be styled. Case is ignored, and the `.` is optional, e.g. `c(".R", ".Rmd",
#'   ".Rnw")` or `c("r", "rmd", "rnw")`.
#' @param exclude_files Character vector with paths to files that should be
#'   excluded from styling.
#' @param include_roxygen_examples Whether or not to style code in roxygen
#'   examples.
#' @family steps
#' @export
step_style_pkg = function(...,
  pkg = ".", style = styler::tidyverse_style,
  transformers = style(...), filetype = "R",
  exclude_files = "R/RcppExports.R", include_roxygen_examples = TRUE) {

  StylePkg$new(
    style = style,
    transformers = transformers,
    filetype = filetype,
    exclude_files = exclude_files,
    include_roxygen_examples = include_roxygen_examples
  )
}
