#########################################################
###
### Calculate EOCT SGPs for Georgia for 2014
###
##########################################################

### Load SGP Package

require(SGP)


### Load Georgia SGP object

load("Data/Georgia_SGP.Rdata")

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

###
###		Cohort referenced EOCT content areas - run seperate to keep SIMEX production limited to "official" version
###

GA_EOCT.config <- c(
		ANALYTIC_GEOMETRY_2014.config,
		COORDINATE_ALGEBRA_2014.config,
		MATHEMATICS_II_2014.config)

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config=GA_EOCT.config,
		sgp.percentiles=TRUE,
		sgp.projections= TRUE,
		sgp.projections.lagged= TRUE,
		sgp.percentiles.baseline= FALSE,
		sgp.projections.baseline= FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps = FALSE,
		# calculate.sgps = FALSE,
		# sgp.use.my.coefficient.matrices = TRUE,
		# goodness.of.fit.print=FALSE,
		calculate.simex = TRUE,
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(SIMEX=15, TAUS=15)))


###
###		BASELINE SGPs
###

GA_EOCT.config <- c(
		AMERICAN_LIT_2014.config,
		BIOLOGY_2014.config,
		ECONOMICS_2014.config,
		GRADE_9_LIT_2014.config,
		PHYSICAL_SCIENCE_2014.config,
		US_HISTORY_2014.config)

# load('/home/avi/Georgia_Baseline_Matrices.Rdata' )
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- Georgia_Baseline_Matrices

### Replace original baseline matrices with updated matrices (original + additional US Hist and ELA progressions)
Georgia_SGP@SGP$Coefficient_Matrices <- Georgia_SGP@SGP$Coefficient_Matrices[-grep("BASELINE", names(Georgia_SGP@SGP$Coefficient_Matrices))]
# Georgia_SGP@SGP$Coefficient_Matrices <- c(Georgia_SGP@SGP$Coefficient_Matrices, Georgia_Baseline_Matrices)

setwd('/media/Data/Dropbox')

### analyzeSGP

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config=GA_EOCT.config,
		sgp.percentiles= FALSE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline= TRUE,
		sgp.projections.lagged.baseline= TRUE,
		simulate.sgps = FALSE,
		calculate.simex.baseline = TRUE,
		goodness.of.fit.print=FALSE,
		# parallel.config=list(BACKEND='PARALLEL', WORKERS=list(SIMEX=12)))
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(BASELINE_PERCENTILES=6, PROJECTIONS=3, LAGGED_PROJECTIONS=2)))

save(Georgia_SGP, file="Georgia_SGP.Rdata")

### combineSGP

Georgia_SGP <- combineSGP(Georgia_SGP, years='2014')

### Save results
save(Georgia_SGP, file="Georgia_SGP.Rdata")


### summarizeSGP (Produces aggregate tables)

Georgia_SGP <- summarizeSGP(Georgia_SGP, parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SUMMARY=20)))


### outputSGP

outputSGP(Georgia_SGP, output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"))


### Save results

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
