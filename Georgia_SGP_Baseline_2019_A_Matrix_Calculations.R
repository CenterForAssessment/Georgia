################################################################################
###                                                                          ###
###        Georgia Learning Loss Analyses -- Create Baseline Matrices        ###
###                                                                          ###
################################################################################

### Load necessary packages
require(SGP)
require(data.table)

###   Load Original Georgia data from 2019 GA SGP Analyses

load("Data/Archive/2019/Georgia_SGP_LONG_Data.Rdata")

###   Create a smaller subset of the LONG data to work with.
Georgia_Baseline_Data <- data.table::data.table(Georgia_SGP_LONG_Data[,
	list(VALID_CASE, GTID, SCHOOL_YEAR, SUBJECT_CODE, YEAR_WITHIN, GRADE, SCALE_SCORE, CONDSEM, PERFORMANCE_LEVEL)])

###   Read in Baseline SGP Configuration Scripts and Combine
source("SGP_CONFIG/2019/BASELINE/Matrices/ELA_SingleCohort.R")
source("SGP_CONFIG/2019/BASELINE/Matrices/MATHEMATICS_SingleCohort.R")

GA_BASELINE_CONFIG <- c(
		ELA_BASELINE.config,
		GRADE_9_LIT_BASELINE.config,
		AMERICAN_LIT_BASELINE.config,

		MATHEMATICS_BASELINE.config,
		ALGEBRA_I_BASELINE.config,
		GEOMETRY_BASELINE.config,
		COORDINATE_ALGEBRA_BASELINE.config,
		ANALYTIC_GEOMETRY_BASELINE.config
)


###
###    baselineSGP - To produce uncorrected and SIMEX baseline matrices
###

###   First create shell SGP object
Georgia_SGP <- prepareSGP(Georgia_Baseline_Data, create.additional.variables=FALSE)

GA_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=GA_BASELINE_CONFIG,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	calculate.simex.baseline=list(
		csem.data.vnames="SCALE_SCORE_CSEM", lambda=seq(0,2,0.5), simulation.iterations=75,
		simex.use.my.coefficient.matrices = FALSE, simex.sample.size=10000, # simex.sample.size=2000, #
		extrapolation="linear", save.matrices=TRUE, use.cohort.for.ranking=TRUE),
	###
	# sgp.test.cohort.size = 10000, # comment out for full run and change calculate.simex.baseline$simex.sample.size to 10000
	###
	sgp.cohort.size=1500,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=25, SIMEX=25)))

###   Save results
save(GA_Baseline_Matrices, file="Data/GA_Baseline_Matrices.Rdata")
