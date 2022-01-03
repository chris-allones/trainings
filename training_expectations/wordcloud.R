library(tidyverse)
library(readxl)
library(tidytext)
library(janitor)
library(ggwordcloud)

# import data
data_expectations <- read_csv("https://github.com/chris-allones/trainings/raw/master/training_expectations/participants-profile.csv") %>% 
 clean_names() %>%
 select(expectations = starts_with("expectations")) %>% 
 cbind(id = 1:nrow(.)) %>% 
 as_tibble() %>% 
 filter(expectations!= ".")

#tidytext

tokenized_expectations <- unnest_tokens(data_expectations, 
                                        input = expectations,
                                        output = word)

tidy_expecatations <- tokenized_expectations %>% 
 anti_join(stop_words) %>% 
 count(word, sort = TRUE) %>% 
 rename(count = n)


ggwordcloud_expectations <- tidy_expecatations %>% 
 filter(count > 2) %>% 
 ggplot(aes(label = word, size = count, color = count)) +
 geom_text_wordcloud() + 
 scale_size_area(max_size = 27) +
 theme_light() +
 theme(panel.border = element_blank())

ggsave("training_expectations/ggwordcloud_expectations.jpg",
       units = "in",
       width = 10,
       height = 7)
