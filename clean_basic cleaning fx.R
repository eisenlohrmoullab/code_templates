library(tidyverse)
library(janitor)
library(visdat)
library(skimr)
library(psych)
library(haven)

checkdaily2 <- read_spss("~/Library/CloudStorage/Box-Box/
                         00 - CLEAR Lab (Locked Folders)/
                         02 - Data Management, Analysis, and Papers/
                         Studies_Projects/CLEAR2/02_datasets/
                         CLEAR2_DAILY/03_cleaned_data/2022-01-18_CLEAR2_DAILY.sav")


#total participants
length(unique(checkdaily2$id))
#rows
nrow(checkdaily2)
#columns
ncol(checkdaily2)
#unique participants
unique(checkdaily2$id)
#missing ids
checkdaily2 %>% group_by(is.na(id)) %>% summarize(n=n())
#missing dates
checkdaily2 %>% group_by(is.na(daterated)) %>% summarize(n=n())
#check repeats
checkdaily2 %>% get_dupes(id, daterated)
#review extra columns
colnames(checkdaily2)
#visualize missingness
checkdaily2 %>%
  select(1:20) %>%
  slice(1:1000) %>%
  vis_miss()
checkdaily2 %>%
  select(1:20) %>%
  slice(1001:2000) %>%
  vis_miss()
#variable types
checkdaily2 %>% skim() %>% summary()
checkdaily2 %>% describe()


checktrait2 <- read_spss("~/Library/CloudStorage/Box-Box/
                         00 - CLEAR Lab (Locked Folders)/
                         02 - Data Management, Analysis, and Papers/
                         Studies_Projects/CLEAR2/02_datasets/
                         CLEAR2_TRAIT/03_cleaned_data/2021-12-29_clear2traitscid.sav")
#total participants
length(unique(checktrait2$id))
#rows
nrow(checktrait2)
#columns
ncol(checktrait2)
#unique participants
unique(checktrait2$id)
#missing ids
checktrait2 %>% group_by(is.na(id)) %>% summarize(n=n())
#missing dates
checktrait2 %>% group_by(is.na(daterated)) %>% summarize(n=n())
#check repeats
checktrait2 %>% get_dupes(id, daterated)
#review extra columns
colnames(checktrait2)
#visualize missingness
checktrait2 %>%
  select(1:20) %>%
  slice(1:1000) %>%
  vis_miss()
checktrait2 %>%
  select(1:20) %>%
  slice(1001:2000) %>%
  vis_miss()
#variable types
checktrait2 %>% skim() %>% summary()
checktrait2 %>% describe()