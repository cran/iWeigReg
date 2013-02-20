\name{ate.HT}
\alias{ate.HT}

\title{Horvitz-Thompson estimator for the causal-inference setup}
\description{This function implements the Horvitz-Thompson estimator of the mean outcome of the average treatment effect in causal inference.}

\usage{ate.HT(y, tr, p, X=NULL, bal=FALSE)}

\arguments{
  \item{y}{A vector or a matrix of observed outcomes.}
  \item{tr}{A vector of treatment indicators (=1 if treated or 0 if untreated).}
  \item{p}{A vector of known or fitted propensity scores.}
  \item{X}{The model matrix for the propensity score model, assumed to be logistic (set \code{X=NULL} if \code{p} is known or treated to be so).}
  \item{bal}{Logical; if \code{TRUE}, the function is used for checking balance (see the details).}
}

\value{
  \item{mu}{The estimated means for treatments 1 and 0 or, if \code{bal=TRUE}, their differences from the overall sample means.}
  \item{diff}{The estimated average treatment effect.}
  \item{v}{The estimated variances of \code{mu}.}
  \item{v.diff}{The estimated variance of \code{diff}.}
}

\details{
Variance estimation is based on asymptotic expansions, allowing for misspecification of the propensity score model.

For balance checking with \code{bal=TRUE}, the input \code{y} should correpond to the covariates for which balance is to be checked, and the output \code{mu} gives the differences between the Horvitz-Thompson estimates and the overall sample means for these covariates.
}

\references{
Tan, Z. (2006) "A distributional approach for causal inference using propensity scores," \emph{Journal of the American Statistical Association}, 101, 1619-1637.

Tan, Z. (2010) "Bounded, efficient and doubly robust estimation with inverse weighting,"
\emph{Biometrika}, 97, 661-682.
}

\examples{
data(KS.data)
attach(KS.data)
z=cbind(z1,z2,z3,z4)
x=cbind(x1,x2,x3,x4)

#logistic propensity score model, correct
ppi.glm <- glm(tr~z, family=binomial(link=logit))

X <- model.matrix(ppi.glm)
ppi.hat <- ppi.glm$fitted

#ppi.hat treated as known
out.HT <- ate.HT(y, tr, ppi.hat)
out.HT$diff
out.HT$v.diff

#ppi.hat treated as estimated
out.HT <- ate.HT(y, tr, ppi.hat, X)
out.HT$diff
out.HT$v.diff

#balance checking 
out.HT <- ate.HT(x, tr, ppi.hat, X, bal=TRUE)
out.HT$mu
out.HT$v

out.HT$mu/ sqrt(out.HT$v)   #t-statistic
}


\keyword{Causal inference}
