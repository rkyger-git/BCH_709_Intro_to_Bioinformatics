#Introducing dplyr and tidyr
library(tidyverse)
interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")
interviews

select(interviews, village, no_membrs, years_liv)

filter(interviews, village == "God")

interviews %>%
  filter(village == "God") %>%
  select(no_membrs, years_liv)

interviews_god <- interviews %>%
  filter(village == "God") %>%
  select(no_membrs, years_liv)

interviews_god

#Exercise 1
interviews %>% 
  filter(memb_assoc == "yes") %>% 
  select(affect_conflicts, liv_count, no_meals)

interviews %>%
  mutate(people_per_room = no_membrs / rooms)

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  mutate(people_per_room = no_membrs / rooms)

#Exercise 2
interviews %>%
  mutate(total_meals = no_membrs*no_meals) %>%
  filter(total_meals>20) %>%
  select(village, total_meals)

interviews %>%
  group_by(village) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs), min_membrs = min(no_membrs)) %>%
  arrange(min_membrs)

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs)) %>%
  arrange(desc(min_membrs))


interviews %>%
  count(village, sort=TRUE)

interviews %>%
  count(no_meals)

interviews %>%
  group_by(village) %>%
  summarize(
    mean_no_membrs = mean(no_membrs),
    min_no_membrs = min(no_membrs),
    max_no_membrs = max(no_membrs),
    n = n()
  )

interviews %>%
  mutate(month = month(date),
         day = day(date),
         year = year(date)) %>%
  group_by(year, month) %>%
  summarize(max_no_membrs = max(no_membrs))


#gather and spread

interviews_spread <- interviews %>%
  mutate(wall_type_logical = TRUE) %>%
  spread(key = respondent_wall_type, value = wall_type_logical, fill = FALSE)

interviews_gather <- interviews_spread %>%
  gather(key = respondent_wall_type, value = "wall_type_logical",
         burntbricks:sunbricks)

interviews_gather <- interviews_spread %>%
  gather(key = "respondent_wall_type", value = "wall_type_logical",
         burntbricks:sunbricks) %>%
  filter(wall_type_logical) %>%
  select(-wall_type_logical)

interviews_items_owned <- interviews %>%
  mutate(split_items = strsplit(items_owned, ";")) %>%
  unnest() %>%
  mutate(items_owned_logical = TRUE) %>%
  spread(key = split_items, value = items_owned_logical, fill = FALSE)
nrow(interviews_items_owned)

interviews_items_owned %>%
  filter(bicycle) %>%
  group_by(village) %>%
  count(bicycle)

interviews_items_owned %>%
  mutate(number_items = rowSums(select(., bicycle:television))) %>%
  group_by(village) %>%
  summarize(mean_items = mean(number_items))

#Excercise 3

interviews_months_no_water <- interviews %>%
  mutate(split_months = strsplit(months_no_water, ";")) %>%
  unnest() %>%
  mutate(months_no_water_logical  = TRUE) %>%
  spread(key = split_months, value = months_no_water_logical, fill = FALSE)

interviews_months_no_water %>%
  mutate(number_months = rowSums(select(., Apr:Sept))) %>%
  group_by(memb_assoc) %>%
  summarize(mean_months = mean(number_months))

#Exporting data

interviews_plotting <- interviews %>%
  ## spread data by items_owned
  mutate(split_items = strsplit(items_owned, ";")) %>%
  unnest() %>%
  mutate(items_owned_logical = TRUE) %>%
  spread(key = split_items, value = items_owned_logical, fill = FALSE) %>%
  rename(no_listed_items = `<NA>`) %>%
  ## spread data by months_lack_food
  mutate(split_months = strsplit(months_lack_food, ";")) %>%
  unnest() %>%
  mutate(months_lack_food_logical = TRUE) %>%
  spread(key = split_months, value = months_lack_food_logical, fill = FALSE) %>%
  ## add some summary columns
  mutate(number_months_lack_food = rowSums(select(., Apr:Sept))) %>%
  mutate(number_items = rowSums(select(., bicycle:television)))

write_csv(interviews_plotting, path = "data_output/interviews_plotting.csv")
