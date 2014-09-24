#########################################################
###
### Calculate SGPs for Georgia - 2014
###
##########################################################

### Load SGP Package

require(SGP)

### Load Georgia SGP object

load("Georgia_SGP.Rdata")
load('Georgia/Data/Georgia_Baseline_Matrices.Rdata' )

### prepareSGP

Georgia_SGP <- prepareSGP(Georgia_SGP)


### AnalyzeSGP : Grade level CRCT tests

SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- Georgia_Baseline_Matrices

Georgia_SGP <- analyzeSGP(
			Georgia_SGP,
			years='2014',
			content_areas=c("ELA", "READING", "MATHEMATICS", "SOCIAL_STUDIES"), # "SCIENCE" is produced in SGP_Config
			sgp.percentiles=TRUE,
			sgp.projections=TRUE,
			sgp.projections.lagged=TRUE,
			sgp.percentiles.baseline=TRUE,
			sgp.projections.baseline=TRUE,
			sgp.projections.lagged.baseline=TRUE,
			simulate.sgps=TRUE,
			calculate.simex=TRUE, # TRUE or NULL (not FALSE!)
			calculate.simex.baseline=TRUE,
			parallel.config=list(BACKEND="PARALLEL", WORKERS=list(TAUS=25, SIMEX=5, PROJECTIONS=15, LAGGED_PROJECTIONS=10)))

### Save Results

#save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
