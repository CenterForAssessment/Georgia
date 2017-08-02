#################################################################
###                                                           ###
###             Calculate SGPs for Georgia - 2017             ###
###                                                           ###
#################################################################

### Load required packages
require(SGP)
require(data.table)

###  Read in 2017 SGP Configuration Scripts

#    GA DOE ::
setwd('U:/DATA/SGP/Data/2017 SGPs/2017 SGP Calculation')

source('U:/DATA/SGP/Data/2017 SGPs/2017 SGP Calculation/2017 config/ELA.R')
source("U:/DATA/SGP/Data/2017 SGPs/2017 SGP Calculation/2017 config/MATHEMATICS.R")


#    CFA/AVI ::
setwd('~/SGP_Projects/Georgia')

source("SGP_CONFIG/EOCT/2017/ELA.R")
source("SGP_CONFIG/EOCT/2017/MATHEMATICS.R")


###
###    EOG Analyses
###

###  Combine 2017 SGP EOG Configuration Scripts
GA_2017.config <- c(
  MATHEMATICS_2017.config,
  ELA_2017.config)


###  Load Required Data (Prior Years in SGP object, Current Year in data table)
load("Data/Georgia_SGP-Shell_2017.Rdata")
load("Data/Georgia_Data_LONG_2017_EOG.Rdata")

 ## PRELIM CODE ##
 SGPstateData[["GA"]][["SGP_Configuration"]][["rq.method"]] <- "fn"
 prelim.simex <- list(lambda=seq(0,2,0.5), simulation.iterations=7, simex.sample.size=1500, csem.data.vnames="SCALE_SCORE_CSEM", extrapolation="linear", save.matrices=TRUE)

###  Run SGP Object Preparation and Student Growth Percentiles via `updateSGP` function
Georgia_SGP <- updateSGP(
  what_sgp_object=Georgia_SGP,
  with_sgp_data_LONG=Georgia_Data_LONG_2017[SUBJECT_CODE %in% c("ELA", "MATHEMATICS")], ## PRELIM CODE ##
  sgp.config = GA_2017.config,
  steps=c("prepareSGP", "analyzeSGP"),
  sgp.percentiles = TRUE,
  sgp.projections = FALSE,
  sgp.projections.lagged = FALSE,
  sgp.percentiles.baseline=FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  sgp.percentiles.equated = FALSE,
  simulate.sgps = TRUE,
  # calculate.simex = TRUE, #  Use list below for PRELIM data tests.
  calculate.simex = prelim.simex,  ## PRELIM CODE ##
  goodness.of.fit.print=TRUE,
  save.intermediate.results=FALSE,
   parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE, WORKERS=list(TAUS=12, SIMEX=12)))

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")

###
###    EOC Analyses
###

###  Combine 2017 SGP EOC Configuration Scripts

GA_2017.config <- c(
  COORDINATE_ALGEBRA_2017.config,
  ANALYTIC_GEOMETRY_2017.config,
  ALGEBRA_I_2017.config,
  GEOMETRY_2017.config,

  GRADE_9_LIT_2017.config,
  AMERICAN_LIT_2017.config
)

eoc.subjects <- c("GRADE_9_LIT", "AMERICAN_LIT", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY", "ALGEBRA_I", "GEOMETRY")
###  Run SGP Object Preparation and Student Growth Percentiles via `updateSGP` function
Georgia_SGP <- updateSGP(
  what_sgp_object=Georgia_SGP,
  with_sgp_data_LONG=Georgia_Data_LONG_2017[SUBJECT_CODE %in% eoc.subjects], ## PRELIM CODE ##
  sgp.config = GA_2017.config,
  steps=c("prepareSGP", "analyzeSGP"),
  sgp.percentiles = TRUE,
  sgp.projections = FALSE,
  sgp.projections.lagged = FALSE,
  sgp.percentiles.baseline=FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  sgp.percentiles.equated = FALSE,
  simulate.sgps = TRUE,
  # calculate.simex = TRUE, #  Use list below for PRELIM data tests.
  calculate.simex = prelim.simex,  ## PRELIM CODE ##
  goodness.of.fit.print=TRUE,
  save.intermediate.results=FALSE,
   parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE, WORKERS=list(TAUS=12, SIMEX=12)))
