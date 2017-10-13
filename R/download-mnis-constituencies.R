# Download all the constituencies and related data from
# [MNIS](http://data.parliament.uk/membersdataplatform/default.aspx)

library(tidyverse)
library(mnis)
library(here)

write_tsv(ref_constituencies(), here("lists", "mnis-constituencies.tsv"))
write_tsv(ref_areas(), here("lists", "mnis-areas.tsv"))
write_tsv(ref_area_types(), here("lists", "mnis-area-types.tsv"))
write_tsv(ref_constituency_areas(), here("lists", "mnis-constituency-areas.tsv"))
write_tsv(ref_constituency_types(), here("lists", "mnis-constituency-types.tsv"))
