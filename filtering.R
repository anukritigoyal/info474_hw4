library(dplyr)

population <- read.csv("population.csv", stringsAsFactors = FALSE)
population <- select(population, LOCATION, TIME, population) %>% group_by(LOCATION, TIME) %>% filter(population == max(population))

fertility <- read.csv("fertility_rates.csv", stringsAsFactors = FALSE)
fertility <- select(fertility, LOCATION, TIME, fertility_rate) %>% group_by(LOCATION, TIME) %>% filter(fertility_rate == max(fertility_rate))

life <- read.csv("life_expectancy.csv", stringsAsFactors = FALSE)
life <- select(life, LOCATION, TIME, life_expectancy) %>% group_by(LOCATION, TIME) %>% slice(2)

new_data <- inner_join(life, fertility, by = c("LOCATION", "TIME"))
new_data <- inner_join(new_data, population, by = c("LOCATION", 'TIME'))
colnames(new_data) <- c("location", "time", "life_expectancy", "fertility_rate", "pop_mlns")
write.csv(new_data, file = 'dataEveryYear.csv')
