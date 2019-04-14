Stage <- R6Class(
  "Stage",

  public = list(
    initialize = function(name) {
      name <- NULL
      steps <- list()
    },

    steps = list(),
    name = NULL,

    add_step = function(step, code) {
      self$add_task(run = step$run, check = step$check, prepare = step$prepare,
        name = code)
    },

    add_task = function(run, check = NULL, prepare = NULL, name = NULL) {
      step <- list(
        run = run,
        check = check %||% function() TRUE,
        prepare = prepare %||% function() {},
        name = name %||% "<unknown task>"
      )
      self$steps <- c(self$steps, list(step))
      invisible(self)
    },

    reset = function() {
      steps <- list()
    },

    prepare_all = function() {
      lapply(steps, private$prepare_one)
      invisible()
    },

    run_all = function() {
      success <- TRUE
      for (step in self$steps) {
        if (!private$run_one(step)) {
          stopc('A step failed in stage "', name, '": ', name, '.')
        }
      }
    }
  ),

  private = list(

    prepare_one = function(step) {
      if (identical(body(step$prepare), body(TicStep$public_methods$prepare)))
        return()

      if (!isTRUE(step$check())) {
        ci_cat_with_color(
          crayon::magenta(paste0("Skipping prepare: ", step$name))
        )
        print(step$check)
        return()
      }

      ci_cat_with_color(
        crayon::magenta(paste0("Preparing: ", step$name))
      )
      step$prepare()

      invisible()
    },

    run_one = function(step) {
      if (!isTRUE(step$check())) {
        ci_cat_with_color(
          crayon::magenta(paste0("Skipping ", self$name, ": ", step$name))
        )
        print(step$check)
        return(TRUE)
      }

      ci_cat_with_color(
        crayon::magenta(paste0("Running ", self$name, ": ", step$name))
      )

      tryCatch(
        {
          withCallingHandlers(
            {
              step$run()
              TRUE
            },
            error = function(e) {
              ci_cat_with_color(crayon::red(paste0("Error: ", conditionMessage(e))))
              tb <- format_traceback()
              ci_cat_with_color(crayon::yellow(tb))
            }
          )
        },
        error = function(e) {
          FALSE
        }
      )
    }
  )
)
Stage <- R6Class(
  "Stage",

  public = list(
    initialize = function(name) {
      name <- NULL
      steps <- list()
    },

    steps = list(),
    name = NULL,

    add_step = function(step, code) {
      self$add_task(run = step$run, check = step$check, prepare = step$prepare,
        name = code)
    },

    add_task = function(run, check = NULL, prepare = NULL, name = NULL) {
      step <- list(
        run = run,
        check = check %||% function() TRUE,
        prepare = prepare %||% function() {},
        name = name %||% "<unknown task>"
      )
      self$steps <- c(self$steps, list(step))
      invisible(self)
    },

    reset = function() {
      steps <- list()
    },

    prepare_all = function() {
      lapply(steps, private$prepare_one)
      invisible()
    },

    run_all = function() {
      success <- TRUE
      for (step in self$steps) {
        if (!private$run_one(step)) {
          stopc('A step failed in stage "', name, '": ', name, '.')
        }
      }
    }
  ),

  private = list(

    prepare_one = function(step) {
      if (identical(body(step$prepare), body(TicStep$public_methods$prepare)))
        return()

      if (!isTRUE(step$check())) {
        ci_cat_with_color(
          crayon::magenta(paste0("Skipping prepare: ", step$name))
        )
        print(step$check)
        return()
      }

      ci_cat_with_color(
        crayon::magenta(paste0("Preparing: ", step$name))
      )
      step$prepare()

      invisible()
    },

    run_one = function(step) {
      if (!isTRUE(step$check())) {
        ci_cat_with_color(
          crayon::magenta(paste0("Skipping ", self$name, ": ", step$name))
        )
        print(step$check)
        return(TRUE)
      }

      ci_cat_with_color(
        crayon::magenta(paste0("Running ", self$name, ": ", step$name))
      )

      tryCatch(
        {
          withCallingHandlers(
            {
              step$run()
              TRUE
            },
            error = function(e) {
              ci_cat_with_color(crayon::red(paste0("Error: ", conditionMessage(e))))
              tb <- format_traceback()
              ci_cat_with_color(crayon::yellow(tb))
            }
          )
        },
        error = function(e) {
          FALSE
        }
      )
    }
  )
)
