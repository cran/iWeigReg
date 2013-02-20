\name{myinv}
\alias{myinv}

\title{Inverse of a matrix}
\description{This function returns the inverse or generalized inverse of a matrix.}

\usage{
myinv(A, type = "solve")
}

\arguments{
  \item{A}{A matrix to be inverted.}
  \item{type}{Type of matrix inversion, set to "solve" (default) or "ginv" (which can be used in the case of computational singularity).}
}

\value{
  The inverse of the given matrix \code{A}.
}
