
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

### Transform urban pop into long-format
read_xls("SEM/00_data/sample_dataset/urbanpop.xls") %>% 
 pivot_longer(cols = "1960":"1966",
              names_to = "year",
              values_to = "pop")


## 3.2 SPSS files
### Load HBAT.sav
### Skim the data and troubleshoot
read_sav("SEM/00_data/sample_dataset/HBAT.sav")


### Load data from Stata online @ https://www.stata-press.com/data/r9/u.html
### Link to auto.dta http://www.stata-press.com/data/r9/auto.dta
read_stata("http://www.stata-press.com/data/r9/auto.dta")

## 3.3 Load SAS data
### Do some cleaning of the variable name
read_sas("SEM/00_data/sample_dataset/eventrepository.sas7bdat") %>% 
 clean_names()



# 4. Basic data wrangling with tidyverse ----
### Use gapminder dataset from gapminder package

gapminder_data <- gapminder::gapminder
gapminder_data %>% skim()


## 4.1 filter() ----
### Filter dataset for the year 1957

gapminder_data %>% 
 filter(year == 1957)

### Filter for Philippines in 2002
gapminder_data %>% 
 filter(country == "Philippines", year == 2002)

### Filter for the year 1957, then arrange in descending order of population
gapminder_data %>% 
 filter(year == 1957) %>% 
 arrange(desc(pop))


## 4.2 mutate() ----
### Use mutate to compute for GDP
gapminder_data %>% 
 mutate(GDP = gdpPercap * pop)


### Filter for year 2007, compute GDP in Million and arrange data by descending life expectancy
gapminder_data %>% 
 filter(year == 2007) %>% 
 mutate(GDP = (pop * gdpPercap) / 1e6) %>% 
 arrange(desc(lifeExp))


## 4.6 grouping and summarizing ----
### Summarise to find the median life expectancy
gapminder_data %>% 
 summarise(median_life_exp = median(lifeExp))

### Filter for 1957 then summarise the median life expectancy
gapminder_data %>% 
 filter(year == 1957) %>% 
 summarise(median_life_exp = median(lifeExp))

### Filter for 1957 then summarise the median life expectancy and the maximum GDP per capital

gapminder_data %>% 
 filter(year == 1957) %>% 
 summarise(median_life_exp = median(lifeExp),
           max_gdp_percap = max(gdpPercap))

### Find median life expectancy and maximum GDP per capital in each year
gapminder_data %>%
 group_by(year) %>% 
 summarise(median_life_exp = median(lifeExp),
           max_gdp_percap = max(gdpPercap))
 

### Find median life expectancy and maximum GDP per capital in each continent per year combination
gapminder_data %>% 
 group_by(year, continent) %>% 
 summarise(median_life_exp = median(lifeExp),
           max_gdp_percap = max(gdpPercap)) %>% 
 ungroup()




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













