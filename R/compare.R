# Compare the legislation.gov.uk and mnis lists of constituencies.

# * mnis does not include Scottish constituencies
# * mnis uses the 2010-05-06 election date as the start of constituencies in
#     England, rather than the dissolution date 2010-04-12.
# * mnis spells "Weston-Super-Mare" as "Weston-super-Mare", which is probably
#     correct.
# * mnis spells "Birmingham,Yardley" as "Birmingham, Yardley", which is probably
#     correct.

library(tidyverse)
library(lubridate)
library(here)

mnis <-
  read_tsv(here("lists", "mnis", "mnis-constituencies.tsv")) %>%
  filter(start_date == ymd("2010-05-06")) %>%
  select(constituency_id, name)

leg_eng <-
  read_tsv(here("lists", "legislation", "constituencies-eng-2007.tsv")) %>%
  select(`westminster-parliamentary-constituency`, name)

leg_sct <-
  read_tsv(here("lists", "legislation", "constituencies-sct-2005.tsv")) %>%
  select(`westminster-parliamentary-constituency`, name)

leg_wls <-
  read_tsv(here("lists", "legislation", "constituencies-wls-2006.tsv")) %>%
  select(`westminster-parliamentary-constituency`, name)

leg_nir <-
  read_tsv(here("lists", "legislation", "constituencies-nir-2008.tsv")) %>%
  select(`westminster-parliamentary-constituency`, name)

leg <- bind_rows(leg_eng, leg_wls, leg_nir)

both <- inner_join(mnis, leg, by = "name")
mnis_only <- anti_join(mnis, leg, by = "name")
legislation_only <- anti_join(leg, mnis, by = "name")
