################################################################################
###                                                                          ###
###            PART B 2021: Straight SGP projections for Georgia             ###
###                                                                          ###
################################################################################

###   Set working directory to top directory

###   Load packages
require(SGP)

###   Load data
load("./Data/Georgia_SGP.Rdata")

###   Load analysis configurations
# rm(list=grep("config", ls(), value=TRUE))
source("./SGP_CONFIG/2021/PART_B/ELA.R")
source("./SGP_CONFIG/2021/PART_B/MATHEMATICS.R")

GA_2021_CONFIG_PART_B <- c(
  ELA_2021.config,
  MATHEMATICS_2021.config
)

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences
##    Add Baseline matrices calculated in 2019 STEP 2A to SGPstateData
load("./Data/GA_Baseline_Matrices.Rdata")
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- GA_Baseline_Matrices

##    Establish required meta-data for Straight projection sequences
source("./SGP_CONFIG/2021/PART_B/GA_Straight_Projections_MetaData.R")

#####
###   Run analysis - abcSGP on Georgia_SGP object from Part A
#####

##    Need to add BASELINE straight target variables first (for combineSGP):
Georgia_SGP@Data$SGP_TARGET_BASELINE_3_YEAR <- as.integer(NA)
Georgia_SGP@Data$SGP_TARGET_BASELINE_3_YEAR_CURRENT <- as.integer(NA)

Georgia_SGP <- abcSGP(
        Georgia_SGP,
        years = "2021", # STILL need to add years now (after adding 2019 baseline projections). Why?
        steps=c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config=GA_2021_CONFIG_PART_B,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=TRUE,
        sgp.projections.lagged.baseline=FALSE,
        sgp.target.scale.scores=TRUE,
        parallel.config = list(
					BACKEND = "PARALLEL",
          WORKERS=15) # list(PROJECTIONS = 10, SGP_SCALE_SCORE_TARGETS = 10))
)

###  Save results
save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
