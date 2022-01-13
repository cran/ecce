context("test translate")

test_that("tanslate Chinese words into English, or English words into Chinese", {

  x <- c("apple", "banana", "pear", "I love you")

  # Example-1
  translate("apple")
  translate(x)

  # Example-2
  translate_full("apple")
  translate_full(x)

  # Example-3
  translate_view("apple")
  translate_view(x)

})
