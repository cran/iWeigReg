\name{mn.lik}
\alias{mn.lik}

\title{Non-calibrated likelihood estimator for the missing-data setup}
\description{This function implements the non-calibrated (or non-doubly robust) likelihood estimator of the mean outcome in the presence of missing data in Tan (2006), JASA.}

\usage{mn.lik(y, tr, p, g, X=NULL, evar=TRUE, inv="solve")}

\arguments{
  \item{y}{A vector of outcomes with missing data.}
  \item{tr}{A vector of non-missing indicators (=1 if \code{y} is observed or 0 if \code{y} is missing).}
  \item{p}{A vector of known or fitted propensity scores.}
  \item{g}{A matrix of calibration variables (see the details).}
  \item{X}{The model matrix for the propensity score model, assumed to be logistic (set \code{X=NULL} if \code{p} is known or treated to be so).}
  \item{evar}{Logical; if \code{FALSE}, no variance estimation.}
  \item{inv}{Type of matrix inversion, set to "solve" (default) or "ginv" (which can be used in the case of computational singularity).}
}

\value{
  \item{mu}{The estimated mean.}
  \item{v}{The estimated variance of \code{mu}, if \code{evar=TRUE}.}
  \item{w}{The vector of calibrated weights.}
  \item{lam}{The vector of lambda maximizing the log-likelihood.}
  \item{norm}{The maximum norm (i.e., \eqn{L_\infty} norm) of the gradient of the log-likelihood at \code{lam}.}
  \item{conv}{Convergence status from \emph{trust}.}
}

\details{
The columns of \code{g} correspond to calibration variables, which can be specified to include a constant and the fitted outcome regression function. See the examples below. In general, a calibration variable is a function of measured covariates selected to exploit the fact that its weighted mean among "responders" should equal to its unweighted population mean.

To estimate the propensity scores, a logistic regression model is assumed.
The model matrix \code{X} does not need to be provided and can be set to \code{NULL}, in which case the estimated propensity scores are treated as known in the estimation.
If the model matrix \code{X} is provided, then the "score," \code{(tr-p)X}, from the logistic regression is used to generate additional calibration constraints in the estimation. This may sometimes lead to unreliable estimates due to multicollinearity, as discussed in Tan (2006). Therefore, this option should be used with caution.

Variance estimation is based on asymptotic expansions in Tan (2013). Alternatively, resampling methods (e.g., bootstrap) can be used.
}

\references{
Tan, Z. (2006) "A distributional approach for causal inference using propensity scores," \emph{Journal of the American Statistical Association}, 101, 1619-1637.

Tan, Z. (2010) "Bounded, efficient and doubly robust estimation with inverse weighting,"
\emph{Biometrika}, 97, 661-682.

Tan, Z. (2013) "Variance estimation under misspecified models,"
unpublished manuscript, \url{http://www.stat.rutgers.edu/~ztan}.
}

\examples{
data(KS.data)
attach(KS.data)
z=cbind(z1,z2,z3,z4)
x=cbind(x1,x2,x3,x4)

#missing data
y[tr==0] <- 0

#logistic propensity score model, correct
ppi.glm <- glm(tr~z, family=binomial(link=logit))

X <- model.matrix(ppi.glm)
ppi.hat <- ppi.glm$fitted

#outcome regression model, misspecified
y.fam <- gaussian(link=identity)

eta1.glm <- glm(y ~ x, subset=tr==1, 
               family=y.fam, control=glm.control(maxit=1000))
eta1.hat <- predict.glm(eta1.glm, 
               newdata=data.frame(x=x), type="response")

#ppi.hat treated as known
out.lik <- mn.lik(y, tr, ppi.hat, g=cbind(1,eta1.hat))  
out.lik$mu
out.lik$v

#ppi.hat treated as estimated
out.lik <- mn.lik(y, tr, ppi.hat, g=cbind(1,eta1.hat), X)
out.lik$mu
out.lik$v
}


\keyword{Missing data}
