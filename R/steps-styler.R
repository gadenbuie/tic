#' @include steps-rcmdcheck.R
StylePkg = R6Class(
  "StylePkg",
  inherit = TicStep,

  public = list(
    initialize = function(...) {
      private$styler_args = list(...)
      super$initialize()
    },

    run = function() {
      remotes::install_local(".")
      do.call(styler::style_pkg, c(list(preview = FALSE), private$styler_args))
    },

    prepare = function() {
      verify_install(c("styler", "remotes"))
      super$prepare()
    }),

  private = list(
    styler_args = NULL
  )
)

#' Step: Build pkgdown documentation
#'
#' Builds package documentation with the \pkg{pkgdown} package.
#'
#' @inheritDotParams styler::style_pkg
#' @family steps
#' @export
step_style_pkg = function(...) {
  StylePkg$new(...)
}
