#' @title Obtain and label Chinese pinyin
#'
#' @description
#' When you pass in a Chinese character, you can obtain the pinyin of the
#' Chinese character, so that you can more easily understand the pronunciation
#' of the Chinese character.
#'
#' @param input A string consisting of Chinese character or sentences.
#'
#' @return A string consisting of pinyin and input Chinese character.
#'
#' @examples
#' \dontrun{
#'   pinyin("type Chinese character")
#' }
#'
#' @export

#------------------------------------------------------------------------------#

pinyin = function(input) {

  q = input

  # Check network connection
  test_internet = curl::has_internet()
  if (!test_internet) {
    stop('No network connection found...')
  }

  # Set Youdao pinyin upload API address
  youdao_url_upload = 'https://openapi.youdao.com/getPinYin'

  # Get the ID and PASSWORD for the Youdao API
  app_key = Sys.getenv("app_key")
  app_secret = Sys.getenv("app_secret")
  if (app_key == "" | app_secret == "") {
    stop('You need to provide the ID and PASSWORD of the Youdao API.')
  }

  # Set a unique universal identifier
  salt = as.character(uuid::UUIDgenerate())

  # Handle timestamp issues, it must be UTC time
  curtime = as.character(
    as.integer(
      as.POSIXct(Sys.time(), tz = "UTC")
    )
  )

  # Set the rule for input characters
  truncate = function(x) {
    if (is.null(x)) {
      return(NULL)
    }
    x = iconv(x, to = 'UTF-8')
    size = nchar(x)
    if (size <= 20) {
      return(x)
    } else {
      truncated = paste0(
        substr(x, 1, 10),
        size,
        substr(x, size - 9, size)
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

  # Setting the signature type
  sign_type = "v3"

  # Generate parameter list
  params = list(
    q = q,
    appKey = app_key,
    salt = salt,
    sign = sign,
    signType = sign_type,
    curtime = curtime
  )

  response = httr::POST(
    url = youdao_url_upload,
    body = params,
    encode = "form"
  )

  convert_data = httr::content(
    response, "text", encoding = "UTF-8"
  )
  json_data = jsonlite::fromJSON(convert_data)

  # Separate pinyin and tone
  split_pinyin = strsplit(json_data$data$data$pinyins, ":")

  # Extract pinyin part
  input_info = sapply(split_pinyin, function(x) x[1])
  pinyin_info = sapply(split_pinyin, function(x) x[2])

  df = data.frame(
    ym = c("a", "e", "i", "o", "u", "_"),
    tones = c(
      "\u0101\u00e1\u01ce\u00e0a",
      "\u0113\u00e9\u011b\u00e8e",
      "\u012b\u00ed\u01d0\u00eci",
      "\u014d\u00f3\u01d2\u00f2o",
      "\u016b\u00fa\u01d4\u00f9u",
      "_"
    )
  )

  info = data.frame(
    input_info = input_info,
    pinyin_info = pinyin_info
  )

  info$letter = gsub("[0-9]", "", info$pinyin_info)
  info$num = gsub("[^0-9]", "", info$pinyin_info)
  info$aux = ifelse(
    info$pinyin_info == "_", "_",
    gsub("[^aeiou]", "", info$pinyin_info)
  )
  info$ym = substr(
    info$aux,
    nchar(info$aux),
    nchar(info$aux)
  )

  info$id = 1:nrow(info)
  info = merge(info, df, by = "ym")
  info = info[order(info$id), ]

  info$tone = ifelse(
    info$pinyin_info == "_", "_",
    substr(info$tones, info$num, info$num)
  )

  info$pinyin = character(
    length = nrow(info)
  )

  for (i in 1:nrow(info)) {
    info$pinyin[i] = gsub(
      info$ym[i],
      info$tone[i],
      info$letter[i]
    )
  }

  words = paste(info$input_info, collapse = "  ")
  pinyin = paste(info$pinyin, collapse = " ")

  cat(pinyin, "\n", words)

}

#------------------------------------------------------------------------------#
