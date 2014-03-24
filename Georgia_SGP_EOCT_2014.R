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

source("SGP_CONFIG/EOCT/2014/ELA.R")
source("SGP_CONFIG/EOCT/2014/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2014/SCIENCE.R")
source("SGP_CONFIG/EOCT/2014/SOCIAL_STUDIES.R")

GA_EOCT.config <- c(
		AMERICAN_LIT_2014.config,
		BIOLOGY_2014.config,
		COORDINATE_ALGEBRA_2014.config,
		ECONOMICS_2014.config,
		GEOMETRY_2014.config,
		GRADE_9_LIT_2014.config,
		MATHEMATICS_I_2014.config,
		MATHEMATICS_II_2014.config,
		PHYSICAL_SCIENCE_2014.config,
		US_HISTORY_2014.config)


####################################################################################
###
### EOCT Analyses
###
####################################################################################

### prepareSGP

Georgia_SGP <- prepareSGP(Georgia_SGP, create.additional.variables=FALSE)


### analyzeSGP

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config=GA_EOCT.config,
		sgp.percentiles=TRUE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline= FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps=FALSE,
		calculate.simex=TRUE,
		calculate.simex.baseline=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=5, BASELINE_PERCENTILES=5, SIMEX=5)))


### combineSGP

Georgia_SGP <- combineSGP(Georgia_SGP)


### summarizeSGP (Produces aggregate tables)

Georgia_SGP <- summarizeSGP(Georgia_SGP, parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SUMMARY=20)))


### outputSGP

outputSGP(Georgia_SGP, output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"))


### Save results

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
