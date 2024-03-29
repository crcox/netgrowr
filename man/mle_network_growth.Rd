% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mle-network-growth.R
\name{mle_network_growth}
\alias{mle_network_growth}
\title{Fit model of network growth using Maximum Likelihood Estimation (MLE)}
\usage{
mle_network_growth(formula, data, split_by, label_with, B0 = NULL)
}
\arguments{
\item{formula}{A formula; see details}

\item{data}{A data frame containing, at least, the variables implied by the
formula.}

\item{split_by}{A string referencing a variable in \code{data} that encodes
time steps; see details.}

\item{label_with}{A string referencing a variable in \code{data} that
provides node-labels. Labels may repeat across time steps specified by
\code{split_by}.}

\item{B0}{An initial estimate of the model parameters. If \code{NULL}, an
initial model will be estimated through a brute force optimization.
[default: NULL]}

\item{beta}{A vector of weights (i.e, the model), or a matrix where each
column is a different model.}
}
\value{
A list as of class \code{mle_network_growth} with the following fields:
\item{coefficients}{Best fit model parameters}
\item{negLogLik}{The model negative log-likelihood.}
\item{fitted.values}{A vector of estimated probabilities for each node acquired over all timepoints.}
\item{nobs}{The number of fitted values}
\item{call}{The function call that generated the model}
\item{model}{The model frame referenced when fitting the model.}
\item{deviance}{The likelihood ratio between a fully saturated model and the current model}
\item{counts}{A two-element integer vector giving the number of calls to objective function and gradient function respectively. This excludes those calls needed to compute the Hessian, if requested, and any calls to the objective function to compute a finite-difference approximation to the gradient. This is returned by \code{\link[stats]{optim}}.}
\item{convergence}{An integer code:
    \describe{
        \item{0}{successful completion (which is always the case for "SANN" and "Brent").}
        \item{1}{indicates that the iteration limit maxit had been reached.}
        \item{10}{indicates degeneracy of the Nelder–Mead simplex.}
        \item{51}{indicates a warning from the "L-BFGS-B" method; see component message for further details.}
        \item{52}{indicates an error from the "L-BFGS-B" method; see component message for further details.}
    }
}
\item{message}{A character string giving any additional information returned by the optimizer, or NULL.}
\item{hessian}{Only included if argument \code{hessian} is true. A symmetric matrix giving an estimate of the Hessian at the solution found. Note that this is the Hessian of the unconstrained problem even if the box constraints are active.}
}
\description{
Objective is to maximize the predicted probability of nodes being added to
the network at the point in time when they are known to have been acquired.
}
\details{
The formula must reference a variable that encodes the time-point at which
each node is acquired as the dependent variable. If \code{data}
contains the data for multiple time steps, then this value should probably be
the same for all points in time at which the node is referenced (although the
function does not enforce this). The independent variables specify the set of
variables that will be used to predict, at each point in time, whether the
node is acquired or not.

The \code{split_by} variable is used to split \code{data} by time-step, so
that probabilities can be estimated independently at discrete points in time.
The assumption is that a node will be acquired once, at a single point in
time.

The function will return a vector if a beta was a vector or one-column
matrix. Otherwise, the return value will be a matrix, with a row for each
node and a column for each model specified by \code{beta}. Regardless, the
returned values are probabilities for nodes that are acquired, as predicted
at the point in time the node was acquired. Probabilities are computed as a
ratio of strengths.
}
\seealso{
\code{\link[netgrowr]{probability_node_added}}, \code{\link[netgrowr]{ratio_of_strengths}}
}
