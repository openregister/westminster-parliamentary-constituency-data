# Compare the legislation.gov.uk and mnis lists of constituencies.

# * mnis includes constitencies from other legislation for Scotland, Wales, and
#     Northern Ireland.
# * mnis uses the 2010-05-06 election date as the start of constituencies,
#   rather than the dissolution date 2010-04-12.
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

legislation <-
  read_tsv(here("lists", "legislation", "constituencies-2007.tsv")) %>%
  select(`westminster-parliamentary-constituency`, name)

both <- inner_join(mnis, legislation, by = "name")
mnis_only <- anti_join(mnis, legislation, by = "name")
legislation_only <- anti_join(legislation, mnis, by = "name")
