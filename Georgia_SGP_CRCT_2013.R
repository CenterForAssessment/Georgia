#########################################################
###
### Calculate SGPs for Georgia - 2013
###
##########################################################

### Load SGP Package

require(SGP)

### Load Georgia SGP object

load("Data/Georgia_SGP.Rdata")


### prepareSGP

Georgia_SGP <- prepareSGP(Georgia_SGP)


### AnalyzeSGP : Grade level CRCT tests

Georgia_SGP <- analyzeSGP(
			Georgia_SGP,
			years='2013',
			content_areas=c("ELA", "READING", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES"),
			sgp.percentiles=TRUE,
			sgp.projections=TRUE,
			sgp.projections.lagged=TRUE,
			sgp.percentiles.baseline=TRUE,
			sgp.projections.baseline=TRUE,
			sgp.projections.lagged.baseline=TRUE,
			simulate.sgps=TRUE,
			parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=10, BASELINE_PERCENTILES=10, PROJECTIONS=5, LAGGED_PROJECTIONS=5)))

### Save Results

save(Georgia_SGP, file="Data/Georgia_SGP-2013_CRCT.Rdata")
