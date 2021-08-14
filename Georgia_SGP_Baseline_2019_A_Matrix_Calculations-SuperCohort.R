################################################################################
###                                                                          ###
###        Georgia Learning Loss Analyses -- Create Baseline Matrices        ###
###                                                                          ###
################################################################################

### Load necessary packages
require(SGP)
require(data.table)

###   Load Original Georgia data from 2019 GA SGP Analyses

load("Data/Archive/2019/Georgia_SGP_LONG_Data.Rdata")

###   Use the following if creating SUPER-COHORT baselines:
load("Data/Archive/2021_PreCOVID/Georgia_SGP_LONG_Data_2015.Rdata")
setnames(Georgia_SGP_LONG_Data_2015,
          c("SCALE_SCORE_CSEM", "CATCH_UP_KEEP_UP_STATUS", "MOVE_UP_STAY_UP_STATUS"),
          c("CONDSEM", "CATCH_UP_KEEP_UP_STATUS_3_YEAR", "MOVE_UP_STAY_UP_STATUS_3_YEAR"))
Georgia_SGP_LONG_Data_2015[, names(Georgia_SGP_LONG_Data_2015)[!names(Georgia_SGP_LONG_Data_2015) %in% names(Georgia_SGP_LONG_Data)] := NULL]
Georgia_SGP_LONG_Data_2015 <- Georgia_SGP_LONG_Data_2015[!SUBJECT_CODE %in% c("PHYSICAL_SCIENCE", "SCIENCE", "SOCIAL_STUDIES", "US_HISTORY", "BIOLOGY", "ECONOMICS")]

Georgia_SGP_LONG_Data <- rbindlist(list(Georgia_SGP_LONG_Data, Georgia_SGP_LONG_Data_2015), fill=TRUE)
Georgia_SGP_LONG_Data[, SGP_FROM_2015 := NULL]

###   Create a smaller subset of the LONG data to work with.
Georgia_Baseline_Data <- data.table::data.table(Georgia_SGP_LONG_Data[,
	list(VALID_CASE, GTID, SCHOOL_YEAR, SUBJECT_CODE, YEAR_WITHIN, GRADE, SCALE_SCORE, CONDSEM, PERFORMANCE_LEVEL)])

###   Read in Baseline SGP Configuration Scripts and Combine
source("SGP_CONFIG/2019/BASELINE/Matrices/ELA_SuperCohort.R")
source("SGP_CONFIG/2019/BASELINE/Matrices/MATHEMATICS_SuperCohort.R")

GA_BASELINE_CONFIG <- c(
		ELA_BASELINE.config,
		GRADE_9_LIT_BASELINE.config,
		AMERICAN_LIT_BASELINE.config,

		MATHEMATICS_BASELINE.config,
		ALGEBRA_I_BASELINE.config,
		GEOMETRY_BASELINE.config,
		COORDINATE_ALGEBRA_BASELINE.config,
		ANALYTIC_GEOMETRY_BASELINE.config
)


###
###    baselineSGP - To produce uncorrected and SIMEX baseline matrices
###

###   Create shell SGP object and then re-run duplicate case invalidation and FIRST_/LAST_OBSERVATION creation

Georgia_SGP <- prepareSGP(Georgia_Baseline_Data, create.additional.variables=FALSE)

Georgia_SGP@Data[, VC_COMPLETE := VALID_CASE]

setkeyv(Georgia_SGP@Data, SGP:::getKey(Georgia_SGP@Data))
setkey(Georgia_SGP@Data, VALID_CASE, CONTENT_AREA, ID, GRADE, YEAR_WITHIN)
dups <- data.table(Georgia_SGP@Data[unique(c(which(duplicated(Georgia_SGP@Data, by=key(Georgia_SGP@Data)))-1, which(duplicated(Georgia_SGP@Data, by=key(Georgia_SGP@Data))))), ], key=key(Georgia_SGP@Data))
table(dups$VALID_CASE) # 80 duplicates within GRADE are already INVALID_CASEs - 186856 still VALID_CASEs
table(dups[VALID_CASE=="VALID_CASE", YEAR, CONTENT_AREA])
table(dups[VALID_CASE=="VALID_CASE" & CONTENT_AREA %in% c("ELA", "MATHEMATICS"), YEAR, GRADE])
Georgia_SGP@Data[which(duplicated(Georgia_SGP@Data, by=key(Georgia_SGP@Data)))-1, VALID_CASE := "INVALID_CASE"]

###   Might need to re-think YEAR_WITHIN in the context of baselineSGPs...
###   Baseline on first/last observation?  Do repeaters manually outside baselineSGP?
###   Add in a prepareSGP call in baselineSGP to re-work FIRST/LAST_OBSERVATION?
###   Run without this next invalidation chunk to get error/data stack...
###   Repeaters with 3 (or more records)

setkeyv(Georgia_SGP@Data, SGP:::getKey(Georgia_SGP@Data))
setkey(Georgia_SGP@Data, VALID_CASE, CONTENT_AREA, ID, GRADE)
dups <- data.table(Georgia_SGP@Data[unique(c(which(duplicated(Georgia_SGP@Data, by=key(Georgia_SGP@Data)))-1, which(duplicated(Georgia_SGP@Data, by=key(Georgia_SGP@Data))))), ], key=key(Georgia_SGP@Data))
table(dups$VALID_CASE)
table(dups[VALID_CASE=="VALID_CASE", YEAR, CONTENT_AREA])

Georgia_SGP@Data[setdiff(which(duplicated(Georgia_SGP@Data, by=key(Georgia_SGP@Data)))-1, which(Georgia_SGP@Data[,YEAR]=='2019')), VALID_CASE := "INVALID_CASE"]

Georgia_SGP@Data[, FIRST_OBSERVATION := NULL]
Georgia_SGP@Data[, LAST_OBSERVATION := NULL]

###   Re-run prepareSGP to get updated FIRST/LAST_OBSERVATION if necessary
Georgia_SGP <- prepareSGP(Georgia_SGP, create.additional.variables=FALSE)

table(Georgia_SGP@Data[, VALID_CASE, VC_COMPLETE])
table(Georgia_SGP@Data[VC_COMPLETE == "VALID_CASE" & VALID_CASE == "INVALID_CASE", YEAR, CONTENT_AREA])

GA_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=GA_BASELINE_CONFIG,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	calculate.simex.baseline=list(
		csem.data.vnames="SCALE_SCORE_CSEM", lambda=seq(0,2,0.5), simulation.iterations=75,
		simex.use.my.coefficient.matrices = FALSE, simex.sample.size=2000, # simex.sample.size=10000
		extrapolation="linear", save.matrices=TRUE, use.cohort.for.ranking=TRUE),
	###
	sgp.test.cohort.size = 10000, # comment out for full run and change calculate.simex.baseline$simex.sample.size to 10000
	###
	sgp.cohort.size=1500,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=13, SIMEX=13)))

###   Save results
save(GA_Baseline_Matrices, file="Data/GA_Baseline_Matrices.Rdata")
