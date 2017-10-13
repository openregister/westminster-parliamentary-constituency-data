# Web-scrape beta.parliament.uk, because I can't understand their API endpoints.
# The ontology is crazy complicated.

library(tidyverse)
library(rvest)
library(here)

html <-
  "https://beta.parliament.uk/constituencies" %>%
  read_html()

html_nodes(html, ".list--details") %>%

