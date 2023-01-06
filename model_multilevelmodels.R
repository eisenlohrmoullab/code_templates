## various sample MLMs
library(lme4)
library(nlme)
library(lmerTest) #to extract P values when lmer doesnt feel like showing them
library(performance) #to extract ICCs
library(emmeans) #for plotting interactions

### USING LME4 PACKAGE: ###
# model 1: predicting a logistic outcome from one predictor, random intercepts, no cycle vars
model1 <- glmer(binge_today ~ DRSP11.d
                            +(1|id),
                            data = etoh_data, 
                            family = "binomial")

# model 2: predicting a linear outcome from one predictor, random intercepts, no cycle vars
model2 <- lmer(DMQcope_today ~ DRSP11.d
                                     +(1|id),
                                     data = etoh_data) 

#model 3:logistic outcome from cycle phase contrasts, with covariates
## note this is a PERIOVULATORY reference group model
### to switch reference group, you'd add back in periov and remove whatever phase you want to be the reference
model3 <- glmer(drinkingday_today ~ age.z+legalage+covidrestrictions+frisatsun+currentdx_SUDalc+currentdx_SUDnonalc+
LH_perimenstrual_count+LH_midluteal_count+LH_midfol_LH + (1+LH_midluteal_count+
                                                            LH_midfol_LH+
                                                            LH_perimenstrual_count|id), 
  data = etoh_data, family = "binomial", control = glmerControl(optimizer = "bobyqa")) 
#"control" argument has a ton of options based on model convergence - can remove to keep at defaults

summary(model3) #view output
ranef(model3) #view random effects
icc(model3) #intraclass correlation coefficients
exp(cbind(OR=fixef(model3))) #view odds ratios
##get fixef, OR, and confint (estimate=OR)
tidy(model3, conf.int=T, exponentiate=T, effects="fixed")

#remove random slopes of cycle if needed
model4 <- glmer(drinkingday_today ~ age.z+legalage+covidrestrictions+frisatsun+currentdx_SUDalc+currentdx_SUDnonalc+
                          LH_perimenstrual_count+LH_midluteal_count+LH_midfol_LH
                        +(1|id),
                        data = etoh_data, 
                        family = "binomial", 
                        control = glmerControl(optimizer = "bobyqa"), 
                        nAGQ = 1) 

#add an interaction term between the cycle contrasts and another variable
model5 <- glmer(drinkingday_today ~ age.z+legalage+covidrestrictions+currentdx_SUDalc+currentdx_SUDnonalc+
                  frisatsun*(LH_perimenstrual_count+LH_midluteal_count+LH_midfol_LH)
                +(1+LH_midluteal_count+LH_midfol_LH+LH_perimenstrual_count|id),
  data = etoh_data, 
  family = "binomial", 
  control = glmerControl(optimizer = "bobyqa")) 

## IF OUTCOME IS LINEAR, function is "lmer" not "glmer"
# rest of syntax is the same, including * for interaction and placement of random effect terms
model6 <- lmer(DMQsocial_today~legalage+age.z+covidrestrictions+
                                   currentdx_SUDalc+currentdx_SUDnonalc+frisatsun+
                                   LH_perimenstrual_count+LH_midluteal_count+LH_midfol_LH
                                 +(1+LH_midluteal_count+
                                     LH_midfol_LH+
                                     LH_perimenstrual_count | id), 
                                 control=lmerControl(optimizer="optimx",
                                                     optCtrl=list(method='nlminb')),
                                 data = etoh_data_motives)

### USING NLME PACKAGE: ###
# nullmodel
modelA <- lme(allo ~ 1,
              random= ~1|id,
              na.action=na.omit,
              data=narsad_full)

# random intercecpts only
modelB <- lme(allo_outliersremoved.log ~ condvisitnumber+
                          condatlab+
                          SSRI+
                          sickatlab_cleaned+
                          bmi.z+
                          age.z,
                        random=~1|id,
                        na.action=na.omit,
                        data=narsad_full)

## easy plot of an interaction
emmip(modelB, condatlab~condvisitnumber, CIs = T)

#how to rotate your reference group if the predictor is all in ONE variable (not dummy coded)?
modelB.2 <- lme(allo_outliersremoved.log ~ relevel(condvisitnumber,2)+
                condatlab+
                SSRI+
                sickatlab_cleaned+
                bmi.z+
                age.z,
              random=~1|id,
              na.action=na.omit,
              data=narsad_full)


#random intercepts and random slopes
modelC <- lme(HRV ~ perimens + periov,
              random= ~ perimens+periov|ID,
              na.action=na.omit, data=data) 

