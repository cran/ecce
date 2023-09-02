#' @title Open a Youdao website browse translation results
#'
#' @description
#' When you pass in an English or Chinese word, this function will Open
#' Youdao website browse translation results.
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
#' # translate_view("good")
#' # translate_view("quarto", from = "en", to = "zh-CHS")
#'
#' @export

#------------------------------------------------------------------------------#

translate_view = function(input, from = "auto", to = "auto") {

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

  # Process text to be translated
  q = input[1]

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

  # Set the rule for intercepting input characters
  truncate = function(x) {
    if (is.null(x)) {
      return(NULL)
    }
    size = nchar(x)
    if (size <= 20) {
      return(x)
    } else {
      truncated = paste0(
        substr(x, 1, 10), size,
        substr(input, size - 9, size)
      )
      return(truncated)
    }
  }

  # Processing signature information
  sign = tolower(
    digest::digest(
      paste0(app_key, truncate(q), salt, curtime, app_secret),
      algo = "sha256",
      serialize = FALSE
    )
  )

  # Setting the Signature Type
  sign_type = "v3"

  # Generate parameter list
  params = list(
    q = q,
    from = from,
    to = to,
    appKey = app_key,
    salt = salt,
    sign = sign,
    signType = sign_type,
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
    Explains = json_data$basic$explains,
    Url = json_data$mTerminalDict$url
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
    url = utils::URLencode(iconv(result$Url, to = "UTF-8"))
    utils::browseURL(result$Url)
  }

}

#------------------------------------------------------------------------------#
