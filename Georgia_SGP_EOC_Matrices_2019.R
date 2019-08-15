#################################################################
###                                                           ###
###             Calculate SGPs for Georgia - 2019             ###
###                                                           ###
#################################################################

### Load required packages ###
require(SGP)
require(data.table)

###  Load Required Data (Prior Years in SGP Shell object, Current Year in data table)
load("Data/Georgia_SGP-Shell_2019.Rdata")
load("Data/Georgia_Data_LONG_2019_EOC.Rdata")

###  Combine 2019 SGP EOC Configuration Scripts
source("SGP_CONFIG/EOCT/2019/ELA.R")
source("SGP_CONFIG/EOCT/2019/MATHEMATICS.R")

GA_2019.config <- c(
  COORDINATE_ALGEBRA_2019.config,
  ANALYTIC_GEOMETRY_2019.config,
  ALGEBRA_I_2019.config,
  GEOMETRY_2019.config,

  GRADE_9_LIT_2019.config,
  AMERICAN_LIT_2019.config
)

###   Reduce config to include only progressions that will be used to calculate SGProjections
GA_2019.config <- GA_2019.config[!sapply(GA_2019.config, function(f) any(grepl("NO_PROJECTIONS", f)))]

###   Remove sgp.exact.grade.progression for all progressions EXCEPT G7_MATH_EOC
for (f in 1:length(GA_2019.config)) {
  if (!(tail(GA_2019.config[[f]]$sgp.content.areas,1)=="GEOMETRY" & head(GA_2019.config[[f]]$sgp.grade.sequences[[1]],1) == 7))
  GA_2019.config[[f]][["sgp.exact.grade.progression"]] <- NULL
}

###
###    Run EOC Analyses for SGPs only.  No combineSGP, outputSGP, etc.  Only need Coefficient_Matrices
###

Georgia_SGP <- updateSGP(
    what_sgp_object=Georgia_SGP,
    with_sgp_data_LONG=Georgia_Data_LONG_2019_EOC,
    sgp.config = GA_2019.config,
    steps=c("prepareSGP", "analyzeSGP"),
    sgp.percentiles = TRUE,
    sgp.projections = FALSE,
    sgp.projections.lagged = FALSE,
    sgp.percentiles.baseline=FALSE,
    sgp.projections.baseline = FALSE,
    sgp.projections.lagged.baseline = FALSE,
    goodness.of.fit.print=FALSE,
    save.intermediate.results=FALSE,
    parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", WORKERS=list(TAUS=20)))
    # parallel.config = list(
    #   BACKEND="PARALLEL",
    #   WORKERS=list(TAUS=20, SIMEX=15)))


###  Save Coefficient_Matrices from preliminary and use for projections
Georgia_EOC_Coef_Matrices_2019 <- Georgia_SGP@SGP$Coefficient_Matrices
save(Georgia_EOC_Coef_Matrices_2019, file="Data/Georgia_EOC_Coef_Matrices_2019.rda")

###  DON'T Save Georgia_SGP!  Only want Georgia_EOC_Coef_Matrices_2019
