
# INTRO TO R AND BASIC DATA WRANGLING ----

# 1. R Packages ----
library(readr) # reading csv files
library(readxl) # reading excel files
library(haven) # reading spss, sas, stata files
library(tidyverse) # load all packages under tidyverse environment
library(dplyr) # for data wrangling
library(skimr) # quick exploration of your data
library(janitor) # quick cleaning of dataset


# 2. R Objects ----


# 3. Reading data into R ----

## 3.1 CSV files
### Load swimming_pools.csv files

### Difference between read_csv() and read.csv()


## 3.2 Excel files
### Load urban_pop files

### Transform urban pop into long-format


## 3.2 SPSS files
### Load HBAT.sav
### Skim the data and troubleshoot

### Load data from Stata online @ https://www.stata-press.com/data/r9/u.html
### Link to auto.dta http://www.stata-press.com/data/r9/auto.dta


## 3.3 Load SAS data
### Do some cleaning of the variable name


# 4. Basic data wrangling with tidyverse ----
### Use gapminder dataset from gapminder package



## 4.1 filter() ----
### Filter dataset for the year 1957

### Filter for Philippines in 2002

### Filter for the year 1957, then arrange in descending order of population


## 4.2 mutate() ----
### Use mutate to compute for GDP


### Filter for year 2007, compute GDP in Million and arrange data by descending life expectancy


## 4.6 grouping and summarizing ----
### Summarise to find the median life expectancy


### Filter for 1957 then summarise the median life expectancy


### Filter for 1957 then summarise the median life expectancy and the maximum GDP per capital


### Find median life expectancy and maximum GDP per capital in each year


### Find median life expectancy and maximum GDP per capital in each continent per year combination


# BONUS: Let's have a sample visualisation with gapminder dataset

gapminder_data %>% 
 filter(year == 2007) %>% 
 ggplot(aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
 geom_point(alpha = 0.8) +
 scale_x_log10() +
 scale_size(range = c(0.1, 20), name = "Population") +
 labs(x = "GDP per Capita",
      y = "Life Expectancy (years)",
      title = "World Development in  2007") +
 theme_light() +
 theme(legend.position = "none")













