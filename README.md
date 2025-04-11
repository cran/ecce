
# ecce <img src="man/figures/logo.png" align="right" alt="" width="120" />

ecce offers some functions which translate English sentence into Chinese,
or translate Chinese sentence into English. Learn more in
`vignette("ecce")` or `help(package = "ecce")`. You can visit
<https://cxy.cc/rproj/ecce/> for the latest information.

## Installation

``` r
# Install development version via GitHub
remotes::install_github("chuxinyuan/ecce")
# Install from CRAN
install.packages("ecce")
```

## Configure the ID and PASSWORD for the Youdao API

To use the ecce package, user need to first register with the [Youdao
Wisdom Cloud AI open platform](https://ai.youdao.com/), and then open
the text translation application. Then put your Youdao API ID and
PASSWORD in the following code and run it once.

``` r
cat(
  '\n# ID and PASSWORD of Youdao Translation',
  'app_key = "Your Youdao API ID"',
  'app_secret = "Your Youdao API PASSWORD"',
  file = '~/.Renviron', sep = '\n', append = TRUE
)
```

## Usage

Get started with pass a Chinese or English sentence into the translation
function. In addition, also support obtain the pinyin of the Chinese 
character, so that you can more easily understand the pronunciation
of the Chinese character.

``` r
# Example-1
translate("我喜欢中国")

# Example-2
translate("I like China")

# Example-3
translate_view("我喜欢中国")

# Example-4
translate_view("I like China")

# Example-5
pinyin("时间序列模型")
```

## License

ecce is free and open source software, licensed under MIT + file
LICENSE.
