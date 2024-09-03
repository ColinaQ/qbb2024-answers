library("tidyverse")
library("ggthemes")

#Q1
df <- read_delim("~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt")

#Q2
glimpse(df)

#Q3
df_SMGEBTCHT <- df %>%
  filter(SMGEBTCHT == "TruSeq.v1")

#Q4
ggplot(data = df_SMGEBTCHT, mapping = aes(x = SMTSD)) +
  geom_bar() +
  ggtitle("Number of samples from each tissue") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Q5
ggplot(data = df_SMGEBTCHT, mapping = aes(x = SMRIN)) +
  geom_density() +
  ggtitle("Distribution of RNA integrity numbers")
#The shape of the distribution is unimodal

#Q6
ggplot(data = df_SMGEBTCHT, mapping = aes(x = SMRIN, y = SMTSD)) +
  geom_boxplot() +
  ggtitle("Distribution of RNA integrity numbers stratified by tissue")
#Kidney - Medulla, leukemia cell line(CML), EBV-transformed lymphocytes,
#Cultured fibroblasts are outliers. One hypothesis on why these tissues are
#outliers could be that since kidney is very slow in regenerating, RNA is
#expressed at lower levels. The CML, lymphocytes, and fibroblasts have 
#high RNA integrity numbers because these cells divide at a high frequency.

#Q7
ggplot(data = df_SMGEBTCHT, mapping = aes(x = SMGNSDTC, y = SMTSD)) +
  geom_boxplot() +
  ggtitle("The number of genes detected per sample stratified by tissue")

#Across different tissues, testis is the outlier. One theory is that 
#this widespread transcription maintains DNA sequence integrity in the 
#male germline by correcting DNA damage through a mechanism called
#transcriptional scanning.

#8
ggplot(data = df_SMGEBTCHT, mapping = aes(x = SMTSISCH, 
                                          y = SMRIN,
                                          )) +
  geom_point(size = 0.5,
             alpha = 0.5) +
  ggtitle("The relationship between ischemic time and RIN") +
  facet_wrap("SMTSD") +
  geom_smooth(method = "lm")

#I noticed that there was a negative correlation in most of these tissues.
#It does depend on tissues. For example, certain tissues have a steeper slope.

#9
ggplot(data = df_SMGEBTCHT, mapping = aes(x = SMTSISCH, 
                                          y = SMRIN,
)) +
  geom_point(size = 0.5,
             alpha = 0.5,
             aes(color = SMATSSCR)) +
  ggtitle("The relationship between ischemic time and RIN") +
  facet_wrap("SMTSD") +
  geom_smooth(method = "lm")


#I also noticed a negative correlation between ischemic time and RIN. 
#But there was a positive correlation between RIN and autolysis score.
#The relationship does depend on tissues.










