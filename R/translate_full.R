#' @title Translate words into English or Chinese with more information
#' @description
#' When you pass in a vector consisting of an English or Chinese words,
#' this function will calls the Youdao translation open API for R to return the
#' corresponding type of Chinese or English representation. Compare to translate
#' function, this function can get more useful translation information.
#'
#' @param x A vector made up of English or Chinese words
#'
#' @return A list made up of Chinese or English words
#'
#' @examples
#'
#' # Example-1
#' translate_full("apple")
#'
#' # Example-2
#' x <- c("apple", "banana", "pear", "I love you")
#' translate_full(x)
#'
#' @export

######################################################################################

# Give relatively more translation information

translate_full = function(x) {

  # Support keyfrom and key
  keyfrom = "JustForTestYouDao"
  key = "498375134"

  # Define a container to store results in
  result = list()

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

    # Select some useful information output
    value = list(
      phonetic = ifelse(
        is.null(obj$basic$`us-phonetic`) == FALSE,
        obj$basic$`us-phonetic`,
        ifelse(
          is.null(obj$basic$`phonetic`) == FALSE,
          obj$basic$`phonetic`,
          "")
        ),
      explains = obj$basic$explains,
      web = obj$web[[1]]$value
      )

    result[[i]] = value

    }

  # Return to the result
  return(
    purrr::flatten(result)
  )

}

######################################################################################
