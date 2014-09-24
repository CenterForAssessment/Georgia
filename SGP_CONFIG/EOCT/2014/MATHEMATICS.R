###########################################################################################################
###
### Scripts associated with 2014 CRCT & EOCT MATHEMATICS
###
###########################################################################################################

### GRADE-LEVEL CRCT MATHEMATICS - run together with EOCT to get all coefficient matrices for projections

MATHEMATICS_2014.config <- list(
	MATHEMATICS.2014 = list(
		sgp.content.areas=rep('MATHEMATICS', 6),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 5), 'FIRST_OBSERVATION'),
		sgp.panel.years=as.character(2009:2014),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8')),
		sgp.calculate.simex.baseline=TRUE))


### Coordinate Algebra

COORDINATE_ALGEBRA_2014.config <- list(
	COORDINATE_ALGEBRA.2014 = list( #20
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=7),
	COORDINATE_ALGEBRA.2014 = list( #21
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2011', '2012', '2014'),
		sgp.grade.sequences=list(c('7', '8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=6),
	COORDINATE_ALGEBRA.2014 = list( #22
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=5),
	COORDINATE_ALGEBRA.2014 = list( #23
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('7', '8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=4),
	COORDINATE_ALGEBRA.2014 = list( #24
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('7', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=3),
	COORDINATE_ALGEBRA.2014 = list( #25
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('6', '7', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=2),
	COORDINATE_ALGEBRA.2014 = list( #26 - New Progression
		sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=1),
	COORDINATE_ALGEBRA.2014 = list( #27
		sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=0)
) ### END COORDINATE_ALGEBRA_2014.config


### Geometry

ANALYTIC_GEOMETRY_2014.config <- list(
	ANALYTIC_GEOMETRY.2014 = list( #28 - New Progression
		sgp.content.areas=c('ALGEBRA', 'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=3),
	ANALYTIC_GEOMETRY.2014 = list( #29 - New Progression
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA', 'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=0),
	ANALYTIC_GEOMETRY.2014 = list( #30 - New Progression
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA', 'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('7', 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=1),
	ANALYTIC_GEOMETRY.2014 = list( #31 - New Progression
		sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=0)
) ### END ANALYTIC_GEOMETRY_2014.config


### Mathematics II

MATHEMATICS_II_2014.config <- list(
	MATHEMATICS_II.2014 = list( #32
		sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=4),
	MATHEMATICS_II.2014 = list( #33
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS_I', 'MATHEMATICS_II'),
		sgp.panel.years=c('2011', '2012', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=3),
	MATHEMATICS_II.2014 = list( #34
		sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=2),
	MATHEMATICS_II.2014 = list( #35
		sgp.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=1)#,
	# MATHEMATICS_II.2014 = list( #36  - Too few kids ( ~ 400 )
		# sgp.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
		# sgp.panel.years=c('2014', '2014'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=0)
) ### END MATHEMATICS_II_2014.config
