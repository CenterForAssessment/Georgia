################################################################################
###                                                                          ###
###       Math 2019 SGP Configurations for 2021 Learning Loss Analyses       ###
###                                                                          ###
################################################################################

### GRADE-LEVEL MATHEMATICS

MATHEMATICS_2019.config <- list(
  MATHEMATICS.2019 = list(
    sgp.content.areas=rep('MATHEMATICS', 3),
    sgp.panel.years.within=c(rep('LAST_OBSERVATION', 2), 'FIRST_OBSERVATION'),
		sgp.panel.years=c("2016", "2017", "2019"),
		sgp.grade.sequences=list(c("3", "5"), c("3", "4", "6"), c("4", "5", "7"), c("5", "6", "8")),
    sgp.projection.sequence = c('MATH_ALG_I', 'MATH_COORD_ALG', 'G7_MATH_EOC')))


### Coordinate Algebra

COORDINATE_ALGEBRA_2019.config <- list(
  COORDINATE_ALGEBRA.2019 = list( #  --  (No change - gap included in original)
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
                                       YEAR=c('2017', '2017'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=999),

  COORDINATE_ALGEBRA.2019 = list( #18 (No change - gap included in original)
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=6),
  COORDINATE_ALGEBRA.2019 = list( #19 (No change - gap included in original)
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=5),

  COORDINATE_ALGEBRA.2019 = list( #20
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS", # NEW CANONICAL skip 8th
    sgp.norm.group.preference=4),

  COORDINATE_ALGEBRA.2019 = list( #21
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(6, 7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # NEW CANONICAL skip 8th
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=3),

  COORDINATE_ALGEBRA.2019 = list( #22
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(6, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),

  COORDINATE_ALGEBRA.2019 = list( #23
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(5, 6, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=1),

  COORDINATE_ALGEBRA.2019 = list( #  --  <1500 :: Include for SGP_NOTE/BASELINE
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'COORDINATE_ALGEBRA'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)
) ### END COORDINATE_ALGEBRA_2019.config


### Analytic Geometry

ANALYTIC_GEOMETRY_2019.config <- list(
  ANALYTIC_GEOMETRY.2019 = list( #  --  (No change - gap included in original)
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
                                       YEAR=c('2017', '2017'), GRADE=c('EOCT', 'EOCT')),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=999),

  ANALYTIC_GEOMETRY.2019 = list( #  --  (No change - gap included in original)
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=997),

  ANALYTIC_GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=995),

  ###  Cohort > 1,500

  ANALYTIC_GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE (Old pref 998)
    sgp.content.areas=c('COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS", # Math canonical progressions & Milestones data only
    sgp.norm.group.preference=7),

  ANALYTIC_GEOMETRY.2019 = list( # NEW
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # OLD CANONICAL + Skip
    sgp.norm.group.preference=6),

	ANALYTIC_GEOMETRY.2019 = list( #27a
    sgp.content.areas=c('MATHEMATICS', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=5),

  ANALYTIC_GEOMETRY.2019 = list( # NEW
    sgp.content.areas=c('MATHEMATICS', 'COORDINATE_ALGEBRA', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=4),

  ANALYTIC_GEOMETRY.2019 = list( #26a
    sgp.content.areas=c('MATHEMATICS', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # NEW CANONICAL
    sgp.norm.group.preference=3),
	ANALYTIC_GEOMETRY.2019 = list( #26b
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # NEW CANONICAL - skip COORDINATE_ALGEBRA in sequence
    sgp.norm.group.preference=2),

  ANALYTIC_GEOMETRY.2019 = list( #  --  NEW :: Include for BASELINE
    sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1),

  ANALYTIC_GEOMETRY.2019 = list( #  --  <1500 :: Include for SGP_NOTE/BASELINE
    sgp.content.areas=c('ANALYTIC_GEOMETRY', 'ANALYTIC_GEOMETRY'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)
) ### END ANALYTIC_GEOMETRY_2019.config


### Algebra I

ALGEBRA_I_2019.config <- list(
  ALGEBRA_I.2019 = list( #29 (No change - gap included in original)
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2019'),
    sgp.grade.sequences=list(c('8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I'),
                                       YEAR=c('2017', '2017'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=7),

  ALGEBRA_I.2019 = list( #30 (No change - gap included in original)
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=6),

  ALGEBRA_I.2019 = list( #31 (No change - gap included in original)
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c('7', '8', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=5),

  ALGEBRA_I.2019 = list( #35a
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('7', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS", #  NEW CANONICAL
    sgp.norm.group.preference=4),
  ALGEBRA_I.2019 = list( #35b
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c('6', '7', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", #  NEW CANONICAL
    sgp.norm.group.preference=3),

	ALGEBRA_I.2019 = list( # NEW
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c('5', '6', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    # sgp.projection.sequence = 'G7_MATH_EOC',  #  NEW Advanced
    sgp.norm.group.preference=2),

  ALGEBRA_I.2019 = list( #38a #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c('ALGEBRA_I', 'ALGEBRA_I'),
    sgp.panel.years=c('2017', '2019'),
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
  GEOMETRY.2019 = list( #38 (No change - gap included in original)
    sgp.content.areas=c('ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=9),

  GEOMETRY.2019 = list( #39 (No change - gap included in original)
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=8),

	GEOMETRY.2019 = list( #41a
    sgp.content.areas=c('MATHEMATICS', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL - skip ALGEBRA_I
    sgp.norm.group.preference=7),
  GEOMETRY.2019 = list( #41
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL - skip ALGEBRA_I
    sgp.norm.group.preference=6),

  GEOMETRY.2019 = list( #42x (Same courses with Skip year)
    sgp.content.areas=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    # sgp.projection.sequence = 'G7_MATH_EOC',
    sgp.norm.group.preference=5),

	GEOMETRY.2019 = list( #42a
    sgp.content.areas=c('MATHEMATICS', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    # sgp.projection.sequence = 'G7_MATH_EOC',
    sgp.norm.group.preference=4),
	GEOMETRY.2019 = list( #42
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'GEOMETRY'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(6, 7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    # sgp.projection.sequence = 'G7_MATH_EOC',
    sgp.norm.group.preference=3),

  ## New sequence and reordered preferences
  GEOMETRY.2019 = list( #43 (No change - gap included in original)
    sgp.content.areas=c('GEOMETRY', 'GEOMETRY'),
    sgp.panel.years=c('2017', '2019'),
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
