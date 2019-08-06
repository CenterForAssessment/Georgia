################################################################################
###                                                                          ###
###      Scripts associated with 2019 EOG & EOC MATHEMATICS:                 ###
###        Coordinate Algebra, Analytic Geometry, Algebra I, and Geometry)   ###
###                                                                          ###
################################################################################

### GRADE-LEVEL MATHEMATICS - Run this code with EOC & get all results at once.

MATHEMATICS_2019.config <- list(
  MATHEMATICS.2019 = list(
    sgp.content.areas=rep('MATHEMATICS', 3),
    sgp.panel.years.within=c(rep('LAST_OBSERVATION', 2), 'FIRST_OBSERVATION'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8')),
    sgp.projection.sequence = c('MATH_ALG_I', 'MATH_COORD_ALG', 'G7_MATH_EOC')))


### Coordinate Algebra

COORDINATE_ALGEBRA_2019.config <- list(
  COORDINATE_ALGEBRA.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
                                       YEAR=c('2017', '2017', '2018', '2018'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=999),

  COORDINATE_ALGEBRA.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c(6, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=998),

  COORDINATE_ALGEBRA.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.norm.group.preference=997),

  ###  Cohort > 1,500

  COORDINATE_ALGEBRA.2019 = list( #18
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
                                       YEAR=c('2018', '2018'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=6),

  COORDINATE_ALGEBRA.2019 = list( #19
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
                                       YEAR=c( '2018', '2018'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=5),

  COORDINATE_ALGEBRA.2019 = list( #20
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=4),

  COORDINATE_ALGEBRA.2019 = list( #21
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=3),

  COORDINATE_ALGEBRA.2019 = list( #22
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),

  COORDINATE_ALGEBRA.2019 = list( #23
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c(6, 7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=1),

  COORDINATE_ALGEBRA.2019 = list( #24
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.norm.group.preference=0)
) ### END COORDINATE_ALGEBRA_2019.config


### Analytic Geometry

ANALYTIC_GEOMETRY_2019.config <- list(
  ANALYTIC_GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
                                       YEAR=c('2017', '2017', '2017', '2018', '2018', '2018'), GRADE=c('EOCT', 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=999),

  ANALYTIC_GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
                                       YEAR=c('2018', '2018'), GRADE=c('EOCT', 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=998),

  ANALYTIC_GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=997),

  ANALYTIC_GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=996),

  ANALYTIC_GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=995),

  ###  Cohort > 1,500

  ANALYTIC_GEOMETRY.2019 = list( #25
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math canonical progressions & Milestones data only
    sgp.norm.group.preference=3),

  ANALYTIC_GEOMETRY.2019 = list( #26
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=2),

  ANALYTIC_GEOMETRY.2019 = list( #27
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=1),

  ANALYTIC_GEOMETRY.2019 = list( #28
    sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=0)
) ### END ANALYTIC_GEOMETRY_2019.config


### Algebra I

ALGEBRA_I_2019.config <- list(

  ALGEBRA_I.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('6', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=999),

  ALGEBRA_I.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('5', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=998),

  ALGEBRA_I.2019 = list( #38a #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
                                       YEAR=c('2018', '2018', '2018'), GRADE=c('8', 'EOCT', 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=997),

  ###  Cohort > 1,500

  ALGEBRA_I.2019 = list( #29
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2019'),
    sgp.grade.sequences=list(c('8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I'),
                                       YEAR=c('2017', '2017', '2018', '2018'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=8),

  ALGEBRA_I.2019 = list( #30
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I'),
                                       YEAR=c('2018', '2018'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=7),

  ALGEBRA_I.2019 = list( #31
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c('7', '8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I'), #  Add in 'GEOMETRY' in 2019
                                       YEAR=c('2018', '2018'), GRADE=c('8', 'EOCT')), # YEAR=c('2018', '2018', '2018'), GRADE=c('8', 'EOCT', 'EOCT')
    sgp.norm.group.preference=6),

  ALGEBRA_I.2019 = list( #32
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=5),

  ALGEBRA_I.2019 = list( #33
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c('7', '8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=4),

  ALGEBRA_I.2019 = list( #34
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('7', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3),

  ALGEBRA_I.2019 = list( #35
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c('6', '7', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.projection.sequence = 'G7_MATH_EOC',
    sgp.norm.group.preference=2),

  ALGEBRA_I.2019 = list( #36
    sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_I'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1),

  ALGEBRA_I.2019 = list( #37
    sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_I'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)
) ### END ALGEBRA_I_2019.config


### GEOMETRY

GEOMETRY_2019.config <- list(
  GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=999),

  GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c(5, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=998),


  ###  Cohort > 1,500

  GEOMETRY.2019 = list( #38
    sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
                                       YEAR=c('2018', '2018', '2018'), GRADE=c('8', 'EOCT', 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=8),

  # New for 2019, check goodness of fit plot
  GEOMETRY.2019 = list( #39
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
                                       YEAR=c('2018', '2018', '2018'), GRADE=c('8', 'EOCT', 'EOCT')),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=7),

  GEOMETRY.2019 = list( #40
    sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=6),

  GEOMETRY.2019 = list( #41
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=5),

  GEOMETRY.2019 = list( #42
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2018', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.projection.sequence = 'G7_MATH_EOC',
    sgp.norm.group.preference=4),

  ## New sequence and reordered preferences
  GEOMETRY.2019 = list( #43
    sgp.content.areas=c('GEOMETRY', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
                                       YEAR=c('2018', '2018', '2018'), GRADE=c('8', 'EOCT', 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3),

  GEOMETRY.2019 = list( #44
    sgp.content.areas=c('GEOMETRY', 'GEOMETRY'),
    sgp.panel.years=c('2018', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),

  GEOMETRY.2019 = list( #45
    sgp.content.areas=c('GEOMETRY', 'GEOMETRY'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1),

  GEOMETRY.2019 = list( #46
    sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)


  ) ### END GEOMETRY_2019.config
