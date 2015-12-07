###########################################################################################
###
### Scripts associated with 2015 EOGT and EOCT SOCIAL STUDIES (US History and Economics)
###
###########################################################################################

### GRADE-LEVEL SOCIAL_STUDIES - Use this code to run with EOCT & get all results at once.

SOCIAL_STUDIES_2015.config <- list(
	SOCIAL_STUDIES.2015 = list(
		sgp.content.areas=rep('SOCIAL_STUDIES', 6),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 5), 'FIRST_OBSERVATION'),
		sgp.panel.years=as.character(2009:2015),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8'))))
		# sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8'))))

### US HISTORY

US_HISTORY_2015.config <- list(
	US_HISTORY.2015 = list( #51
		sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.panel.years=c('2011', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2012', '2012', '2012', '2013', '2013', '2013', '2014', '2014', '2014'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=6),
	US_HISTORY.2015 = list( #52
		sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.panel.years=c('2012', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2013', '2013', '2013', '2014', '2014', '2014'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=5),
	US_HISTORY.2015 = list( #53
		sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2014', '2014', '2014'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=4),

	US_HISTORY.2015 = list( #54
		sgp.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2014', '2014'), GRADE=c('EOCT', 'EOCT')),
		sgp.norm.group.preference=3),
	US_HISTORY.2015 = list( #55
		sgp.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

	US_HISTORY.2015 = list( #56 - Repeaters
		sgp.content.areas=c('US_HISTORY','US_HISTORY'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	US_HISTORY.2015 = list( #57 - Block Schedule
		sgp.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.panel.years=c('2015', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'), # Should this be Last, First for "block schedule"?
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END US_HISTORY_2015.config


### ECONOMICS

ECONOMICS_2015.config <- list(
	ECONOMICS.2015 = list( #58
		sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS'),
		sgp.panel.years=c('2011', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2012', '2012', '2012', '2013', '2013', '2013', '2014', '2014', '2014'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=6),
	ECONOMICS.2015 = list( #59
		sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS'),
		sgp.panel.years=c('2012', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2013', '2013', '2013', '2014', '2014', '2014'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=5),
	ECONOMICS.2015 = list( #60
		sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2014', '2014', '2014'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=4),
	ECONOMICS.2015 = list( #61
		sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),

	ECONOMICS.2015 = list( #62
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2014', '2014'), GRADE=c('EOCT', 'EOCT')),
		sgp.norm.group.preference=2),

	ECONOMICS.2015 = list( #63
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	ECONOMICS.2015 = list( #64 - Block Schedule -- singular design matrix with prelim data
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2015', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END ECONOMICS_2015.config
