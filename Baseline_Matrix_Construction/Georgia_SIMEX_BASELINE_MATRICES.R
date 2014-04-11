###################################################################################################
###
###   Georgia Baseline SIMEX matrix calculation
###
###################################################################################################

### Load SGP Package

require(SGP)

### Load Long Data exported from 2013 SGP analyses to create a smaller object
load('/home/avi/SGP_Projects/Georgia/Data/Georgia_SGP_LONG_Data.Rdata')

###  Reduce data to only what we'll be using
Georgia_SGP_LONG_Data <- Georgia_SGP_LONG_Data[, c(1:4, 11, 18:21, 36, 47:48), with=FALSE]

### prepareSGP

Georgia_SGP <- prepareSGP(Georgia_SGP_LONG_Data, create.additional.variables=FALSE)

###  Save SGP object with data only.
save(Georgia_SGP, file='Georgia_SGP_SIMEX_BASELINE.Rdata')

###  Add in existing BASELINE splineMatrices for the Naive estimates
Georgia_SGP@SGP <- SGPstateData$GA$Baseline_splineMatrix


###
###		SIMEX Baseline Matrix Construction
###

###		CRCT Content Areas (except SOCIAL_STUDIES - produced in 2013)

	Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		years='2013',
		content_areas=c("ELA", "READING", "MATHEMATICS", "SCIENCE"), 
		sgp.percentiles=FALSE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011'), # should have been the default (4 panel years) when run in fall 2012 with 2008-2011 data
		simulate.sgps = FALSE,
		calculate.simex.baseline=TRUE,
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(SIMEX=25)))

###		EOCT Content Areas

