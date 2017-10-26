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
  rename(name = X1) %>%
  select(name) %>%
  filter(!str_detect(tolower(name), "^in "),
         !str_detect(tolower(name), "name and designation"),
         !str_detect(tolower(name), "the london borough"),
         name != toupper(name)) %>%
  mutate(name = str_replace_all(name, "\\r\\n", " "),
         name = str_replace_all(name, "\\r", " "),
         name = str_replace_all(name, " \\(county.*", ""),
         name = str_replace_all(name, " \\(borough.*", ""),
         `westminster-parliamentary-constituency` = row_number() + 100,
         `start-date` = "2010-04-12",
         `end-date` = NA) %>%
  arrange(name) %>%
  select(`westminster-parliamentary-constituency`, everything()) %>%
  write_tsv(here("lists", "legislation", "constituencies-2007.tsv"), na = "")

x2009 <- read_html("http://www.legislation.gov.uk/uksi/2009/698/schedule/made")

x2009 %>%
  html_table(header = FALSE) %>%
  bind_rows() %>%
  rename(name = X1) %>%
  select(name) %>%
  filter(!str_detect(tolower(name), "^in "),
         !str_detect(tolower(name), "name and designation"),
         !str_detect(tolower(name), "the london borough"),
         name != toupper(name)) %>%
  mutate(name = str_replace_all(name, "\\r\\n", " "),
         name = str_replace_all(name, "\\r", " "),
         name = str_replace_all(name, " \\(county.*", ""),
         name = str_replace_all(name, " \\(borough.*", ""),
         `westminster-parliamentary-constituency` = NA, # complete manually
         `start-date` = "2010-04-12",
         `end-date` = NA) %>%
  arrange(name) %>%
  select(`westminster-parliamentary-constituency`, everything()) %>%
  write_tsv(here("lists", "legislation", "constituencies-2009.tsv"), na = "")
