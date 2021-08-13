##################################################################################
###
### Scripts associated with 2011 EOCT SOCIAL STUDIES: US HISTORY and ECONOMICS
###
##################################################################################

### US HISTORY

US_HISTORY_2011.config <- list(
	US_HISTORY.2011 = list( # 52
		sgp.content.areas=c('SOCIAL_STUDIES','US_HISTORY'),
		sgp.panel.years=c('2008','2011'),
		sgp.grade.sequences=list(c('8','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	US_HISTORY.2011 = list( # 53
		sgp.content.areas=c('SOCIAL_STUDIES','US_HISTORY'),
		sgp.panel.years=c('2009','2011'),
		sgp.grade.sequences=list(c('8','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	US_HISTORY.2011 = list( # 54
		sgp.content.areas=c('SOCIAL_STUDIES','US_HISTORY'),
		sgp.panel.years=c('2010','2011'),
		sgp.grade.sequences=list(c('8','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	US_HISTORY.2011 = list( # 55
		sgp.content.areas=c('US_HISTORY','US_HISTORY'),
		sgp.panel.years=c('2010','2011'),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	US_HISTORY.2011 = list( # 56
		sgp.content.areas=c('US_HISTORY','US_HISTORY'),
		sgp.panel.years=c('2011','2011'),
		sgp.grade.sequences=list(c('EOCT','EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END US_HISTORY_2011.config


### ECONOMICS

ECONOMICS_2011.config <- list(
	ECONOMICS.2011 = list( # 57
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2009', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	ECONOMICS.2011 = list( # 58
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	ECONOMICS.2011 = list( # 59
		sgp.content.areas=c('ECONOMICS', 'ECONOMICS'),
		sgp.panel.years=c('2010', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	ECONOMICS.2011 = list( # 60
		sgp.content.areas=c('ECONOMICS', 'ECONOMICS'),
		sgp.panel.years=c('2011', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	ECONOMICS.2011 = list( # 61
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2011', '2011'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END ECONOMICS_2011.config
