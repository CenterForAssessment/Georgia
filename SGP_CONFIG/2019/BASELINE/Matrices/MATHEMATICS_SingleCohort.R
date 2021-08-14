################################################################################
###                                                                          ###
###   Math Baseline Configs for Georgia 2021 SGP Analyses (Single cohort)    ###
###                                                                          ###
################################################################################

MATHEMATICS_BASELINE.config <- list(
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("3", "4"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),

	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("4", "5"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 3),
		sgp.baseline.panel.years=c("2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("3", "4", "5"),
		sgp.baseline.grade.sequences.lags=c(1,1),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 2),
		sgp.baseline.panel.years=c("2017", "2019"),
		sgp.baseline.grade.sequences=c("3", "5"),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),

	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("5", "6"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 3),
		sgp.baseline.panel.years=c("2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("4", "5", "6"),
		sgp.baseline.grade.sequences.lags=c(1,1),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 2),
		sgp.baseline.panel.years=c("2017", "2019"),
		sgp.baseline.grade.sequences=c("4", "6"),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 3),
		sgp.baseline.panel.years=c("2016", "2017", "2019"),
		sgp.baseline.grade.sequences=c("3", "4", "6"),
		sgp.baseline.grade.sequences.lags=c(1,2),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),

	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("6", "7"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 3),
		sgp.baseline.panel.years=c("2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("5", "6", "7"),
		sgp.baseline.grade.sequences.lags=c(1,1),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 2),
		sgp.baseline.panel.years=c("2017", "2019"),
		sgp.baseline.grade.sequences=c("5", "7"),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 3),
		sgp.baseline.panel.years=c("2016", "2017", "2019"),
		sgp.baseline.grade.sequences=c("4", "5", "7"),
		sgp.baseline.grade.sequences.lags=c(1,2),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),

	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("7", "8"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 3),
		sgp.baseline.panel.years=c("2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("6", "7", "8"),
		sgp.baseline.grade.sequences.lags=c(1,1),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 2),
		sgp.baseline.panel.years=c("2017", "2019"),
		sgp.baseline.grade.sequences=c("6", "8"),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("MATHEMATICS", 3),
		sgp.baseline.panel.years=c("2016", "2017", "2019"),
		sgp.baseline.grade.sequences=c("5", "6", "8"),
		sgp.baseline.grade.sequences.lags=c(1,2),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"))
)

### Coordinate Algebra

COORDINATE_ALGEBRA_BASELINE.config <- list(
  list( #
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2016", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=3),

  list( #
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c(6, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),

  ###  Cohort > 1,500

	list( #19
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
  list( #19
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(7, 8, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

	list( #21
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),
  list( #21
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, 8, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( #21 - skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( #21 - skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(6, 7, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

  list( #22 - Advanced
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),
	list( #22 - Advanced, skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(6, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),

  list( #23 - Advanced - (single prior above)
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(6, 7, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( #23 - Advanced, skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(5, 6, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

  list( #24
    sgp.baseline.content.areas=c("COORDINATE_ALGEBRA", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),

	list( #
    sgp.baseline.content.areas=c("COORDINATE_ALGEBRA", "COORDINATE_ALGEBRA"),
    sgp.baseline.panel.years=c("2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=0)
) ### END COORDINATE_ALGEBRA_BASELINE.config


### Analytic Geometry

ANALYTIC_GEOMETRY_BASELINE.config <- list(
  list( #
    sgp.baseline.content.areas=c("COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2016", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=3),
  list( #
    sgp.baseline.content.areas=c("COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( #
    sgp.baseline.content.areas=c("COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),
	list( # Block Schedule  --  no kids?
    sgp.baseline.content.areas=c("COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=0),

  list( # VERY Advanced (single prior above)
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(6, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( # -- skip year (none with 5th grade prior)
    sgp.baseline.content.areas=c("MATHEMATICS", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(6, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),

  ###  Cohort > 1,500

  list( #26 -- CANONICAL (single prior above)
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( #26 -- CANONICAL - skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( #26 -- CANONICAL - skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(7, 8, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

  list( #27 (single prior above)
    sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( #27 - skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( #27 - skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(6, 7, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

  list( #28
    sgp.baseline.content.areas=c("ANALYTIC_GEOMETRY", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),

  list( # same year repeat --  <1500 :: Include for SGP_NOTE
    sgp.baseline.content.areas=c("ANALYTIC_GEOMETRY", "ANALYTIC_GEOMETRY"),
    sgp.baseline.panel.years=c("2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=0)
) ### END ANALYTIC_GEOMETRY_BASELINE.config


###  Algebra I
###  Came online in 2016  --  NO 2015 DATA

ALGEBRA_I_BASELINE.config <- list(
  list( #
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c(6, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),

  list( #
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c(5, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),

  ###  Cohort > 1,500

  list( #29 Came online in 2016  --  Not enough DATA
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2016", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=3),

	list( #31  -- (already gap year)
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
  list( #31 Came online in 2016  --  Not enough DATA for two priors
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(7, 8, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

	list( #32
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),
  list( #33
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, 8, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( #33 -- skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( #33 -- skip year  --  Came online in 2016  --  Not enough DATA for two priors
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(6, 7, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

  list( #35
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(6, 7, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( #35 -- skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(5, 6, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),
	list( #35 -- skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(6, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),

	list( #38a #
    sgp.baseline.content.areas=c("ALGEBRA_I", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
  list( #36
    sgp.baseline.content.areas=c("ALGEBRA_I", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),
  list( #37
    sgp.baseline.content.areas=c("ALGEBRA_I", "ALGEBRA_I"),
    sgp.baseline.panel.years=c("2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=0)
) ### END ALGEBRA_I_BASELINE.config


### GEOMETRY
###  Came online in 2016  --  NO 2015 DATA

GEOMETRY_BASELINE.config <- list(
  list( #
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(6, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( #  skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(6, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),

	list( #
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(5, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
  list( # skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(5, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),

  ###  Cohort > 1,500

	list( #38
    sgp.baseline.content.areas=c("ALGEBRA_I", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( #39  --  Came online in 2016  --  Not enough DATA for two priors
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c("8", "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

	list( #40
    sgp.baseline.content.areas=c("ALGEBRA_I", "GEOMETRY"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),
  list( #41
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( #41  --  skip year  --  Came online in 2016  --  Not enough DATA for two priors
    sgp.baseline.content.areas=c("MATHEMATICS", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( #41  --  skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "GEOMETRY"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(7, 8, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

  list( #42 - (single prior above - #40)
    sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( #42  --  skip year  --  Came online in 2016  --  Not enough DATA for two priors
    sgp.baseline.content.areas=c("MATHEMATICS", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( #42  --  skip year
    sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS", "GEOMETRY"),
    sgp.baseline.panel.years=c("2016", "2017", "2019"),
    sgp.baseline.grade.sequences=c(6, 7, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

  ## New sequence and reordered preferences
  list( #43
    sgp.baseline.content.areas=c("GEOMETRY", "GEOMETRY"),
    sgp.baseline.panel.years=c("2017", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),

  list( #44
    sgp.baseline.content.areas=c("GEOMETRY", "GEOMETRY"),
    sgp.baseline.panel.years=c("2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),

  list( #45
    sgp.baseline.content.areas=c("GEOMETRY", "GEOMETRY"),
    sgp.baseline.panel.years=c("2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=0),

  list( #46 - Block Schedule
    sgp.baseline.content.areas=c("ALGEBRA_I", "GEOMETRY"),
    sgp.baseline.panel.years=c("2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=0)
  ) ### END GEOMETRY_BASELINE.config
