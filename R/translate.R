#' @title Translate English words into Chinese, or translate Chinese words into English
#'
#' @description
#' When you pass in a vector consisting of an English or Chinese words,
#' this function will calls the Youdao translation open API for R to return the
#' corresponding type of Chinese or English representation.
#'
#' @param x A vector made up of English or Chinese words
#'
#' @return A vector made up of Chinese or English words
#'
#' @examples
#'
#' # Example-1
#' translate("apple")
#'
#' # Example-2
#' x <- c("apple", "banana", "pear", "I love you")
#' translate(x)
#'
#' @export

######################################################################################

# The most basic translation function gives only one result at a time

translate = function(x) {

  # Support keyfrom and key
  keyfrom = "JustForTestYouDao"
  key = "498375134"

  # Define a container to store results in
  result = 1:length(x)

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
      "http://fanyi.youdao.com/openapi.do?",
      "keyfrom=", keyfrom,
      "&key=", key,
      "&type=data&doctype=json&version=1.2&q=",
      x[i]
    )

    # Get the data in the website and clean it
    url = utils::URLencode(iconv(url, to = 'UTF-8'))
    initial = RCurl::getURL(url)
    obj = rjson::fromJSON(initial)
    web = obj$web
    value = (web)[[1]]$value
    result[i] = value[1]

    }

  # Solve messy code problems that may exist in different environments
  if(stringr::str_detect(Sys.getlocale(), "936")) {
    result = iconv(result, "UTF-8", "gb2312")
  }

  # Return to the result
  return(result)

}

######################################################################################
