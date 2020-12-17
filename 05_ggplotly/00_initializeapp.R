# initialize app
library(tidyverse)

landings <- read.csv(here::here("05_ggplotly","data","nmfslandings.csv"))

ak <- landings %>% 
  filter(State == "ALASKA") %>%
  mutate_at(c("Pounds","Dollars"), parse_number)

