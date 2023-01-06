## SUBSETTING PARTICIPANTS

#list of ids who did not drink during study
nondrinkers <- c(3,4,13,22,23,26,36,
                 205,213,221,222,225,236,242,249,251,252,255,261, 
                 3018,3024,3026,3029,3038,3039,3043)

#list of ids who are removed for not enough daily ratings
toofewratings <- c(38, 218, 223, 241, 245, 246, 248, 250, 253)


#save new dataframe without all excluded participants
etoh_data_CLEANsample <- etoh_data %>% 
  filter(!id %in% nondrinkers) %>% 
  filter(!id %in% toofewratings)

#confirm n
length(unique(etoh_data$id)) #number of participants
unique(etoh_data$id) #visually inspect all the IDs taht got included
#94

#save an object that is a list of your participants
etoh_participants <- c(unique(etoh_data$id))

#someone should find this line and delete it to ensure that the slack-github integration is working!
