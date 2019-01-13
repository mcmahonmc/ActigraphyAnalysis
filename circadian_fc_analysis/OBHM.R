library(tidyverse)
library(RColorBrewer)
library(ggcorrplot)

net <- read.csv("~/Box/ADM_Study/ADM/data/netmetrics_corr_mean_cat.csv")

net$record_id <- as.numeric(net$record_id)
net$group[ net$record_id < 40000 ] <- "YA"
net$group[ net$record_id >= 40000] <- "OA"


t.test(average_local_efficiency_mean ~ group, data = net)
net%>%  
  ggplot(aes(y = average_local_efficiency_mean, x = group, fill = group)) +
  geom_boxplot(fill = brewer.pal(8, "Paired")[7:8]) +  
  theme_classic() 

t.test(degree_assortativity_coefficient_mean ~ group, data = net)
net%>%  
  ggplot(aes(y = degree_assortativity_coefficient_mean, x = group, fill = group)) +
  geom_boxplot(fill = brewer.pal(8, "Paired")[7:8]) +  
  theme_classic() 

t.test(global_efficiency_mean ~ group, data = net)
net%>%  
  ggplot(aes(y = global_efficiency_mean, x = group, fill = group)) +
  geom_boxplot(fill = brewer.pal(8, "Paired")[7:8]) +  
  theme_classic() 

t.test(transitivity_mean ~ group, data = net)
net%>%  
  ggplot(aes(y = transitivity_mean, x = group, fill = group)) +
  geom_boxplot(fill = brewer.pal(8, "Paired")[7:8]) +  
  theme_classic() 

t.test(average_clustering_mean ~ group, data = net)
net%>%  
  ggplot(aes(y = average_clustering_mean, x = group, fill = group)) +
  geom_boxplot(fill = brewer.pal(8, "Paired")[7:8]) +  
  theme_classic() 

-------
  
d1 <- read.csv("~/Box/ADM_Study/ADM/data/combined_data_2018-11-19.csv")

d2 <- dplyr::select(d1, record_id, group, IS:fnlrgact, age, sex, edu,
                    -M10_start_diff, -L5_start_diff,-M10_starttime, -L5_starttime)

d <- merge(d2, net, by = "record_id")

d$sex[substr(d$sex, 0, 1) == "f" | substr(d$sex, 0, 1) == "F"] <- "F"
d$sex[substr(d$sex, 0, 1) == "m" | substr(d$sex, 0, 1) == "M"] <- "M"
d$sex <- factor(d$sex)


d$edu <- substr(d$edu, 0, 2)
d$edu <- str_pad(d$edu, 2, pad = "0")
d$edu <- as.numeric(d$edu)

d %>%
  group_by(group.x) %>%
  summarize(N = n(), 
            age_mean = mean(age), age_sd = sd(age), 
            Female = sum(sex == "F"), Male = sum(sex == "M"),
            years_edu = mean(edu), edu_sd = sd(edu))


d2 <- dplyr::select(d,-transitivity_mean, -transitivity_std_dev)

d2_YA <- subset(d2, d2$group.x == "YA")
d2_OA <- subset(d2, d2$group.x == "OA")
d2 <- dplyr::select(d2,-group.x, -record_id, -group.y)
d2_YA <- dplyr::select(d2_YA,-group.x, -record_id, -group.y)
d2_OA <- dplyr::select(d2_OA,-group.x, -record_id, -group.y)
#d2[c("group")] <- list(NULL); d2_OA[c("group")] <- list(NULL); d2_YA[c("group")] <- list(NULL)

d2[,2:length(d2)] <- sapply(d2[,2:length(d2)],as.numeric)
d2 <- d2[complete.cases(d2),]

d2_YA[,2:length(d2_YA)] <- sapply(d2_YA[,2:length(d2_YA)],as.numeric)
d2_YA <- d2_YA[complete.cases(d2_YA),]

d2_OA[,2:length(d2_OA)] <- sapply(d2_OA[,2:length(d2_OA)],as.numeric)
d2_OA <- d2_OA[complete.cases(d2_OA),]

d2_cor <- cor(d2, method = "pearson")
d2_cor_OA <- cor(d2_OA, method = "pearson")
d2_cor_YA <- cor(d2_YA, method = "pearson")

ggcorrplot(d2_cor, p.mat = cor_pmat(d2), colors = c("red", "white", "orange"), ggtheme = ggplot2::theme_minimal, hc.order = FALSE, insig = 'blank')

ggcorrplot(d2_cor_YA, p.mat = cor_pmat(d2_YA), colors = c("red", "white", "orange"), ggtheme = ggplot2::theme_minimal, hc.order = FALSE, insig = 'blank')

ggcorrplot(d2_cor_OA, p.mat = cor_pmat(d2_OA), colors = c("red", "white", "orange"), ggtheme = ggplot2::theme_minimal, hc.order = FALSE, insig = 'blank')


