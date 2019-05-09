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

#' Step: Style package using the [styler] package
#'
#' Styles a R package using `styler::style_pkg()`
#'
#' @inheritDotParams styler::style_pkg
#' @family steps
#' @export
step_style_pkg = function(...) {
  StylePkg$new(...)
}
