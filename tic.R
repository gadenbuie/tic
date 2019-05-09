get_stage("install") %>%
  add_step(step_install_github("ropensci/rotemplate"))

do_package_checks(error_on = if (getRversion() >= "3.2") "warning" else "error")

if (ci_has_env("BUILD_PKGDOWN")) {
  do_pkgdown()
}

get_stage("deploy") %>%
  add_code_step(styler::style_pkg()) %>%
  add_step(step_push_deploy())
