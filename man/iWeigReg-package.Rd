\name{iWeigReg-package}
\alias{iWeigReg-package}
\alias{iWeigReg}
\docType{package}

\title{
A R package for improved methods for causal inference and missing data problems
}

\description{
Improved methods based on inverse probability weighting and outcome regression 
	     for causal inference and missing data problems.
}

\details{

The R package \code{iWeigReg} -- version 1.0 can be used for two main tasks:
\itemize{
\item to estimate the mean of an outcome in the presence of missing data,

\item to estimate the average treatment effect in causal inference.
}
There are 4 functions provided for the first task:
\itemize{
\item \code{mn.lik}: the non-calibrated (or non-doubly robust) likelihood estimator in Tan (2006),

\item \code{mn.clik}: the calibrated (or doubly robust) likelihood estimator in Tan (2010),

\item \code{mn.reg}: the non-calibrated (or non-doubly robust) regression estimator,

\item \code{mn.creg}: the calibrated (or doubly robust) regression estimator in Tan (2006).
}
In parallel, there are also 4 functions for the second task, \code{ate.lik}, \code{ate.clik}, \code{ate.reg}, and \code{ate.creg}. Currently, the treatment is assumed to be binary (i.e., untreated or treated). Extensions to multi-valued treatments will be incorporated in later versions.

In general, the function recommended to use is the calibrated (or doubly robust) likelihood estimator, \code{mn.clik} or \code{ate.clik}, which is a two-step procedure with the first step corresponding to the non-calibrated (or non-doubly robust) likelihood estimator. The calibrated (or doubly robust) regression estimator, \code{mn.creg} or \code{ate.creg}, is a close relative to the calibrated likelihood estimator, but may sometimes yield an estimate lying outside the sample range, for example, outside the unit interval (0,1) for estimating the mean of a binary outcome.

The package also provides two functions, \code{mn.HT} and \code{ate.HT}, for the Horvitz-Thompson estimator, i.e., the unaugmented inverse probability weighted estimator. These functions can be used for balance checking.

See the vignette for more details.
}

\keyword{iWeigReg}