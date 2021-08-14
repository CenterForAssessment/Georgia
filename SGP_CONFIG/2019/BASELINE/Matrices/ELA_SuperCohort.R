################################################################################
###                                                                          ###
###    ELA Baseline Configs for Georgia 2021 SGP Analyses (Super cohort)     ###
###                                                                          ###
################################################################################


ELA_BASELINE.config <- list(
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("3", "4"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),

	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("4", "5"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("3", "4", "5"),
		sgp.baseline.grade.sequences.lags=c(1,1),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("3", "5"),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),

	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("5", "6"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("4", "5", "6"),
		sgp.baseline.grade.sequences.lags=c(1,1),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("4", "6"),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("3", "4", "6"),
		sgp.baseline.grade.sequences.lags=c(1,2),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),

	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("6", "7"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("5", "6", "7"),
		sgp.baseline.grade.sequences.lags=c(1,1),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("5", "7"),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("4", "5", "7"),
		sgp.baseline.grade.sequences.lags=c(1,2),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),

	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("7", "8"),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("6", "7", "8"),
		sgp.baseline.grade.sequences.lags=c(1,1),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("6", "8"),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION")),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("5", "6", "8"),
		sgp.baseline.grade.sequences.lags=c(1,2),
		sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"))
)

### GRADE_9_LIT

GRADE_9_LIT_BASELINE.config <- list(
  list( #  Not available until 2019?
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"), # Only one viable cohort?
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=3),
	list( # 1
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
  list( # 2
    sgp.baseline.content.areas=c("ELA", "ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, 8, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

	list( # 3 CANONICAL
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),
	list( # 4 CANONICAL
    sgp.baseline.content.areas=c("ELA", "ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, 8, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( # CANONICAL - skip year
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( # CANONICAL - skip year (2 prior)
    sgp.baseline.content.areas=c("ELA", "ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(6, 7, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

	##  Accelerated
  list( # 5
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c( 7, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),
	list( # 6
    sgp.baseline.content.areas=c("ELA", "ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(6, 7, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( # 6  -  skip year
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(6, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( # 6 - skip year - no kids with 2 priors?
    sgp.baseline.content.areas=c("ELA", "ELA", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(5, 6, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

  list( # 7 (9 in spreadsheet) + already gap year
    sgp.baseline.content.areas=c("GRADE_9_LIT", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),

	list( # 8 (7 in spreadsheet)
    sgp.baseline.content.areas=c("GRADE_9_LIT", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),

###   Might need to re-think YEAR_WITHIN in the context of baselineSGPs...  Baseline on first/last observation?  Do same-year repeaters manually outside baselineSGP?

  list( # 9 (8 in spreadsheet)
    sgp.baseline.content.areas=c("GRADE_9_LIT", "GRADE_9_LIT"),
    sgp.baseline.panel.years=c("2019"), #  For now just run as single year (2019) cohort
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=0)
) ### END GRADE_9_LIT_BASELINE.config


### AMERICAN_LIT

AMERICAN_LIT_BASELINE.config <- list(
  list( # 10  2 year skip
    sgp.baseline.content.areas=c("GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=3),
	list( # 1 year skip
    sgp.baseline.content.areas=c("GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( # 0 year skip
    sgp.baseline.content.areas=c("GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),

	list( # 12 (single prior above)
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),
	list( # 12 - skip 2 year  (gap already included!  extra gap?)
    sgp.baseline.content.areas=c("ELA", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=3),
  list( # 12.noskip - more typical (single prior above)
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( # 12.noskip - skip 1 year
    sgp.baseline.content.areas=c("ELA", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),

  list( # 13 CANONICAL - not impacted by 1 year skip! (single prior above)
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),
	list( # 13 - CANONICAL skip year (gap already included!  extra gap?)
    sgp.baseline.content.areas=c("ELA", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=3),

	list( # 15a - no gap year between G9Lit and AmLit (single prior above)
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,1)),
	list( # 15b - skip year  -  (skip G9 Lit, one prior)
    sgp.baseline.content.areas=c("ELA", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(8, "EOCT"),
    sgp.baseline.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=2),
	list( # 15b - skip year  -  (skip G9 Lit, two prior)
    sgp.baseline.content.areas=c("ELA", "ELA", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c(7, 8, "EOCT"),
    sgp.baseline.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=c(1,2)),

	list( # 16
    sgp.baseline.content.areas=c("AMERICAN_LIT", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2015", "2016", "2017", "2018", "2019"),
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=1),
  list( # 17
    sgp.baseline.content.areas=c("AMERICAN_LIT", "AMERICAN_LIT"),
    sgp.baseline.panel.years=c("2019"), #  For now just run as single year (2019) cohort
    sgp.baseline.grade.sequences=c("EOCT", "EOCT"),
    sgp.baseline.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.baseline.grade.sequences.lags=0)
) ### END AMERICAN_LIT.BASELINE.config
