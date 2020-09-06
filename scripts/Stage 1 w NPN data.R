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

###duration 1: first leaf to last leaf

npn.firstleaf <- aggregate(yday ~ PlantNumber + Year, data=oak.leaf[oak.leaf$yday<"180" & quercus.all$leaf.present.observed=="Yes",], FUN=min)
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