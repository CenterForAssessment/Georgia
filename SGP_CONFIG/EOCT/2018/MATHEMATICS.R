################################################################################
###                                                                          ###
###  Scripts associated with 2018 EOG & EOC MATHEMATICS:                     ###
###      Coordinate Algebra, Analytic Geometry, Algebra I, and Geometry)     ###
###                                                                          ###
################################################################################

### GRADE-LEVEL MATHEMATICS - Run this code with EOC & get all results at once.

MATHEMATICS_2018.config <- list(
  MATHEMATICS.2018 = list(
    sgp.content.areas=rep('MATHEMATICS', 3),
    sgp.panel.years.within=c(rep('LAST_OBSERVATION', 2), 'FIRST_OBSERVATION'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8')),
    sgp.projection.sequence = c('MATH_ALG_I', 'MATH_COORD_ALG', 'G7_MATH_EOC')))


### Coordinate Algebra

COORDINATE_ALGEBRA_2018.config <- list(
  COORDINATE_ALGEBRA.2018 = list( #19
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2015', '2018'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
                                       YEAR=c('2016', '2016','2017', '2017'), GRADE=c('8','EOCT')),
    sgp.norm.group.preference=10),

  COORDINATE_ALGEBRA.2018 = list( #20
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2018'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections with full progressions only!
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
                                       YEAR=c('2017', '2017'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=9),

  COORDINATE_ALGEBRA.2018 = list( #21
    sgp.content.areas=c('MATHEMATICS','MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2015','2016', '2018'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION','LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections with full progressions only!
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
                                       YEAR=c( '2017', '2017'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=8),

  COORDINATE_ALGEBRA.2018 = list( #22
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections with full progressions only!
    sgp.norm.group.preference=7),


  COORDINATE_ALGEBRA.2018 = list( #23
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=6),

  COORDINATE_ALGEBRA.2018 = list( #24
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c(7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections with Milestones data only!
    sgp.norm.group.preference=5),

  COORDINATE_ALGEBRA.2018 = list( #25
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c(6, 7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=4),

  COORDINATE_ALGEBRA.2018 = list( #26
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c(6, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections with Milestones data only!
    sgp.norm.group.preference=3),

  COORDINATE_ALGEBRA.2018 = list( #27
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=2),

  COORDINATE_ALGEBRA.2018 = list( #28
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2018', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=1)
) ### END COORDINATE_ALGEBRA_2017.config


### Analytic Geometry

ANALYTIC_GEOMETRY_2018.config <- list(
  ANALYTIC_GEOMETRY.2018 = list( #29
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2015', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
                                       YEAR=c('2016','2016','2016','2017','2017', '2017'), GRADE=c('EOCT', 'EOCT')),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math canonical progressions & Milestones data only
    sgp.norm.group.preference=8),

  ANALYTIC_GEOMETRY.2018 = list( #30
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
                                       YEAR=c('2017','2017'), GRADE=c('EOCT', 'EOCT')),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math canonical progressions & Milestones data only
    sgp.norm.group.preference=7),


  ANALYTIC_GEOMETRY.2018 = list( #31
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math canonical progressions & Milestones data only
    sgp.norm.group.preference=6),

  ANALYTIC_GEOMETRY.2018 = list( #32
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=5),

  ANALYTIC_GEOMETRY.2018 = list( #33
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=4),


  ANALYTIC_GEOMETRY.2018 = list( #34
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=3),

  ANALYTIC_GEOMETRY.2018 = list( #35
    sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=2),


  ANALYTIC_GEOMETRY.2018 = list( #36
    sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2018', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=1),

  ANALYTIC_GEOMETRY.2018 = list( #37
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2018', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math Projections for canonical progressions only
    sgp.norm.group.preference=0)

) ### END ANALYTIC_GEOMETRY_2018.config


### Algebra I

ALGEBRA_I_2018.config <- list(
  ALGEBRA_I.2018 = list( #38
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2015', '2018'),
    sgp.grade.sequences=list(c('8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I'),
                                       YEAR=c('2016','2016','2017', '2017'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=10),

  ALGEBRA_I.2018 = list( #39
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2018'),
    sgp.grade.sequences=list(c('8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I'),
                                       YEAR=c('2017', '2017'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=9),

  ALGEBRA_I.2018 = list( #40
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2015', '2016', '2018'),
    sgp.grade.sequences=list(c('7', '8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I'),
                                       YEAR=c('2017', '2017'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=8),

  ALGEBRA_I.2018 = list( #41
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=7),

  ALGEBRA_I.2018 = list( #42
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c('7', '8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=6),

  ALGEBRA_I.2018 = list( #43
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('7', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=5),

  ALGEBRA_I.2018 = list( #44
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c('6', '7', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # Experimental
    sgp.projection.sequence = 'G7_MATH_EOC',
    sgp.norm.group.preference=4),

  ALGEBRA_I.2018 = list( #45
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('6', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3),


  ALGEBRA_I.2018 = list( #46
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('5', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),

  ALGEBRA_I.2018 = list( #47
    sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1),

  ALGEBRA_I.2018 = list( #48
    sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_I'),
    sgp.panel.years=c('2018', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)
) ### END ALGEBRA_I_2018.config


### GEOMETRY

GEOMETRY_2018.config <- list(
  GEOMETRY.2018 = list( #49
    sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=7),

  GEOMETRY.2018 = list( #50
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=6),

  GEOMETRY.2018 = list( #51
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # Experimental
    sgp.projection.sequence = 'G7_MATH_EOC',
    sgp.norm.group.preference=5),

  GEOMETRY.2018 = list( #52
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c(6, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=4),

  GEOMETRY.2018 = list( #53
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2018'),
    sgp.grade.sequences=list(c(5, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3),

  GEOMETRY.2018 = list( #54
    sgp.content.areas=c('GEOMETRY', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),

  GEOMETRY.2018 = list( #55
    sgp.content.areas=c('GEOMETRY', 'GEOMETRY'),
    sgp.panel.years=c('2018', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1),

  GEOMETRY.2018 = list( #56
    sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2018', '2018'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)


) ### END GEOMETRY_2018.config
