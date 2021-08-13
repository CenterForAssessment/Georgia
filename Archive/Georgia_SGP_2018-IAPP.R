###########################################################################
###                                                                     ###
###     Re-calculate SGPs for Georgia without IAPP Districts - 2018     ###
###                                                                     ###
###########################################################################

### Load required packages
require(SGP)
require(data.table)

setwd("/media/Data/GA_IAPP")

###  Load Required Data (Prior Years in SGP object, Current Year in data table)
load("Data/Georgia_SGP-Shell_2018.Rdata")
load("Data/Georgia_Data_LONG_2018_EOG.Rdata")
assign('Georgia_Data_LONG_2018_EOG', Georgia_Data_LONG_2018); rm(Georgia_Data_LONG_2018)
load("Data/Georgia_Data_LONG_2018_EOC.Rdata")
assign('Georgia_Data_LONG_2018_EOC', Georgia_Data_LONG_2018); rm(Georgia_Data_LONG_2018)

# IAPP_Districts <- data.table(read.csv("Data/IAPP_districts.csv", stringsAsFactors=FALSE))
# paste(IAPP_Districts$SR_SYSTEM_ID, collapse="', '")
IAPP_Districts <- c('607', '631', '772', '671', '678', '679', '781', '715', '657', '765', '637', '647', '654', '656', '689', '698', '709', '714', '717', '793')

Georgia_SGP@Data <- Georgia_SGP@Data[!DISTRICT_NUMBER %in% IAPP_Districts & YEAR %in% 2015:2017] # This Shell has 2018 data!?!  See EOC subset below?
Georgia_Data_LONG_2018_EOG <- Georgia_Data_LONG_2018_EOG[!SR_SYSTEM_ID %in% IAPP_Districts]
Georgia_Data_LONG_2018_EOC <- Georgia_Data_LONG_2018_EOC[!SR_SYSTEM_ID %in% IAPP_Districts & SCHOOL_YEAR == '2018'] # Remove 2017 Test Out students - already in Shell

setkey(Georgia_SGP@Data, VALID_CASE, CONTENT_AREA, GRADE, YEAR, ID, YEAR_WITHIN, SCALE_SCORE)
setkey(Georgia_SGP@Data, VALID_CASE, CONTENT_AREA, GRADE, YEAR, ID, YEAR_WITHIN)
sum(duplicated(Georgia_SGP@Data[VALID_CASE != "INVALID_CASE"], by=key(Georgia_SGP@Data))) # 497 EOC duplicates with valid GTIDs - (((take the highest score if any exist)))
dups <- data.table(Georgia_SGP@Data[unique(c(which(duplicated(Georgia_SGP@Data, by=key(Georgia_SGP@Data)))-1, which(duplicated(Georgia_SGP@Data, by=key(Georgia_SGP@Data))))), ], key=key(Georgia_SGP@Data))
Georgia_SGP@Data[which(duplicated(Georgia_SGP@Data, by=key(Georgia_SGP@Data)))-1, VALID_CASE := "INVALID_CASE"] # 1 new invalid for 2018 IAPP

###  Read in 2018 SGP Configuration Scripts
source("SGP_CONFIG/EOCT/2018/ELA.R")
source("SGP_CONFIG/EOCT/2018/MATHEMATICS.R")

###
###    EOC calculation of coefficient matrices for projections
###

GA_2018.config <- c(
  COORDINATE_ALGEBRA_2018.config,
  ANALYTIC_GEOMETRY_2018.config,
  ALGEBRA_I_2018.config,
  GEOMETRY_2018.config,

  GRADE_9_LIT_2018.config,
  AMERICAN_LIT_2018.config
)

###   Reduce config to include only progressions that will be used to calculate SGProjections
GA_2018.config <- GA_2018.config[!sapply(GA_2018.config, function(f) any(grepl("NO_PROJECTIONS", f)))]

###   Remove sgp.exact.grade.progression for all progressions EXCEPT G7_MATH_EOC
for (f in 1:length(GA_2018.config)) {
  if (!(tail(GA_2018.config[[f]]$sgp.content.areas,1)=="GEOMETRY" & head(GA_2018.config[[f]]$sgp.grade.sequences[[1]],1) == 7))
  GA_2018.config[[f]][["sgp.exact.grade.progression"]] <- NULL
}

###
###    Run EOC Analyses for SGPs only.  No combineSGP, outputSGP, etc.  Only need Coefficient_Matrices
###

