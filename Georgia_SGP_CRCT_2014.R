#########################################################
###
### Calculate SGPs for Georgia - 2014
###
##########################################################

### Load SGP Package

require(SGP)

### Load Georgia SGP object

load("Data/Georgia_SGP.Rdata")
load('Data/Georgia_Baseline_Matrices.Rdata' )


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
			calculate.simex=NULL, # TRUE or NULL (not FALSE!) - NULL now to avoid creating (unnecessary) Cohort referenced SIMEX
			calculate.simex.baseline=TRUE, # TRUE or NULL (not FALSE!)
			goodness.of.fit.print=FALSE, # Print all out once after running EOCTs
			parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=12, BASELINE_PERCENTILES=12, PROJECTIONS=6, LAGGED_PROJECTIONS=6))) #TAUS=25, SIMEX=5

### Save Results

#save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
