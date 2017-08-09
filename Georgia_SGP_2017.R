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

 ##  PRELIM CODE ONLY  -  Speed up prelim tests  ##
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
  overwrite.existing.data=FALSE,
	# update.old.data.with.new=FALSE,
	output.updated.data=FALSE,
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

###   analyzeSGP to produce Projections for all subjects

GA_2017.config <- c(
  MATHEMATICS_2017.config,
  COORDINATE_ALGEBRA_2017.config,
  ANALYTIC_GEOMETRY_2017.config,
  ALGEBRA_I_2017.config,
  GEOMETRY_2017.config,

  ELA_2017.config,
  GRADE_9_LIT_2017.config,
  AMERICAN_LIT_2017.config)


Georgia_SGP <- analyzeSGP(
  Georgia_SGP,
  sgp.config = GA_2017.config,
  sgp.percentiles = FALSE,
  sgp.projections = TRUE,
  sgp.projections.lagged = TRUE,
  sgp.percentiles.baseline = FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  sgp.projections.max.forward.progression.years=5,
  goodness.of.fit.print=FALSE,
  parallel.config = list(
    BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE,
    WORKERS=list(PROJECTIONS = 12, LAGGED_PROJECTIONS = 6)))


###  Post Process @SGP$SGPercentiles to get SGP_ORDER_1 info merged in to highest order row

for (ca in names(Georgia_SGP@SGP$SGPercentiles)) {
  tmp.SGPercentiles <- Georgia_SGP@SGP$SGPercentiles[[ca]]
  tmp.SGPercentiles$Most_Recent_Prior <- as.character(NA)
  tmp.SGPercentiles[, Most_Recent_Prior := sapply(strsplit(as.character(tmp.SGPercentiles$SGP_NORM_GROUP), "; "), function(x) rev(x)[2])]

  setkey(tmp.SGPercentiles, ID, Most_Recent_Prior)
  tmp.SGPercentiles <- tmp.SGPercentiles[!is.na(SGP_ORDER_1), list(ID, Most_Recent_Prior, SGP_ORDER_1)][tmp.SGPercentiles][, i.SGP_ORDER_1 := NULL]
  tmp.SGPercentiles <- tmp.SGPercentiles[!is.na(SGP_SIMEX_ORDER_1), list(ID, Most_Recent_Prior, SGP_SIMEX_ORDER_1)][tmp.SGPercentiles][, i.SGP_SIMEX_ORDER_1 := NULL]

  tmp.SGPercentiles -> Georgia_SGP@SGP$SGPercentiles[[ca]]
}
