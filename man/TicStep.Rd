% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/steps-base.R
\name{TicStep}
\alias{TicStep}
\title{The base class for all steps}
\description{
Override this class to create a new step.
}
\section{Methods}{

\describe{
\item{\code{run}}{
This method must be overridden, it is called when running the stage
to which a step has been added.
}
\item{\code{prepare}}{ This method is called when preparing the stage to
which a step has been added. It auto-install all packages which are
needed for a certain step. For example, \code{step_build_pkgdown()} requires
the \emph{pkgdown} package.

For \code{add_code_step()}, it autodetects any package calls in the form of
\code{pkg::fun} and tries to install these packages from CRAN. If a steps
\code{prepare_call} is not empty, the \verb{$prepare} method is skipped for this
step. This can be useful if a package should be installed from
non-standard repositories, e.g. from Github. }
\item{\code{check}}{
This method determines if a step is prepared and run.
Return \code{FALSE} if conditions for running this step are not met.
}
}
}

\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{TicStep$new()}}
\item \href{#method-run}{\code{TicStep$run()}}
\item \href{#method-prepare}{\code{TicStep$prepare()}}
\item \href{#method-check}{\code{TicStep$check()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{TicStep$new()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-run"></a>}}
\subsection{Method \code{run()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{TicStep$run()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-prepare"></a>}}
\subsection{Method \code{prepare()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{TicStep$prepare()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-check"></a>}}
\subsection{Method \code{check()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{TicStep$check()}\if{html}{\out{</div>}}
}

}
}
