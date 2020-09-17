library(nlme)

spp.sub <- paste("Quercus", c("alba", "lusitanica", "lyrata", "macranthera", "macrocarpa", "mongolica", "pyrenaica"))

quercus.subset <- quercus.summary1[quercus.summary1$Species %in% spp.sub, ]

quercus.subset2 <- quercus.summary2[quercus.summary1$Species %in% spp.sub, ]

quercus.subset3 <- quercus.summary3[quercus.summary1$Species %in% spp.sub, ]

quercus.subset4 <- quercus.summary4[quercus.summary1$Species %in% spp.sub, ]

#duration 1

mod1 <- lm(duration1 ~ Species + PlantNumber + Year, data=quercus.subset)
summary(mod1)
anova(mod1)

#comparing to alba
lme1 <- lme(duration1 ~ Species, random=list(PlantNumber=~1, Year=~1), data=quercus.subset, na.action=na.omit)
summary(lme1)
summary(mod1)
#comparing to macrocarpa
lme2 <- lme(duration1 ~ relevel(Species, "Quercus macrocarpa"), random=list(PlantNumber=~1, Year=~1), data=quercus.subset, na.action=na.omit)
summary(lme2)

#duration 2

mod2 <- lm(duration2 ~ Species + PlantNumber + Year, data=quercus.subset2)
summary(mod2)
anova(mod2)

#have to compare to macrocarpa for this one - there is no duration 2 value for alba
lme3 <- lme(duration2 ~ relevel(Species, "Quercus macrocarpa"), random=list(PlantNumber=~1, Year=~1), data=quercus.subset2, na.action=na.omit)
summary(lme3)

#duration 3

mod3 <- lm(duration3 ~ Species + PlantNumber + Year, data=quercus.subset3)
summary(mod3)
anova(mod3)

#comparing to alba
lme4 <- lme(duration3 ~ Species, random=list(PlantNumber=~1, Year=~1), data=quercus.subset3, na.action=na.omit)
summary(lme4)

#comparing to macrocarpa
lme5 <- lme(duration3 ~ relevel(Species, "Quercus macrocarpa"), random=list(PlantNumber=~1, Year=~1), data=quercus.subset3, na.action=na.omit)
summary(lme5)

#duration 4
mod4 <- lm(duration4 ~ Species + PlantNumber + Year, data=quercus.subset4)
summary(mod4)
anova(mod4)

#comparing to alba
lme6 <- lme(duration4 ~ Species, random=list(PlantNumber=~1, Year=~1), data=quercus.subset4, na.action=na.omit)

#comparing to macrocarpa
lme7 <- lme(duration4 ~ relevel(Species, "Quercus macrocarpa"), random=list(PlantNumber=~1, Year=~1), data=quercus.subset4, na.action=na.omit)
summary(lme7)
