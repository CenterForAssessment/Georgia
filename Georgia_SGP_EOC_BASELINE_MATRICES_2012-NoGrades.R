###################################################################################################
###
###   Georgia Baseline SGP matrix calculation  --  Second version, now without grade levels in HS
###
###################################################################################################

### Load SGP Package

require(SGP)

### NULL out baseline coefficient matrices for Georgia
#  Need the new EOCT knots and boundaries.  Update from Github eventually - still waiting for it to load on 11/23/12
load('/home/avi/Dropbox/GitHub_Repos/SGPstateData/SGPstateData.rda')

SGPstateData$GA$Baseline_splineMatrix <- NULL


### Load Long Data

setwd("/media/Data/SGP/Georgia")
load("Data/Georgia_Data_LONG-2012_FINAL.Rdata")

#  Reduce data to only what we'll be using
Georgia_Data_LONG <- Georgia_Data_LONG[!Georgia_Data_LONG$SUBJECT_CODE %in% c("MATHEMATICS", "SOCIAL_STUDIES") &
	Georgia_Data_LONG$GRADE %in% 6:12 & Georgia_Data_LONG$VALID_CASE == 'VALID_CASE',]

Georgia_Data_LONG$GRADE[Georgia_Data_LONG$GRADE > 8] <- 'EOCT'


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
				baseline.grade.sequences=c(8, 'EOCT')), # 8:9
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'), # can go back to 2007 with 7th grade GPS
				baseline.grade.sequences=c(7, 8, 'EOCT')), # 7:9

			list(
				baseline.content.areas=c('SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8, NA, 'EOCT')), # 8, 10
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(7, 8, NA, 'EOCT')), # 7, 8, 10

##  Phys Sci Priors
			list(
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
				baseline.grade.sequences=c(8, 'EOCT', 'EOCT')), # 8:10				
			list(
				baseline.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'), # can go back to 2007 with 7th grade GPS
				baseline.grade.sequences=c('EOCT', 'EOCT')), # continous grade progression - 9:10, 10:11, etc.
			list(
				baseline.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', NA, 'EOCT'))) # grade prog with skip year - eg. 9, 11

# #  Repeaters
			# list(
				# baseline.content.areas=c('BIOLOGY', 'BIOLOGY'),
				# baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				# baseline.grade.sequences=c('EOCT', 'EOCT')))


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

my.baseline.config <- list(
#  Science Priors
			list( #  Enough kids to do an 8th grade baseline here
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('7', '8')),
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('6', '7', '8')),

			list(
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
				baseline.grade.sequences=c(8, 'EOCT')), # 8:9
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'), # can go back to 2007 with 7th grade GPS
				baseline.grade.sequences=c(7, 8, 'EOCT')), # 7:9

			list(
				baseline.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8, NA, 'EOCT')), # 8, 10
			list(
				baseline.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(7, 8, NA, 'EOCT')), # 7:8, 10

# BIO Priors 
			list(
				baseline.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'), # can only go back to 2008 with 8th grade GPS
				baseline.grade.sequences=c(8, 'EOCT', 'EOCT')),

			list(
				baseline.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT')), # continuous
			list(
				baseline.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', NA, 'EOCT'))) # skip year

# #  Repeaters
			# list(
				# baseline.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
				# baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				# baseline.grade.sequences=c('EOCT', 'EOCT')))


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
				baseline.grade.sequences=c(8,8, 'EOCT')),
			list(
				baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(7,7, 8,8, 'EOCT')),

			list(
				baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8,8, NA, 'EOCT')),
			list(
				baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(7,7, 8,8, NA, 'EOCT')))

	#  Repeaters
			# list(
				# baseline.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
				# baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				# baseline.grade.sequences=c('EOCT', 'EOCT')))

GA_GRADE_9_LIT_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=4,  ## NOTE Change here
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=10)))

