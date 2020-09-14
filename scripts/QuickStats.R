summary(quercus.summary1)

spp.sub <- paste("Quercus", c("alba", "lusitanica", "lyrata", "macranthera", "macrocarpa", "mongolica", "pyrenaica"))

quercus.subset <- quercus.summary1[quercus.summary1$Species %in% spp.sub, ]
summary(quercus.subset)

# A visualization of the comparisons we want to make
ggplot(data=quercus.subset) +
  facet_grid(Year ~ .) + 
  geom_boxplot(aes(x=Species, y=duration1)) +
  guides(fill=F) +
  theme(axis.text.x = element_text(angle=-15, hjust=0))
  
# All stats are variations of y=mx+b; y = dependent variable; x=independent (predictors)
#  -- R will calculate m & b
# We can always start with a linear regression model (lm)
mod1 <- lm(duration1 ~ Species, data=quercus.subset)
summary(mod1)
anova(mod1)

# Confoudning factors; sources of non-independence:
# -- physical location; age of tree; weather affecting
# -- what we have is hierarchical data bc there's an order and different levels
mod2 <- lm(duration1 ~ Species + PlantNumber + Year, data=quercus.subset)
summary(mod2)
anova(mod2)

# We're going to do a hierarchical or linear mixed model to account for  non-independence
library(nlme)
lme1 <- lme(duration1 ~ Species, random=list(PlantNumber=~1, Year=~1), data=quercus.subset, na.action=na.omit)
summary(lme1)
summary(mod1)

lme2 <- lme(duration1 ~ relevel(Species, "Quercus macrocarpa"), random=list(PlantNumber=~1, Year=~1), data=quercus.subset, na.action=na.omit)
summary(lme2)
summary(mod2)
