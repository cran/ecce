#' @title Open a Youdao website browse translation results
#'
#' @description
#' When you pass in a vector consisting of an English or Chinese words,
#' this function will Open Youdao website browse translation results.
#'
#' @param x A vector made up of English or Chinese words
#'
#' @return Not print any result but open a website
#'
#' @examples
#'
#' # Example-1
#' translate_view("apple")
#'
#' # Example-2
#' x <- c("apple", "banana", "pear", "I love you")
#' translate_view(x)
#'
#' @export

######################################################################################

# Open the website for the word or word

translate_view = function(x) {

  # Traverse every member of the x vector
  for (i in 1:length(x)) {

    # Replace the Spaces between words with "+"
    x[i] = gsub(
      pattern = " ",
      replacement = "+",
      x = x[i]
    )

    # Generate the url
    url = paste0(
      'http://dict.youdao.com/m/search?keyfrom=dict.mindex&vendor=&q=', x[i]
    )
    url = utils::URLencode(iconv(url, to = 'UTF-8'))

    # Open the website
    utils::browseURL(url)

  }

}

######################################################################################







