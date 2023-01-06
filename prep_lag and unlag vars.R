#### UNLAGGING VARIABLES: 

#drinking day, binge vars
## we ask "did you drink yesterday" and want that data aligned with the date the pt drank
combinedtraitdaily <- combinedtraitdaily %>% 
  arrange(id, daterated) %>%
  group_by(id) %>%
  mutate(numdrinks_today = lead(numdrinks_yest),
         drinkingday_today = lead(drinkingday_yest),
         binge_today = lead(binge_yest))

#create next day planning + next day symptoms
narsad_daily <- narsad_daily %>%
  arrange(id, date) %>%
  group_by(id) %>%
  mutate(nextday_ASIQplan = lead(ASIQ_planning),
         nextday_ASIQmean = lead(ASIQ_mean),
         twoday_ASIQplan = lead(ASIQ_planning, n=2),
         twoday_ASIQmean = lead(ASIQ_mean, n=2))

## LAGGING VARIABLES - when we want yesterdays variable saved today as "usedPRN-yest"
narsad_daily <- narsad_daily %>%
  arrange(id, date) %>%
  group_by(id) %>%
  mutate(usedbenzo_yest = lag(usedbenzo),
         usedprn_yest = lag(usedPRN))