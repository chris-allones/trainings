
# INTRO TO R AND BASIC DATA WRANGLING ----

# 1. R Packages ----
library(readr) # reading csv files
library(readxl) # reading excel files
library(tidyverse) # load all packages under tidyverse environment
library(dplyr) # for data wrangling
library(skimr) # quick exploration of your data


# 2. R Objects ----


# 3. Reading data into R ----

## 3.1 CSV files
### Load swimming_pools.csv files
swimming_pools <- read_csv("SEM/00_data/sample_dataset/swimming_pools.csv")
swimming_pools %>% summary()

?read_csv

### Difference between read_csv() and read.csv()
read_csv("SEM/00_data/sample_dataset/potatoes.csv")
read.csv("SEM/00_data/sample_dataset/potatoes.csv")


## 3.2 Excel files
### Load urban_pop files

read_xls("SEM/00_data/sample_dataset/urbanpop.xls")
read_xlsx("SEM/00_data/sample_dataset/urbanpop.xlsx")
read_excel("SEM/00_data/sample_dataset/urbanpop.xls")
read_excel("SEM/00_data/sample_dataset/urbanpop.xlsx")

### Transform urban pop into longe-format
read_xls("SEM/00_data/sample_dataset/urbanpop.xls") %>% 
 pivot_longer(cols = "1960":"1966",
              names_to = "year",
              values_to = "pop")






## Load


# 4. Basic data wrangling with tidyverse ----

## 4.1 select() ----

## 4.2 filter() ----

## 4.3 mutate() ----

## 4.4 rename() ----

## 4.5 arrange() ----

## 4.6 group_by() and summarize() ----

