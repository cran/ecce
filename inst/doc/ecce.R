## ---- eval = FALSE------------------------------------------------------------
#  # Install development version from GitLab
#  remotes::install_git("https://gitlab.com/chuxinyuan/ecce.git")

## ---- eval = FALSE------------------------------------------------------------
#  # Example-1
#  x1 <- "苹果"
#  translate(x1)
#  
#  # Example-2
#  x2 <- "apple"
#  translate(x2)

## ---- eval = FALSE------------------------------------------------------------
#  # Example-3
#  x3 <- c("苹果", "香蕉", "梨子", "我爱你")
#  translate(x3)
#  
#  # Example-4
#  x4 <- c("apple", "banana", "pear", "I love you")
#  translate(x4)

## ---- eval = FALSE------------------------------------------------------------
#  # Example-5
#  x5 <- "苹果"
#  translate_full(x5)
#  
#  # Example-6
#  x6 <- "apple"
#  translate_full(x6)

## ---- eval = FALSE------------------------------------------------------------
#  # Example-7
#  x7 <- "苹果"
#  translate_view(x7)
#  
#  # Example-8
#  x8 <- "apple"
#  translate_view(x8)

## ----eval = FALSE-------------------------------------------------------------
#  library(dplyr)
#  love <- c("father", "mother", "I love U")
#  love %>%
#    translate() %>%
#    paste0(., collapse = "")

