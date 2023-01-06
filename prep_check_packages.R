## check_packages.R

#Run this script to check for packages that the other R scripts will use. If missing, try to install.
#code borrowed from here:
#http://www.vikram-baliga.com/blog/2015/7/19/a-hassle-free-way-to-verify-that-r-packages-are-installed-and-loaded
#inroduced to JB in 2022 CodeHorizons Github for Data Analysis course

#add new packages to the chain here
packages = c("here","readr", "haven", "readxl", "usethis",
             "tidyverse", "ggplot2", "zoo",
             "nlme", "lme4", "lmerTest", "emmeans", "psych", "performance",
             "lubridate", "visdat", "skimr", "broom.mixed")

package.check <- lapply(packages, FUN = function(x) {
  if (!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
    library(x, character.only = TRUE)
  }
})


### COPY / PASTE THE FOLLOWING LINE INTO YOUR NEW SCRIPT ### 
source("check_packages.R")