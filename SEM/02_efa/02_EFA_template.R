
# EXPLORATORY FACTOR ANALYSIS ----
# Libraries
library(tidyverse)
library(haven)
library(janitor)
library(likert)
library(psych)
library(EFAtools)

# Data managemnet ----

hbat_data <- read_sav("00_data/HBAT_SEM_NOMISSING.sav") %>% 
 clean_names() %>% 
 select(js1:si4) %>%
 mutate_all(as.numeric)

## Quick glance to the data


# 1. Factorability check ----
## 1.1 Bartlett Test of Sphericity ----
BARTLETT(x = hbat_data, N = nrow(hbat_data))

## 1.2  Kaiser-Meyen-Olkin (KMO) test ----
KMO(hbat_data)


# 2. Choosing the number of factors ----
## 2.1 Kaiser-Guttman Criterion ----

KGC(hbat_data, eigen_type = "EFA")


## 2.2 Scree test ----
scree(hbat_data)

## 2.3 Parallel analysis ----
fa.parallel(hbat_data, fa = "fa")



# 3. Factor extraction ----
## 3.1 Extraction method: Minimum residual (MinRes) ----
hbat_unrotated_minres <- fa(r = hbat_data, nfactors = 5, rotate = "none")
print(hbat_unrotated$loadings, sort = TRUE, cutoff = 0.4)


## 3.2 Extraction method: Maximum likelihood estimation (MLE) ----
hbat_unrotated_mle <- fa(r = hbat_data, nfactors = 5, rotate = "none", fm = "ml")
print(hbat_unrotated_mle$loadings, sort = TRUE, cutoff = 0.4)


# 4. Factor rotation and respicification ----
## 3.3 Rotation method: Varimax ----
hbat_unrotated_mle_varimax <- fa(r = hbat_data, nfactors = 5, rotate = "varimax", fm = "ml")
print(hbat_unrotated_mle_varimax$loadings, sort = TRUE, cutoff = 0.4)


## 3.4 Rotation method: Promax ----
hbat_unrotated_mle_promax <- fa(r = hbat_data, nfactors = 5, rotate = "promax", fm = "ml")
print(hbat_unrotated_mle_promax$loadings, sort = TRUE, cutoff = 0.4)




