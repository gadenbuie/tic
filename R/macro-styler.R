#' do_styler
#'
#' The [do_style_pkg()] macro adds the necessary steps for styling
#' a package via the [styler] package.
#'
#' @include macro.R
#' @name macro
NULL


#' Style R package
#'
#' @description
#' `do_style_pkg()` styles a R package using [styler::style_pkg()] package.
#'
#' @inheritParams step_setup_push_deploy
#' @inheritParams step_do_push_deploy
#' @param ... Passed on to [step_style_pkg()]
#' @family macros
#' @export
#' @examples
#' dsl_init()
#'
#' do_style_pkg()
#'
#' dsl_get()
do_style_pkg <- function(...,
  deploy = NULL,
  orphan = FALSE,
  checkout = TRUE,
  path = ".", branch = NULL,
  remote_url = NULL,
  commit_message = NULL, commit_paths = ".") {

  #' @param deploy `[flag]`\cr
  #'   If `TRUE`, deployment setup is performed before building the pkgdown site,
  #'   and the site is deployed after building it.
  #'   Set to `FALSE` to skip deployment.
  if (is.null(deploy)) {
    #'   By default (if `deploy` is `NULL`), deployment happens
    #'   if the following conditions are met:
    #'
    #'   1. The repo can be pushed to (see [ci_can_push()]).
    deploy <- ci_can_push()

    #'   2. The `branch` argument is `NULL`
    #'   (i.e., if the deployment happens to the active branch),
    #'   or the current branch is `master` (see [ci_get_branch()]).
    if (deploy && !is.null(branch)) {
      deploy <- (ci_get_branch() == "master")
    }
  }

  #' @description

  if (isTRUE(deploy)) {
    #' 1. [step_setup_ssh()] in the `"before_deploy"` to setup the upcoming deployment (if `deploy` is set),
    #' 1. [step_setup_push_deploy()] in the `"before_deploy"` stage (if `deploy` is set),
    get_stage("before_deploy") %>%
      add_step(step_setup_ssh()) %>%
      add_step(step_setup_push_deploy(
        path = !!enquo(path),
        branch = !!enquo(branch),
        remote_url = !!enquo(remote_url),
        orphan = !!enquo(orphan),
        checkout = !!enquo(checkout)
      ))
  }

  #' 1. [step_style_pkg()] in the `"deploy"` stage, forwarding all `...` arguments.
  get_stage("deploy") %>%
    add_step(step_style_pkg(!!!enquos(...)))

  #' 1. [step_do_push_deploy()] in the `"deploy"` stage.
  if (isTRUE(deploy)) {
    get_stage("deploy") %>%
      add_step(step_do_push_deploy(
        path = !!enquo(path),
        commit_message = !!enquo(commit_message),
        commit_paths = !!enquo(commit_paths)
      ))
  }
}
