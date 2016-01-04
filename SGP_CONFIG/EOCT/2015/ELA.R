################################################################################
###
### Scripts associated with 2015 EOGT & EOCT ELA (GRADE_9_LIT & AMERICAN_LIT)
###
################################################################################

###  GRADE-LEVEL ELA - No READING in new Milestones Assessments
###  Use CRCT ELA and Reading as priors for Milestones

ELA_2015.config <- list(
	ELA.2015 = list(
		sgp.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'ELA'),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 4), 'FIRST_OBSERVATION'),
		sgp.panel.years=c('2013', '2013', '2014', '2014', '2015'),
		sgp.grade.sequences=list(c('3', '3', '4'), c('3', '3', '4', '4', '5'), c('4', '4', '5', '5', '6'), c('5', '5', '6', '6', '7'), c('6', '6', '7', '7', '8')),
		sgp.projection.grade.sequences=list("NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS")))


### GRADE_9_LIT

GRADE_9_LIT_2015.config <- list(
	GRADE_9_LIT.2015 = list( # 1
		sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.panel.years=c('2013', '2013', '2015'),
		sgp.grade.sequences=list(c(8, 8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('ELA', 'READING', 'GRADE_9_LIT'), 
			YEAR=c('2014', '2014', '2014'), GRADE=c(8, 8, 'EOCT')), # Add 8th Grade Science Filter
		sgp.norm.group.preference=6),
	GRADE_9_LIT.2015 = list( # 2
		sgp.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.panel.years=c('2012', '2012', '2013', '2013', '2015'),
		sgp.grade.sequences=list(c(7, 7, 8, 8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('ELA', 'READING', 'GRADE_9_LIT'), 
			YEAR=c('2014', '2014', '2014'), GRADE=c(8, 8, 'EOCT')), # Add 8th Grade Science Filter
		sgp.norm.group.preference=5),

	GRADE_9_LIT.2015 = list( # 3
		sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.panel.years=c('2014', '2014', '2015'),
		sgp.grade.sequences=list(c(8, 8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=4),
	GRADE_9_LIT.2015 = list( # 4
		sgp.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.panel.years=c('2013', '2013', '2014', '2014', '2015'),
		sgp.grade.sequences=list(c(7, 7, 8, 8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=3),

	GRADE_9_LIT.2015 = list( # 5
		sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.panel.years=c('2014', '2014', '2015'),
		sgp.grade.sequences=list(c(7, 7, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=2),
	GRADE_9_LIT.2015 = list( # 6
		sgp.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.panel.years=c('2013', '2013', '2014', '2014', '2015'),
		sgp.grade.sequences=list(c(6, 6, 7, 7, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=1),

	GRADE_9_LIT.2015 = list( # 7
		sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
	 	sgp.norm.group.preference=0)#,
	# GRADE_9_LIT.2015 = list( # 8 -- Qi removed from Final Course Sequence list
	# 	sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
	# 	sgp.panel.years=c('2015', '2015'),
	# 	sgp.grade.sequences=list(c('EOCT', 'EOCT')),
	# 	sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
	# 	sgp.exact.grade.progression=TRUE,
	# 	sgp.norm.group.preference=0)
) ### END GRADE_9_LIT_2014.config


### AMERICAN_LIT

AMERICAN_LIT_2015.config <- list(
	AMERICAN_LIT.2015 = list( # 8
		sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2012', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
			YEAR=c('2013', '2013', '2014', '2014'), GRADE=c('EOCT', 'EOCT')),
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=5),
	# AMERICAN_LIT.2015 = list( #  -- Qi removed from Final Course Sequence list
	# 	sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
	# 	sgp.panel.years=c('2011', '2011', '2012', '2015'),
	# 	sgp.grade.sequences=list(c(8, 8, 'EOCT', 'EOCT')),
	# 	sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
	# 	sgp.exact.grade.progression=TRUE,
	# 	sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
	# 		YEAR=c('2013', '2013', '2014', '2014'), GRADE=c('EOCT', 'EOCT')),
	# 	sgp.norm.group.preference=5),

	AMERICAN_LIT.2015 = list( # 9
		sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
			YEAR=c('2014', '2014'), GRADE=c('EOCT', 'EOCT')),
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=4),
	AMERICAN_LIT.2015 = list( # 10
		sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2012', '2012', '2013', '2015'),
		sgp.grade.sequences=list(c(8, 8, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
			YEAR=c('2014', '2014'), GRADE=c('EOCT', 'EOCT')),
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=3),

	AMERICAN_LIT.2015 = list( # 11
		sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=2),
	AMERICAN_LIT.2015 = list( # 12
		sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2013', '2013', '2014', '2015'),
		sgp.grade.sequences=list(c(8, 8, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=1),
	AMERICAN_LIT.2015 = list( # 13
		sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=0)
) ### END AMERICAN_LIT.2015.config
