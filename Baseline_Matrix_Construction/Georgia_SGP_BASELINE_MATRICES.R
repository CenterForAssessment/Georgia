###################################################################################################
###
###   Georgia Baseline SGP matrix calculation  --  Second version, now without grade levels in HS
###
###################################################################################################

### Load SGP Package

require(SGP)

### NULL out the existing baseline coefficient matrices for Georgia
#  Need the new EOCT knots and boundaries available in SGP version 0.9-9.9

SGPstateData$GA$Baseline_splineMatrix <- NULL

### Load Long Data

setwd("/media/Data/SGP/Georgia")
load("Data/Georgia_Data_LONG-2012_FINAL.Rdata")

#  Reduce data to only what we'll be using
summary(as.factor(Georgia_Data_LONG$SUBJECT_CODE[Georgia_Data_LONG$SCALE_SCORE < 199]))
Georgia_Data_LONG$VALID_CASE[Georgia_Data_LONG$SCALE_SCORE == 0] <- "INVALID_CASE"

Georgia_Data_LONG <- Georgia_Data_LONG[!Georgia_Data_LONG$SUBJECT_CODE %in% c("MATHEMATICS", "ALGEBRA", "GEOMETRY", "SOCIAL_STUDIES") &
	Georgia_Data_LONG$GRADE %in% 6:12 & Georgia_Data_LONG$VALID_CASE == 'VALID_CASE',]

Georgia_Data_LONG$GRADE[!Georgia_Data_LONG$SUBJECT_CODE %in% c("ELA", "READING", "SCIENCE")] <- 'EOCT'

### prepareSGP

Georgia_SGP <- prepareSGP(Georgia_Data_LONG, create.additional.variables=FALSE)

###
###
###

my.baseline.config <- list(

	##  Science Priors
			list(
				baseline.content.areas=c('SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
				baseline.grade.sequences=c(8, 'EOCT'),
				baseline.grade.sequences.lags=1), # 8:9
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'), # can go back to 2007 with 7th grade GPS
				baseline.grade.sequences=c(7, 8, 'EOCT'),
				baseline.grade.sequences.lags=c(1, 1)), # 7:9

			list(
				baseline.content.areas=c('SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8, 'EOCT'),
				baseline.grade.sequences.lags=2), # 8, 10
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(7, 8, 'EOCT'),
				baseline.grade.sequences.lags=c(1, 2)), # 7, 8, 10

##  Phys Sci Priors
			list(
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
				baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
				baseline.grade.sequences.lags=c(1, 1)), # 8:10				
			list(
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
				baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
				baseline.grade.sequences.lags=c(1, 2)), # 8:10				

			list(
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # Added 5/22/13
				baseline.grade.sequences=c(7, 'EOCT', 'EOCT'),
				baseline.grade.sequences.lags=c(1, 1)), # 8:10				

			list(
				baseline.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'), # can go back to 2007 with 7th grade GPS
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=1), # continous grade progression - 9:10, 10:11, etc.
			list(
				baseline.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=2), # grade prog with skip year - eg. 9, 11

#  Repeaters
			list(
				baseline.content.areas=c('BIOLOGY', 'BIOLOGY'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=1))


GA_BIOLOGY_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=20)))

save(GA_BIOLOGY_Baseline_Matrices, file="Data/Baseline_Matrices/GA_BIOLOGY_Baseline_Matrices.Rdata")

### PHYSICAL_SCIENCE 

#   RE-RUN THESE TO GET THE Time_Lags FOR 8TH GRADE MATRICES  ( OR PLUG IN MANUALLY )

