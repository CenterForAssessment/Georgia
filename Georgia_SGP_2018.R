#################################################################
###                                                           ###
###             Calculate SGPs for Georgia - 2018             ###
###                                                           ###
#################################################################

### Load required packages
require(SGP)
require(data.table)

###  Read in 2018 SGP Configuration Scripts

#    GA DOE ::
setwd('U:/DATA/SGP/Data/2018 SGPs/2018 SGP Calculation')

source('U:/DATA/SGP/Data/2018 SGPs/2018 SGP Calculation/2018 config/ELA.R')
source("U:/DATA/SGP/Data/2018 SGPs/2018 SGP Calculation/2018 config/MATHEMATICS.R")


#    CFA/AVI ::
setwd('~/SGP_Projects/Georgia/')

source("SGP_CONFIG/EOCT/2018/ELA.R")
source("SGP_CONFIG/EOCT/2018/MATHEMATICS.R")


###
###    EOG Analyses
###

###  Combine 2018 SGP EOG Configuration Scripts
GA_2018.config <- c(
  MATHEMATICS_2018.config,
  ELA_2018.config)


###  Load Required Data (Prior Years in SGP object, Current Year in data table)
load("Data/Georgia_SGP-Shell_2018.Rdata")
load("Data/Georgia_Data_LONG_2018_EOG.Rdata")


###  Run SGP Object Preparation and Student Growth Percentiles via `updateSGP` function
Georgia_SGP <- updateSGP(
  what_sgp_object=Georgia_SGP,
  with_sgp_data_LONG=Georgia_Data_LONG_2018,
  sgp.config = GA_2018.config,
  steps=c("prepareSGP", "analyzeSGP"),
  sgp.percentiles = TRUE,
  sgp.projections = FALSE,
  sgp.projections.lagged = FALSE,
  sgp.percentiles.baseline = FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  sgp.percentiles.equated = FALSE,
  simulate.sgps = TRUE,
  calculate.simex = TRUE, #  Use list below for PRELIM data tests.
  # calculate.simex = list(csem.data.vnames="SCALE_SCORE_CSEM", lambda=seq(0,2,0.5), simulation.iterations=75, simex.sample.size=5000, extrapolation="linear", save.matrices=TRUE, verbose=TRUE),          ## PRELIM CODE ##
  goodness.of.fit.print=TRUE,
  save.intermediate.results=FALSE,
   parallel.config = list(BACKEND="PARALLEL", WORKERS=list(TAUS=20, SIMEX=15))) # BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE,

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")


###   analyzeSGP to produce Projections for EOG subjects

##    Load EOC Coefficient_Matrices produced from preliminary analyses (see EOC section below)
##    Combine these with EOG matrices to run EOG projections.
load("Data/Georgia_EOC_Coef_Matrices_2018.rda")

Georgia_SGP@SGP$Coefficient_Matrices <- c(Georgia_SGP@SGP$Coefficient_Matrices, Georgia_EOC_Coef_Matrices_2018)

##    Include ALGEBRA_I, COORDINATE_ALGEBRA and GRADE_9_LIT in configs to get 8th grade projections
GA_2018.config <- c(
  MATHEMATICS_2018.config,
  ALGEBRA_I_2018.config,
  COORDINATE_ALGEBRA_2018.config,

  ELA_2018.config,
  GRADE_9_LIT_2018.config)

Georgia_SGP <- analyzeSGP(
  Georgia_SGP,
  sgp.config = GA_2018.config,
  sgp.percentiles = FALSE,
  sgp.projections = TRUE,
  sgp.projections.lagged = TRUE,
  sgp.percentiles.baseline = FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  goodness.of.fit.print=FALSE,
  parallel.config = list(
    BACKEND="FOREACH", TYPE="doParallel", # SNOW_TEST=TRUE,
    WORKERS=list(PROJECTIONS = 9, LAGGED_PROJECTIONS = 6)))


