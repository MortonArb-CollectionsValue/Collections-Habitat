# Examples for how to download and save datasets
# 1. Downloading data from The Morton Arboretum
# 2. Downloading data from NPN

# *** comment these lines out after installing rnpn**  
# VERY IMPORTANT NOTE: DO NOT INSTALL rnpn FROM CRAN!! 
# It MUST be installed form github to have the functions we need
install.packages("devtools")
library('devtools')
devtools::install_github("usa-npn/rnpn")

library(googlesheets4); library(car); library(lubridate)
library(ggplot2)

#
# Making some directories to help with organization
## NOTE: This assumes you opened R by double-clicking this script in your github folder.  Your working directory (in the bar of the "Console" tab) should be [SOMETHIGN]/Collections-Habitat/scripts
# If it's not, you'll need to set your working directory to be here
# Once you do that, we can use the same file paths without having to worry about differences in where your github folder is vs. mine

if(!dir.exists("../data")) dir.create("../data/")
if(!dir.exists("../figures/")) dir.create("../figures/")

# -----------------------------------
# 1. Arb Data
# -----------------------------------
source("clean_google_form.R")


# For your project we'll want the 2018 and 2019 Oak data
# ** First Time: Make sure to follow the prompts in the console**
# It will take a few moments/minutes for the script to run
# Ignore the warnings -- it's stuff the function fixes

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

# Putting 2019 and 2018 into the same data frame to make working with it easier (in the long run; might be hard at first)
quercus.all <- rbind(quercus18, quercus19)
summary(quercus.all) # makign sure this worked; check date & year columns to make sure they make sense

# Creating a yday (day of year) column that you'll want to do all of your indexing
quercus.all$yday <- lubridate::yday(quercus.all$Date.Observed)
summary(quercus.all)

# Making a figure -- what is this figure telling us?
histo.time <- ggplot(data=quercus.all) +
  facet_grid(Year ~ .) +
  geom_histogram(aes(x=yday, fill=Species), binwidth=7) +
  guides(fill=F) # Turning off the color legend because there's just too many species
histo.time # prints the figure in the plot plan

# Saving the graph as a file to make it easier to find without booting up R; this is important for making reports
png("../figures/Quercus_MortonArb_TimeHisto.png", height=6, width=6, units="in", res=180)
histo.time
dev.off()


# Save the dataset so we can use it later without having to start form scratchg
# Note the consistent naming scheme w/ the figure saves
write.csv(quercus.all, "../data/Quercus_MortonArb_2018-2019.csv", row.names=F)
# -----------------------------------
#------------------------------------PLots
ggplot(quercus.all[quercus.all$PlantNumber=="392-2011*1"&quercus.all$Year=="2019"&quercus.all$leaf.present.observed=="Yes",], aes(x=yday, y=leaf.present.observed, color=Observer)) +
  geom_point() 
#+  facet_wrap(~Year)

#-----------------------------------Calculations
#First leaf to last leaf
quercus.firstleaf <- aggregate(yday ~ PlantNumber + Year, data=quercus.all[quercus.all$yday<"180" & quercus.all$leaf.present.observed=="Yes",], FUN=min)
summary(quercus.firstleaf)
head(quercus.firstleaf)
names(quercus.firstleaf)[names( quercus.firstleaf)=="yday"] <- "yday.firstleaf"

quercus.lastleaf <- aggregate(yday ~ PlantNumber + Year, data=quercus.all[quercus.all$yday>"180" & quercus.all$leaf.present.observed=="Yes",], FUN=max)
summary(quercus.lastleaf)
head(quercus.lastleaf)
names(quercus.lastleaf)[names( quercus.lastleaf)=="yday"] <- "yday.lastleaf"

quercus.summary1 <- merge(quercus.firstleaf, quercus.lastleaf, all=T)
summary(quercus.summary1)

quercus.summary1$duration1 <- quercus.summary1$yday.lastleaf-quercus.summary1$yday.firstleaf
summary(quercus.summary1)
head(quercus.summary1)

hist(quercus.summary1$duration1)

#2: first budburst to last leaf

quercus.firstbudburst <- aggregate(yday ~ PlantNumber + Year, data=quercus.all[quercus.all$leaf.breaking.buds.observed=="Yes",], FUN=min)
summary(quercus.firstbudburst)
head(quercus.firstbudburst)
names(quercus.firstbudburst)[names( quercus.firstbudburst)=="yday"] <- "yday.firstbudburst"


quercus.summary2<- merge(quercus.lastleaf, quercus.firstbudburst, all=T)
summary(quercus.summary2)

quercus.summary2$duration2 <- quercus.summary2$yday.lastleaf-quercus.summary2$yday.firstbudburst
summary(quercus.summary2)
head(quercus.summary2)

hist(quercus.summary2$duration2)

#3: first budburst to fall color

