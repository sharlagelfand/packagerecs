library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(purrr)

packages <- read_csv("data-raw/packages.csv")

packages <- packages %>%
  separate_rows(tags, sep = ",") %>%
  mutate(tags = str_trim(tags)) %>%
  nest(tags, .key = "tags") %>%
  mutate(tags = map(tags, "tags"))

usethis::use_data(packages, overwrite = TRUE)
