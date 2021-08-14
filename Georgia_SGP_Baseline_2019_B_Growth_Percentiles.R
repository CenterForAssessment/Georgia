################################################################################
###                                                                          ###
###    Georgia Learning Loss Analyses -- 2019 Baseline Growth Percentiles    ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load data and remove some old vars.
load("Data/Archive/2019/Georgia_SGP_LONG_Data.Rdata")
Georgia_SGP_LONG_Data[, c("FIRST_OBSERVATION", "LAST_OBSERVATION", "SGP_FROM_2015") := NULL]

###   Add single-cohort baseline matrices to SGPstateData
load("Data/GA_Baseline_Matrices.Rdata")
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- GA_Baseline_Matrices
SGPstateData[["GA"]][["SGP_Configuration"]][["sgp.cohort.size"]] <- NULL

###   Read in BASELINE percentiles configuration scripts and combine
source("SGP_CONFIG/2019/BASELINE/Percentiles/ELA.R")
source("SGP_CONFIG/2019/BASELINE/Percentiles/MATHEMATICS.R")

GA_2019_Baseline_Config <- c(
	  MATHEMATICS_2019.config,
		COORDINATE_ALGEBRA_2019.config,
		ANALYTIC_GEOMETRY_2019.config,
		ALGEBRA_I_2019.config,
		GEOMETRY_2019.config,

	  ELA_2019.config,
		GRADE_9_LIT_2019.config,
		AMERICAN_LIT_2019.config
)

#####
###   Run BASELINE SGP analysis - create new Georgia_SGP object with historical data
#####

###   Temporarily set names of prior scores from sequential/cohort analyses
setnames(Georgia_SGP_LONG_Data,
	c("SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED"),
	c("SS_PRIOR_COHORT", "SS_PRIOR_STD_COHORT"))

Georgia_SGP <- abcSGP(
      sgp_object = Georgia_SGP_LONG_Data,
      steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
      sgp.config = GA_2019_Baseline_Config,
      sgp.percentiles = FALSE,
      sgp.projections = FALSE,
      sgp.projections.lagged = FALSE,
      sgp.percentiles.baseline = TRUE,  #  Skip year SGPs for 2021 comparisons
      sgp.projections.baseline = FALSE, #  Calculated in next step
      sgp.projections.lagged.baseline = FALSE,
	    calculate.simex.baseline = TRUE,
			###   Use these four arguments for small sample test run.
			###   Delete/comment out and set calculate.simex = TRUE for full EOC run.
	      # calculate.simex.baseline = list(
				# 	lambda=seq(0,2,0.5), simulation.iterations=25, simex.sample.size=2500,
				# 	csem.data.vnames="SCALE_SCORE_CSEM", extrapolation="linear", save.matrices=FALSE,
				# 	simex.use.my.coefficient.matrices=TRUE, use.cohort.for.ranking=TRUE),
				# sgp.test.cohort.size = 5000,
				# return.sgp.test.results = "ALL_DATA",
				# goodness.of.fit.print=FALSE,
			###
			###
      save.intermediate.results = FALSE,
			outputSGP.output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"),
			parallel.config = list(
				BACKEND = "PARALLEL",
				WORKERS=list(SIMEX=38)) # might be faster with BASELINE_PERCENTILES?
)

###   Re-set and rename prior scores (one set for sequential/cohort, another for skip-year/baseline)
setnames(Georgia_SGP@Data,
  c("SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED", "SS_PRIOR_COHORT", "SS_PRIOR_STD_COHORT"),
  c("SCALE_SCORE_PRIOR_BASELINE", "SCALE_SCORE_PRIOR_STANDARDIZED_BASELINE", "SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED"))

###   Quick checks
table(Georgia_SGP@Data[YEAR=='2019' & is.na(SGP) & !is.na(SGP_BASELINE), SGP_NOTE], exclude=NULL)
tmp.tbl <- table(Georgia_SGP@Data[YEAR=='2019' & is.na(SGP) & !is.na(SGP_BASELINE), as.character(SGP_NORM_GROUP_BASELINE)])  #  small cohort N (<1500)
tmp.tbl[tmp.tbl > 1500] # ??? 2016/MATHEMATICS_7; 2017/MATHEMATICS_8; 2019/COORDINATE_ALGEBRA_EOCT
table(Georgia_SGP@Data[YEAR=='2019' & !is.na(SGP) & is.na(SGP_BASELINE), as.character(SGP_NORM_GROUP)]) #  single (2018) prior only
###   Save results
save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
