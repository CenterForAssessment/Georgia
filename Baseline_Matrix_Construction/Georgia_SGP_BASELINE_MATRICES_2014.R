
load("Data/Georgia_SGP.Rdata")

Georgia_Baseline_Matrices <- Georgia_SGP@SGP$Coefficient_Matrices[grep("BASELINE", names(Georgia_SGP@SGP$Coefficient_Matrices))]
Georgia_SGP@SGP$Coefficient_Matrices <- Georgia_SGP@SGP$Coefficient_Matrices[-grep("BASELINE", names(Georgia_SGP@SGP$Coefficient_Matrices))]

SGPstateData][['GA']][['Baseline_splineMatrix']] <- NULL
 
### GRADE_9_LIT

my.baseline.config <- list(
	list(  # 7,584 students #1
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(8,8, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 3)),
	list(  # 4,399 students #2
		sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(7,7, 8,8, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 0, 3)),

	list(  # 4,882 students #7
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(7,7, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1)),
	list(  # 3,813 students #8
		sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(6,6, 7,7, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 0, 1))) # Continuous NO 8th grade ELA/Reading

GA_GRADE_9_LIT_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=4,  ## NOTE Change here
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=20)))

for (i in 1:length(GA_GRADE_9_LIT_Baseline_Matrices[[1]])) {
	print(paste(GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Version$Matrix_Information$N,
	GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Version$Date_Prepared,
	GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Grade_Progression,
	GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Content_Areas,
	GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Time_Lags[[1]], "\n", sep=", "))
}


### AMERICAN_LIT 

my.baseline.config <- list(
	list(  # 19,722 students #11
		sgp.baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=3), # skip 2 years

	list(  # 11,293 students #12
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(8,8, 'EOCT', 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 3))) # skip 2 years
				
				
GA_AMERICAN_LIT_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=3,  ## NOTE Change here
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=20)))

for (i in 1:length(GA_AMERICAN_LIT_Baseline_Matrices[[1]])) {
	print(paste(GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Version$Matrix_Information$N,
	GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Version$Date_Prepared,
	GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Grade_Progression,
	GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Content_Areas,
	GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Time_Lags[[1]], "\n", sep=", "))
}


###  US History

my.baseline.config <- list(
	list(  # 11,507 students #62
		sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('8', 'EOCT'),
		sgp.baseline.grade.sequences.lags=4,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	###  Only have 7th grade as of 2010, so could do 1 year skip with 1 cohort (2 if add in 2014 data)
	# list(  #  students #64
		# sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES', 'US_HISTORY'),
		# sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c('7', '8', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1,3),
		# sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
	# list(  #  students #66
		# sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES', 'US_HISTORY'),
		# sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c('7', '8', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1,2),
		# sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	list(  # 15,155 students #67
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
	# list(  # 924 students #68
		# sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS', 'US_HISTORY'),
		# sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c('8', 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1,1),
		# sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
	list(  # 5,938 students #69
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
	# list(  # 3,483 students #70 - REMOVE this is the only US Hist progression that works with TWO priors
		# sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS', 'US_HISTORY'),
		# sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c('8', 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1,2),
		# sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	list(  # 12,060 students #73
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=0,
		sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))
		# sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'))) # 10932

GA_USHIST_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=1,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=20)))


for (i in 1:length(GA_USHIST_Baseline_Matrices[[1]])) {
	print(paste(GA_USHIST_Baseline_Matrices[[1]][[i]]@Version$Matrix_Information$N,
	GA_USHIST_Baseline_Matrices[[1]][[i]]@Version$Date_Prepared,
	GA_USHIST_Baseline_Matrices[[1]][[i]]@Grade_Progression,
	GA_USHIST_Baseline_Matrices[[1]][[i]]@Content_Areas,
	GA_USHIST_Baseline_Matrices[[1]][[i]]@Time_Lags[[1]], "\n", sep=", "))
}


Georgia_Baseline_Matrices[["AMERICAN_LIT.BASELINE"]] <- c(Georgia_Baseline_Matrices[["AMERICAN_LIT.BASELINE"]], GA_AMERICAN_LIT_Baseline_Matrices[["AMERICAN_LIT.BASELINE"]])
Georgia_Baseline_Matrices[["GRADE_9_LIT.BASELINE"]] <- c(Georgia_Baseline_Matrices[["GRADE_9_LIT.BASELINE"]], GA_GRADE_9_LIT_Baseline_Matrices[["GRADE_9_LIT.BASELINE"]])
Georgia_Baseline_Matrices[["US_HISTORY.BASELINE"]] <- c(Georgia_Baseline_Matrices[["US_HISTORY.BASELINE"]], GA_USHIST_Baseline_Matrices[["US_HISTORY.BASELINE"]])

save(Georgia_Baseline_Matrices, file="Georgia_Baseline_Matrices.Rdata")


###################################################################################################
###
###   Georgia Baseline SIMEX matrix calculation
###
###################################################################################################

SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- 
  SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]][-grep("BASELINE.SIMEX", names(SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]]))]

### GRADE_9_LIT

my.baseline.config <- list(
	list(  # 7,584 students #1
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(8,8, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 3)),
	list(  # 4,399 students #2
		sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(7,7, 8,8, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 0, 3)),

	list(  # 4,882 students #7
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(7,7, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1)),
	list(  # 3,813 students #8
		sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(6,6, 7,7, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 0, 1))) # Continuous NO 8th grade ELA/Reading


	GA_GRADE_9_LIT_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=4,  ## NOTE Change here
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=25)))
	

### AMERICAN_LIT 

my.baseline.config <- list(
	list(  # 19,722 students #11
		sgp.baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=3), # skip 2 years

	list(  # 11,293 students #12
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(8,8, 'EOCT', 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 3))) # skip 2 years
						
	GA_AMERICAN_LIT_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=3,  ## NOTE Change here
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=25))) #16


###  US History

my.baseline.config <- list(
	list(  # 11,507 students #62
		sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('8', 'EOCT'),
		sgp.baseline.grade.sequences.lags=4,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	list(  # 15,155 students #67
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
	list(  # 5,938 students #69
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	list(  # 12,060 students #73
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=0,
		sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))

	GA_USHIST_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=1,
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=25)))


source('Github_Repos/Packages/SGP/R/mergeSGP.R')
source('Github_Repos/Packages/SGP/R/unique.splineMatrix.R')


Georgia_SIMEX_Baseline_Matrices <- Georgia_Baseline_Matrices[grep("BASELINE.SIMEX", names(Georgia_Baseline_Matrices))]
Georgia_Baseline_Matrices <- Georgia_Baseline_Matrices[-grep("BASELINE.SIMEX", names(Georgia_Baseline_Matrices))]

Tmp_SIMEX_Baseline_Matrices <- c(GA_GRADE_9_LIT_SIMEX_Baseline_Matrices, GA_AMERICAN_LIT_SIMEX_Baseline_Matrices, GA_USHIST_SIMEX_Baseline_Matrices)
SIMEX_Baseline_Matrices <- mergeSGP(list(Coefficient_Matrices= Georgia_SIMEX_Baseline_Matrices), list(Coefficient_Matrices= Tmp_SIMEX_Baseline_Matrices))

SIMEX_Baseline_Matrices$Coefficient_Matrices$GRADE_9_LIT.BASELINE.SIMEX[[2]][[1]][[101]]@Version

Georgia_Baseline_Matrices <- c(Georgia_Baseline_Matrices, SIMEX_Baseline_Matrices$Coefficient_Matrices)

save(Georgia_Baseline_Matrices, file="Georgia_Baseline_Matrices.Rdata")
