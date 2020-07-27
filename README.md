# Collections-Habitat
Preliminary of analysis of habitat suitability for a subset of species

Preliminary README copied from a Google Doc to get @AlenaSpreitzer started.

# Assessment of Habitat Suitability for Trees in The Morton Arboretum Living Collections
Intern Project 2020: Alena Spreitzer

## Background (Unscientific)
When analyzing the growing degree-day thresholds associated with budburst phenology at The Morton Arboretum, curator Matt Lobdell noted that some species that stuck out in the above figure like Q. lyrata are not doing well and appear very stressed and sickly.  The Forest Ecology research group came up with a few hypotheses for why this might be.  These hypotheses are based on collective work of the research group, particularly the following Projects

[add links]
Living Collections Phenology Monitoring
2020 REU Project: Phenology Modeling
IMLS Collections Value -- Ecological Value & Habitat Suitability

## Hypothesis 1: Phenology
### Hypothesis: 
We hypothesize that these species are leafing out later than other species that are doing well and are expencing shorter growing seasons compared to species that are doing well.  
#### Stage 1: We predict that when we compare the growing season length as defined by the time between budburst (budburst = Yes and/or leaves = Yes in our phenology data) and senescence (leaves=N), these species have shorter seasons than native species and species doing well at the Arb.  
#### Stage 2: We further predict that in their native ranges, the growing degree-day threshold is reached much earlier in the year and these species have longer growing seasons in their native ranges.
### Study Design:
#### Stage 1: Analysis at The Morton Arboretum
1. Calculate the day of year for start- and end-of-season in each year for the different species in the oak collection
Start-of-season: First budburst, first leaf 
End-of-season: leaf color (talk to Lucien), last leaf
2. Calculate the Growing Season Duration in number of days: Day of end-of-season minus day of start-of-season
There should be 4 duration values (each possible combination) that we will look at because we don’t know which is best yet
3. Compare growing season duration among species
Graphically
Analysis
#### Stage 2: Comparison with native range; if species is in National Phenology Network, 
repeat Stage 1 using NPN data
#### Stage 3: Comparison with native range if species is NOT in National Phenology Network -- Revisit after alternate hypothesis about ecological niche
Model growing-degree-day threshold for bud-burst using phenology data
Talk to Lucien Fitzpatrick (and/or Andrew Ernat)
Extract temperature data for 1980-2019 from Daymet using occurrence points from IMLS project (below/Lucien)
Calculate predicted day of budburst: what day of year is modeled GDD threshold crossed? (Talk to Lucien Fitzpatrick)
Compare the predicted day of budburst at The Morton Arboretum with the average date of budburst for native range
NOTE: we won’t try to model senescence because the science isn’t robust for it yet.  If we get to super-bonus-land, we can try using the MODIS end-of-season data

## Hypothesis 2: Arb Outside Ecological Niche
### Hypothesis: 
The habitat (ecological niche) for the species is controlled by many interacting factors including soils and climate and that the Arboretum lies outside the conditions occupied by the species in its dominant niche axes (e.g. soils, climate). 


### Background (Google Slides presentation)
### Study Design: IMLS Methods Workflow
1. Use Occurrence points to extract environmental predictors for species currently in collections plus The Morton Arboretum; Start with just US species
Climate: Daymet
Soils: 
SoildGrids (easier, but less reliable)
gSSURGO (more reliable, but a pain in the butt)
Topography: Digital Elevation Models
Biome/Ecoregion: WWF ecoregions
2. Use Nonmetric Nondimensional Scaling (vegan package in R) to perform an ordination
3. Calculate convex hulls 
4. Graph ordination results; 
5. Calculate distance of Arb to species centroid or convex hull edge

