# Scrape the constituencies from legislation.gov.uk

# Both the original and the amended order first affected the constitutionn of
# the House of Commons on its dissolution on the 12th of April 2010.

library(tidyverse)
library(rvest)
library(stringr)
library(here)

eng2007 <- read_html("http://www.legislation.gov.uk/uksi/2007/1681/schedule/made")

eng2007 %>%
  html_table(header = FALSE) %>%
  bind_rows() %>%
  rename(name = X1) %>%
  select(name) %>%
  filter(!str_detect(tolower(name), "^in "),
         !str_detect(tolower(name), "name and designation"),
         !str_detect(tolower(name), "the london borough"),
         name != toupper(name)) %>%
  arrange(name) %>%
  mutate(name = str_replace_all(name, "\\r\\n", " "),
         name = str_replace_all(name, "\\r", " "),
         name = str_replace_all(name, " \\(county.*", ""),
         name = str_replace_all(name, " \\(borough.*", ""),
         `westminster-parliamentary-constituency` = row_number() + 100,
         `start-date` = "2010-04-12",
         `end-date` = NA) %>%
  select(`westminster-parliamentary-constituency`, everything()) %>%
  write_tsv(here("lists", "legislation", "constituencies-eng-2007.tsv"), na = "")

eng2009 <- read_html("http://www.legislation.gov.uk/uksi/2009/698/schedule/made")

eng2009 %>%
  html_table(header = FALSE) %>%
  bind_rows() %>%
  rename(name = X1) %>%
  select(name) %>%
  filter(!str_detect(tolower(name), "^in "),
         !str_detect(tolower(name), "name and designation"),
         !str_detect(tolower(name), "the london borough"),
         name != toupper(name)) %>%
  arrange(name) %>%
  mutate(name = str_replace_all(name, "\\r\\n", " "),
         name = str_replace_all(name, "\\r", " "),
         name = str_replace_all(name, " \\(county.*", ""),
         name = str_replace_all(name, " \\(borough.*", ""),
         `westminster-parliamentary-constituency` = NA, # complete manually
         `start-date` = "2010-04-12",
         `end-date` = NA) %>%
  select(`westminster-parliamentary-constituency`, everything()) %>%
  write_tsv(here("lists", "legislation", "constituencies-eng-2009.tsv"), na = "")

sct2005 <- read_html("http://www.legislation.gov.uk/uksi/2005/250/schedule/made")

sct2005 %>%
  html_table(header = FALSE) %>%
  purrr::pluck(1) %>%
  rename(name = X1) %>%
  select(name) %>%
  filter(!str_detect(tolower(name), "name and designation")) %>%
  mutate(name = str_replace(name, " Burgh Constituency$", ""),
         name = str_replace(name, " County Constituency$", ""),
         `westminster-parliamentary-constituency` = row_number() + 700,
         `start-date` = "2005-05-05",
         `end-date` = NA) %>%
  arrange(name) %>%
  select(`westminster-parliamentary-constituency`, everything()) %>%
  write_tsv(here("lists", "legislation", "constituencies-sct-2005.tsv"), na = "")

nir2008 <- read_html("http://www.legislation.gov.uk/uksi/2008/1486/schedule/made")

nir2008 %>%
  html_table(header = FALSE) %>%
  purrr::pluck(1) %>%
  rename(name = X1) %>%
  select(name) %>%
  filter(!str_detect(tolower(name), "name and designation")) %>%
  mutate(name = str_replace(name, " \\(.*", ""),
         `westminster-parliamentary-constituency` = row_number() + 800,
         `start-date` = "2010-04-12",
         `end-date` = NA) %>%
  arrange(name) %>%
  select(`westminster-parliamentary-constituency`, everything()) %>%
  write_tsv(here("lists", "legislation", "constituencies-nir-2008.tsv"), na = "")

wls2006 <- read_html("http://www.legislation.gov.uk/uksi/2006/1041/schedule/1/made")

wls2006 %>%
  html_table(header = FALSE) %>%
  bind_rows() %>%
  rename(name = X1) %>%
  select(name) %>%
  filter(!str_detect(tolower(name), "name and designation"),
         !str_detect(tolower(name), "^in ")) %>%
  mutate(name = str_replace(name, " County Constituency", ""),
         name = str_replace(name, " County Constitutency", ""),
         name = str_replace(name, " Borough Constituency", ""),
         `westminster-parliamentary-constituency` = row_number() + 900,
         `start-date` = "2010-04-12",
         `end-date` = NA) %>%
  arrange(name) %>%
  select(`westminster-parliamentary-constituency`, everything()) %>%
  write_tsv(here("lists", "legislation", "constituencies-wls-2006.tsv"), na = "")