###   combineSGP  -- EOG (Run target scale scores in final combineSGP with EOC)

Georgia_SGP <- combineSGP(Georgia_SGP, years = "2018")


###   outputSGP

outputSGP(Georgia_SGP, output.type = "LONG_FINAL_YEAR_Data")


###   Remove EOC preliminary coef matrices from object before saving
Georgia_SGP@SGP$Coefficient_Matrices <- Georgia_SGP@SGP$Coefficient_Matrices[grep("ELA|MATHEMATICS", names(Georgia_SGP@SGP$Coefficient_Matrices))]

save(Georgia_SGP, file="Data/Georgia_SGP-prelim_fin.Rdata")


###
###    EOC Analyses
###

load("Data/Georgia_SGP.Rdata")
load("Data/Georgia_Data_LONG_2018_EOC.Rdata")

###  Combine 2018 SGP EOC Configuration Scripts
source("SGP_CONFIG/EOCT/2018/ELA.R")
source("SGP_CONFIG/EOCT/2018/MATHEMATICS.R")

GA_2018.config <- c(
  COORDINATE_ALGEBRA_2018.config,
  ANALYTIC_GEOMETRY_2018.config,
  ALGEBRA_I_2018.config,
  GEOMETRY_2018.config,

  GRADE_9_LIT_2018.config,
  AMERICAN_LIT_2018.config
)

