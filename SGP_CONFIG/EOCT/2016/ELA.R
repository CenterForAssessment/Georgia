################################################################################
###
### Scripts associated with 2016 EOG & EOC ELA (GRADE_9_LIT & AMERICAN_LIT)
###
################################################################################

ELA_2016.config <- list(
	ELA.2016 = list(
		sgp.content.areas=c('ELA', 'ELA'),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.panel.years=c( '2015', '2016'),
		sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8')),
		sgp.exact.grade.progression=list(TRUE, TRUE, TRUE, TRUE, TRUE),
		# sgp.projection.grade.sequences=list("NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS"),
		sgp.norm.group.preference=2),
	ELA.2016 = list(
		sgp.content.areas=c('READING','ELA', 'ELA', 'ELA'),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 3), 'FIRST_OBSERVATION'),
		sgp.panel.years=c('2014','2014', '2015', '2016'),
		sgp.grade.sequences=list(c('3','3', '4', '5'), c( '4','4', '5', '6'), c('5','5', '6', '7'), c('6','6', '7', '8')),
		sgp.exact.grade.progression=list(TRUE, TRUE, TRUE, TRUE),
		sgp.projection.grade.sequences=list("NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS","NO_PROJECTIONS"), # ELA/Lit Projections with Milestones data only!
		sgp.norm.group.preference=1))




### GRADE_9_LIT

GRADE_9_LIT_2016.config <- list(
	#GRADE_9_LIT.2016 = list( # 1
	#	sgp.content.areas=c('READING', 'ELA', 'GRADE_9_LIT'),
	#	sgp.panel.years=c('2014', '2014', '2016'),
	#	sgp.grade.sequences=list(c(8, 8, 'EOCT')),
	#	sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
	#	sgp.exact.grade.progression=TRUE,
	#	sgp.projection.grade.sequences="NO_PROJECTIONS",
	#	sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('READING', 'ELA', 'GRADE_9_LIT'), 
	#		YEAR=c('2015', '2015', '2015'), GRADE=c(8, 8, 'EOCT')), # Add 8th Grade Filter
	#	sgp.norm.group.preference=6),
	#GRADE_9_LIT.2016 = list( # 2
	#	sgp.content.areas=c('READING', 'ELA', 'READING', 'ELA', 'GRADE_9_LIT'),
	#	sgp.panel.years=c('2013', '2013', '2014', '2014', '2016'),
	#	sgp.grade.sequences=list(c(7, 7, 8, 8, 'EOCT')),
	#	sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
	#	sgp.exact.grade.progression=TRUE,
	#	sgp.projection.grade.sequences="NO_PROJECTIONS",
	#	sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('READING', 'ELA', 'GRADE_9_LIT'), 
	#		YEAR=c('2015', '2015', '2015'), GRADE=c(8, 8, 'EOCT')), # Add 8th Grade Filter
	#	sgp.norm.group.preference=5),
	GRADE_9_LIT.2016 = list( # 3
		sgp.content.areas=c('ELA', 'GRADE_9_LIT'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		# sgp.projection.grade.sequences="NO_PROJECTIONS", # ELA/Lit Projections with Milestones data only!
		sgp.norm.group.preference=4),
	GRADE_9_LIT.2016 = list( # 4
		sgp.content.areas=c('READING', 'ELA', 'ELA', 'GRADE_9_LIT'),
		sgp.panel.years=c('2014', '2014', '2015', '2016'),
		sgp.grade.sequences=list(c(7, 7, 8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=3),

	GRADE_9_LIT.2016 = list( # 5
		sgp.content.areas=c('ELA', 'GRADE_9_LIT'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c( 7, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=2),
	GRADE_9_LIT.2016 = list( # 6
		sgp.content.areas=c('READING', 'ELA', 'ELA', 'GRADE_9_LIT'),
		sgp.panel.years=c('2014', '2014', '2015', '2016'),
		sgp.grade.sequences=list(c(6, 6, 7, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=1),

	GRADE_9_LIT.2016 = list( # 7
		sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
	 	sgp.norm.group.preference=0)
	 	
) ### END GRADE_9_LIT_2015.config


### AMERICAN_LIT

AMERICAN_LIT_2016.config <- list(
	AMERICAN_LIT.2016 = list( # 8
		sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2013', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
			YEAR=c('2014', '2014', '2015', '2015'), GRADE=c('EOCT', 'EOCT')),
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=6),

	AMERICAN_LIT.2016 = list( # 9
		sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2014', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
			YEAR=c('2015', '2015'), GRADE=c('EOCT', 'EOCT')),
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=5),

	AMERICAN_LIT.2016 = list( # 10
		sgp.content.areas=c('READING', 'ELA', 'GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2013', '2013', '2014', '2016'),
		sgp.grade.sequences=list(c(8, 8, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
			YEAR=c('2015', '2015'), GRADE=c('EOCT', 'EOCT')),
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=4),

	AMERICAN_LIT.2016 = list( # 11
		sgp.content.areas=c('READING', 'ELA', 'GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2013', '2013', '2014', '2016'),
		sgp.grade.sequences=list(c(7, 7, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
			YEAR=c('2015', '2015'), GRADE=c('EOCT', 'EOCT')),
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=3),

	AMERICAN_LIT.2016 = list( # 12
		sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=2),
		
	AMERICAN_LIT.2016 = list( # 13
		sgp.content.areas=c('READING', 'ELA', 'GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2014', '2014', '2015', '2016'),
		sgp.grade.sequences=list(c(8, 8, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=1),
		
	AMERICAN_LIT.2016 = list( # 14
		sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS",
		sgp.norm.group.preference=0)
) ### END AMERICAN_LIT.2016.config
