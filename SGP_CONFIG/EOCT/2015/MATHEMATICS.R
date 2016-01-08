######################################################################################################
###
### Scripts associated with 2015 EOGT & EOCT MATHEMATICS (Coordinate Algebra and Analytic Geometry)
###
######################################################################################################

### GRADE-LEVEL MATHEMATICS  - Use this code to run with EOCT & get all results at once.

MATHEMATICS_2015.config <- list(
	MATHEMATICS.2015 = list(
		sgp.content.areas=rep('MATHEMATICS', 3),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 2), 'FIRST_OBSERVATION'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8'))))


### Coordinate Algebra

COORDINATE_ALGEBRA_2015.config <- list(
	COORDINATE_ALGEBRA.2015 = list( #14
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA'), 
			YEAR=c('2014', '2014'), GRADE=c(8, 'EOCT')), # Add 8th Grade Math Filter
		sgp.norm.group.preference=7),
	COORDINATE_ALGEBRA.2015 = list( #15
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2012', '2013', '2015'),
		sgp.grade.sequences=list(c(7, 8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA'), 
			YEAR=c('2014', '2014'), GRADE=c(8, 'EOCT')), # Add 8th Grade Math Filter
		sgp.norm.group.preference=6),

	COORDINATE_ALGEBRA.2015 = list( #16
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	COORDINATE_ALGEBRA.2015 = list( #17
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c(7, 8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	COORDINATE_ALGEBRA.2015 = list( #18
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('7', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	COORDINATE_ALGEBRA.2015 = list( #19
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c('6', '7', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	COORDINATE_ALGEBRA.2015 = list( #20 - Repeaters
		sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	COORDINATE_ALGEBRA.2015 = list( #21 - Repeaters (Same Year)
		sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2015', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END COORDINATE_ALGEBRA_2015.config


### Geometry

ANALYTIC_GEOMETRY_2015.config <- list(
	ANALYTIC_GEOMETRY.2015 = list( #22 
		sgp.content.areas=c('COORDINATE_ALGEBRA',  'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
			YEAR=c('2014', '2014'), GRADE=c('EOCT', 'EOCT')),
		sgp.norm.group.preference=7),
	ANALYTIC_GEOMETRY.2015 = list( #23 
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA',  'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2012', '2013', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
			YEAR=c('2014', '2014'), GRADE=c('EOCT', 'EOCT')),
		sgp.norm.group.preference=6),

	ANALYTIC_GEOMETRY.2015 = list( #24 
		sgp.content.areas=c('COORDINATE_ALGEBRA',  'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	ANALYTIC_GEOMETRY.2015 = list( #25 
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA',  'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	ANALYTIC_GEOMETRY.2015 = list( #26 
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA',  'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	ANALYTIC_GEOMETRY.2015 = list( #27 - Repeater
		sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	ANALYTIC_GEOMETRY.2015 = list( #28 - Repeater (Same Year) -- From prelim data "NOTE: Supplied data together with grade progression contains no data ..."
	  #  2nd attemp (with 2014 Long data and new object) had data (3382 cases), but threw "singular design matrix" error...
		sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2015', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	ANALYTIC_GEOMETRY.2015 = list( #29 - Block Schedule -- singular design matrix with prelim data
		sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2015', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END ANALYTIC_GEOMETRY_2015.config
