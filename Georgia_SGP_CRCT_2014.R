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

###  Add baseline matrices to the SGPstateData (removed from 'public record' in Summer 2013)
###  Replace original baseline matrices with updated matrices (original + additional US Hist and ELA progressions)

SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- Georgia_Baseline_Matrices

Georgia_SGP@SGP$Coefficient_Matrices <- Georgia_SGP@SGP$Coefficient_Matrices[-grep("BASELINE", names(Georgia_SGP@SGP$Coefficient_Matrices))]
Georgia_SGP@SGP$Coefficient_Matrices <- c(Georgia_SGP@SGP$Coefficient_Matrices, Georgia_Baseline_Matrices)

### AnalyzeSGP : Grade level CRCT tests

Georgia_SGP <- analyzeSGP(
			Georgia_SGP,
			years='2014',
			content_areas=c("ELA", "READING", "MATHEMATICS", "SOCIAL_STUDIES", "SCIENCE"),
			sgp.percentiles=TRUE,
			sgp.projections=TRUE,
			sgp.projections.lagged=TRUE,
			sgp.percentiles.baseline=TRUE,
			sgp.projections.baseline=TRUE,
			sgp.projections.lagged.baseline=TRUE,
			simulate.sgps= FALSE,
			calculate.simex = NULL, # Only produce BASELINE SIMEX for CRCT.
			calculate.simex.baseline=TRUE, 
			goodness.of.fit.print=FALSE, # Print all out once after running EOCTs
			parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=1, BASELINE_PERCENTILES=1, TAUS=13, SIMEX=5))) # Parallel config as run by Adam for official results

### Save Results

#save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
