

# Library
library(tidyverse)
library(readxl)
library(janitor)


# Loading case data ----

case_data <- read_excel("00 case study/e_bus_customer_satisfaction.xlsx") %>% clean_names()
