library("tidyverse")
library("ggplot2")

df <- read_tsv("~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt")

df <- df %>%
  mutate( SUBJECT=str_extract( SAMPID, "[^-]+-[^-]+" ), .before=1 )

df %>%
  group_by(SUBJECT) %>%
  summarize( count=n() ) %>%
  arrange( desc(count) )

df %>%
  group_by(SUBJECT) %>%
  summarize( count=n() ) %>%
  arrange( count )

#The "K-562" and "GTEX-NPJ8" columns have the most samples.
#The "GTEX-1JMI6" and "GTEX-1PAR6" columns have the least samples.

df %>%
  group_by(SMTSD) %>%
  summarize( count=n() ) %>%
  arrange( desc(count) )

df %>%
  group_by(SMTSD) %>%
  summarize( count=n() ) %>%
  arrange( count )

#The "Whole Blood" and "Muscle - Skeletal" columns have the most samples.
#The "Kidney - Medulla" and "Cervix - Ectocervix" columns have the least samples.




df_npj8 <- df %>%
  filter(SUBJECT=="GTEX-NPJ8") %>%
  group_by(SMTSD) %>%
  summarize( count=n() ) %>%
  arrange( desc(count) )

#The "Whole Blood" column has the most samples.

df_npj8 <- df %>%
  filter(SUBJECT=="GTEX-NPJ8") %>%
  filter(SMTSD=="Whole Blood")

#The samples are different in that they are collected differently, and their
#sequencing methods are also different.


df_SMATSSCR <- df %>%
  group_by(SUBJECT) %>%
  filter( !is.na(SMATSSCR) ) %>%
  summarize(mean(SMATSSCR)) %>%
  filter(`mean(SMATSSCR)` == 0)
  
nrow(df_SMATSSCR)

#15 subjects have a mean SMATSSCR score of 0.

df_SMATSSCR <- df %>%
  group_by(SUBJECT) %>%
  filter( !is.na(SMATSSCR) ) %>%
  summarize(mean(SMATSSCR))

mean(df_SMATSSCR$`mean(SMATSSCR)`)


#One observation I can make here is that the mean score of all the SMATSSCR values
#in the "SMATSSCR) is 0.9050125

quantile(df_SMATSSCR$`mean(SMATSSCR)`, prob=c(.25,.5,.75))

#Another observation I can make here is the quantile information

#This information can also be presented as a histogram plot


















