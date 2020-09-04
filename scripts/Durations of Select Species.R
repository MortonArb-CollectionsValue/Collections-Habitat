#Durations of select species
#1.1: Macrocarpa, first leaf to last leaf
flmac <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday<"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus macrocarpa",], FUN=min)
names(flmac)[names( flmac)=="yday"] <- "yday.firstleaf"

llmac <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday>"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus macrocarpa",], FUN=max)
names(llmac)[names( llmac)=="yday"] <- "yday.lastleaf"

macrocarpa1 <- merge(flmac, llmac, all=T)

macrocarpa1$d1 <- macrocarpa1$yday.lastleaf-macrocarpa1$yday.firstleaf

#2.1: Macrocarpa, first budburst to last leaf
fbmac <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.breaking.buds.observed=="Yes" & quercus.all$Species=="Quercus macrocarpa",], FUN=min)
names(fbmac)[names( fbmac)=="yday"] <- "yday.firstbudburst"

macrocarpa2<- merge(llmac, fbmac, all=T)

macrocarpa2$d2 <- macrocarpa2$yday.lastleaf-macrocarpa2$yday.firstbudburst

#3.1: Macrocarpa, first budburst to fall color
fcmac <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes" & quercus.all$Species=="Quercus macrocarpa",], FUN=min)
names(fcmac)[names(fcmac)=="yday"] <- "yday.fallcolor"

macrocarpa3<- merge(fbmac, fcmac, all=T)

macrocarpa3$d3 <- macrocarpa3$yday.fallcolor-macrocarpa3$yday.firstbudburst

#4.1: Macrocarpa, first leaf to fall color
macrocarpa4<- merge(flmac, fcmac, all=T)

macrocarpa4$d4 <- macrocarpa4$yday.fallcolor-macrocarpa4$yday.firstleaf

#1.2: Alba, first leaf to last leaf
flalb <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday<"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus alba",], FUN=min)
names(flalb)[names( flalb)=="yday"] <- "yday.firstleaf"

llalb <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday>"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus alba",], FUN=max)
names(llalb)[names( llalb)=="yday"] <- "yday.lastleaf"

alba1 <- merge(flalb, llalb, all=T)

alba1$d1 <- alba1$yday.lastleaf-alba1$yday.firstleaf

#2.2: Alba, first budburst to last leaf
fbalb <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.breaking.buds.observed=="Yes" & quercus.all$Species=="Quercus alba",], FUN=min)
names(fbalb)[names( fbalb)=="yday"] <- "yday.firstbudburst"

alba2<- merge(llmac, fbmac, all=T)

alba2$d2 <- alba2$yday.lastleaf-alba2$yday.firstbudburst

#3.2: Alba, first budburst to fall color
fcalb <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes" & quercus.all$Species=="Quercus alba",], FUN=min)
names(fcalb)[names(fcalb)=="yday"] <- "yday.fallcolor"

alba3<- merge(fbalb, fcalb, all=T)

alba3$d3 <- alba3$yday.fallcolor-alba3$yday.firstbudburst
summary(alba3)
#4.2: Alba, first leaf to fall color
alba4<- merge(flalb, fcalb, all=T)

alba4$d4 <- alba4$yday.fallcolor-alba4$yday.firstleaf

#1.3: lyrata, first leaf to last leaf
fllyr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday<"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus lyrata",], FUN=min)
names(fllyr)[names(fllyr)=="yday"] <- "yday.firstleaf"

lllyr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday>"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus lyrata",], FUN=max)
names(lllyr)[names( lllyr)=="yday"] <- "yday.lastleaf"

lyrata1 <- merge(fllyr, lllyr, all=T)

lyrata1$d1 <- lyrata1$yday.lastleaf-lyrata1$yday.firstleaf

#2.3: lyrata, first budburst to last leaf
fblyr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.breaking.buds.observed=="Yes" & quercus.all$Species=="Quercus lyrata",], FUN=min)
names(fblyr)[names(fblyr)=="yday"] <- "yday.firstbudburst"

lyrata2<- merge(lllyr, fblyr, all=T)

lyrata2$d2 <- lyrata2$yday.lastleaf-lyrata2$yday.firstbudburst
summary(lyrata2)

#3.3: lyrata, first budburst to fall color
fclyr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes" & quercus.all$Species=="Quercus lyrata",], FUN=min)
names(fclyr)[names(fclyr)=="yday"] <- "yday.fallcolor"

lyrata3<- merge(fblyr, fclyr, all=T)

lyrata3$d3 <- lyrata3$yday.fallcolor-lyrata3$yday.firstbudburst
summary(lyrata3)

#4.3: lyrata, first leaf to fall color
lyrata4<- merge(fllyr, fclyr, all=T)

lyrata4$d4 <- lyrata4$yday.fallcolor-lyrata4$yday.firstleaf

#1.4: lusitanica, first leaf to last leaf
fllus <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday<"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus lusitanica",], FUN=min)
names(fllus)[names(fllus)=="yday"] <- "yday.firstleaf"

lllus <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday>"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus lusitanica",], FUN=max)
names(lllus)[names(lllus)=="yday"] <- "yday.lastleaf"

lusitanica1 <- merge(fllus, lllus, all=T)

lusitanica1$d1 <- lusitanica1$yday.lastleaf-lusitanica1$yday.firstleaf

#2.4: lusitanica, first budburst to last leaf
fblus <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.breaking.buds.observed=="Yes" & quercus.all$Species=="Quercus lusitanica",], FUN=min)
names(fblus)[names(fblus)=="yday"] <- "yday.firstbudburst"

lusitanica2<- merge(lllus, fblus, all=T)

