################################################################################
###                                                                          ###
###  Scripts for 2017 EOG & EOC MATHEMATICS - Single Prior Projections:      ###
###      Coordinate Algebra, Analytic Geometry, Algebra I, and Geometry)     ###
###                                                                          ###
################################################################################

### GRADE-LEVEL MATHEMATICS - Run this code with EOC & get all results at once.

MATHEMATICS_2017.config <- list(
  MATHEMATICS.2017 = list(
    sgp.content.areas=rep('MATHEMATICS', 2),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.panel.years=c('2016', '2017'),
    sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8')),
    sgp.projection.sequence = c('MATH_ALG_I', 'MATH_COORD_ALG', 'G7_MATH_EOC')))


### Coordinate Algebra

COORDINATE_ALGEBRA_2017.config <- list(
  COORDINATE_ALGEBRA.2017 = list( #24
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2017'),
    sgp.grade.sequences=list(c(7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS",  # CANONICAL
    sgp.norm.group.preference=5)
) ### END COORDINATE_ALGEBRA_2016.config


### Analytic Geometry

ANALYTIC_GEOMETRY_2017.config <- list(
  ANALYTIC_GEOMETRY.2017 = list( #31
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2017'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS",  # CANONICAL
    sgp.norm.group.preference=6)
) ### END ANALYTIC_GEOMETRY_2017.config


### Algebra I

ALGEBRA_I_2017.config <- list(
  ALGEBRA_I.2017 = list( #41
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2017'),
    sgp.grade.sequences=list(c('8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=7),

  ALGEBRA_I.2017 = list( #43
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2017'),
    sgp.grade.sequences=list(c('7', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS",  # CANONICAL + Experimental
    sgp.norm.group.preference=5)
) ### END ALGEBRA_I_2017.config


### GEOMETRY

GEOMETRY_2017.config <- list(
  GEOMETRY.2017 = list( #49
    sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=7)
) ### END GEOMETRY_2017.config
