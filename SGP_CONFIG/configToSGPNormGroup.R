###################################################################################################
###
### Script to convert SGP configurations for EOCT analyses to SGP_NORM_GROUP preference tables
###
###################################################################################################

### Load packages

require("data.table")
options(error=recover)

### utility function

configToSGPNormGroup <- function(sgp.config) {
        tmp.norm.group <- tmp.norm.group.baseline <- paste(sgp.config$sgp.panel.years, paste(sgp.config$sgp.content.areas, unlist(sgp.config$sgp.grade.sequences), sep="_"), sep="/")
	return(
		data.table(
			SGP_NORM_GROUP=paste(tmp.norm.group, collapse="; "), 
			SGP_NORM_GROUP_BASELINE=paste(tmp.norm.group.baseline, collapse="; "),
			PREFERENCE=as.integer(sgp.config$sgp.norm.group.preference)
		)
	)
}


### Load and create 2010 - 2015 EOCT Configuration

source("EOCT/2010/ELA.R")
source("EOCT/2010/MATHEMATICS.R")
source("EOCT/2010/SCIENCE.R")
source("EOCT/2010/SOCIAL_STUDIES.R")
source("EOCT/2011/ELA.R")
source("EOCT/2011/MATHEMATICS.R")
source("EOCT/2011/SCIENCE.R")
source("EOCT/2011/SOCIAL_STUDIES.R")
source("EOCT/2012/ELA.R")
source("EOCT/2012/MATHEMATICS.R")
source("EOCT/2012/SCIENCE.R")
source("EOCT/2012/SOCIAL_STUDIES.R")
source("EOCT/2013/ELA.R")
source("EOCT/2013/MATHEMATICS.R")
source("EOCT/2013/SCIENCE.R")
source("EOCT/2013/SOCIAL_STUDIES.R")
source("EOCT/2014/ELA.R")
source("EOCT/2014/MATHEMATICS.R")
source("EOCT/2014/SCIENCE.R")
source("EOCT/2014/SOCIAL_STUDIES.R")
source("EOCT/2015/ELA.R")
source("EOCT/2015/MATHEMATICS.R")
source("EOCT/2015/SCIENCE.R")
source("EOCT/2015/SOCIAL_STUDIES.R")

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

GA_EOCT_2013.config <- c(
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

GA_EOCT_2014.config <- c(
		GRADE_9_LIT_2014.config,
		AMERICAN_LIT_2014.config,

		BIOLOGY_2014.config,
		PHYSICAL_SCIENCE_2014.config,

		ANALYTIC_GEOMETRY_2014.config,
		COORDINATE_ALGEBRA_2014.config,
		MATHEMATICS_II_2014.config,

		US_HISTORY_2014.config,
		ECONOMICS_2014.config)

GA_EOCT_2015.config <- c(
	GRADE_9_LIT_2015.config,
	AMERICAN_LIT_2015.config,
	
	BIOLOGY_2015.config,
	PHYSICAL_SCIENCE_2015.config,
	
	ANALYTIC_GEOMETRY_2015.config,
	COORDINATE_ALGEBRA_2015.config,

	US_HISTORY_2015.config,
	ECONOMICS_2015.config)

### Create configToNormGroup data.frame

tmp.configToNormGroup <- lapply(GA_EOCT_2010.config, configToSGPNormGroup)

GA_SGP_Norm_Group_Preference_2010 <- data.table(
					YEAR="2010",
					rbindlist(tmp.configToNormGroup))


tmp.configToNormGroup <- lapply(GA_EOCT_2011.config, configToSGPNormGroup)

GA_SGP_Norm_Group_Preference_2011 <- data.table(
					YEAR="2011",
					rbindlist(tmp.configToNormGroup))


tmp.configToNormGroup <- lapply(GA_EOCT_2012.config, configToSGPNormGroup)

GA_SGP_Norm_Group_Preference_2012 <- data.table(
					YEAR="2012",
					rbindlist(tmp.configToNormGroup))


tmp.configToNormGroup <- lapply(GA_EOCT_2013.config, configToSGPNormGroup)

GA_SGP_Norm_Group_Preference_2013 <- data.table(
					YEAR="2013",
					rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(GA_EOCT_2014.config, configToSGPNormGroup)

GA_SGP_Norm_Group_Preference_2014 <- data.table(
					YEAR="2014",
					rbindlist(tmp.configToNormGroup))

tmp.configToNormGroup <- lapply(GA_EOCT_2015.config, configToSGPNormGroup)

GA_SGP_Norm_Group_Preference_2015 <- data.table(
	YEAR="2015",
	rbindlist(tmp.configToNormGroup))

GA_SGP_Norm_Group_Preference <- rbind(
			GA_SGP_Norm_Group_Preference_2010,
			GA_SGP_Norm_Group_Preference_2011,
			GA_SGP_Norm_Group_Preference_2012,
			GA_SGP_Norm_Group_Preference_2013,
			GA_SGP_Norm_Group_Preference_2014,
			GA_SGP_Norm_Group_Preference_2015
			)

GA_SGP_Norm_Group_Preference$SGP_NORM_GROUP <- as.factor(GA_SGP_Norm_Group_Preference$SGP_NORM_GROUP)
GA_SGP_Norm_Group_Preference$SGP_NORM_GROUP_BASELINE <- as.factor(GA_SGP_Norm_Group_Preference$SGP_NORM_GROUP_BASELINE)


### Save result

setkey(GA_SGP_Norm_Group_Preference, YEAR, SGP_NORM_GROUP)
save(GA_SGP_Norm_Group_Preference, file="GA_SGP_Norm_Group_Preference.Rdata")