quercus.fallcolor <- aggregate(yday ~ PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes",], FUN=min)
summary(quercus.fallcolor)
head(quercus.fallcolor)
names(quercus.fallcolor)[names( quercus.fallcolor)=="yday"] <- "yday.fallcolor"


quercus.summary3<- merge(quercus.firstbudburst, quercus.fallcolor, all=T)
summary(quercus.summary3)

quercus.summary3$duration3 <- quercus.summary3$yday.fallcolor-quercus.summary3$yday.firstbudburst
summary(quercus.summary3)
head(quercus.summary3)

hist(quercus.summary3$duration3)

#4: first leaf to fall color

quercus.fallcolor <- aggregate(yday ~ PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes",], FUN=min)
summary(quercus.fallcolor)
head(quercus.fallcolor)
names(quercus.fallcolor)[names( quercus.fallcolor)=="yday"] <- "yday.fallcolor"


quercus.summary4<- merge(quercus.firstleaf, quercus.fallcolor, all=T)
summary(quercus.summary3)

quercus.summary4$duration4 <- quercus.summary4$yday.fallcolor-quercus.summary4$yday.firstleaf
summary(quercus.summary4)
head(quercus.summary4)

hist(quercus.summary4$duration4)


# Saving durations

write.csv(quercus.summary1$duration1, "../data/Durations_First_leaf_last_leaf.csv", row.names=F)
write.csv(quercus.summary2$duration2, "../data/Durations_First_budburst_last_leaf.csv", row.names=F)
write.csv(quercus.summary3$duration3, "../data/Durations_First_budburst_fall_color.csv", row.names=F)
write.csv(quercus.summary4$duration4, "../data/Durations_First_leaf_fall_color.csv", row.names=F)

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

histo.duration1average <- ggplot(data=duration1average) +
  #facet_grid(Year ~ .) + unsure if this is needed if we are just comparing season durations?
  geom_histogram(aes(x=duration1,),binwidth = 10) +
  guides(fill=F)
histo.duration1average

histo.duration2average <- ggplot(data=duration2average) +
  geom_histogram(aes(x=duration2,),binwidth = 10) +
  guides(fill=F)
histo.duration2average

histo.duration3average <- ggplot(data=duration1average) +
  geom_histogram(aes(x=duration3,),binwidth = 10) +
  guides(fill=F)
histo.duration3average

histo.duration4average <- ggplot(data=duration4average) +
  geom_histogram(aes(x=duration4,),binwidth = 10) +
  guides(fill=F)
histo.duration4average

png("../figures/Quercus_Duration1Averages.png", height=6, width=6, units="in", res=180)
histo.time
dev.off()

png("../figures/Quercus_Duration2Averages.png", height=6, width=6, units="in", res=180)
histo.time
dev.off()

png("../figures/Quercus_Duration3Averages.png", height=6, width=6, units="in", res=180)
histo.time
dev.off()

png("../figures/Quercus_Duration4Averages.png", height=6, width=6, units="in", res=180)
histo.time
dev.off()

# -----------------------------------
# 2. Downloading NPN data
# **** NOTE: rnpn needs to be installed from GITHUB -- not CRAN! ****
#  i.e. you can NOT just do library('rnpn') -- you'll have an older version
# -----------------------------------
path.NPN <- "../data_raw/NPN/uncleaned"
if(!dir.exists(path.NPN)) dir.create(path.NPN)

library(rnpn)
species.name <- 'Q.alba'

# To get pre-summarized data, use npn_donwload_individual_phenometrics
# to get help: ?npn_download_individual_phenometrics 
npn.spp <- npn_species()
npn.quercus <- npn.spp[npn.spp$genus=="Quercus",]

oak.leaf <- npn_download_individual_phenometrics(phenophase_ids =c(371, 483),species_ids=npn.quercus$species_id[npn.quercus$species=="alba"], years=2000:2019, request_source="The Morton Arboretum")
oak.leaf[oak.leaf==-9999] <- NA
dim(oak.leaf)

#Bud Burst and Leaves will be the two phenophases of most interest because we care about Spring phenology
oak.budburst <- oak.leaf[oak.leaf$phenophase_id == '371']
summary(oak.budburst)
oak.leaves <- oak.leaf[oak.leaf$phenophase_id == '483']
summary(oak.leaves)

#260 individual trees for White Oak "Breaking Leaf Buds" 
length(unique(oak.budburst$individual_id))

#261 individual trees for White Oak "Leaves"
length(unique(oak.leaves$individual_id))

#taking a look at the trends of the first observations for leaves and bud burst
hist(oak.budburst$first_yes_doy)
hist(oak.leaves$first_yes_doy)

#saving the raw NPN data which has no filters set on it. This is just what all Q. alba data NPN has for 371 'Breaking Leaf Buds' and 483 'Leaves' 
write.csv(oak.leaf, file.path(paste0('../data/NPN_Quercus_Raw_', species.name, '.csv')), row.names=F)

