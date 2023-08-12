#' @title Translate English words into Chinese, or translate Chinese words into English
#'
#' @description
#' When you pass in an English or Chinese word, this function will calls
#' the Youdao text translation API for R to return the corresponding type
#' of Chinese or English representation.
#'
#' @param input An English or Chinese word.
#'
#' @param from The source language, an optional parameter.
#'
#' @param to The target language, an optional parameter.
#'
#' @return A list consisting of Phonetic, explains, etc about target language.
#'
#' @examples
#'
#' # Example(Not run)
#' # translate("good")
#' # translate("quarto", from = "en", to = "zh-CHS")
#'
#' @export

#------------------------------------------------------------------------------#

translate = function(input, from = "auto", to = "auto") {

  # Check network connection
  test_internet = curl::has_internet()
  if (!test_internet) {
    stop('No network connection found...')
  }

  # Set Youdao API address
  api_url = "http://openapi.youdao.com/api"

  # Get the ID and PASSWORD for the Youdao API
  app_key = Sys.getenv("app_key")
  app_secret = Sys.getenv("app_secret")
  if (app_key == "" | app_secret == "") {
    stop('You need to provide the ID and PASSWORD of the Youdao API.')
  }

  # Set the rule for intercepting input characters
  input = input[1]
  truncate = function(input) {
    if (is.null(input)) {
      return(NULL)
    }
    size = nchar(input)
    if (size <= 20) {
      return(input)
    } else {
      truncated_input = paste0(
        substr(input, 1, 10), size,
        substr(input, size - 9, size)
      )
      return(truncated_input)
    }
  }
  q = truncate(input)

  # Set the source and target language
  from = from
  to = to

  # Set a unique universal identifier
  salt = as.character(uuid::UUIDgenerate())

  # Handle timestamp issues, it must be UTC time
  curtime = as.character(
    as.integer(
      as.POSIXct(Sys.time(), tz = "UTC")
    )
  )

  # Processing signature information
  # sha256(ID+input+salt+curtime+secret)
  sign = tolower(
    digest::digest(
      paste0(app_key, q, salt, curtime, app_secret),
      algo = "sha256",
      serialize = FALSE
    )
  )

  # Setting the Signature Type
  signType = "v3"

  # Generate parameter list
  params = list(
    q = q,
    from = from,
    to = to,
    appKey = app_key,
    salt = salt,
    sign = sign,
    signType = signType,
    curtime = curtime
  )

  # Obtain preliminary translation data
  response = httr::GET(url = api_url, query = params)
  translated_data = httr::content(response, "text")

  # The result of cleaning and processing
  json_data = jsonlite::fromJSON(translated_data)
  result = list(
    Query = json_data$query,
    Phonetic = json_data$basic$phonetic,
    WFS = json_data$basic$wfs,
    Explains = json_data$basic$explains
  )

  # Return to the result and gives the necessary prompts
  if (is.null(result$Explains)) {
    stop(
      paste(
      "Please check that the word are spelled correctly,",
       "if the spelling is really fine, then you can try",
       "explicitly giving the source language and target",
       "language parameter Settings by 'from' and 'to'.",
      sep = " "
      )
    )
  } else {
    return(result)
  }

}

#------------------------------------------------------------------------------#