my.baseline.config <- list(
#  Science Priors
			list( #  Enough kids to do an 8th grade baseline here
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('7', 'EOCT'), # Originally run as 7, 8
				baseline.grade.sequences.lags=1),
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('6', '7', 'EOCT'), # Originally run as 6, 7, 8
				baseline.grade.sequences.lags=c(1, 1)),

			list(
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
				baseline.grade.sequences=c(8, 'EOCT'),
				baseline.grade.sequences.lags=1), # 8:9
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'), # can go back to 2007 with 7th grade GPS
				baseline.grade.sequences=c(7, 8, 'EOCT'),
				baseline.grade.sequences.lags=c(1, 1)), # 7:9

			list(
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8, 'EOCT'),
				baseline.grade.sequences.lags=2), # 8, 10
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(7, 8, 'EOCT'),
				baseline.grade.sequences.lags=c(1, 2)), # 7:8, 10

# BIO Priors 
			list(
				baseline.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
				baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
				baseline.grade.sequences.lags=c(1, 1)),
			list(
				baseline.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
				baseline.grade.sequences=c(8, 'EOCT', 'EOCT'),
				baseline.grade.sequences.lags=c(1, 2)),

			list(
				baseline.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=1), # continuous
			list(
				baseline.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=2), # skip year

#  Repeaters
			list(
				baseline.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=1))


GA_PHYSICAL_SCIENCE_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=2,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=20)))

save(GA_PHYSICAL_SCIENCE_Baseline_Matrices, file="Data/Baseline_Matrices/GA_PHYSICAL_SCIENCE_Baseline_Matrices.Rdata")


### GRADE_9_LIT 

my.baseline.config <- list(
			list(
				baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8,8, 'EOCT'),
				baseline.grade.sequences.lags=c(0, 1)),
			list(
				baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(7,7, 8,8, 'EOCT'),
				baseline.grade.sequences.lags=c(0, 1, 0, 1)), # Dual/Continuous

			list(
				baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8,8, 'EOCT'),
				baseline.grade.sequences.lags=c(0, 2)),
			list(
				baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(7,7, 8,8, 'EOCT'),
				baseline.grade.sequences.lags=c(0, 1, 0, 2)), # Dual/SKIP

	 # Repeaters
			list(
				baseline.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=1))

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

save(GA_GRADE_9_LIT_Baseline_Matrices, file="Data/Baseline_Matrices/GA_GRADE_9_LIT_Baseline_Matrices.Rdata")


### AMERICAN_LIT 

my.baseline.config <- list(
	#  Have 8th grade priors available:
			list(
				baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8,8, 'EOCT', 'EOCT'),
				baseline.grade.sequences.lags=c(0, 1, 1)), # 8,8,9:10
			list(
				baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8,8, 'EOCT', 'EOCT'),
				baseline.grade.sequences.lags=c(0, 1, 2)), #c(8,8,9,11)
	#  EOCT prior only
			list(
				baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=1), # continuous
			list(
				baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=2), # skip year

	#  Repeaters
			list(
				baseline.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=1))
				
				
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

save(GA_AMERICAN_LIT_Baseline_Matrices, file="Data/Baseline_Matrices/GA_AMERICAN_LIT_Baseline_Matrices.Rdata")


### Economics 

my.baseline.config <- list(
			list(
				baseline.content.areas=c('US_HISTORY', 'ECONOMICS'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=1),
			list(
				baseline.content.areas=c('US_HISTORY', 'ECONOMICS'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=2),

#  ECON repeaters - run "Thu Feb 21 12:50:30 2013"
			list(
				baseline.content.areas=c('ECONOMICS', 'ECONOMICS'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT'),
				baseline.grade.sequences.lags=1))


GA_ECON_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=1,  ## NOTE Change here
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=20)))

save(GA_ECON_Baseline_Matrices, file="Data/Baseline_Matrices/GA_ECON_Baseline_Matrices.Rdata")


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

save(GA_USHIST_Baseline_Matrices, file="Data/Baseline_Matrices/GA_USHIST_Baseline_Matrices.Rdata")


### SOCIAL STUDIES

#  The LAST / FIRST observations for Soc St are causing problems. 
#  Temporarily set YEAR_WITHIN to NULL (DON'T SAVE object!)  

Georgia_SGP@Data[, YEAR_WITHIN := NULL]

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

GA_SOCIAL_STUDIES_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(BACKEND="PARALLEL", WORKERS=list(TAUS=24)))

