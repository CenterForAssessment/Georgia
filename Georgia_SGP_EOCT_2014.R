#########################################################
###
### Calculate EOCT SGPs for Georgia for 2014
###
##########################################################

### Load SGP Package

require(SGP)


### Load Georgia SGP object

load("Data/Georgia_SGP.Rdata")

###  Add baseline matrices to the SGPstateData (removed from 'public record' in Summer 2013)
###  Replacement of original matrices in Georgia_SGP not needed to be done again (done in CRCT)

load('Data/Georgia_Baseline_Matrices.Rdata' )
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- Georgia_Baseline_Matrices


### Load EOCT configurations
require(SGP)
setwd('/media/Data/Dropbox/Github_Repos/Projects/Georgia')

source("SGP_CONFIG/EOCT/2014/ELA.R")
source("SGP_CONFIG/EOCT/2014/SCIENCE.R")
source("SGP_CONFIG/EOCT/2014/SOCIAL_STUDIES.R")
source("SGP_CONFIG/EOCT/2014/MATHEMATICS.R")

####################################################################################
###
### EOCT Analyses
###
####################################################################################


GA_EOCT.config <- c(
		ANALYTIC_GEOMETRY_2014.config,
		COORDINATE_ALGEBRA_2014.config,
		MATHEMATICS_II_2014.config,

		BIOLOGY_2014.config,
		PHYSICAL_SCIENCE_2014.config,

		GRADE_9_LIT_2014.config,
		AMERICAN_LIT_2014.config,

		ECONOMICS_2014.config,
		US_HISTORY_2014.config)

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config = GA_EOCT.config,
		sgp.percentiles = TRUE,
		sgp.projections = FALSE,
		sgp.projections.lagged = FALSE,
		sgp.percentiles.baseline = TRUE,
		sgp.projections.baseline = FALSE,
		sgp.projections.lagged.baseline = FALSE,
		# calculate.simex = TRUE, # SIMEX arguments no longer need to be specified.  Now included in CONFIG scripts.
		simulate.sgps = FALSE,
		parallel.config = list(BACKEND='PARALLEL', WORKERS=list(PERCENTILES=1, BASELINE_PERCENTILES=1, TAUS=13, SIMEX=5))) # Parallel config as run by Adam for official results


### combineSGP - combine results from CRCT and EOCT analyses

Georgia_SGP <- combineSGP(Georgia_SGP, years='2014')

### Save results
save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")


### summarizeSGP (Produces aggregate tables)

Georgia_SGP <- summarizeSGP(Georgia_SGP, parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SUMMARY=20)))

### Save results

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")

### outputSGP

outputSGP(Georgia_SGP, output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"))

###  Produce GOF plots (no GROBs produced from analyzeSGP)

gofSGP(Georgia_SGP, years= '2014', use.sgp="SGP", output.format=c("PDF", "PNG"))
gofSGP(Georgia_SGP, years= '2014', use.sgp="SGP_SIMEX", output.format=c("PDF", "PNG"))
gofSGP(Georgia_SGP, years= '2014', use.sgp="SGP_BASELINE", output.format=c("PDF", "PNG"))
gofSGP(Georgia_SGP, years= '2014', use.sgp="SGP_SIMEX_BASELINE", output.format=c("PDF", "PNG"))

