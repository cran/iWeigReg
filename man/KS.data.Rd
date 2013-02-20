\name{KS.data}
\docType{data}
\alias{KS.data}

\title{A simulated dataset}
\description{A dataset simulated as in Kang and Schafer (2007).}

\usage{data(KS.data)}

\format{A data frame containing 1000 rows and 10 columns.}

\details{ 
The dataset is generated as follows.
\preformatted{
set.seed(0)

n <- 1000

z <- matrix(rnorm(4*n, 0, 1), nrow=n)

ppi.tr <- as.vector( 1/(1+exp(-z\%*\%c(-1,.5,-.25,-.1))) )
tr <- rbinom(n, 1, ppi.tr)

y.mean <- as.vector( 210+z%*%c(27.4, 13.7, 13.7, 13.7) )
y <- y.mean+rnorm(n, 0, 1)

x <- cbind(exp(z[,1]/2), z[,2]/(1+exp(z[,1]))+10, 
          (z[,1]*z[,3]/25+.6)^3, (z[,2]+z[,4]+20)^2)
x <- t(t(x)/c(1,1,1,400)-c(0,10,0,0))

KS.data <- data.frame(y,tr,z,x)
colnames(KS.data) <- 
   c("y", "tr", "z1", "z2", "z3", "z4", "x1", "x2", "x3", "x4")

save(KS.data, file="KS.data.rda")
} }

\references{

Kang, J.D.Y. and Schafer, J.L. (2007) "Demystifying double robustness: A comparison of alternative strategies for estimating a population mean from incomplete data," \emph{Statistical Science}, 22, 523-539.
}

\keyword{datasets}
