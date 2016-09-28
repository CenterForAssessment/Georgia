#########################################################
###
###     Re-Calculate SGPs for Georgia - 2016
###
##########################################################

### Load required packages

require(SGP)
require(data.table)

###  Read in 2016 SGP Configuration Scripts

#    GA DOE ::
setwd('U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation')

source('U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/2016 config/ELA.R')
source("U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/2016 config/SCIENCE.R")
source("U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/2016 config/SOCIAL_STUDIES.R")
source("U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/2016 config/MATHEMATICS.R")


#    CFA/AVI
setwd('~/SGP_Projects/Georgia')

source("SGP_CONFIG/EOCT/2016/ELA.R")
source("SGP_CONFIG/EOCT/2016/SCIENCE.R")
source("SGP_CONFIG/EOCT/2016/SOCIAL_STUDIES.R")
source("SGP_CONFIG/EOCT/2016/MATHEMATICS.R")


###  Combine 2016 SGP EOG & EOC Configuration Scripts
GA_2016.config <- c(
  MATHEMATICS_2016.config,
  COORDINATE_ALGEBRA_2016.config,
  ANALYTIC_GEOMETRY_2016.config,
  ALGEBRA_I_2016.config,
  GEOMETRY_2016.config,

  SCIENCE_2016.config,
  BIOLOGY_2016.config,
  PHYSICAL_SCIENCE_2016.config,

  SOCIAL_STUDIES_2016.config,
  US_HISTORY_2016.config,
  ECONOMICS_2016.config,

  ELA_2016.config,
  GRADE_9_LIT_2016.config,
  AMERICAN_LIT_2016.config)

### updateSGP
load("Data/Georgia_SGP-Shell_2016+Coef_Matrices.Rdata")
load("Data/Georgia_Data_LONG_2016.Rdata")

Georgia_SGP <- updateSGP(
  what_sgp_object=Georgia_SGP,
  with_sgp_data_LONG=Georgia_Data_LONG_2016,
  # overwrite.existing.data=FALSE, # unnecessary after SGP version 1.5-9.12
  sgp.config = GA_2016.config,
  steps=c("prepareSGP", "analyzeSGP"),
  sgp.percentiles = TRUE,
  sgp.projections = TRUE,
  sgp.projections.lagged = TRUE,
  sgp.percentiles.baseline=FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  sgp.percentiles.equated = FALSE,
  simulate.sgps = TRUE,
  sgp.use.my.coefficient.matrices=TRUE,
  calculate.simex = list(
      csem.data.vnames="SCALE_SCORE_CSEM", lambda=seq(0,2,0.5), simulation.iterations=75, simex.sample.size=5000,
      extrapolation="linear", simex.use.my.coefficient.matrices=TRUE, save.matrices=TRUE),
  goodness.of.fit.print=TRUE,
  save.intermediate.results=FALSE,
  parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", WORKERS=list(TAUS=12, SIMEX=25))) #SNOW_TEST=TRUE,

save(Georgia_SGP, file="Georgia_SGP-recalc.Rdata")


###  Post Process @SGP$SGPercentiles to get SGP_ORDER_1 info merged in to highest order row

for (ca in names(Georgia_SGP@SGP$SGPercentiles)) {
  if (names(Georgia_SGP@SGP$SGPercentiles[ca]) %in% c("ECONOMICS.2016", "US_HISTORY.2016")) {
    cat(paste("\n\tSkipping", names(Georgia_SGP@SGP$SGPercentiles[ca]), "\n"))
    next
  }
  tmp.SGPercentiles <- Georgia_SGP@SGP$SGPercentiles[[ca]]
  tmp.SGPercentiles$Most_Recent_Prior <- as.character(NA)
  tmp.SGPercentiles[, Most_Recent_Prior := sapply(strsplit(as.character(tmp.SGPercentiles$SGP_NORM_GROUP), "; "), function(x) rev(x)[2])]

  setkey(tmp.SGPercentiles, ID, Most_Recent_Prior)
  tmp.SGPercentiles <- tmp.SGPercentiles[!is.na(SGP_ORDER_1), list(ID, Most_Recent_Prior, SGP_ORDER_1)][tmp.SGPercentiles][, i.SGP_ORDER_1 := NULL]
  tmp.SGPercentiles <- tmp.SGPercentiles[!is.na(SGP_SIMEX_ORDER_1), list(ID, Most_Recent_Prior, SGP_SIMEX_ORDER_1)][tmp.SGPercentiles][, i.SGP_SIMEX_ORDER_1 := NULL]

  tmp.SGPercentiles -> Georgia_SGP@SGP$SGPercentiles[[ca]]
}


###
###   combineSGP
###

Georgia_SGP <- combineSGP(Georgia_SGP)

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")

###
###   outputSGP
###

outputSGP(Georgia_SGP)
