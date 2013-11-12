#########################################################
###
### Calculate EOCT SGPs for Georgia for 2013
###
##########################################################

### Load SGP Package

require(SGP)


### Load Georgia SGP object

load("Data/Georgia_SGP.Rdata")


### Load EOCT configurations

source("SGP_CONFIG/EOCT/2013/ELA.R")
source("SGP_CONFIG/EOCT/2013/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2013/SCIENCE.R")
source("SGP_CONFIG/EOCT/2013/SOCIAL_STUDIES.R")

GA_EOCT.config <- c(
		AMERICAN_LIT_2013.config,
		BIOLOGY_2013.config,
		COORDINATE_ALGEBRA_2013.config,
		ECONOMICS_2013.config,
		GEOMETRY_2013.config,
		GRADE_9_LIT_2013.config,
		MATHEMATICS_I_2013.config,
		MATHEMATICS_II_2013.config,
		PHYSICAL_SCIENCE_2013.config,
		US_HISTORY_2013.config)


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
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=5, BASELINE_PERCENTILES=5)))


### combineSGP

Georgia_SGP <- combineSGP(Georgia_SGP)


### outputSGP

outputSGP(Georgia_SGP, output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"))


### Save results

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
