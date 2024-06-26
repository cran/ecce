% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/translate_view.R
\name{translate_view}
\alias{translate_view}
\title{Open a Youdao website browse translation results}
\usage{
translate_view(input, from = "auto", to = "auto")
}
\arguments{
\item{input}{An English or Chinese sentence.}

\item{from}{The source language, an optional parameter.}

\item{to}{The target language, an optional parameter.}
}
\value{
Just open a website and do not return any results.
}
\description{
When you pass in an English or Chinese sentence, this function will Open
Youdao website browse translation results.
}
\examples{
\dontrun{
  translate_view("I like China")
  translate_view("quarto", from = "en", to = "zh-CHS")
}

}
