library(tidyverse)
library(ggplot2)

## Q-Q Plot Quick Tutorial

raw_data <- c(20, 23,  7, 1, 15, 29, 24, 13, 19, 12, 32, 6, 11, 18)

## Method 1: Manually calculated the standard normal quantiles
sorted_data <- sort(raw_data)
df <- tibble(data=sorted_data) %>% mutate(
    plotting_position = row_number() / (nrow(df)+1),
    std_norm_quantile = qnorm(plotting_position)
)

df

df %>% ggplot(aes(x = std_norm_quantile, y = data)) +
    geom_smooth(method = "lm", se = FALSE) + 
    geom_point() +
    xlab("Theoretical Standard Normal Quantiles") +
    ylab("Observed Data")

## Method 2: Just use the functions in ggplot2

df %>% ggplot(aes(sample = data)) +
    stat_qq() +
    stat_qq_line(colour = "blue")
