## MEASURING TIME IN STUDY

# make sure dayssinceenroll gets calculated as DAYS (without the YMD specifier, it calculates seconds)
etoh_data <- etoh_data %>% group_by(id) %>%
  mutate(dayssinceenroll = ymd(daterated) - min(ymd(daterated)),
         dayssinceenroll.num = as.numeric(dayssinceenroll))

# does day in study predict likelihood of drinking?
modeltraj.0 <- mixed_model(fixed = drinkingday_today ~ dayssinceenroll.num,
                              random= ~ 1 + dayssinceenroll.num | id,
                              data=etoh_data, family=binomial())
summary(RR_modeltraj.0)