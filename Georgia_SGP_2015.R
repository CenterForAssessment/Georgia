#########################################################
###
### Calculate SGPs for Georgia - 2015
###
##########################################################

### Load required packages

require(SGP)
require(data.table)

setwd('~/SGP_Projects/Georgia')

###  Load NEW Georgia SGP object and 2015 data (if starting new session after data cleaning and new object creation)
###  Alternatively, use this to clean up working environment after running data prep and creating new SGP object:
# rm(list=c(grep("Georgia_SGP|Georgia_Data_LONG_2015", ls(), invert=T, value=T), "Georgia_SGP_LONG_Data")); gc()

load("Data/Georgia_SGP.Rdata")
load("Data/Georgia_Data_LONG_2015.Rdata")


###  Read in 2015 SGP Configuration Scripts and Combine

source("SGP_CONFIG/EOCT/2015/ELA.R")
source("SGP_CONFIG/EOCT/2015/SCIENCE.R")
source("SGP_CONFIG/EOCT/2015/SOCIAL_STUDIES.R")
source("SGP_CONFIG/EOCT/2015/MATHEMATICS.R")

GA_2015.config <- c(
		MATHEMATICS_2015.config,
		COORDINATE_ALGEBRA_2015.config,
		ANALYTIC_GEOMETRY_2015.config,

		SCIENCE_2015.config,
		BIOLOGY_2015.config,
		PHYSICAL_SCIENCE_2015.config,

		SOCIAL_STUDIES_2015.config,
		US_HISTORY_2015.config,
		ECONOMICS_2015.config,

		ELA_2015.config,
		GRADE_9_LIT_2015.config,
		AMERICAN_LIT_2015.config)

###  Winnow out all course progressions with fewer than 1,500 kids (per discussion on 1/27/16)
SGPstateData[["GA"]][["SGP_Configuration"]][["sgp.cohort.size"]] <- 1500

### updateSGP

Georgia_SGP <- updateSGP(
		what_sgp_object=Georgia_SGP,
		with_sgp_data_LONG=Georgia_Data_LONG_2015,
		sgp.config = GA_2015.config,
		# Run summarizeSGP step AFTER we get Teacher-Student Links
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles = TRUE,
		sgp.projections = TRUE,
		sgp.projections.lagged = TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline = FALSE,
		sgp.projections.lagged.baseline = FALSE,
		sgp.percentiles.equated = TRUE,
		simulate.sgps = TRUE,
		calculate.simex = TRUE,
		goodness.of.fit.print=TRUE,
		save.intermediate.results=FALSE,
		outputSGP.output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"),
		parallel.config = list(BACKEND="PARALLEL", WORKERS=list(TAUS=22, SIMEX=20))) # Ubuntu/Linux
		# parallel.config = list(BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE, WORKERS=list(TAUS=11, SIMEX=11))) # WINDOWS

### Fill in ACHIEVEMENT_LEVEL_PRIOR for ELA
Georgia_SGP@Data[which(CONTENT_AREA=="ELA" & YEAR=='2015' & VALID_CASE=="VALID_CASE"), ACHIEVEMENT_LEVEL_PRIOR :=
	ordered(findInterval(as.numeric(SCALE_SCORE_PRIOR), c(800, 850)), labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]

outputSGP(Georgia_SGP, output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"))
### Save Results

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")


###  Summarize Results
Georgia_SGP <- summarizeSGP(
	Georgia_SGP,
	parallel.config=list(
		# BACKEND="PARALLEL",
		BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE, 
		WORKERS=list(SUMMARY=5))
)

###  Visualize Results
Georgia_SGP@Data$SCHOOL_NAME <- as.character(NA); gc()
Georgia_SGP@Data$DISTRICT_NAME <- as.character(NA); gc()

SGPstateData[["GA"]][["Student_Report_Information"]][["Transformed_Achievement_Level_Cutscores"]] <- 
	list(ELA=c(100, 200, 300), GRADE_9_LIT=c(100, 200, 300), AMERICAN_LIT=c(100, 200, 300),
			 SOCIAL_STUDIES=c(100, 200, 300), US_HISTORY=c(100, 200, 300), ECONOMICS=c(100, 200, 300),
			 SCIENCE=c(100, 200, 300), BIOLOGY=c(100, 200, 300), PHYSICAL_SCIENCE=c(100, 200, 300),
			 MATHEMATICS=c(100, 200, 300), COORDINATE_ALGEBRA=c(100, 200, 300),ANALYTIC_GEOMETRY=c(100, 200, 300))

visualizeSGP(Georgia_SGP,
						 plot.types = "growthAchievementPlot",#c("bubblePlot", "growthAchievementPlot"),
						 bPlot.years= "2015",
						 bPlot.content_areas=c("ELA", "SOCIAL_STUDIES", "SCIENCE", "MATHEMATICS"),
						 bPlot.anonymize=TRUE,
						 gaPlot.content_areas = c("SOCIAL_STUDIES", "SCIENCE", "MATHEMATICS"),
						 parallel.config=list(
						 	BACKEND='FOREACH', TYPE="doParallel",
						 	WORKERS=list(GA_PLOTS=12)))