Georgia_Data_LONG_2018_EOC_Fall_Spring <- Georgia_Data_LONG_2018_EOC[YEAR_WITHIN %in% 1:2]

GA_TMP_SGP <- updateSGP(
    what_sgp_object=Georgia_SGP,
    with_sgp_data_LONG=Georgia_Data_LONG_2018_EOC_Fall_Spring,
    sgp.config = GA_2018.config,
    steps=c("prepareSGP", "analyzeSGP"),
    sgp.percentiles = TRUE,
    sgp.projections = FALSE,
    sgp.projections.lagged = FALSE,
    sgp.percentiles.baseline=FALSE,
    sgp.projections.baseline = FALSE,
    sgp.projections.lagged.baseline = FALSE,
    save.intermediate.results=FALSE,
    parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", WORKERS=list(TAUS=20)))

###  Save Coefficient_Matrices from preliminary and use for projections
Georgia_EOC_Coef_Matrices_2018 <- GA_TMP_SGP@SGP$Coefficient_Matrices
save(Georgia_EOC_Coef_Matrices_2018, file="Data/Georgia_EOC_Coef_Matrices_2018-reduced.rda")
rm(GA_TMP_SGP) #  Don't need temporary SGP object from Coefficient_Matrices production


###
###    Run EOG Analyses using pre-calculated EOC Coefficient_Matrices for projections.
###

##    Load EOC Coefficient_Matrices produced from Fall/Spring data (see above step)
##    Populate @SGP$Coefficient_Matrices slot with these with EOC matrices to run EOG projections.

load("Data/Georgia_EOC_Coef_Matrices_2018-reduced.rda")
Georgia_SGP@SGP$Coefficient_Matrices <- Georgia_EOC_Coef_Matrices_2018

##    Include ALGEBRA_I, COORDINATE_ALGEBRA and GRADE_9_LIT in configs to get 8th grade projections
GA_2018.config <- c(
  MATHEMATICS_2018.config,
  ALGEBRA_I_2018.config,
  COORDINATE_ALGEBRA_2018.config,

  ELA_2018.config,
  GRADE_9_LIT_2018.config)

Georgia_SGP <- updateSGP(
  what_sgp_object=Georgia_SGP,
  with_sgp_data_LONG=Georgia_Data_LONG_2018_EOG,
  sgp.config = GA_2018.config,
  steps=c("prepareSGP", "analyzeSGP"),
  save.intermediate.results=FALSE,
  overwrite.existing.data=FALSE,
  output.updated.data=FALSE,

  sgp.percentiles = TRUE,
  sgp.projections = TRUE,
  sgp.projections.lagged = TRUE,
  sgp.percentiles.baseline = FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  simulate.sgps = TRUE,
  calculate.simex = TRUE,
  parallel.config = list(
    BACKEND="PARALLEL",
    WORKERS=list(TAUS=11, SIMEX=11)))

###   Remove EOC preliminary coef matrices from object before saving
Georgia_SGP@SGP$Coefficient_Matrices <- Georgia_SGP@SGP$Coefficient_Matrices[grep("ELA|MATHEMATICS", names(Georgia_SGP@SGP$Coefficient_Matrices))]

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")

###
###    EOC Analyses
###

###   Load data if not already loaded from analyses above...
# load("Data/Georgia_SGP.Rdata")
# load("Data/Georgia_Data_LONG_2018_EOC.Rdata")

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
  with_sgp_data_LONG=Georgia_Data_LONG_2018_EOC,
  sgp.config = GA_2018.config,
  steps=c("prepareSGP", "analyzeSGP"),
  overwrite.existing.data=FALSE,
	output.updated.data=FALSE,
  sgp.percentiles = TRUE,
  sgp.projections = TRUE,
  sgp.projections.lagged = TRUE,
  sgp.percentiles.baseline=FALSE,
  sgp.projections.baseline = FALSE,
  sgp.projections.lagged.baseline = FALSE,
  simulate.sgps = TRUE,
  calculate.simex = TRUE,
  save.intermediate.results=FALSE,
    parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", WORKERS=list(TAUS=11, SIMEX=11)))


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

Georgia_SGP <- combineSGP(Georgia_SGP, years = "2018")


###
###   Save final object and outputSGP for results
###

save(Georgia_SGP, file="Data/Georgia_SGP_IAPP_2018.Rdata")

outputSGP(Georgia_SGP, output.type="LONG_FINAL_YEAR_Data")
