## ----eval = FALSE-------------------------------------------------------------
# # Install development version via GitHub
# remotes::install_github("chuxinyuan/ecce")
# # Install from CRAN
# install.packages("ecce")

## ----eval=FALSE---------------------------------------------------------------
# cat(
#   '\n# ID and PASSWORD of Youdao Translation',
#   'app_key = "Your Youdao API ID"',
#   'app_secret = "Your Youdao API PASSWORD"',
#   file = '~/.Renviron', sep = '\n', append = TRUE
# )

## ----eval = FALSE-------------------------------------------------------------
# # Example-1
# translate("我喜欢中国")
# 
# # Example-2
# translate("I like China")
# 
# # Example-3
# translate(
#   input = "quarto",
#   from = "en",
#   to = "zh-CHS"
# )

## ----eval = FALSE-------------------------------------------------------------
# # Example-4
# translate_view("我喜欢中国")
# 
# # Example-5
# translate_view("I like China")
# 
# # Example-6
# translate_view(
#   input = "quarto",
#   from = "en",
#   to = "zh-CHS"
# )

## ----eval = FALSE-------------------------------------------------------------
# # Example-7
# pinyin("时间序列模型")

