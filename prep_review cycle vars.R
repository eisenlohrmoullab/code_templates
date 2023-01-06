### WAYS TO VIEW AND CHECK YOUR CYCLE DATA

# open all data in separate window
etoh_data %>% select(id, daterated, firstdayofperiod, cycleday, posLHtoday, daycountLH) %>% View()

#count unique IDs
nrow(as.data.frame(unique(etoh_data$id)))

#check how many observations you have in each cycle day
etoh_data %>% group_by(daycountLH) %>%
  summarize(n=n())

#check how many observations you have in each cycle phase
etoh_data %>% group_by(LH_periov_LH, LH_midluteal_count, LH_perimenstrual_count, LH_midfol_LH) %>%
  summarize(n=n())

#visually inspect the cycle phasing
etoh_data %>% select(daterated, cycleday, daycountLH, starts_with("LH_"))

#add the LH-based cycle phasing to one variable for ease of graphing (NOT for modeling)
etoh_data <- etoh_data %>% mutate(LH_cyclephase = case_when(LH_periov_LH==1 ~ 1,
                                                            LH_midluteal_count==1 ~ 2,
                                                            LH_perimenstrual_count==1 ~ 3,
                                                            LH_midfol_LH==1 ~ 4,
                                                            TRUE ~ 0))

#add a variable that labels cyclephase with names, for easier easier graphing
etoh_data$LH_cyclephasenames <- factor(etoh_data$LH_cyclephase,
                                       levels = c(0,1,2,3,4),
                                       labels = c("none",
                                                  "periov",
                                                  "midlut",
                                                  "perimen",
                                                  "midfol"))

#remove any day that does NOT get included in the models, aka any day that doesn't get an LH_cyclephase
etoh_data <- etoh_data %>% 
  filter(LH_cyclephase!=0)