save(GA_GRADE_9_LIT_Baseline_Matrices, file="Data/Baseline_Matrices/GA_GRADE_9_LIT_Baseline_Matrices.Rdata")


### AMERICAN_LIT 

my.baseline.config <- list(
	#  Have 8th grade priors available:
			list(
				baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8,8, 'EOCT', 'EOCT')), # 8,8,9:10
			list(
				baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c(8,8, NA, 'EOCT', 'EOCT')), #c(8,8,10:11)
	#  EOCT prior only
			list(
				baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT')), # continuous
			list(
				baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
				baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', NA, 'EOCT'))) # skip year

	# #  Repeaters
			# list(
				# baseline.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
				# baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				# baseline.grade.sequences=c('EOCT', 'EOCT')))
				
				
GA_AMERICAN_LIT_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=3,  ## NOTE Change here
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=10)))

save(GA_AMERICAN_LIT_Baseline_Matrices, file="Data/Baseline_Matrices/GA_AMERICAN_LIT_Baseline_Matrices.Rdata")



### Economics 

my.baseline.config <- list(
			list(
				baseline.content.areas=c('US_HISTORY', 'ECONOMICS'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', 'EOCT')),
			list(
				baseline.content.areas=c('US_HISTORY', 'ECONOMICS'),
				baseline.panel.years=c('2008', '2009', '2010', '2011', '2012'),
				baseline.grade.sequences=c('EOCT', NA, 'EOCT')))

			# list(
				# baseline.content.areas=c('ECONOMICS', 'ECONOMICS'),
				# baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				# baseline.grade.sequences=c('EOCT', 'EOCT')))  #  ECON may not have enough kids to run...


GA_ECON_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=1,  ## NOTE Change here
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=10)))

save(GA_ECON_Baseline_Matrices, file="Data/Baseline_Matrices/GA_ECON_Baseline_Matrices.Rdata")




###
###		Repeaters (different year).  New to 2012
### 

# my.baseline.config <- list(
			# list(
				# baseline.content.areas=c('US_HISTORY', 'US_HISTORY'),
				# baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
				# baseline.grade.sequences=c('EOCT', 'EOCT')))


# GA_USHIST_Baseline_Matrices <- baselineSGP(
	# Georgia_SGP,
	# sgp.baseline.config=my.baseline.config,
	# sgp.percentiles.baseline.max.order=1,
	# return.matrices.only=TRUE,
	# calculate.baseline.sgps=FALSE,
	# goodness.of.fit.print=FALSE)

# save(GA_USHIST_Baseline_Matrices, file="Data/Baseline_Matrices/GA_USHIST_Baseline_Matrices.Rdata")


###
###		Replace Baseline Matrices in SGPstateData
###

load('/home/avi/Dropbox/stateData/Baseline_Coefficient_Matrices/GA_Baseline_Matrices.Rdata')
GA_Baseline_Matrices[['AMERICAN_LIT.BASELINE']] <- GA_AMERICAN_LIT_Baseline_Matrices$AMERICAN_LIT.BASELINE
GA_Baseline_Matrices[['BIOLOGY.BASELINE']] <- GA_BIOLOGY_PHYS_SCI_Baseline_Matrices$BIOLOGY.BASELINE
GA_Baseline_Matrices[['ECONOMICS.BASELINE']] <- GA_ECON_Baseline_Matrices$ECONOMICS.BASELINE
GA_Baseline_Matrices[['GRADE_9_LIT.BASELINE']] <- GA_GRADE_9_LIT_Baseline_Matrices$GRADE_9_LIT.BASELINE
GA_Baseline_Matrices[['PHYSICAL_SCIENCE.BASELINE']] <- GA_PHYSICAL_SCIENCE_Baseline_Matrices$PHYSICAL_SCIENCE.BASELINE

save(GA_Baseline_Matrices, file='Data/Baseline_Matrices/GA_Baseline_Matrices.Rdata', compress='bzip2')
