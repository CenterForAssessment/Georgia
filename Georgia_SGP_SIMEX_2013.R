#########################################################
###
### Calculate EOCT SGPs for Georgia for 2013
###
##########################################################

### Load SGP Package

require(SGP)


### Load Georgia SGP object

load("Georgia_SGP.Rdata")

load('GA_SIMEX_Cohort_Matrices.Rdata')
load('GA_SIMEX_Baseline_Matrices.Rdata')

Georgia_SGP@SGP[[1]] <- c(Georgia_SGP@SGP[[1]], GA_SIMEX_Baseline_Matrices, GA_SIMEX_Cohort_Matrices)

###
###	 analyzeSGP : Grade level CRCT content areas
###

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		years='2013',
		content_areas=c("ELA", "READING", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES"),
		sgp.percentiles= FALSE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps = FALSE,
		calculate.simex = TRUE,
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(BASELINE_PERCENTILES=15)))

save(Georgia_SGP, file="Georgia_SGP.Rdata")

### analyzeSGP:  Baseline EOCT content areas

### Load EOCT configurations

source("SGP_CONFIG/EOCT/2013/ELA.R")
source("SGP_CONFIG/EOCT/2013/SCIENCE.R")
source("SGP_CONFIG/EOCT/2013/SOCIAL_STUDIES.R")

GA_EOCT.config <- c(
		AMERICAN_LIT_2013.config,
		BIOLOGY_2013.config,
		ECONOMICS_2013.config,
		GRADE_9_LIT_2013.config,
		PHYSICAL_SCIENCE_2013.config,
		US_HISTORY_2013.config)

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config=GA_EOCT.config,
		sgp.percentiles= FALSE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps = FALSE,
		calculate.simex = TRUE,
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(BASELINE_PERCENTILES=15)))

save(Georgia_SGP, file="Georgia_SGP.Rdata")

### analyzeSGP:  Cohort referenced EOCT content areas

### Load EOCT configurations

source("SGP_CONFIG/EOCT/2013/MATHEMATICS.R")

GA_EOCT.config <- c(
		GEOMETRY_2013.config,
		COORDINATE_ALGEBRA_2013.config,
		MATHEMATICS_II_2013.config,
		MATHEMATICS_I_2013.config)

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config=GA_EOCT.config,
		sgp.percentiles=TRUE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline= FALSE,
		sgp.projections.baseline= FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps = FALSE,
		# calculate.sgps = FALSE,
		sgp.use.my.coefficient.matrices = TRUE,
		# calculate.simex = TRUE,
		calculate.simex = list(state="GA", lambda=seq(0,2,0.5), simulation.iterations=50, simex.sample.size=25000, extrapolation="linear", simex.use.my.coefficient.matrices=TRUE),
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(SIMEX=15, TAUS=15)))

### combineSGP

Georgia_SGP <- combineSGP(Georgia_SGP, years='2013')

### Save results
save(Georgia_SGP, file="Georgia_SGP.Rdata")
