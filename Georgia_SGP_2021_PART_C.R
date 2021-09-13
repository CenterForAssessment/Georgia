################################################################################
###                                                                          ###
###       PART C 2021: Lagged (skip-year) SGP projections for Georgia        ###
###                                                                          ###
################################################################################

###   Set working directory to top directory

###   Load packages
require(SGP)

###   Load data
load("./Data/Georgia_SGP.Rdata")

###   Load analysis configurations
source("./SGP_CONFIG/2021/PART_C/ELA.R")
source("./SGP_CONFIG/2021/PART_C/MATHEMATICS.R")

GA_2021_CONFIG_PART_C <- c(
  ELA_2021.config,
  MATHEMATICS_2021.config,

  AMERICAN_LIT_2021.config,
  ALGEBRA_I_2021.config,
  COORDINATE_ALGEBRA_2021.config
)

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences
##    Add Baseline matrices calculated in 2019 STEP 2A to SGPstateData
load("./Data/GA_Baseline_Matrices.Rdata")
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- GA_Baseline_Matrices

##    Establish required meta-data for LAGGED projection sequences
source("../SGP_CONFIG/2021/PART_C/GA_Lagged_Projections_MetaData.R")

#####
###   Run analysis - abcSGP on Georgia_SGP object from Parts A & B
#####

##  Figure out "CURRENT_CURRENT" first !!!

Georgia_SGP <- abcSGP(
        Georgia_SGP,
        steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config=GA_2021_CONFIG_PART_C,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=FALSE,
        sgp.projections.lagged.baseline=TRUE,
        sgp.target.scale.scores=FALSE, # Not working...
        outputSGP.output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"),
        parallel.config = list(
					BACKEND = "PARALLEL",
          WORKERS=list(LAGGED_PROJECTIONS = 12, SGP_SCALE_SCORE_TARGETS = 12))
)

require(data.table)
setnames(Georgia_SGP@SGP[["SGProjections"]][["ELA.2021.BASELINE"]],
          gsub("_CURRENT_CURRENT", "_CURRENT", names(Georgia_SGP@SGP[["SGProjections"]][["ELA.2021.BASELINE"]])))

setnames(Georgia_SGP@SGP[["SGProjections"]][["MATHEMATICS.2021.BASELINE"]],
          gsub("_CURRENT_CURRENT", "_CURRENT", names(Georgia_SGP@SGP[["SGProjections"]][["MATHEMATICS.2021.BASELINE"]])))

###  Save results
save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
