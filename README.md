
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ecce <img src="man/figures/logo.png" align="right" alt="" width="120" />

ecce offers some functions which translate English words into Chinese,
or translate Chinese words into English. You can see ecce in action at
<https://cxy.rbind.io/ecce/>: this is the output of ecce applied to the
latest version of ecce. Learn more in `vignette("ecce")` or
`?translate`.

## Installation

``` r
# Install development version from GitLab
remotes::install_git("https://gitlab.com/chuxinyuan/ecce.git")
```

## Usage

Get started with define a vector and pass it to the translate function.

``` r
x1 <- c("苹果", "香蕉", "梨子", "我爱你")
x2 <- c("apple", "banana", "pear", "I love you")

# Example-1
translate("苹果")
translate(x1)
translate("apple")
translate(x2)

# Example-2
translate_full("苹果")
translate_full(x1)
translate_full("apple")
translate_full(x2)

# Example-3
translate_view("苹果")
translate_view(x1)
translate_view("apple")
translate_view(x2)
```

## License

ecce is free and open source software, licensed under MIT + file
LICENSE.
