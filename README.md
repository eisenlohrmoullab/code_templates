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

**model_multilevelmodels.R"
