\name{ate.clik}
\alias{ate.clik}

\title{Calibrated likelihood estimator for the causal-inference setup}
\description{This function implements the calibrated (or doubly robust) likelihood estimator of the average treatment effect in causal inference in Tan (2010), Biometrika.}

\usage{ate.clik(y, tr, p, g0,g1, X=NULL, evar=TRUE, inv="solve")}

\arguments{
  \item{y}{A vector of observed outcomes.}
  \item{tr}{A vector of treatment indicators (=1 if treated or 0 if untreated).}
  \item{p}{A vector of known or fitted propensity scores.}
  \item{g0}{A matrix of calibration variables for treatment 0 (see the details).}
  \item{g1}{A matrix of calibration variables for treatment 1 (see the details).}
  \item{X}{The model matrix for the propensity score model, assumed to be logistic (set \code{X=NULL} if \code{p} is known or treated to be so).}
  \item{evar}{Logical; if \code{FALSE}, no variance estimation.}
  \item{inv}{Type of matrix inversion, set to "solve" (default) or "ginv" (which can be used in the case of computational singularity).}
}

\value{
  \item{mu}{The estimated means for treatments 1 and 0.}
  \item{diff}{The estimated average treatment effect.}
  \item{v}{The estimated variances of \code{mu}, if \code{evar=TRUE}.}
  \item{v.diff}{The estimated variance of \code{diff}, if \code{evar=TRUE}.}
  \item{w}{A matrix of two columns, giving calibrated weights for treatments 1 and 0 respectively.}
  \item{lam}{A matrix of two columns, giving lambda maximizing the log-likelihood for treatments 1 and 0 respectively.}
  \item{norm}{A vector of two elements, giving the maximum norm (i.e., \eqn{L_\infty} norm) of the gradient of the log-likelihood at the maximum for treatments 1 and 0 respectively.}
  \item{conv}{A vector of two elements, giving convergence status from \emph{trust} for treatments 1 and 0 respectively.}
}

\details{
The two-step procedure in Tan (2010, Section 5.4) is used when dealing with estimated propensity scores. The first step corresponds to the non-calibrated (or non-doubly robust) likelihood estimator implemented in \code{\link{ate.lik}}.

The columns of \code{g0} (or respectively \code{g1}) correspond to calibration variables for treatment 0 (or treatment 1), which can be specified to include a constant and the fitted outcome regression function for treatment 0 (or treatment 1). See the examples below. In general, a calibration variable is a function of measured covariates selected to exploit the fact that its weighted treatment-specific mean should equal to its unweighted population mean.

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

eta0.glm <- glm(y ~ x, subset=tr==0, 
               family=y.fam, control=glm.control(maxit=1000))
eta0.hat <- predict.glm(eta0.glm, 
               newdata=data.frame(x=x), type="response")

#ppi.hat treated as known
out.lik <- ate.clik(y, tr, ppi.hat, 
                     g0=cbind(1,eta0.hat),g1=cbind(1,eta1.hat))
out.lik$diff
out.lik$v.diff

#ppi.hat treated as estimated (see the details)
out.lik <- ate.clik(y, tr, ppi.hat, 
                     g0=cbind(1,eta0.hat),g1=cbind(1,eta1.hat), X)
out.lik$diff
out.lik$v.diff
}


\keyword{Causal inference}
