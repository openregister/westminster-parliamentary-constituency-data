# Scrape the constituencies from legislation.gov.uk

# Both the original and the amended order first affected the constitutionn of
# the House of Commons on its dissolution on the 12th of April 2010.

library(tidyverse)
library(rvest)
library(stringr)
library(here)

x2007 <- read_html("http://www.legislation.gov.uk/uksi/2007/1681/schedule/made")

x2007 %>%
  html_table(header = FALSE) %>%
  bind_rows() %>%
  select(1) %>%
  filter(!str_detect(tolower(X1), "^in "),
         !str_detect(tolower(X1), "name and designation"),
         X1 != toupper(X1)) %>%
  mutate(X1 = str_replace_all(X1, "\\r\\n", " "),
         X1 = str_replace_all(X1, "\\r", " "),
         X1 = str_replace_all(X1, " \\(.*", ""),
         `westminster-parliamentary-constituency` = row_number() + 100,
         `start-date` = "2010-04-12",
         `end-date` = NA) %>%
  rename(name = X1) %>%
  select(`westminster-parliamentary-constituency`, everything()) %>%
  write_tsv(here("lists", "legislation", "constituencies-2007.tsv"), na = "")

x2009 <- read_html("http://www.legislation.gov.uk/uksi/2009/698/schedule/made")

x2009 %>%
  html_table(header = FALSE) %>%
  bind_rows() %>%
  select(1) %>%
  filter(!str_detect(tolower(X1), "^in "),
         !str_detect(tolower(X1), "name and designation"),
         X1 != toupper(X1)) %>%
  mutate(X1 = str_replace_all(X1, "\\r\\n", " "),
         X1 = str_replace_all(X1, "\\r", " "),
         X1 = str_replace_all(X1, " \\(.*", ""),
         `westminster-parliamentary-constituency` = NA, # complete manually
         `start-date` = "2010-04-12",
         `end-date` = NA) %>%
  rename(name = X1) %>%
  select(`westminster-parliamentary-constituency`, everything()) %>%
  write_tsv(here("lists", "legislation", "constituencies-2009.tsv"), na = "")

