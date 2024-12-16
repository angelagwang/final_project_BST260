
#load packages and data
library(excessmort) 
library(tidyverse)
library(lubridate)

view(puerto_rico_counts)

#create dataset that combines weekly death counts and removes weeks with less than 7 days

weekly_counts_origage <- puerto_rico_counts %>%
  #collapse dates into weeks and make dates start on the day that maria made landfall (wednesday)
  mutate(date = as.Date(date),
         date = floor_date(date, unit = "week", week_start = 3)) %>% 
  group_by(date, agegroup, sex) %>%
  #find total deaths and pop per week by each combo of age group and sex, n used to find number of days in each week, mean(population) to not double count pop
  summarize(deaths_per_group = sum(outcome),
            n = n(), 
            population_per_group = mean(population), .groups = "drop") %>%
  filter(n == 7) %>%
  select(-n) %>%
  mutate(year = year(date))

saveRDS(weekly_counts_origage, "../data/weekly_counts.rds")

#adjust age groups and recalculate the total deaths and population sizes for the final table used for most of the analysis

dat <- weekly_counts_origage  %>%
  filter(between(year(date), 2000, 2018)) %>%
  #collapse age groups 
  mutate(agegroup = case_when(
    agegroup == "0-4" ~ "0-19",
    agegroup == "5-9" ~ "0-19",
    agegroup == "10-14" ~ "0-19",
    agegroup == "15-19" ~ "0-19",
    agegroup == "20-24" ~ "20-39",
    agegroup == "25-29" ~ "20-39",
    agegroup == "30-34" ~ "20-39",
    agegroup == "35-39" ~ "20-39",
    agegroup == "40-44" ~ "40-59",
    agegroup == "45-49" ~ "40-59",
    agegroup == "50-54" ~ "40-59",
    agegroup == "55-59" ~ "40-59",
    TRUE ~ "60+",
  )) %>%
  #sum population and deaths to get total per new age group and sex
  group_by(date, agegroup, sex) %>%
  summarize(total_deaths = sum(deaths_per_group),
            population = sum(population_per_group), .groups = "drop") %>%
  #add columnns for the week of the year and year
  mutate(week = as.factor(epiweek(date)),
         year = year(date),
         mortality_rate = total_deaths/population,
         diftime = difftime(date, min(date), units =  "days")) #days since the current date and the first date in the dataset

saveRDS(dat, "../data/dat.rds")