save(GA_SOCIAL_STUDIES_Baseline_Matrices, file="Data/Baseline_Matrices/GA_SOCIAL_STUDIES_Baseline_Matrices.Rdata")

###
###		Repeaters (different year).
### 

# my.baseline.config <- list(
			# list(
				# baseline.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_I'),
				# baseline.panel.years=c('2010', '2011', '2012'),
				# baseline.grade.sequences=c('EOCT', 'EOCT'),
				# baseline.grade.sequences.lags=1))

# GA_MATHEMATICS_I_Baseline_Matrices <- baselineSGP(
	# Georgia_SGP,
	# sgp.baseline.config=my.baseline.config,
	# sgp.percentiles.baseline.max.order=1,
	# return.matrices.only=TRUE,
	# calculate.baseline.sgps=FALSE,
	# goodness.of.fit.print=FALSE)

# save(GA_MATHEMATICS_I_Baseline_Matrices, file="Data/Baseline_Matrices/GA_MATHEMATICS_I_Baseline_Matrices.Rdata")


# my.baseline.config <- list(
			# list(
				# baseline.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
				# baseline.panel.years=c('2010', '2011', '2012'),
				# baseline.grade.sequences=c('EOCT', 'EOCT'),
				# baseline.grade.sequences.lags=1))

# GA_MATHEMATICS_II_Baseline_Matrices <- baselineSGP(
	# Georgia_SGP,
	# sgp.baseline.config=my.baseline.config,
	# sgp.percentiles.baseline.max.order=1,
	# return.matrices.only=TRUE,
	# calculate.baseline.sgps=FALSE,
	# goodness.of.fit.print=FALSE)

# save(GA_MATHEMATICS_II_Baseline_Matrices, file="Data/Baseline_Matrices/GA_MATHEMATICS_II_Baseline_Matrices.Rdata")


###
###		Replace Baseline Matrices in SGPstateData
###

load('GA_Baseline_Matrices.Rdata')
GA_Baseline_Matrices <- GA_Baseline_Matrices[1:4]
GA_Baseline_Matrices[['AMERICAN_LIT.BASELINE']] <- GA_AMERICAN_LIT_Baseline_Matrices$AMERICAN_LIT.BASELINE
GA_Baseline_Matrices[['BIOLOGY.BASELINE']] <- c(GA_Baseline_Matrices[['BIOLOGY.BASELINE']], GA_BIOLOGY_Baseline_Matrices$BIOLOGY.BASELINE) # Add in 5/22/13
GA_Baseline_Matrices[['ECONOMICS.BASELINE']] <- GA_ECON_Baseline_Matrices$ECONOMICS.BASELINE
GA_Baseline_Matrices[['GRADE_9_LIT.BASELINE']] <- GA_GRADE_9_LIT_Baseline_Matrices$GRADE_9_LIT.BASELINE
# GA_Baseline_Matrices[['MATHEMATICS_I.BASELINE']] <- GA_MATHEMATICS_I_Baseline_Matrices$MATHEMATICS_I.BASELINE
# GA_Baseline_Matrices[['MATHEMATICS_II.BASELINE']] <- GA_MATHEMATICS_II_Baseline_Matrices$MATHEMATICS_II.BASELINE
GA_Baseline_Matrices[['PHYSICAL_SCIENCE.BASELINE']] <- GA_PHYSICAL_SCIENCE_Baseline_Matrices$PHYSICAL_SCIENCE.BASELINE
GA_Baseline_Matrices[['US_HISTORY.BASELINE']] <- GA_USHIST_Baseline_Matrices$US_HISTORY.BASELINE
GA_Baseline_Matrices[['SOCIAL_STUDIES.BASELINE']] <- GA_SOCIAL_STUDIES_Baseline_Matrices$SOCIAL_STUDIES

save(GA_Baseline_Matrices, file='/media/Data/Dropbox/Github_Repos/Packages/SGPstateData/Baseline_Coefficient_Matrices/GA_Baseline_Matrices.Rdata', compress='bzip2')
