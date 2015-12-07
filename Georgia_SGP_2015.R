#########################################################
###
### Calculate SGPs for Georgia - 2014
###
##########################################################

### Load SGP Package

require(SGP)

###  Load Georgia SGP object

load("Data/Georgia_SGP.Rdata")

#    Remove HIGH_NEED_STATUS since this is not used by GA DOE (variable creation takes 40 minutes in prepareSGP step!)
Georgia_SGP@Data[, HIGH_NEED_STATUS := NULL]

###  Load 2015 data
load("Data/Georgia_Data_LONG_2015.Rdata")


###  Add Achievement/Proficiency levels to SGPstateData manually (for prelim -- to be added to SGP package by AVI)
SGPstateData[["GA"]][["Achievement"]][["Levels"]] <- list(
		Labels=c("Beginning Learner", "Developing Learner", "Distinguished Learner", "Proficient Learner"),
		Proficient=c("Not Proficient", "Not Proficient", "Proficient", "Proficient"))


###  Read in 2015 SGP Configuration Scripts and Combine


source("SGP_CONFIG/EOCT/2015/ELA.R")
source("SGP_CONFIG/EOCT/2015/SCIENCE.R")
source("SGP_CONFIG/EOCT/2015/SOCIAL_STUDIES.R")
source("SGP_CONFIG/EOCT/2015/MATHEMATICS.R")

GA_EOCT.config <- c(
		MATHEMATICS_2015.config,
		ANALYTIC_GEOMETRY_2015.config,
		COORDINATE_ALGEBRA_2015.config,

		SCIENCE_2015.config,
		BIOLOGY_2015.config,
		PHYSICAL_SCIENCE_2015.config,

		ELA_2015.config,
		GRADE_9_LIT_2015.config,
		AMERICAN_LIT_2015.config,

		SOCIAL_STUDIES_2015.config,
		ECONOMICS_2015.config,
		US_HISTORY_2015.config)


### updateSGP

Georgia_SGP <- updateSGP(
		what_sgp_object=Georgia_SGP,
		with_sgp_data_LONG=Georgia_Data_LONG_2015,
		sgp.config = GA_EOCT.config,
		# steps=c("prepareSGP", "analyzeSGP", "combineSGP", "summarizeSGP", "visualizeSGP", "outputSGP")
		steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
		sgp.percentiles=TRUE,
		sgp.projections = FALSE,
		sgp.projections.lagged = FALSE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline = FALSE,
		sgp.projections.lagged.baseline = FALSE,
		simulate.sgps = TRUE,    # Needed for SGP_STANDARD_ERROR and SGP_BASELINE_STANDARD_ERROR
		calculate.simex = TRUE,  # Produce Cohort SIMEX for all analyses now.
		save.intermediate.results=FALSE,
		goodness.of.fit.print="GROB",
		parallel.config = list(BACKEND='FOREACH', TYPE="doParallel", WORKERS=list(TAUS=10, SIMEX=10)))

### Save Results

#save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
