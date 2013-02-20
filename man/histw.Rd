\name{histw}
\alias{histw}

\title{Weighted histogram}
\description{This function plots a weighted histogram.}

\usage{histw(x, w, xaxis, xmin, xmax, ymax, 
          bar=TRUE, add=FALSE, col="black", dens=TRUE)}

\arguments{
  \item{x}{A data vector.}
  \item{w}{A weight vector, which will be rescaled to sum up to one.}

  \item{xaxis}{A vector of cut points.}
  \item{xmin}{The minimum of \code{x} coordinate.}
  \item{xmax}{The maximum of \code{x} coordinate.}
  \item{ymax}{The maximum of \code{y} coordinate.}

  \item{bar}{bar plot (if \code{TRUE}) or line plot.}
  \item{add}{if \code{TRUE}, the plot is added to an existing plot.}
  \item{col}{color of lines.}
  \item{dens}{if \code{TRUE}, the histogram has a total area of one.}
}

\references{
Tan, Z. (2006) "A distributional approach for causal inference using propensity scores," \emph{Journal of the American Statistical Association}, 101, 1619-1637.
}

\examples{
data(KS.data)
attach(KS.data)
z=cbind(z1,z2,z3,z4)
x=cbind(x1,x2,x3,x4)

#logistic propensity score model, misspecified
ppi.glm <- glm(tr~x, family=binomial(link=logit))

ppi.hat <- ppi.glm$fitted

#outcome regression model, correct
y.fam <- gaussian(link=identity)

eta1.glm <- glm(y ~ z, subset=tr==1, 
               family=y.fam, control=glm.control(maxit=1000))
eta1.hat <- predict.glm(eta1.glm, 
               newdata=data.frame(x=x), type="response")

eta0.glm <- glm(y ~ z, subset=tr==0, 
               family=y.fam, control=glm.control(maxit=1000))
eta0.hat <- predict.glm(eta0.glm, 
               newdata=data.frame(x=x), type="response")

#causal inference
out.clik <- ate.clik(y, tr, ppi.hat, 
               g0=cbind(1,eta0.hat),g1=cbind(1,eta1.hat))

#balance checking
gp1 <- tr==1
gp0 <- tr==0

par(mfrow=c(2,3))
look <- z1

histw(look[gp1], rep(1,sum(gp1)), xaxis=seq(-3.5,3.5,.25),
    xmin=-3.5, xmax=3.5, ymax=.8)
histw(look[gp0], rep(1,sum(gp0)), xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8, bar=0, add=TRUE, col="red")

histw(look[gp1], 1/ppi.hat[gp1], xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8)
histw(look[gp0], 1/(1-ppi.hat[gp0]), xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8, bar=0, add=TRUE, col="red")

histw(look[gp1], 1/out.clik$w[gp1,1], xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8)
histw(look[gp0], 1/out.clik$w[gp0,2], xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8, bar=0, add=TRUE, col="red")

look <- z2

histw(look[gp1], rep(1,sum(gp1)), xaxis=seq(-3.5,3.5,.25),
    xmin=-3.5, xmax=3.5, ymax=.8)
histw(look[gp0], rep(1,sum(gp0)), xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8, bar=0, add=TRUE, col="red")

histw(look[gp1], 1/ppi.hat[gp1], xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8)
histw(look[gp0], 1/(1-ppi.hat[gp0]), xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8, bar=0, add=TRUE, col="red")

histw(look[gp1], 1/out.clik$w[gp1,1], xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8)
histw(look[gp0], 1/out.clik$w[gp0,2], xaxis=seq(-3.5,3.5,.25), 
    xmin=-3.5, xmax=3.5, ymax=.8, bar=0, add=TRUE, col="red")
}


\keyword{Missing data}
\keyword{Causal inference}
