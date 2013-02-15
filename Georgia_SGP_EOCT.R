#########################################################
###
### Calculate EOCT SGPs for Georgia
###
##########################################################

### Load SGP Package

require(SGP)
require(data.table)
options(error=recover)


### Load Georgia SGP object

load("Data/Data_to_Start/Georgia_SGP.Rdata")


### Load EOCT configurations

source("SGP_CONFIG/EOCT/2010/ELA.R")
source("SGP_CONFIG/EOCT/2010/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2010/SCIENCE.R")
source("SGP_CONFIG/EOCT/2010/SOCIAL_STUDIES.R")
source("SGP_CONFIG/EOCT/2011/ELA.R")
source("SGP_CONFIG/EOCT/2011/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2011/SCIENCE.R")
source("SGP_CONFIG/EOCT/2011/SOCIAL_STUDIES.R")
source("SGP_CONFIG/EOCT/2012/ELA.R")
source("SGP_CONFIG/EOCT/2012/MATHEMATICS.R")
source("SGP_CONFIG/EOCT/2012/SCIENCE.R")
source("SGP_CONFIG/EOCT/2012/SOCIAL_STUDIES.R")

GA_EOCT_2010.config <- c(
                AMERICAN_LIT_2010.config,
                BIOLOGY_2010.config,
                ECONOMICS_2010.config,
                GRADE_9_LIT_2010.config,
                MATHEMATICS_I_2010.config,
                PHYSICAL_SCIENCE_2010.config,
                US_HISTORY_2010.config)

GA_EOCT_2011.config <- c(
                AMERICAN_LIT_2011.config,
                BIOLOGY_2011.config,
                ECONOMICS_2011.config,
                GRADE_9_LIT_2011.config,
                MATHEMATICS_I_2011.config,
                MATHEMATICS_II_2011.config,
                PHYSICAL_SCIENCE_2011.config,
                US_HISTORY_2011.config)

GA_EOCT_2012.config <- c(
		ALGEBRA_2012.config,
                AMERICAN_LIT_2012.config,
                BIOLOGY_2012.config,
                ECONOMICS_2012.config,
		GEOMETRY_2012.config,
                GRADE_9_LIT_2012.config,
                MATHEMATICS_I_2012.config,
                MATHEMATICS_II_2012.config,
                PHYSICAL_SCIENCE_2012.config,
                US_HISTORY_2012.config)

GA_EOCT.config <- c(GA_EOCT_2010.config, GA_EOCT_2011.config, GA_EOCT_2012.config)


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
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=14, BASELINE_PERCENTILES=14)))


### combineSGP

Georgia_SGP <- combineSGP(Georgia_SGP)
