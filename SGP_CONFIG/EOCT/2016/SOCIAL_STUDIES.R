###########################################################################################
###
### Scripts associated with 2016 EOG and EOC SOCIAL STUDIES (US History and Economics)
###
###########################################################################################

### GRADE-LEVEL SOCIAL_STUDIES - Use this code to run with EOCT & get all results at once.

SOCIAL_STUDIES_2016.config <- list(
	SOCIAL_STUDIES.2016 = list(
		sgp.content.areas=rep('SOCIAL_STUDIES', 2),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8')),
		sgp.exact.grade.progression=list(TRUE, TRUE, TRUE, TRUE, TRUE),
		sgp.norm.group.preference=2),

	SOCIAL_STUDIES.2016 = list(
		sgp.content.areas=rep('SOCIAL_STUDIES', 3),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 2), 'FIRST_OBSERVATION'),
		sgp.panel.years=c('2014', '2015', '2016'),
		sgp.grade.sequences=list(c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8')),
		sgp.exact.grade.progression=list(TRUE, TRUE, TRUE, TRUE),
		sgp.projection.grade.sequences=list("NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS"), # Projections with Milestones data only!
		sgp.norm.group.preference=1))



### US HISTORY

US_HISTORY_2016.config <- list(
	US_HISTORY.2016 = list( #53
		sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.panel.years=c('2012', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2013', '2013', '2013', '2014', '2014', '2014', '2015', '2015', '2015'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=5),
		
	US_HISTORY.2016 = list( #54
		sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.panel.years=c('2013', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2014', '2014', '2014', '2015', '2015', '2015'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=4),
		
	US_HISTORY.2016 = list( #55
		sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.panel.years=c('2014', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2015', '2015', '2015'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=3),


	US_HISTORY.2016 = list( #56
		sgp.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),

	US_HISTORY.2016 = list( #57 - Repeaters
		sgp.content.areas=c('US_HISTORY','US_HISTORY'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),

	US_HISTORY.2016 = list( #58 - Block Schedule 
		sgp.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.panel.years=c('2016', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
		
) ### END US_HISTORY_2016.config


### ECONOMICS

ECONOMICS_2016.config <- list(
	ECONOMICS.2016 = list( #59
		sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS'),
		sgp.panel.years=c('2012', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2013', '2013', '2013', '2014', '2014', '2014', '2015', '2015', '2015'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=6),
		
	ECONOMICS.2016 = list( #60
		sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS'),
		sgp.panel.years=c('2013', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2014', '2014', '2014', '2015', '2015', '2015'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=5),
		
	ECONOMICS.2016 = list( #61
		sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS'),
		sgp.panel.years=c('2014', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SOCIAL_STUDIES', 'US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2015', '2015', '2015'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=4),
		
	ECONOMICS.2016 = list( #62
		sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c(8, 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
		
	ECONOMICS.2016 = list( #63
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2014', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('US_HISTORY', 'ECONOMICS'), 
			YEAR=c('2015', '2015'), GRADE=c('EOCT', 'EOCT')),
		sgp.norm.group.preference=2),

	ECONOMICS.2016 = list( #64
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2015', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
		
	ECONOMICS.2016 = list( #65 - Block Schedule 
		sgp.content.areas=c('ECONOMICS', 'ECONOMICS'),
		sgp.panel.years=c('2016', '2016'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
		
) ### END ECONOMICS_2016.config
