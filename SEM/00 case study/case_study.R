#### SESSION 3: CASE STUDY ####

#### ARTICLE: Young people's perceived service quality and environmental performance of hybrid electric bus.
#### AUTHOR: Zial Haque and Tehjeeb Noor
#### DOI Link: https://doi.org/10.1016/j.tbs.2020.03.003


# Library
library(tidyverse)
library(readxl)
library(janitor)
library(lavaan)
library(psych)
library(MVN)
library(semTools)



# 1 Data ----
case_data <- read_excel("SEM/00 case study/e_bus_customer_satisfaction.xlsx") %>% 
 clean_names()

case_data_items <- case_data %>%
 select(bt1:bt7, bd1:bd4, emp1:emp5, cs1:cs3, ep1:ep4, ls1:ls5)
 
## 1.1 Multivariate normality ---
mvn(data = case_data_items, mvnTest = "mardia")




# 2. EXPLORATORY FACTOR ANALYSIS ----
## 2.1 Scree plot using parallel analysis ----
fa.parallel(case_data_items, fa = "fa")

## 2.2 Factor loadings ----
bus_fa <- fa(r = case_data_items,
   nfactors = 6,
   rotate = "varimax")

print(bus_fa$loadings, sort = TRUE, cutoff = 0.4)




# 3. CONFIRMATORY FACTOR ANALYSIS ----
## 3.1 Specifying CFA model ----
cfa_model <- "tangible =~ bt1 + bt2 + bt4 + bt5 + bt6 + bt7
              drivers_quality =~ bd1 + bd2 + bd3 + bd4
              empathy =~ emp1 + emp2 + emp3 + emp4 + emp5
              env_perf =~ ep1 + ep2 + ep3 + ep4
              customer_sat =~ cs1 + cs2 + cs3
              life_sat =~ ls1 + ls2 + ls3 + ls4 + ls5"

## 3.2 Fitting CFA model ----
cfa_fit <- cfa(model = cfa_model, 
               data = case_data_items, 
               estimator = "MLR")

## 3.3 Factor loadings ----
standardizedSolution(cfa_fit)

## 3.4 Reliability and validity ----
reliability(cfa_fit) %>% round(2)





# 4 STRUCTURAL EQUATION MODELLING ----
## 4.1 Specifying structural model -----
ebus_model <- "tangible =~ bt1 + bt2 + bt4 + bt5 + bt6 + bt7
              drivers_quality =~ bd1 + bd2 + bd3 + bd4
              empathy =~ emp1 + emp2 + emp3 + emp4 + emp5
              env_perf =~ ep1 + ep2 + ep3 + ep4
              customer_sat =~ cs1 + cs2 + cs3
              life_sat =~ ls1 + ls2 + ls3 + ls4 + ls5
              
              # structural model
              customer_sat ~ tangible + drivers_quality + empathy + env_perf
              life_sat ~ customer_sat"

## 4.2 Fitting structural model ----
ebus_fit <- sem(model = ebus_model,
                data = case_data,
                estimator = "MLR")

## 4.3 summary results ----
ebus_fit %>% summary(standardized = TRUE,
                     fit.measures = TRUE,
                     rsq = TRUE)

## 4.4 Adding indirect effects (mediation effects) ----
### 4.4.1 SEM model with mediation ----
ebus_model_ie <- "tangible =~ bt1 + bt2 + bt4 + bt5 + bt6 + bt7
              drivers_quality =~ bd1 + bd2 + bd3 + bd4
              empathy =~ emp1 + emp2 + emp3 + emp4 + emp5
              env_perf =~ ep1 + ep2 + ep3 + ep4
              customer_sat =~ cs1 + cs2 + cs3
              life_sat =~ ls1 + ls2 + ls3 + ls4 + ls5
              
              # structural model
              customer_sat ~ a*tangible + b*drivers_quality + c*empathy + d*env_perf
              life_sat ~ e*customer_sat
             
              # indirect effects
              ie_tangible := a*e
              ie_drivers_qual := b*e
              ie_empathy := c*e
              ie_en_perf := d*e"


### 4.4.2 Fitting structural model with mediation ----
ebus_fit_ie <- sem(model = ebus_model_ie,
                   data = case_data,
                   estimator = "MLR")

### 4.4.3 Summary results ----
ebus_fit_ie %>% summary(standardized = TRUE,
                     fit.measures = TRUE,
                     rsq = TRUE)








