#########################################################
###
### Calculate SGPs for Georgia - 2015
###
##########################################################

### Load required packages

require(SGP)
require(data.table)

###  Load NEW Georgia SGP object and 2015 data (if starting new session after data cleaning and new object creation)
###  Alternatively, use this to clean up working environment after running data prep and creating new SGP object:
# rm(list=c(grep("Georgia_SGP|Georgia_Data_LONG_2015", ls(), invert=T, value=T), "Georgia_SGP_LONG_Data")); gc()

load("Data/Georgia_SGP.Rdata")
load("Data/Georgia_Data_LONG_2015.Rdata")


###  Read in 2015 SGP Configuration Scripts and Combine

source("SGP_CONFIG/EOCT/2015/ELA.R")
source("SGP_CONFIG/EOCT/2015/SCIENCE.R")
source("SGP_CONFIG/EOCT/2015/SOCIAL_STUDIES.R")
source("SGP_CONFIG/EOCT/2015/MATHEMATICS.R")

GA_2015.config <- c(
		MATHEMATICS_2015.config,
		COORDINATE_ALGEBRA_2015.config,
		ANALYTIC_GEOMETRY_2015.config,

		SCIENCE_2015.config,
		BIOLOGY_2015.config,
		PHYSICAL_SCIENCE_2015.config,

		ELA_2015.config,
		GRADE_9_LIT_2015.config,
		AMERICAN_LIT_2015.config,

		SOCIAL_STUDIES_2015.config,
		US_HISTORY_2015.config,
		ECONOMICS_2015.config)


### updateSGP

Georgia_SGP <- updateSGP(
		what_sgp_object=Georgia_SGP,
		with_sgp_data_LONG=Georgia_Data_LONG_2015,
		sgp.config = GA_2015.config,
		# Run summarizeSGP step AFTER we get Teacher-Student Links
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles = TRUE,
		sgp.projections = TRUE,
		sgp.projections.lagged = TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline = FALSE,
		sgp.projections.lagged.baseline = FALSE,
		sgp.percentiles.equated = TRUE,
		simulate.sgps = TRUE,
		calculate.simex = TRUE,
		goodness.of.fit.print=TRUE,
		save.intermediate.results=FALSE,
		outputSGP.output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"),
		# parallel.config = list(BACKEND="PARALLEL", WORKERS=list(TAUS=20, SIMEX=20))) # Ubuntu/Linux
		parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE, WORKERS=list(TAUS=11, SIMEX=11))) # WINDOWS


### Save Results

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")

require(SGP)
Georgia_SGP <- summarizeSGP(
	Georgia_SGP,
	# highest.level.summary.grouping="SCHOOL", # Only need this for bubble plots right now.
	parallel.config=list(
		# BACKEND="PARALLEL",
		BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE, 
		WORKERS=list(SUMMARY=6))
)
