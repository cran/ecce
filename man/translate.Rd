% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/translate.R
\name{translate}
\alias{translate}
\title{Translate English words into Chinese, or translate Chinese words into English}
\usage{
translate(x)
}
\arguments{
\item{x}{A vector made up of English or Chinese words}
}
\value{
A vector made up of Chinese or English words
}
\description{
When you pass in a vector consisting of an English or Chinese words,
this function will calls the Youdao translation open API for R to return the
corresponding type of Chinese or English representation.
}
\examples{

# Example-1
translate("apple")

# Example-2
x <- c("apple", "banana", "pear", "I love you")
translate(x)

}