###  Run SGP Object Preparation and Student Growth Percentiles via `updateSGP` function
Georgia_SGP <- updateSGP(
  what_sgp_object=Georgia_SGP,
  with_sgp_data_LONG=Georgia_Data_LONG_2018,
  sgp.config = GA_2018.config,
  steps=c("prepareSGP", "analyzeSGP"),
  overwrite.existing.data=FALSE,
	output.updated.data=FALSE,
  sgp.percentiles = TRUE,
  sgp.projections = FALSE,
  sgp.projections.lagged = FALSE,
  sgp.percentiles.baseline=FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  sgp.percentiles.equated = FALSE,
  simulate.sgps = TRUE,
  calculate.simex = TRUE, #  Use list below for PRELIM data tests.
  # calculate.simex = prelim.simex,  ## PRELIM CODE ##
  goodness.of.fit.print=TRUE,
  save.intermediate.results=FALSE,
    parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", WORKERS=list(TAUS=15, SIMEX=15))) # SNOW_TEST=TRUE,

###  Save Coefficient_Matrices from preliminary and use for projections
Georgia_EOC_Coef_Matrices_2018 <- Georgia_SGP@SGP$Coefficient_Matrices[-grep("ELA|MATHEMATICS", names(Georgia_SGP@SGP$Coefficient_Matrices))]
save(Georgia_EOC_Coef_Matrices_2018, file="Data/Georgia_EOC_Coef_Matrices_2018.rda")

# save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")

###   analyzeSGP to produce Projections for EOC subjects (only final year subjects - other EOCs ran above with EOGs)

GA_2018.config <- c(
  ANALYTIC_GEOMETRY_2018.config,
  GEOMETRY_2018.config,
  AMERICAN_LIT_2018.config)

Georgia_SGP <- analyzeSGP(
  Georgia_SGP,
  sgp.config = GA_2018.config,
  sgp.percentiles = FALSE,
  sgp.projections = TRUE,
  sgp.projections.lagged = TRUE,
  sgp.percentiles.baseline = FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  goodness.of.fit.print=FALSE,
  parallel.config = list(
    BACKEND="FOREACH", TYPE="doParallel", # SNOW_TEST=TRUE,
    WORKERS=list(PROJECTIONS = 6, LAGGED_PROJECTIONS = 6)))


####
###   Post Process @SGP$SGPercentiles to get SGP_ORDER_1 info merged in to highest order row.
###   This is necessary for CONTENT_AREA configs in which `sgp.exact.grade.progression` is used for 2 prior progressions
####

for (ca in names(Georgia_SGP@SGP$SGPercentiles)) {
  tmp.SGPercentiles <- Georgia_SGP@SGP$SGPercentiles[[ca]]
  tmp.SGPercentiles$Most_Recent_Prior <- as.character(NA)
  tmp.SGPercentiles[, Most_Recent_Prior := sapply(strsplit(as.character(tmp.SGPercentiles$SGP_NORM_GROUP), "; "), function(x) rev(x)[2])]

  setkey(tmp.SGPercentiles, ID, Most_Recent_Prior)
  tmp.SGPercentiles <- tmp.SGPercentiles[!is.na(SGP_ORDER_1), list(ID, Most_Recent_Prior, SGP_ORDER_1)][tmp.SGPercentiles][, i.SGP_ORDER_1 := NULL]
  tmp.SGPercentiles <- tmp.SGPercentiles[!is.na(SGP_SIMEX_ORDER_1), list(ID, Most_Recent_Prior, SGP_SIMEX_ORDER_1)][tmp.SGPercentiles][, i.SGP_SIMEX_ORDER_1 := NULL]
  tmp.SGPercentiles <- tmp.SGPercentiles[!is.na(SGP_SIMEX_RANKED_ORDER_1), list(ID, Most_Recent_Prior, SGP_SIMEX_RANKED_ORDER_1)][tmp.SGPercentiles][, i.SGP_SIMEX_RANKED_ORDER_1 := NULL]

  tmp.SGPercentiles -> Georgia_SGP@SGP$SGPercentiles[[ca]]
}


###
###   combineSGP
###

###   Calculate all Target Scale Scores at same time (not used in FORMATTED results)

GA_2018.config <- c(
  MATHEMATICS_2018.config,
  ALGEBRA_I_2018.config,
  COORDINATE_ALGEBRA_2018.config,
  ANALYTIC_GEOMETRY_2018.config,
  GEOMETRY_2018.config,

  ELA_2018.config,
  GRADE_9_LIT_2018.config,
  AMERICAN_LIT_2018.config)

Georgia_SGP <- combineSGP(Georgia_SGP,
    years = "2018",
    # max.sgp.target.years.forward = 1,
    sgp.target.scale.scores = TRUE,
    sgp.config = GA_2018.config,
    parallel.config = list(
      BACKEND = "FOREACH", TYPE = "doParallel", # SNOW_TEST=TRUE,
      WORKERS = list(SGP_SCALE_SCORE_TARGETS = 10)))

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")


###
###   outputSGP
###

outputSGP(Georgia_SGP)

###
###   summarizeSGP
###

Georgia_SGP <- summarizeSGP(
	Georgia_SGP,
	parallel.config=list(
		BACKEND="PARALLEL", WORKERS=list(SUMMARY=3))
)

Georgia_Summary_2018 <- Georgia_SGP@Summary

save(Georgia_Summary_2018, file="Data/Georgia_Summary_2018.Rdata")


###
###   visualizeSGP
###

load("Data/Georgia_Summary_2018.Rdata")
Georgia_SGP@Summary <- Georgia_Summary_2018

Georgia_SGP@Data$SCHOOL_NAME <- as.character(NA); gc()
Georgia_SGP@Data$DISTRICT_NAME <- as.character(NA); gc()

visualizeSGP(Georgia_SGP,
						 plot.types = c("bubblePlot", "growthAchievementPlot"),
						 bPlot.years= "2018",
             bPlot.content_areas=c("ELA", "MATHEMATICS"),
						 bPlot.anonymize=TRUE,
             gaPlot.years = "2018",
             gaPlot.content_areas = c("ELA", "MATHEMATICS"),
             gaPlot.max.order.for.progression=2,
            #  gaPlot.start.points="Achievement Percentiles",
						 parallel.config=list(
						 	BACKEND='FOREACH', TYPE="doParallel",
						 	WORKERS=list(GA_PLOTS=10)))