###		BIOLOGY

	my.baseline.config <- list(

	##  Science Priors
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
			sgp.baseline.grade.sequences=c(8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'), # can go back to 2007 with 7th grade GPS
			sgp.baseline.grade.sequences=c(7, 8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(1, 1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),

		list(
			sgp.baseline.content.areas=c('SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=2,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(7, 8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(1, 2),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	##  Phys Sci Priors
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
			sgp.baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(1, 1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
			sgp.baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(1, 2),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(1, 1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'), # can go back to 2007 with 7th grade GPS
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=2,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	#  Repeaters
		list(
			sgp.baseline.content.areas=c('BIOLOGY', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))


	GA_BIOLOGY_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=2,
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=16)))
	
	save(GA_BIOLOGY_SIMEX_Baseline_Matrices, file="Data/Baseline_Matrices/GA_BIOLOGY_SIMEX_Baseline_Matrices.Rdata")


### PHYSICAL_SCIENCE 

#   RE-RUN THESE TO GET THE Time_Lags FOR 8TH GRADE MATRICES  ( OR PLUG IN MANUALLY )

	my.baseline.config <- list(
	#  Science Priors
		list( #  Enough kids to do an 8th grade baseline here
			sgp.baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('7', 'EOCT'), # Originally run as 7, 8
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('6', '7', 'EOCT'), # Originally run as 6, 7, 8
			sgp.baseline.grade.sequences.lags=c(1, 1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),

		list(
			sgp.baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
			sgp.baseline.grade.sequences=c(8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')), # 8:9
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'), # can go back to 2007 with 7th grade GPS
			sgp.baseline.grade.sequences=c(7, 8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(1, 1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')), # 7:9

		list(
			sgp.baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=2,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')), # 8, 10
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(7, 8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(1, 2),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')), # 7:8, 10

	# BIO Priors 
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
			sgp.baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(1, 1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
			sgp.baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(1, 2),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),

		list(
			sgp.baseline.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')), # continuous
		list(
			sgp.baseline.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=2,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')), # skip year

	#  Repeaters
		list(
			sgp.baseline.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))


	GA_PHYSICAL_SCIENCE_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=2,
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=16)))
	
	save(GA_PHYSICAL_SCIENCE_SIMEX_Baseline_Matrices, file="Data/Baseline_Matrices/GA_PHYSICAL_SCIENCE_SIMEX_Baseline_Matrices.Rdata")


### GRADE_9_LIT 

	my.baseline.config <- list(
		list(
			sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(8,8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(0, 1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(7,7, 8,8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(0, 1, 0, 1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')), # Dual/Continuous

		list(
			sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(8,8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(0, 2),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(7,7, 8,8, 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(0, 1, 0, 2),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')), # Dual/SKIP

	 # Repeaters
		list(
			sgp.baseline.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))

	GA_GRADE_9_LIT_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=4,  ## NOTE Change here
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=16)))
	
	save(GA_GRADE_9_LIT_SIMEX_Baseline_Matrices, file="Data/Baseline_Matrices/GA_GRADE_9_LIT_SIMEX_Baseline_Matrices.Rdata")


### AMERICAN_LIT 

	my.baseline.config <- list(
	#  Have 8th grade priors available:
		list(
			sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(8,8, 'EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(0, 1, 1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c(8,8, 'EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=c(0, 1, 2),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
	#  EOCT prior only
		list(
			sgp.baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')), # continuous
		list(
			sgp.baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=2,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')), # skip year

	#  Repeaters
		list(
			sgp.baseline.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))
						
	GA_AMERICAN_LIT_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=3,  ## NOTE Change here
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=16)))
	
	save(GA_AMERICAN_LIT_SIMEX_Baseline_Matrices, file="Data/Baseline_Matrices/GA_AMERICAN_LIT_SIMEX_Baseline_Matrices.Rdata")


### Economics 

	my.baseline.config <- list(
		list(
			sgp.baseline.content.areas=c('US_HISTORY', 'ECONOMICS'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('US_HISTORY', 'ECONOMICS'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=2,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	#  ECON repeaters - run "Thu Feb 21 12:50:30 2013"
		list(
			sgp.baseline.content.areas=c('ECONOMICS', 'ECONOMICS'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))

	GA_ECON_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=1,  ## NOTE Change here
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=16)))
	
	save(GA_ECON_SIMEX_Baseline_Matrices, file="Data/Baseline_Matrices/GA_ECON_SIMEX_Baseline_Matrices.Rdata")


###  US History

	my.baseline.config <- list(
		# list( #  Not run.  Too few students (1,341 in "supercohort") and removed by Qi from 2013 EOCT Course Sequence list
			# sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
			# sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
			# sgp.baseline.grade.sequences=c('8', 'EOCT'),
			# sgp.baseline.grade.sequences.lags=1,
			# sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(  #  67,610 students
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('8', 'EOCT'),
			sgp.baseline.grade.sequences.lags=2,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(  # 225,409 students
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('8', 'EOCT'),
			sgp.baseline.grade.sequences.lags=3,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(  # 21,504 students
			sgp.baseline.content.areas=c('US_HISTORY', 'US_HISTORY'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list(  # 6,104 students
			sgp.baseline.content.areas=c('US_HISTORY', 'US_HISTORY'),
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
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=16)))
	
	save(GA_USHIST_SIMEX_Baseline_Matrices, file="Data/Baseline_Matrices/GA_USHIST_SIMEX_Baseline_Matrices.Rdata")


### SOCIAL STUDIES

	my.baseline.config <- list(
		list( 
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
			sgp.baseline.panel.years=c('2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('3', '4'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
		list( 
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
			sgp.baseline.panel.years=c('2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('4', '5'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION')),
		list( 
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
			sgp.baseline.panel.years=c('2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('3', '4', '5'),
			sgp.baseline.grade.sequences.lags=c(1,1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION')),
		list( 
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
			sgp.baseline.panel.years=c('2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('5', '6'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION')),
		list( 
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
			sgp.baseline.panel.years=c('2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('4', '5', '6'),
			sgp.baseline.grade.sequences.lags=c(1,1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION')),
		list( 
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
			sgp.baseline.panel.years=c('2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('6', '7'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION')),
		list( 
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
			sgp.baseline.panel.years=c('2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('5', '6', '7'),
			sgp.baseline.grade.sequences.lags=c(1,1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION')),
		list( 
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
			sgp.baseline.panel.years=c('2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('7', '8'),
			sgp.baseline.grade.sequences.lags=1,
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION')),
		list( 
			sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES', 'SOCIAL_STUDIES'),
			sgp.baseline.panel.years=c('2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('6', '7', '8'),
			sgp.baseline.grade.sequences.lags=c(1,1),
			sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION')))

	GA_SOCIAL_STUDIES_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP, state="GA",
		sgp.baseline.config=my.baseline.config,
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		# calculate.baseline.simex now set to default:
		# calculate.baseline.simex=list(state="GA", lambda=seq(0,2,0.5), simulation.iterations=50, simex.sample.size=25000, extrapolation="linear", save.matrices=TRUE),
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=16)))
	
	save(GA_SOCIAL_STUDIES_SIMEX_Baseline_Matrices, file="Data/Baseline_Matrices/GA_SOCIAL_STUDIES_SIMEX_Baseline_Matrices.Rdata")


###  Same year (Block Schedule and Repeaters)



	my.baseline.config <- list(
		list(
			sgp.baseline.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')),

		list(
			sgp.baseline.content.areas=c('BIOLOGY', 'BIOLOGY'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')),
			
		list(
			sgp.baseline.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')),

		list(
			sgp.baseline.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')),
			
		list(
			sgp.baseline.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')),
			
		list(
			sgp.baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
			sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')),

		list(
			sgp.baseline.content.areas=c('US_HISTORY', 'US_HISTORY'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')),

		list(
			sgp.baseline.content.areas=c('US_HISTORY', 'ECONOMICS'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')),
		list(
			sgp.baseline.content.areas=c('ECONOMICS', 'ECONOMICS'),
			sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
			sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
			sgp.baseline.grade.sequences.lags=0,
			sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))
			
	GA_BLOCK_SCHED_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=1,  ## NOTE Change here
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=25)))
	
	save(GA_BLOCK_SCHED_SIMEX_Baseline_Matrices, file="GA_BLOCK_SCHED_SIMEX_Baseline_Matrices.Rdata")

###
###		Combine matrices
###

source('~/Dropbox/Github_Repos/Packages/SGP/R/mergeSGP.R')
source('~/Dropbox/Github_Repos/Packages/SGP/R/unique.splineMatrix.R')

GA_SIMEX_Baseline_Matrices <- c(GA_SIMEX_Baseline_Matrices, GA_SOCIAL_STUDIES_SIMEX_Baseline_Matrices, GA_BIOLOGY_SIMEX_Baseline_Matrices, GA_PHYSICAL_SCIENCE_SIMEX_Baseline_Matrices, GA_GRADE_9_LIT_SIMEX_Baseline_Matrices, GA_AMERICAN_LIT_SIMEX_Baseline_Matrices, GA_USHIST_SIMEX_Baseline_Matrices, GA_ECON_SIMEX_Baseline_Matrices)

GA_SIMEX_Baseline_Matrices <- mergeSGP(list(Coefficient_Matrices= GA_SIMEX_Baseline_Matrices), list(Coefficient_Matrices= GA_BLOCK_SCHED_SIMEX_Baseline_Matrices))$Coefficient_Matrices

save(GA_SIMEX_Baseline_Matrices, file = 'GA_SIMEX_Baseline_Matrices.Rdata')
