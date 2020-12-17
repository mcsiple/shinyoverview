# initialize app

# remotes::install_github("ewenme/ghibli")
library(tidyverse)

landings <- read.csv(here::here("05_ggplotly","data","nmfslandings.csv"))

crabs <- landings %>% 
  filter(Confidentiality == "Public") %>%
  #filter(str_detect(NMFS.Name, "CRAB")) %>%
  mutate_at(c("Pounds","Dollars"), parse_number)

