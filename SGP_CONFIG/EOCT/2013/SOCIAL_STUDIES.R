##################################################################################
###
### Scripts associated with 2013 EOCT SOCIAL STUDIES: US HISTORY and ECONOMICS
###
##################################################################################

### US HISTORY

US_HISTORY_2013.config <- list(
	US_HISTORY.2013 = list( #59
		sgp.content.areas=c('SOCIAL_STUDIES','US_HISTORY'),
		sgp.panel.years=c('2010','2013'),
		sgp.grade.sequences=list(c('8','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	US_HISTORY.2013 = list( #60
		sgp.content.areas=c('SOCIAL_STUDIES','US_HISTORY'),
		sgp.panel.years=c('2011','2013'),
		sgp.grade.sequences=list(c('8','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	US_HISTORY.2013 = list( #61
		sgp.content.areas=c('US_HISTORY','US_HISTORY'),
		sgp.panel.years=c('2012','2013'),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	US_HISTORY.2013 = list( #62
		sgp.content.areas=c('US_HISTORY','US_HISTORY'),
		sgp.panel.years=c('2013','2013'),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END US_HISTORY_2013.config


### ECONOMICS

ECONOMICS_2013.config <- list(
	ECONOMICS.2013 = list( #64
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2011', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	ECONOMICS.2013 = list( #65
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	ECONOMICS.2013 = list( #66
		sgp.content.areas=c('ECONOMICS', 'ECONOMICS'),
		sgp.panel.years=c('2012', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	ECONOMICS.2013 = list( #67
		sgp.content.areas=c('ECONOMICS', 'ECONOMICS'),
		sgp.panel.years=c('2013', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	ECONOMICS.2013 = list( #68
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2013', '2013'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END ECONOMICS_2013.config
