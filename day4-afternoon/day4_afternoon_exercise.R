library(tidyverse)
library(broom)
library(ggplot2)

#Exercise 1

# read in the data
dnm <- read_csv(file = "/Users/cmdb/qbb2024-answers/day4-afternoon/aau1043_dnm.csv")

ages <- read_csv(file = "/Users/cmdb/qbb2024-answers/day4-afternoon/aau1043_parental_age.csv")

dnm_summary <- dnm %>%
  group_by(Proband_id) %>%
  summarize(n_paternal_dnm = sum(Phase_combined == "father", na.rm = TRUE),
            n_maternal_dnm = sum(Phase_combined == "mother", na.rm = TRUE))


dnm_by_parental_age <- left_join(dnm_summary, ages, by = "Proband_id")


#Exercise 2

#2.1
ggplot(data = dnm_by_parental_age, 
       mapping = aes(x = Mother_age,
                     y = n_maternal_dnm)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(data = dnm_by_parental_age, 
       mapping = aes(x = Father_age,
                     y = n_paternal_dnm)) +
  geom_point() +
  geom_smooth(method = "lm")

#2.2
lm(data = dnm_by_parental_age,
   formula = n_maternal_dnm ~ 1 + Mother_age) %>% 
  summary()

#The "size" or the slope of this relationship is 0.37757, which means that
#the number of maternal DNM is maternal age multiplies 0.37757 + 2.50402.
#This matches with what I observed in plots from 2.1.
#This relationship is significant because the p value is less than 2.2e-16.
#This means that that the likelihood of the observed differences due to 
#chance is very small.

#2.3
lm(data = dnm_by_parental_age, 
   formula= n_paternal_dnm ~1 + Father_age) %>% 
  summary()

#The "size" or the slope of this relationship is 1.35384, which means that
#the number of maternal DNM is maternal age multiplies 1.35384 + 10.32632.
#This matches with what I observed in plots from 2.1.
#This relationship is significant because the p value is less than 2.2e-16.
#This means that that the likelihood of the observed differences due to 
#chance is very small.

#2.4

#paternal_DNMs = 1.35384*50.5 + 10.32632 = 78.69524

#2.5

ggplot(dnm_by_parental_age) +
  geom_histogram(aes(x = n_maternal_dnm, y = ..density..),
                 binwidth = 1, fill = "orange", alpha = 0.5,
                 position = "identity") +
  geom_histogram(aes(x = n_paternal_dnm, y = ..density..),
                 binwidth = 1, fill = "blue", alpha = 0.5,
                 position = "identity") +
  labs(title = "Distribution of Maternal and Paternal DNMs per Proband",
       x = "Number of DNMs",
       y = "Density")

#2.6
#I would choose to use a paired t-test since the test allows us to check
#if the mean difference between the two groups (maternal vs. paternal DNMs 
#for the same proband) is significantly different from zero.

t.test(dnm_by_parental_age$n_maternal_dnm, dnm_by_parental_age$n_paternal_dnm, 
       paired = TRUE)

#Since in the result, the p value is very small. Altogether, it means that
#there is a statistically significant difference between the number of 
#maternally and paternally inherited DNMs, with paternally inherited DNMs 
#being significantly higher.








