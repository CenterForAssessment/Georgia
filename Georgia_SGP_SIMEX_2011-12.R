#########################################################
###
### Calculate SIMEX SGPs for Georgia for 2013
###
##########################################################

### Load SGP Package

require(SGP)


### Load Georgia SGP object

load("Georgia_SGP.Rdata")

###
###	 analyzeSGP : Grade level CRCT content areas
###

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		years=c('2012'), #'2011', 
		content_areas=c("ELA", "READING", "MATHEMATICS", "SCIENCE"), # NO BASELINE SOCIAL_STUDIES in 2011 or 2012
		sgp.percentiles= FALSE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps = FALSE,
		calculate.simex.baseline = TRUE,
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(BASELINE_PERCENTILES=8)))

save(Georgia_SGP, file="Georgia_SGP.Rdata")

### analyzeSGP:  Baseline EOCT content areas

### Load EOCT configurations
### NO BASELINE US_HISTORY in 2011 or 2012

source("SGP_CONFIG/EOCT/2011/ELA.R")
source("SGP_CONFIG/EOCT/2011/SCIENCE.R")
source("SGP_CONFIG/EOCT/2011/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2012/ELA.R")
source("SGP_CONFIG/EOCT/2012/SCIENCE.R")
source("SGP_CONFIG/EOCT/2012/SOCIAL_STUDIES.R")

GA_EOCT_2011.config <- c(
                AMERICAN_LIT_2011.config,
                BIOLOGY_2011.config,
                ECONOMICS_2011.config,
                GRADE_9_LIT_2011.config,
                PHYSICAL_SCIENCE_2011.config)

GA_EOCT_2012.config <- c(
		ALGEBRA_2012.config,
                AMERICAN_LIT_2012.config,
                BIOLOGY_2012.config,
                ECONOMICS_2012.config,
                GRADE_9_LIT_2012.config,
                PHYSICAL_SCIENCE_2012.config)

GA_EOCT.config <- c(GA_EOCT_2011.config, GA_EOCT_2012.config)

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
		calculate.simex.baseline = TRUE,
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(BASELINE_PERCENTILES=11)))

save(Georgia_SGP, file="Georgia_SGP.Rdata")

# ### analyzeSGP:  Cohort referenced EOCT content areas

# ### Load EOCT configurations

# source("SGP_CONFIG/EOCT/2013/MATHEMATICS.R")

# GA_EOCT.config <- c(
		# GEOMETRY_2013.config,
		# COORDINATE_ALGEBRA_2013.config,
		# MATHEMATICS_II_2013.config,
		# MATHEMATICS_I_2013.config)

# Georgia_SGP <- analyzeSGP(
		# Georgia_SGP,
		# sgp.config=GA_EOCT.config,
		# sgp.percentiles=TRUE,
		# sgp.projections=FALSE,
		# sgp.projections.lagged=FALSE,
		# sgp.percentiles.baseline= FALSE,
		# sgp.projections.baseline= FALSE,
		# sgp.projections.lagged.baseline=FALSE,
		# simulate.sgps = FALSE,
		# # calculate.sgps = FALSE,
		# sgp.use.my.coefficient.matrices = TRUE,
		# # calculate.simex = TRUE,
		# calculate.simex = list(state="GA", lambda=seq(0,2,0.5), simulation.iterations=50, simex.sample.size=25000, extrapolation="linear", simex.use.my.coefficient.matrices=TRUE),
		# parallel.config=list(BACKEND='PARALLEL', WORKERS=list(SIMEX=15, TAUS=15)))

# ### combineSGP

# Georgia_SGP <- combineSGP(Georgia_SGP, years='2013')

# ### Save results
# save(Georgia_SGP, file="Georgia_SGP.Rdata")
