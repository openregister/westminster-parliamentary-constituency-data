# Make data from the mnis lists.  This is meeting prep.  If we continue making
# the register, we should eventually derive the data from legislation.

library(tidyverse)

read_tsv(here("lists", "mnis", "mnis-constituencies.tsv")) %>%
  rename(`start-date` = start_date, `end-date` = end_date) %>%
  select(name, `start-date`, `end-date`) %>%
  distinct() %>%
  mutate(`westminster-parliamentary-constituency` = row_number() + 100,
         `start-date` = format(`start-date`, "%Y-%m-%d"),
         `end-date` = format(`end-date`, "%Y-%m-%d")) %>%
  group_by(name) %>%
  mutate(`westminster-parliamentary-constituency` = first(`westminster-parliamentary-constituency` )) %>%
  select(`westminster-parliamentary-constituency`, name, `start-date`, `end-date`) %>%
  write_tsv(here("data", "westminster-parliamentary-constituency.tsv"), na = "")
