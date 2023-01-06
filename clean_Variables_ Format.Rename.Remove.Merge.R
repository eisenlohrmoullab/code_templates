### COMMON EDITS TO MAKE TO DATASETS BEFORE MERGING ###


### CHANGE VARIABLE FORMATS: examples
c1trait$rel_years <-as.character(c1trait$rel_years)
c2trait$numpregnancies <-as.numeric(c2trait$numpregnancies)
c2trait <- c2trait %>% mutate(across(starts_with("SES_zipcode"), as.character))
c2trait$age <- as.numeric(c2trait$age)

### RENAME A VARIABLE: example
c3trait <- c3trait %>% rename(age=Age)

### create sample-standardized age and bmi prior to mering one-to-many
trait$age.z <- scale(trait$age, center = TRUE) #scale=T is default, so this z-scores

# MERGE, if you want all similar variables to merge
tempdaily <- full_join(c1daily, c2daily)

# before merging, remove duplicate columns between the two datsets (otherwise they wont merge right)
daily <- daily %>% select(-age)

#merge, if you know ID is the only matching variable
combinedtraitdaily <- full_join(trait, daily, by="id")

# return a count of how many unique IDs you have
length(unique(combinedtraitdaily$id))