lusitanica2$d2 <- lusitanica2$yday.lastleaf-lusitanica2$yday.firstbudburst

#3.4: lusitanica, first budburst to fall color
fclus <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes" & quercus.all$Species=="Quercus lusitanica",], FUN=min)
names(fclus)[names(fclus)=="yday"] <- "yday.fallcolor"

lusitanica3<- merge(fblus, fclus, all=T)

lusitanica3$d3 <- lusitanica3$yday.fallcolor-lusitanica3$yday.firstbudburst

#4.4: lusitanica, first leaf to fall color
lusitanica4<- merge(fllus, fclus, all=T)

lusitanica4$d4 <- lusitanica4$yday.fallcolor-lusitanica4$yday.firstleaf

#1.5: pyrenaica, first leaf to last leaf
flpyr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday<"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus pyrenaica",], FUN=min)
names(flpyr)[names(flpyr)=="yday"] <- "yday.firstleaf"

llpyr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday>"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus pyrenaica",], FUN=max)
names(llpyr)[names(llpyr)=="yday"] <- "yday.lastleaf"

pyrenaica1 <- merge(flpyr, llpyr, all=T)

pyrenaica1$d1 <- pyrenaica1$yday.lastleaf-pyrenaica1$yday.firstleaf

#2.5: pyrenaica, first budburst to last leaf
fbpyr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.breaking.buds.observed=="Yes" & quercus.all$Species=="Quercus pyrenaica",], FUN=min)
names(fbpyr)[names(fbpyr)=="yday"] <- "yday.firstbudburst"

pyrenaica2<- merge(llpyr, fbpyr, all=T)

pyrenaica2$d2 <- pyrenaica2$yday.lastleaf-pyrenaica2$yday.firstbudburst

#3.5: pyrenaica, first budburst to fall color
fcpyr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes" & quercus.all$Species=="Quercus pyrenaica",], FUN=min)
names(fcpyr)[names(fcpyr)=="yday"] <- "yday.fallcolor"

pyrenaica3<- merge(fbpyr, fcpyr, all=T)

pyrenaica3$d3 <- pyrenaica3$yday.fallcolor-pyrenaica3$yday.firstbudburst

#4.5: pyrenaica, first leaf to fall color
pyrenaica4<- merge(flpyr, fcpyr, all=T)

pyrenaica4$d4 <- pyrenaica4$yday.fallcolor-pyrenaica4$yday.firstleaf

#1.6: mongolica, first leaf to last leaf
flmon <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday<"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus mongolica",], FUN=min)
names(flmon)[names(flmon)=="yday"] <- "yday.firstleaf"

llmon <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday>"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus mongolica",], FUN=max)
names(llmon)[names(llmon)=="yday"] <- "yday.lastleaf"

mongolica1 <- merge(flmon, llmon, all=T)

mongolica1$d1 <- mongolica1$yday.lastleaf-mongolica1$yday.firstleaf

#2.6: mongolica, first budburst to last leaf
fbmon <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.breaking.buds.observed=="Yes" & quercus.all$Species=="Quercus mongolica",], FUN=min)
names(fbmon)[names(fbmon)=="yday"] <- "yday.firstbudburst"

mongolica2<- merge(llmon, fbmon, all=T)

mongolica2$d2 <- mongolica2$yday.lastleaf-mongolica2$yday.firstbudburst

#3.6: mongolica, first budburst to fall color
fcmon <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes" & quercus.all$Species=="Quercus mongolica",], FUN=min)
names(fcmon)[names(fcmon)=="yday"] <- "yday.fallcolor"

mongolica3<- merge(fbmon, fcmon, all=T)

mongolica3$d3 <- mongolica3$yday.fallcolor-mongolica3$yday.firstbudburst

#4.6: mongolica, first leaf to fall color
mongolica4<- merge(flmon, fcmon, all=T)

mongolica4$d4 <- mongolica4$yday.fallcolor-mongolica4$yday.firstleaf

#1.7: macranthera, first leaf to last leaf
flmacr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday<"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus macranthera",], FUN=min)
names(flmacr)[names(flmacr)=="yday"] <- "yday.firstleaf"

llmacr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$yday>"180" & quercus.all$leaf.present.observed=="Yes" & quercus.all$Species=="Quercus macranthera",], FUN=max)
names(llmacr)[names(llmacr)=="yday"] <- "yday.lastleaf"

macranthera1 <- merge(flmacr, llmacr, all=T)

macranthera1$d1 <- macranthera1$yday.lastleaf-macranthera1$yday.firstleaf

#2.7: macranthera, first budburst to last leaf
fbmacr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.breaking.buds.observed=="Yes" & quercus.all$Species=="Quercus macranthera",], FUN=min)
names(fbmacr)[names(fbmacr)=="yday"] <- "yday.firstbudburst"

macranthera2<- merge(llmacr, fbmacr, all=T)


macranthera2$d2 <- macranthera2$yday.lastleaf-macranthera2$yday.firstbudburst

#3.7: macranthera, first budburst to fall color
fcmacr <- aggregate(yday ~ Species + PlantNumber + Year, data=quercus.all[quercus.all$leaf.color.observed=="Yes" & quercus.all$Species=="Quercus macranthera",], FUN=min)
names(fcmacr)[names(fcmacr)=="yday"] <- "yday.fallcolor"

macranthera3<- merge(fbmacr, fcmacr, all=T)

macranthera3$d3 <- macranthera3$yday.fallcolor-macranthera3$yday.firstbudburst

#4.7: macranthera, first leaf to fall color
macranthera4<- merge(flmacr, fcmacr, all=T)

macranthera4$d4 <- macranthera4$yday.fallcolor-macranthera4$yday.firstleaf



