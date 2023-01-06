## PLOTS ACROSS CYCLE

# example 1a: likelihood to drink by phase
#person-mean-center
data_for_plot1a <- etoh_data %>% group_by(id, LH_cyclephasenames) %>% 
  summarize(drinkingprob.m=mean(drinkingprob.m),
            drinkingprobphase.m = mean(drinkingday_today, na.rm = TRUE),
            drinkingprobphase.d = drinkingprobphase.m - drinkingprob.m)

plot1a <- data_for_plot1a %>% 
  group_by(LH_cyclephasenames) %>%
  summarize(grand.m.drinkingprob.d = mean(drinkingprobphase.d, na.rm=T),
            se=sd(drinkingprobphase.d, na.rm=T)/sqrt(n())) %>%
  #can save the above code into a separate dataset if preferred (dont have to do it in one line w/ ggplot)
  ggplot(aes(x=LH_cyclephasenames, y=grand.m.drinkingprob.d))+
  geom_line(group=1)+
  ##everything from here down is just formatting
  scale_x_discrete(labels=c("midfol" = "Midfollicular", 
                            "midlut" = "Midluteal",
                            "perimen" = "Perimenstrual",
                            "periov" = "Periovulatory"))+
  scale_y_continuous(limits = c(-0.05, 0.10))+
  geom_errorbar(aes(ymin=grand.m.drinkingprob.d-se, 
                    ymax=grand.m.drinkingprob.d+se), 
                size=0.5, width=0.5, position=position_dodge())+
  geom_hline(yintercept=0.0, color="red", linetype="dashed")+
  theme_bw()+
  xlab("Cycle Phase")+
  ylab("Person-Centered Prob. of Drinking")

# save
plot1a %>% ggsave(filename = "2022-07-23_dd_by_phase_1a", 
                                                  width = 4, height = 3,
                                                  path = "../04_writing/2022-04-26 ACER R&R/",
                                                  units = c("in"),
                                                  device = "png")

# example 1b: likelihood to drink by hybrid-counted cycle day
#create hybrid version of cycle day:
etoh_data_cycleday <- etoh_data_cycleday %>%
  mutate(hybridcycleday = case_when((daycountLH >= -7 & daycountLH <= 5) ~ paste(as.character(daycountLH), "L", sep = ""),
                                    (cycleday >= -9 & cycleday <= 7) ~ paste(as.character(cycleday), "M",  sep = ""),
                                    TRUE ~ NA_character_))

#remove days taht did not get a hybrid cycle day
etoh_data_cycleday <- etoh_data_cycleday %>%
  filter(!is.na(hybridcycleday))

#save the order you want the labels on the x axis
hybridcycleday_order <- c("-7L",
                          "-6L",
                          "-5L",
                          "-4L",
                          "-3L",
                          "-2L",
                          "-1L",
                          "0L",
                          "1L",
                          "2L",
                          "3L",
                          "4L",
                          "5L",
                          "-9M",
                          "-8M",
                          "-7M",
                          "-6M",
                          "-5M",
                          "-4M",
                          "-3M",
                          "-2M",
                          "-1M",
                          "1M",
                          "2M",
                          "3M",
                          "4M",
                          "5M",
                          "6M",
                          "7M")

#person-mean-center
data_for_plot1b <- etoh_data_cycleday %>% group_by(id, hybridcycleday) %>% 
  filter(!is.na(hybridcycleday)) %>%
  summarize(drinkingprob.m=mean(drinkingprob.m),
            drinkingprob.day.m = mean(drinkingday_today, na.rm = TRUE),
            drinkingdayprob.d = drinkingprob.day.m - drinkingprob.m) %>%
  arrange(factor(hybridcycleday, levels = hybridcycleday_order))

# plot
plot1b <- 
  data_for_plot1b %>% group_by(hybridcycleday) %>%
  summarize(grand.m.drinkingprob.d = mean(drinkingdayprob.d, na.rm=T), #grand mean of deviations
            se=sd(drinkingdayprob.d, na.rm=T)/sqrt(n())) %>%
  arrange(factor(hybridcycleday, levels = hybridcycleday_order)) %>%
  mutate(roll= rollapply(grand.m.drinkingprob.d, 3, 
                         mean, align = "center", fill=NA)) %>% #3 day rolling average
  #everything above can be saved into its own df, does not need to be one line with plot
  ggplot(aes(x=factor(hybridcycleday, levels = hybridcycleday_order), y=roll))+
  geom_line(group=1)+
  geom_hline(yintercept = 0, linetype="dashed", col="red")+
  geom_errorbar(aes(ymin=roll-se, ymax=roll+se), 
                size=0.5, width=0.5, position=position_dodge())+
  #everything below is formatting
  theme_bw()+
  scale_y_continuous(expand = c(0,0.001))+ #adjust axes for your own data
  xlab("Cycle Day (based on LH-surge and menses self-report)")+
  ylab("Person-Centered Prob. of Drinking")+
  annotate("rect", ymin = -0.065, ymax = -0.055, xmin = "-7L", xmax = "-3L", alpha = .2)+ #place labels manually x+y
  annotate("text", x="-7L", y=-0.06, label="midfollicular", 
           size=3, hjust=-0.25, fontface="italic")+
  annotate("rect", ymin = -0.065, ymax = -0.055, xmin = "-2L", xmax = "1L", alpha = .2)+
  annotate("text", x="-2L", y=-0.06, label="periovulatory", 
           size=3, hjust=0, fontface="italic")+
  annotate("rect", ymin = -0.065, ymax = -0.055, xmin = "-9M", xmax = "-5M", alpha = .2)+
  annotate("text", x="-9M", y=-0.06, label="midluteal", 
           size=3, hjust=-0.5, fontface="italic")+
  annotate("rect", ymin = -0.065, ymax = -0.055, xmin = "-3M", xmax = "2M", alpha = .2)+
  annotate("text", x="-3M", y=-0.06, label="perimenstrual", 
           size=3, hjust=-0.15, fontface="italic")+
  annotate("text", x="0L", y=-0.07, label="*", size=8, color="blue")+
  annotate("text", x="1M", y=-0.07, label="*", size=8, color="blue")

#save
plot1b %>% ggsave(filename = "newplotname", 
                                               width = 8, height = 3,
                                               path = "../04_writing/2022-04-26 ACER R&R/",
                                               units = c("in"),
                                               device = "png")