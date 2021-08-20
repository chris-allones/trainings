# CONFIRMATORY FACTOR ANALYSIS ----

# Library
library(haven)
library(janitor)
library(tidyverse)
library(lavaan)
library(semTools)
library(semPlot)

# Data
hbat_data <- read_sav("SEM/00_data/HBAT_SEM_NOMISSING.sav") %>% 
 clean_names() %>% 
 select(js1:si4) %>%
 mutate_all(as.numeric)

# 1. CONFIRMATORY FACTOR ANALYSIS

## 1.1 Specifying our CFA model ----
hbat_cfa_model <- "si =~ si1 + si2 + si3 + si4
              js =~ js1 + js2 + js3 + js4 + js5
              ac =~ ac1 + ac2 + ac3 + ac4
              ep =~ ep1 + ep2 + ep3 + ep4
              oc =~ oc1 + oc2 + oc3 + oc4"


## 1.3 Fitting our CFA model ----
hbat_cfa_fit <- cfa(model = hbat_cfa_model, data = hbat_data)
hbat_cfa_fit %>% summary(standardized = TRUE)


## 1.4 Fit indices ----
fitmeasures(hbat_cfa_fit)
fitmeasures(hbat_cfa_fit,
            fit.measures = c('chisq', 'df','pvalue', "gfi", 
                             'rmsea', 'rmr', 'srmr', 'nfi', 
                             'nnfi', 'cfi', 'agfi'))


## 1.5 Reliability and validity
reliability(hbat_cfa_fit)


# 2. STRUCTURAL MODEL

## 2.1 Specifying structural model
hbat_sem_model <- "si =~ si1 + si2 + si3 + si4
              js =~ js1 + js2 + js3 + js4 + js5
              ac =~ ac1 + ac2 + ac3 + ac4
              ep =~ ep1 + ep2 + ep3 + ep4
              oc =~ oc1 + oc2 + oc3 + oc4
               
              #structural model
              js ~ ep + ac
              oc ~ ep + ac + js
              si ~ js + oc"

## 2.2 Fitting the structural model
hbat_sem_fit <- sem(model = hbat_sem_model, data = hbat_data)
hbat_sem_fit %>% summary(standardized = TRUE)


## 2.3 Plotting the structural model

semPaths(object = hbat_sem_fit,
         what = "std",
         layout = "tree2",
         intercepts = FALSE,
         residuals = FALSE)

## 2.3 Fit indices

gof_indices <- c('chisq', 'df','pvalue', "gfi", 
                 'rmsea', 'rmr', 'srmr', 'nfi', 
                 'nnfi', 'cfi', 'agfi')
fitmeasures(hbat_sem_fit, fit.measures = gof_indices)
fitmeasures(hbat_cfa_fit, fit.measures = gof_indices)


## 2.4 Estimating indirect and total effects

hbat_sem_model_ie <- "si =~ si1 + si2 + si3 + si4
              js =~ js1 + js2 + js3 + js4 + js5
              ac =~ ac1 + ac2 + ac3 + ac4
              ep =~ ep1 + ep2 + ep3 + ep4
              oc =~ oc1 + oc2 + oc3 + oc4
               
              #structural model
              js ~ ep + ac
              oc ~ ep + ac + a*js
              si ~ b*oc + c*js

              #indirect and total effects
              js_ie := a*b
              js_te := a*b + c"

hbat_sem_fit_ie <- sem(model = hbat_sem_model_ie, data = hbat_data)

hbat_sem_fit_ie %>% summary(standardized = TRUE)



