################################################################################
###                                                                          ###
###  Scripts associated with 2017 EOG & EOC ELA - Single Prior Projections:  ###
###                                                                          ###
################################################################################

ELA_2017.config <- list(
  ELA.2017 = list(
    sgp.content.areas=c('ELA', 'ELA'),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.panel.years=c('2016', '2017'),
    sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8'))))


### GRADE_9_LIT

GRADE_9_LIT_2017.config <- list(
   GRADE_9_LIT.2017 = list( # 4
    sgp.content.areas=c('ELA', 'GRADE_9_LIT'),
    sgp.panel.years=c('2016', '2017'),
    sgp.grade.sequences=list(c(8, 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=5)
) ### END GRADE_9_LIT_2015.config


### AMERICAN_LIT

AMERICAN_LIT_2017.config <- list(
  AMERICAN_LIT.2017 = list( # 11
    sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
    sgp.panel.years=c('2015', '2017'),
    sgp.grade.sequences=list(c('EOCT', 'EOCT')),
    sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
    sgp.exact.grade.progression=TRUE,
    sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('GRADE_9_LIT', 'AMERICAN_LIT'),
                                       YEAR=c('2016', '2016'), GRADE=c('EOCT', 'EOCT')),
    # sgp.projection.grade.sequences="NO_PROJECTIONS",  # ELA/Lit Projections with Milestones data only
    sgp.norm.group.preference=7)
) ### END AMERICAN_LIT.2017.config
