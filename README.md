# code_templates
CLEAR Lab Code Templates. Includes R code for data prep, data cleaning, modeling, and plotting.

TEST: January 5th, 2023. Jordan linked to slack.

As of April 10th 2023, Data Team decided to keep a list of code_templates in the Readme file.

**scripts that start with "clean_" should be used for cleaning datasets. scripts that start with "model_" are useful for your analytic models. 

**check_packages.R**
- author: Jordan
- what it does: If this script is copied/saved in the same directory as your analysis, this checks that you have all packages listed in the script installed and imported into your environment. Saves you from having to write a long list of libraries at the top of the script.
- when to use: anytime you are starting a new repository.

**clean_basic cleaning fx.R**
- author: Jordan
- what it does: has examples of easy one-line codes to check basic aspects of your dataset like number of rows and columns, listing unique IDs, visualizing missing data, variable names, etc.
- when to use: beginning of any analysis or cleaning. good if you just want a quick "how do i check xyz" but not a full script. 

**clean_clean_review-raw-vars_check-missing_clean-ID.Rmd**
- author: Jordan
- what it does: same as "clean_basic cleaning fx.R" but with more robust notes and sample code for saving changes.
- when to use: beginning of any analysis or cleaning. 

**clean_Variables_ Format.Rename.Remove.Merge.R**
- author: Jordan
- what it does: lists common functions/edits you may need to make to datasets before they can be merged. 
- when to use: Before merging datasets (such as daily-to-trait, or clear2-to-clear3)

**model_dayssinceenroll.R**
- author: Jordan
- what it does: creates a numeric variable that counts days the participant has been in study since enrollment, which can be used to model effects of linear time as a covariate.
- when to use: if you want to covary time in study in your model.

**model_multilevelmodels.R**
- author: Jordan
- what it does: various examples of MLMs using lme4 package and nlme package. options with and without random intercepts/slopes; logistic vs linear outcomes; dummy coded cycle variables, etc.
- when to use: any multilevel model.

**plot_cyclephase and day-KY.Rmd**
- author: Jordan
- what it does: function to calculate person-means and person-deviations; loop to run those functions on outcomes of interest; create line graph of person-centered outcomes across cycle day; create line graph of person-centered outcomes across cycle phase.
- when to use: when plotting raw data from a daily dataset. 

**plot_Raincloud Plot.Rmd**
- author: Jordan
- what it does: create a "raincloud plot" of fixed and random effects from a multilevel model, which is a combination of a histogram (summary of individual random effects), a scatter plot (individual random effects), and a box plot (fixed effects).
- when to use: a possibility for plotting your MLM outcomes.

**prep_calc-cyclicity-as-percentage.Rmd**
- author: Jordan
- what it does: calculate percent change in DRSP symptoms using C-PASS (premenstrual vs postmenstrual) or How To Study the Menstrual Cycle (perimenstrual vs midfollicular) phases; create histograms of each person's percent change in that symptom; creates a categorical variable to indicate if a person has over 30% change between cycle phases.
- when to use: when describing symptom cyclicity based on raw daily data. 

**prep_Cycle Phase Coding 5 phase - ADHD-KY.Rmd**
- author: Jordan
- what it does: create cycle day using menses; create cycle day using LH; create cycle phases based on both menses-day-counts and LH-day-counts; review and edit the "hybrid cycle phase" count system. called "5-phase" because it includes an early luteal phase (periovulatory, early luteal, midluteal, perimenstrual, midfollicular). template was created for ADHD-KY Collaboration, but can be renamed and used for any CLEAR lab data.
- when to use: after daily dataset is fully clean, but before running analyses.
- ***Note: After reviewing this script and the other ones, I think this may be best for collaborations that do not use our experimental paradigm, while "prep_hybrid-LH-menses-cycleday-coding.Rmd" is best for clear lab data specifically.

**prep_Cycle Phase Coding for ADHD-KY.Rmd**
- author: Jordan
- what it does: create cycle day using menses; create cycle day using LH; create cycle phases based on both menses-day-counts and LH-day-counts; review and edit the "hybrid cycle phase" count system. does NOT include an early luteal phase (periovulatory, midluteal, perimenstrual, midfollicular). template was created for ADHD-KY Collaboration, but can be renamed and used for any CLEAR lab data.
- when to use: after daily dataset is fully clean, but before running analyses.

**prep_cycleday_cyclephase.Rmd**
- author: Jordan
- what it does: creates a cycleday variable (-15 to +10) based on menses count only. Then, creates 4 cycle phase dummy code variables based on counting (midluteal, perimenstrual, midfollicular, periovulatory). Does not use any LH-surge data. Finally, adds one variable with all 4 cycle phases (numbered 1-4) for graphing.
- When to use: when graphing or analyzing any daily data based exclusively on menses count.

**prep_hybrid-LH-menses-cycleday-coding.Rmd**
- author: Jordan
- what it does: creates daycountLH, which codes a verison of cycleday based on LH surge from days -7 to +15 surrounding ovulation.  Then, creates midfollicular, periovulatory and early luteal phases baesd on LH surge; and mdiluteal and perimenstrual phases based on menses count. Reviews overlaps between LH- and menses-based phases, then creates overrides to fix double-counted days.
- When to use: For analyses of baseline CLEAR data, after "prep_cycleday_cyclephase.Rmd" script was used to create menses-based variables. 

**prep_lag-and-unlag-vars.R**
- author: Jordan
- what it does: Unlags variables that ask about yesterday so they align with the day they are about. Create next day and 2-day-later symptoms for later averaging (ex: 3 day symptom mean).
- When to use: When prepping for an analysis that uses day before or day after variables.

**prep_Person Mean Centering and Plotting by Phase.rtf**
- author: Jordan
- what it does: example for creating a person-mean, a daily person deviation, and plotting a person-centered outcome across the cycle.
- When to use: When visualizing one outcome across the cycle, raw data.
- ***Note: This is saved as a text file because I had initlally just written it as a slack message for someone. Can be changed into a script.
- ***Note 2: I now have better code to do this in a loop, for many outcomes at once. Use "prep_person-means-person-devs-rolling-avgs.Rmd"

**prep_person-means-person-devs-rolling-avgs.Rmd**
- author: Jordan
- what it does: writes functions and runs them within a for loop on a list to: create person-means; create person-centered deviations; create 3-day rolling averages
- When to use: when prepping your analytic data for graphing.

**prep_review cycle vars.R**
- author: Jordan
- what it does: views and checks your cycle related variables, such as daycountLH, cycleday, firstdayofperiod, and posLHtoday to check for anything weird. Such as: how many observations fall under each cycle day? how many observations fall under each cycle phase? are there any days that are double counted in phases? Also creates labeled phase variable for graphing and removes days that are not in cycle-phase-based models.
- When to use: After you have created your cycle variables, but before running your models.

**prep_subset participants.R**
- author: Jordan
- what it does: creates a dataset with or without a list of specific participants.
- When to use: In your data prep file that is specific to your analytic project.

**prep_table1_demographics.Rmd**
- author: Jordan
- what it does: calculates descriptive information for your demographic table/Table 1. Also has sample code for using the TableOne package in R. Example code for summary stats on Age, Race, Ethnicity, Number of Suicide Attempts, Lifetime Suicidal Behavior (Y/N). Creates SCID categorical variables such as "any lifetime SUD", "Current Depressive Disorder", "Any Current Anxiety Disorder" etc. Plot code for looking at samples by age, race, marital status, sexual orientation, education.
- When to use: After you know exactly which participants are in your analytic sample.


