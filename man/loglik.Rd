\name{loglik}
\alias{loglik}

\title{The non-calibrated objective function ("log-likelihood")}
\description{This function computes the objective function, its gradient and its Hessian matrix for the non-calibrated likelihood estimator in Tan (2006), JASA.}

\usage{
loglik(lam, tr, h)
}

\arguments{
  \item{lam}{A vector of parameters ("lambda").}
  \item{tr}{A vector of non-missing or treatment indicators.}
  \item{h}{A constraint matrix.}
}

\value{
  \item{value}{The value of the objective function.}
  \item{gradient}{The gradient of the objective function.}
  \item{hessian}{The Hessian matrix of objective function.}
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
p <- ppi.glm$fitted

#outcome regression model, misspecified
y.fam <- gaussian(link=identity)

eta1.glm <- glm(y ~ x, subset=tr==1, 
               family=y.fam, control=glm.control(maxit=1000))
eta1.hat <- predict.glm(eta1.glm, 
               newdata=data.frame(x=x), type="response")

#
g1 <- cbind(1,eta1.hat)
h <- cbind(p, (1-p)*g1)

loglik(lam=rep(0,dim(h)[2]-1), tr=tr, h=h)
}
