% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/translate_full.R
\name{translate_full}
\alias{translate_full}
\title{Translate words into English or Chinese with more information}
\usage{
translate_full(x)
}
\arguments{
\item{x}{A vector made up of English or Chinese words}
}
\value{
A list made up of Chinese or English words
}
\description{
When you pass in a vector consisting of an English or Chinese words,
this function will calls the Youdao translation open API for R to return the
corresponding type of Chinese or English representation. Compare to translate
function, this function can get more useful translation information.
}
\examples{

# Example-1
translate_full("apple")

# Example-2
x <- c("apple", "banana", "pear", "I love you")
translate_full(x)

}
