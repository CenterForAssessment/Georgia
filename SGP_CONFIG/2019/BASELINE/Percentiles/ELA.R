################################################################################
###                                                                          ###
###       ELA 2019 SGP Configurations for 2021 Learning Loss Analyses        ###
###                                                                          ###
################################################################################


ELA_2019.config <- list(
  ELA.2019 = list(
    sgp.content.areas=c('ELA', 'ELA', 'ELA'),
    sgp.panel.years.within=c(rep('LAST_OBSERVATION', 2), 'FIRST_OBSERVATION'),
		sgp.panel.years=c("2016", "2017", "2019"),
		sgp.grade.sequences=list(c("3", "5"), c("3", "4", "6"), c("4", "5", "7"), c("5", "6", "8")))
)


### GRADE_9_LIT

GRADE_9_LIT_2019.config <- list(
  GRADE_9_LIT.2019 = list( #  --  No change - gap included in original
    sgp.content.areas=c('ELA', 'GRADE_9_LIT'),
    sgp.panel.years=c('2016', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('ELA', 'GRADE_9_LIT'),
                                       YEAR=c('2017', '2017'), GRADE=c('8', 'EOCT')),
    sgp.norm.group.preference=999),

  ###  Cohort > 1,500

  GRADE_9_LIT.2019 = list( # 1 -- No change - gap included in original
    sgp.content.areas=c('ELA', 'GRADE_9_LIT'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=8),
  GRADE_9_LIT.2019 = list( # 2 -- No change - gap included in original
    sgp.content.areas=c('ELA', 'ELA', 'GRADE_9_LIT'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=7),

  GRADE_9_LIT.2019 = list( # 3 skip year
    sgp.content.areas=c('ELA', 'GRADE_9_LIT'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c( 7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS", #  NEW CANONICAL
    sgp.norm.group.preference=6),
  GRADE_9_LIT.2019 = list( # 4 skip year
    sgp.content.areas=c('ELA', 'ELA', 'GRADE_9_LIT'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(6, 7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", #  NEW CANONICAL
    sgp.norm.group.preference=5),

  GRADE_9_LIT.2019 = list( # 5 skip year
    sgp.content.areas=c('ELA', 'GRADE_9_LIT'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c( 6, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS", #  NEW CANONICAL
    sgp.norm.group.preference=4),
  GRADE_9_LIT.2019 = list( # 6 skip year
    sgp.content.areas=c('ELA', 'ELA', 'GRADE_9_LIT'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(5, 6, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3),

  GRADE_9_LIT.2019 = list( # 7 (No change - gap included in original)
    sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),

  GRADE_9_LIT.2019 = list( # 9 (8 in spreadsheet)
    sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)
) ### END GRADE_9_LIT_2019.config


### AMERICAN_LIT

AMERICAN_LIT_2019.config <- list(
  AMERICAN_LIT.2019 = list( #  --  <1500 :: Skip Year
    sgp.content.areas=c('ELA', 'AMERICAN_LIT'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=999),

  AMERICAN_LIT.2019 = list( # 10 (No change - gap included in original)
    sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
    sgp.panel.years=c('2016', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'),
                                       YEAR=c('2017', '2017'), GRADE=c('EOCT', 'EOCT')),  # , '2018', '2018' not needed (wouldn't know, in theory, if existed)
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=7),

  AMERICAN_LIT.2019 = list( # 11 (No change - gap included in original)
    sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    # sgp.projection.grade.sequences="NO_PROJECTIONS",  #
    sgp.norm.group.preference=6),

  AMERICAN_LIT.2019 = list( # 12 (No change - gap included in original)
    sgp.content.areas=c('ELA', 'GRADE_9_LIT', 'AMERICAN_LIT'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=5),

  AMERICAN_LIT.2019 = list( # 13 (No change - gap included in original)
    sgp.content.areas=c('ELA', 'GRADE_9_LIT', 'AMERICAN_LIT'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # New CANONICAL
    sgp.norm.group.preference=4),

	AMERICAN_LIT.2019 = list( #  NEW 2 prior + 2 Year skip - skip G9 Lit
    sgp.content.areas=c('ELA', 'ELA', 'AMERICAN_LIT'),
    sgp.panel.years=c('2015', '2016', '2019'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'),
                                       YEAR=c('2017', '2017'), GRADE=c('EOCT', 'EOCT')), # , '2018', '2018' not needed (wouldn't know, in theory, if existed)
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3),

  AMERICAN_LIT.2019 = list( # 15 - NEW 1 prior - skip G9 Lit
    sgp.content.areas=c('ELA', 'AMERICAN_LIT'),
    sgp.panel.years=c('2017', '2019'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),
  AMERICAN_LIT.2019 = list( # 15 - NEW 2 prior - skip G9 Lit
    sgp.content.areas=c('ELA', 'ELA', 'AMERICAN_LIT'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.grade.sequences=list(c(7, 8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1),

  AMERICAN_LIT.2019 = list( # 17
    sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
    sgp.panel.years=c('2019', '2019'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)
) ### END AMERICAN_LIT.2019.config
