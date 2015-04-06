##################################################################################
###
### Scripts associated with 2014 CRCT and EOCT (US HISTORY and ECONOMICS) SOCIAL STUDIES
###
##################################################################################

#### GRADE-LEVEL CRCT SOCIAL_STUDIES - run together with EOCT to get all coefficient matrices for projections

###   NOT USED IN 2014 -- CRCT RUN SEPERATELY FROM EOCT

SOCIAL_STUDIES_2014.config <- list(
	SOCIAL_STUDIES.2014 = list(
		sgp.content.areas=rep('SOCIAL_STUDIES', 6),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 5), 'FIRST_OBSERVATION'),
		sgp.panel.years=as.character(2009:2014),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8')),
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE))

####
#### EOCT SOCIAL_STUDIES - RUN SEPERATELY FROM CRCT IN2014
####

### US HISTORY

US_HISTORY_2014.config <- list(
	US_HISTORY.2014 = list( #62 - New Progression
		sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.panel.years=c('2010', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=11),
	US_HISTORY.2014 = list( #63
		sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.panel.years=c('2011', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=10),
	# US_HISTORY.2014 = list( #64 - New Progression - 7th grade GPS Soc Stds only available from 2010 forward.  Could do cohort referenced this year, but not enough to build baseline
		# sgp.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES', 'US_HISTORY'),
		# sgp.panel.years=c('2010', '2011', '2014'),
		# sgp.grade.sequences=list(c('7', '8', 'EOCT')),
		# sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=9),
	US_HISTORY.2014 = list( #65
		sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=8),
	# US_HISTORY.2014 = list( #66 - New Progression - 7th grade GPS Soc Stds only available from 2010 forward.  Could do cohort referenced this year, but not enough to build baseline
		# sgp.content.areas=c('SOCIAL_STUDIES', 'SOCIAL_STUDIES', 'US_HISTORY'),
		# sgp.panel.years=c('2011', '2012', '2014'),
		# sgp.grade.sequences=list(c('7', '8', 'EOCT')),
		# sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=7),

	US_HISTORY.2014 = list( #67 - New Progression
		sgp.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=6),
	# US_HISTORY.2014 = list( #68 - New Progression - Only 900 kids in baseline cohort - not enough to establish good baseline and kids are already covered in progression 67 above
		# sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS', 'US_HISTORY'),
		# sgp.panel.years=c('2012', '2013', '2014'),
		# sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT')),
		# sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=5),
	US_HISTORY.2014 = list( #69 - New Progression
		sgp.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=4),
	# US_HISTORY.2014 = list( #70 - New Progression - 3,400 kids in baseline cohort - MARGINAL baseline cohort size and this would be the ONLY US history analysis with more than one prior.  kids are already covered in progression 69 above
		# sgp.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS', 'US_HISTORY'),
		# sgp.panel.years=c('2011', '2012', '2014'),
		# sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT')),
		# sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=3),

	US_HISTORY.2014 = list( #71
		sgp.content.areas=c('US_HISTORY','US_HISTORY'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=2),
	# US_HISTORY.2014 = list( #72
		# sgp.content.areas=c('US_HISTORY','US_HISTORY'),
		# sgp.panel.years=c('2014', '2014'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		# sgp.exact.grade.progression=TRUE,
	  # sgp.calculate.simex=TRUE,
	  # sgp.calculate.simex.baseline=TRUE,
		# sgp.norm.group.preference=1),
	US_HISTORY.2014 = list( #73 - New Progression
		sgp.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=0),
	US_HISTORY.2014 = list( #72
		sgp.content.areas=c('US_HISTORY','US_HISTORY'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=1)
) ### END US_HISTORY_2014.config


### ECONOMICS

ECONOMICS_2014.config <- list(
	ECONOMICS.2014 = list( #74
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=4),
	ECONOMICS.2014 = list( #75
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=3),
	ECONOMICS.2014 = list( #76
		sgp.content.areas=c('ECONOMICS', 'ECONOMICS'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=2),
	ECONOMICS.2014 = list( #77
		sgp.content.areas=c('ECONOMICS', 'ECONOMICS'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=1),
	ECONOMICS.2014 = list( #78
		sgp.content.areas=c('US_HISTORY', 'ECONOMICS'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=0)
) ### END ECONOMICS_2014.config
