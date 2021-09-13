################################################################################
###                                                                          ###
###             Georgia 2021 (Cohort and Baseline) SGP Analyses              ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load cleaned 2019 BASELINE SGP object and 2021 LONG data
load("./Data/Georgia_SGP.Rdata")
load("./Data/Georgia_Data_LONG_2021.Rdata")

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences
##    Add Baseline matrices calculated in 2019 STEP 2A to SGPstateData
load("./Data/GA_Baseline_Matrices.Rdata")
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- GA_Baseline_Matrices

###   Read in BASELINE projections configuration scripts and combine
source("./SGP_CONFIG/2021/PART_A/ELA.R")
source("./SGP_CONFIG/2021/PART_A/MATHEMATICS.R")

Georgia_2021_CONFIG_PART_A <- c(
	ELA_2021.config,
	MATHEMATICS_2021.config,

	AMERICAN_LIT_2021.config,
	ALGEBRA_I_2021.config,
	COORDINATE_ALGEBRA_2021.config
)

#####
###   Run Baseline Student Growth Percentiles (2021 Part A)
#####

Georgia_SGP <- updateSGP(
        what_sgp_object = Georgia_SGP,
        with_sgp_data_LONG = Georgia_Data_LONG_2021,
				steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = Georgia_2021_CONFIG_PART_A,
        sgp.percentiles = TRUE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
				calculate.simex = TRUE,
				calculate.simex.baseline = list(
					lambda=seq(0,2,0.5), simulation.iterations=75, simex.sample.size=10000,
					csem.data.vnames="SCALE_SCORE_CSEM", extrapolation="linear", save.matrices=FALSE,
					simex.use.my.coefficient.matrices=TRUE, use.cohort.for.ranking=FALSE), # use baseline cohort for RANKING!
				save.intermediate.results = FALSE,
        parallel.config = list(
					BACKEND = "PARALLEL",
          WORKERS=list(TAUS = 27, SIMEX = 25))
)

### Copy SCALE_SCORE_PRIOR and SCALE_SCORE_PRIOR_STANDARDIZED to BASELINE counter parts
Georgia_SGP@Data[YEAR=="2021", SCALE_SCORE_PRIOR_BASELINE:=SCALE_SCORE_PRIOR]
Georgia_SGP@Data[YEAR=="2021", SCALE_SCORE_PRIOR_STANDARDIZED_BASELINE:=SCALE_SCORE_PRIOR_STANDARDIZED]

###   Save results
save(Georgia_SGP, file="./Data/Georgia_SGP.Rdata")
