## ---- eval = FALSE------------------------------------------------------------
#  # Install development version from GitLab
#  remotes::install_git("https://gitlab.com/chuxinyuan/ecce.git")
#  # Install from CRAN
#  install.packages("ecce")

## ---- eval=FALSE--------------------------------------------------------------
#  if (!file.exists("~/.Renviron")){
#    file.create("~/.Renviron")
#  }
#  
#  file_path = "~/.Renviron"
#  file = file(file_path, open = "a")
#  
#  comment = "# ID and PASSWORD of Youdao Translation"
#  writeLines(comment, file)
#  
#  code_lines = c(
#    "app_key = \"Your Youdao API ID\"",
#    "app_secret = \"Your Youdao API PASSWORD\""
#  )
#  
#  for (code in code_lines) {
#    writeLines(code, file)
#  }
#  
#  close(file)

## ---- eval = FALSE------------------------------------------------------------
#  # Example-1
#  translate("中国")
#  
#  # Example-2
#  translate("good")
#  
#  # Example-3
#  translate(
#    input = "quarto",
#    from = "en",
#    to = "zh-CHS"
#  )

## ---- eval = FALSE------------------------------------------------------------
#  # Example-4
#  translate_view("中国")
#  
#  # Example-5
#  translate_view("good")
#  
#  # Example-6
#  translate_view(
#    input = "quarto",
#    from = "en",
#    to = "zh-CHS"
#  )

