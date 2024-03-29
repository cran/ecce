
# ecce <img src="man/figures/logo.png" align="right" alt="" width="120" />

ecce offers some functions which translate English words into Chinese,
or translate Chinese words into English. Learn more in
`vignette("ecce")` or `help(package = "ecce")`. You can visit
<https://cxy.rbind.io/ecce/> for the latest information.

## Installation

``` r
# Install development version from GitLab
remotes::install_gitlab("chuxinyuan/ecce")
# Install from CRAN
install.packages("ecce")
```

## Provide the ID and PASSWORD for the Youdao API

To use the ecce package, users need to first register with the [Youdao
Wisdom Cloud AI open platform](https://ai.youdao.com/), and then open
the text translation application. Then put your Youdao API ID and
PASSWORD in the following code and run it once.

``` r
if (!file.exists("~/.Renviron")){
  file.create("~/.Renviron")
} 

file_path = "~/.Renviron"
file = file(file_path, open = "a")

comment = "# ID and PASSWORD of Youdao Translation"
writeLines(comment, file)

code_lines = c(
  "app_key = \"Your Youdao API ID\"",
  "app_secret = \"Your Youdao API PASSWORD\""
)

for (code in code_lines) {
  writeLines(code, file)
}

close(file)
```

## Usage

Get started with pass a Chinese or English word into the translation
function. In addition, also support obtain the pinyin of the Chinese 
character, so that you can more easily understand the pronunciation
of the Chinese character.

``` r
# Example-1
translate("中国")

# Example-2
translate("good")

# Example-3
translate_view("中国")

# Example-4
translate_view("good")

# Example-5
pinyin("模型")
```

## License

ecce is free and open source software, licensed under MIT + file
LICENSE.
