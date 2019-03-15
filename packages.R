library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(purrr)

packages <- read_csv("packages.csv")

packages <- packages %>%
  separate_rows(tags, sep = ",") %>%
  mutate(tags = str_trim(tags)) %>%
  nest(tags, .key = "tags") %>%
  mutate(tags = map(tags, "tags"))

saveRDS(packages, "packages.rds")
