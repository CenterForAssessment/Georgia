#########################################################################################################################
###
### Scripts associated with 2016 EOG & EOC MATHEMATICS (Coordinate Algebra, Analytic Geometry, Algebra I, and Geometry)
###
#########################################################################################################################

### GRADE-LEVEL MATHEMATICS  - Use this code to run with EOCT & get all results at once.

MATHEMATICS_2016.config <- list(
	MATHEMATICS.2016 = list(
		sgp.content.areas=rep('MATHEMATICS', 2),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8')),
		sgp.exact.grade.progression=list(TRUE, TRUE, TRUE, TRUE, TRUE),
		sgp.projection.sequence = c("MATH_COORD_ALG", "MATH_ALG_I"),
		sgp.norm.group.preference=2),
	MATHEMATICS.2016 = list(
		sgp.content.areas=rep('MATHEMATICS', 3),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 2), 'FIRST_OBSERVATION'),
		sgp.panel.years=c('2014', '2015', '2016'),
		sgp.grade.sequences=list(c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8')),
		sgp.exact.grade.progression=list(TRUE, TRUE, TRUE, TRUE),
		sgp.projection.grade.sequences=list("NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS"), # Projections with Milestones data only!
		sgp.norm.group.preference=1))


### Coordinate Algebra

COORDINATE_ALGEBRA_2016.config <- list(
	COORDINATE_ALGEBRA.2016 = list( #15
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		# sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections with Milestones data only!
		sgp.norm.group.preference=4),

	COORDINATE_ALGEBRA.2016 = list( #16
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2014', '2015', '2016'),
		sgp.grade.sequences=list(c(7, 8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections with Milestones data only!
		sgp.norm.group.preference=3),

	COORDINATE_ALGEBRA.2016 = list( #17
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c(7, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

	COORDINATE_ALGEBRA.2016 = list( #18
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2014', '2015', '2016'),
		sgp.grade.sequences=list(c(6, 7, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	COORDINATE_ALGEBRA.2016 = list( #19
		sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)

) ### END COORDINATE_ALGEBRA_2016.config


### Analytic Geometry

ANALYTIC_GEOMETRY_2016.config <- list(
	ANALYTIC_GEOMETRY.2016 = list( #20
		sgp.content.areas=c('COORDINATE_ALGEBRA',  'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2014', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
			YEAR=c('2015', '2015'), GRADE=c('EOCT', 'EOCT')),
		sgp.projection.grade.sequences="NO_PROJECTIONS", # Math canonical progressions & Milestones data only
		sgp.norm.group.preference=4),

	ANALYTIC_GEOMETRY.2016 = list( #21
		sgp.content.areas=c('COORDINATE_ALGEBRA',  'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		# sgp.projection.grade.sequences="NO_PROJECTIONS", # Math canonical progression with Milestones data
		sgp.norm.group.preference=3),

	ANALYTIC_GEOMETRY.2016 = list( #22
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA',  'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2014', '2015', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections with Milestones data only!
		sgp.norm.group.preference=2),

	ANALYTIC_GEOMETRY.2016 = list( #23
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA',  'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2014', '2015', '2016'),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
		sgp.norm.group.preference=1),

	ANALYTIC_GEOMETRY.2016 = list( #24 - Repeater
		sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
		sgp.norm.group.preference=0)

) ### END ANALYTIC_GEOMETRY_2016.config


### Algebra I

ALGEBRA_I_2016.config <- list(
	ALGEBRA_I.2016 = list( #25 - Only 1,110 kids -- not analyzed.
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2014', '2016'),
		sgp.grade.sequences=list(c('8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
			YEAR=c('2015', '2015', '2015'), GRADE=c('8', 'EOCT', 'EOCT')),
		sgp.norm.group.preference=4),

  ALGEBRA_I.2016 = list( #26
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),

	ALGEBRA_I.2016 = list( #27
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2014','2015', '2016'),
		sgp.grade.sequences=list(c('7','8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION','LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.projection.grade.sequences="NO_PROJECTIONS",  # Math Projections with Milestones data only!
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

  ALGEBRA_I.2016 = list( #28
		sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('7', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	ALGEBRA_I.2016 = list( #29
		sgp.content.areas=c('MATHEMATICS','MATHEMATICS', 'ALGEBRA_I'),
		sgp.panel.years=c('2014','2015', '2016'),
		sgp.grade.sequences=list(c('6','7', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION','LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)

) ### END ALGEBRA_I_2016.config


### GEOMETRY

GEOMETRY_2016.config <- list(
	GEOMETRY.2016 = list( #30
		sgp.content.areas=c('COORDINATE_ALGEBRA', 'GEOMETRY'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

	GEOMETRY.2016 = list( #31
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'GEOMETRY'),
		sgp.panel.years=c('2014', '2015', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	GEOMETRY.2016 = list( #32
		sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'GEOMETRY'),
		sgp.panel.years=c('2014', '2015', '2016'),
		sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)

) ### END ANALYTIC_GEOMETRY_2016.config
