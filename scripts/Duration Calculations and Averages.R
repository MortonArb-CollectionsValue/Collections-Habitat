#Libraries
install.packages("devtools")
library('devtools')
devtools::install_github("usa-npn/rnpn")

library(googlesheets4); library(car); library(lubridate)
library(ggplot2)

if(!dir.exists("../data")) dir.create("../data/")
if(!dir.exists("../figures/")) dir.create("../figures/")

source("clean_google_form.R")

# Downloading 2019 data
quercus19 <- clean.google(collection="Quercus", dat.yr=2019)
quercus19$Collection <- as.factor("Quercus")
quercus19$Year <- lubridate::year(quercus19$Date.Observed)
summary(quercus19)

# Downloading 2018 data
quercus18 <- clean.google(collection="Quercus", dat.yr=2018)
quercus18$Collection <- as.factor("Quercus")
quercus18$Year <- lubridate::year(quercus18$Date.Observed)
summary(quercus18)

quercus.all <- rbind(quercus18, quercus19)

quercus.all$yday <- lubridate::yday(quercus.all$Date.Observed)

#-----------------------------------Calculations
#First leaf to last leaf
quercus.firstleaf <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday<"180" & quercus.all$leaf.present.observed=="Yes",], FUN=min)
names(quercus.firstleaf)[names( quercus.firstleaf)=="yday"] <- "yday.firstleaf"

quercus.lastleaf <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday>"180" & quercus.all$leaf.present.observed=="Yes",], FUN=max)
names(quercus.lastleaf)[names( quercus.lastleaf)=="yday"] <- "yday.lastleaf"

quercus.summary1 <- merge(quercus.firstleaf, quercus.lastleaf, all=T)

quercus.summary1$duration1 <- quercus.summary1$yday.lastleaf-quercus.summary1$yday.firstleaf

#2: first budburst to last leaf

quercus.firstbudburst <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.breaking.buds.observed=="Yes",], FUN=min)
names(quercus.firstbudburst)[names( quercus.firstbudburst)=="yday"] <- "yday.firstbudburst"

quercus.summary2<- merge(quercus.lastleaf, quercus.firstbudburst, all=T)

quercus.summary2$duration2 <- quercus.summary2$yday.lastleaf-quercus.summary2$yday.firstbudburst

#3: first budburst to fall color

quercus.fallcolor <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes",], FUN=min)
names(quercus.fallcolor)[names( quercus.fallcolor)=="yday"] <- "yday.fallcolor"

quercus.summary3<- merge(quercus.firstbudburst, quercus.fallcolor, all=T)

quercus.summary3$duration3 <- quercus.summary3$yday.fallcolor-quercus.summary3$yday.firstbudburst

#4: first leaf to fall color

quercus.fallcolor <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes",], FUN=min)
names(quercus.fallcolor)[names( quercus.fallcolor)=="yday"] <- "yday.fallcolor"


quercus.summary4<- merge(quercus.firstleaf, quercus.fallcolor, all=T)

quercus.summary4$duration4 <- quercus.summary4$yday.fallcolor-quercus.summary4$yday.firstleaf

# Saving durations

write.csv(quercus.summary1, "../data/Durations_First_leaf_last_leaf.csv", row.names=F)
write.csv(quercus.summary2, "../data/Durations_First_budburst_last_leaf.csv", row.names=F)
write.csv(quercus.summary3, "../data/Durations_First_budburst_fall_color.csv", row.names=F)
write.csv(quercus.summary4, "../data/Durations_First_leaf_fall_color.csv", row.names=F)

# Average duration by species and year

duration1average <- aggregate(duration1 ~ PlantNumber+Year, data=quercus.summary1, FUN=mean)
summary(duration1average)

duration2average <- aggregate(duration2 ~ PlantNumber+Year, data=quercus.summary2, FUN=mean)
summary(duration2average)

duration3average <- aggregate(duration3 ~ PlantNumber+Year, data=quercus.summary3, FUN=mean)
summary(duration3average)

duration4average <- aggregate(duration4 ~ PlantNumber+Year, data=quercus.summary4, FUN=mean)
summary(duration4average)

#graphing

duration1average <- ggplot(data=quercus.summary1) +
  facet_grid(Year ~ .) + 
  geom_boxplot(aes(x=Species, y=duration1)) +
  guides(fill=F)
duration1average

duration2average <- ggplot(data=quercus.summary2) +
  facet_grid(Year ~ .) +
  geom_boxplot(aes(x=Species, y=duration2)) +
  guides(fill=F)
duration2average

duration3average <- ggplot(data=quercus.summary3) +
  facet_grid(Year ~ .) +
  geom_boxplot(aes(x=Species, y=duration3)) +
  guides(fill=F)
duration3average

duration4average <- ggplot(data=quercus.summary4) +
  facet_grid(Year ~ .) +
  geom_boxplot(aes(x=Species, y=duration4)) +
  guides(fill=F)
duration4average

png("../figures/Duration1Averages.png", height=6, width=6, units="in", res=180)
duration1average
dev.off()

png("../figures/Duration2Averages.png", height=6, width=6, units="in", res=180)
duration2average
dev.off()

png("../figures/Duration3Averages.png", height=6, width=6, units="in", res=180)
duration3average
dev.off()

png("../figures/Duration4Averages.png", height=6, width=6, units="in", res=180)
duration4average
dev.off()


