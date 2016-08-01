
###  Read in 2016 SGP Configuration Scripts and Combine

source('U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/2016 config/ELA.R')
source("U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/2016 config/SCIENCE.R")
source("U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/2016 config/SOCIAL_STUDIES.R")
source("U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/2016 config/MATHEMATICS.R")

GA_2016.config <- c(
  MATHEMATICS_2016.config,
  COORDINATE_ALGEBRA_2016.config,
  ANALYTIC_GEOMETRY_2016.config,
  
  SCIENCE_2016.config,
  BIOLOGY_2016.config,
  PHYSICAL_SCIENCE_2016.config,
  
  SOCIAL_STUDIES_2016.config,
  US_HISTORY_2016.config,
  ECONOMICS_2016.config,
  
  ELA_2016.config,
  GRADE_9_LIT_2016.config,
  AMERICAN_LIT_2016.config
  )

###  Winnow out all course progressions with fewer than 1,500 kids (per discussion on 1/27/16)
SGPstateData[["GA"]][["SGP_Configuration"]][["sgp.cohort.size"]] <- 1500



### updateSGP

Georgia_SGP <- updateSGP(
  what_sgp_object=Georgia_SGP,
  with_sgp_data_LONG=Georgia_Data_LONG_2016,
  sgp.config = GA_2016.config,
  # Run summarizeSGP step AFTER we get Teacher-Student Links
  steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
  sgp.percentiles = TRUE,
  sgp.projections = FALSE, #
  sgp.projections.lagged = FALSE, #
  sgp.percentiles.baseline=FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  sgp.percentiles.equated = FALSE, #
  simulate.sgps = TRUE,
  calculate.simex = TRUE,
  #sgp.test.cohort.size=2000,
  return.sgp.test.results=TRUE,
  goodness.of.fit.print=TRUE,
  save.intermediate.results=FALSE,
  outputSGP.output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"),
  parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE, WORKERS=list(TAUS=12, SIMEX=12)))
  
  


