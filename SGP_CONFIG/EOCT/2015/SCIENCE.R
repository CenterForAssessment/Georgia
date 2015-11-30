######################################################################################
###
### Scripts associated with 2015 CRCT & EOCT SCIENCE (Physical Science and Biology)
###
######################################################################################

### GRADE-LEVEL CRCT SCIENCE - run as custom config to get correct projections sequences

# SCIENCE_2015.config <- list(
# 	SCIENCE.2015 = list(
# 		sgp.content.areas=rep('SCIENCE', 6),
# 		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 5), 'FIRST_OBSERVATION'),
# 		sgp.panel.years=as.character(2009:2015),
# 		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', 7,  '8')),
# 		sgp.projection.sequence = c("SCIENCE_BIO", "SCIENCE_PHYSCI")))


### PHYSICAL_SCIENCE

PHYSICAL_SCIENCE_2015.config <- list(
	PHYSICAL_SCIENCE.2015 = list( #30
		sgp.content.areas=c('SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c(8,  'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SCIENCE', 'PHYSICAL_SCIENCE'), 
			YEAR=c('2013', '2015'), GRADE=c(8, 'EOCT')),
		sgp.norm.group.preference=10),
	PHYSICAL_SCIENCE.2015 = list( #31
		sgp.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2012', '2013', '2015'),
		sgp.grade.sequences=list(c(7, 8,  'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'), 
			YEAR=c('2012', '2013', '2015'), GRADE=c(7, 8, 'EOCT')),
		sgp.norm.group.preference=9),
	PHYSICAL_SCIENCE.2015 = list( #32
		sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c(8,  'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=8),
	PHYSICAL_SCIENCE.2015 = list( #33
		sgp.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c(7, 8,  'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=7),
	PHYSICAL_SCIENCE.2015 = list( #34
		sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c(7,  'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=6),
	PHYSICAL_SCIENCE.2015 = list( #35
		sgp.content.areas=c('SCIENCE','SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c(6,  7,  'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	PHYSICAL_SCIENCE.2015 = list( #36
		sgp.content.areas=c('BIOLOGY','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('BIOLOGY', 'PHYSICAL_SCIENCE'), 
			YEAR=c('2013', '2015'), GRADE=c('EOCT', 'EOCT')),
		sgp.norm.group.preference=4),
	PHYSICAL_SCIENCE.2015 = list( #37
		sgp.content.areas=c('SCIENCE','BIOLOGY','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2012', '2013', '2015'),
		sgp.grade.sequences=list(c(8,  'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SCIENCE', 'BIOLOGY', 'PHYSICAL_SCIENCE'), 
			YEAR=c('2012', '2013', '2015'), GRADE=c(8, 'EOCT', 'EOCT')),
		sgp.norm.group.preference=3),
	PHYSICAL_SCIENCE.2015 = list( #38
		sgp.content.areas=c('BIOLOGY','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	PHYSICAL_SCIENCE.2015 = list( #39
		sgp.content.areas=c('SCIENCE','BIOLOGY','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c(8,  'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	PHYSICAL_SCIENCE.2015 = list( #40 - Repeater
		sgp.content.areas=c('PHYSICAL_SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END PHYSICAL_SCIENCE_2015.config


### BIOLOGY

BIOLOGY_2015.config <- list(
	BIOLOGY.2015 = list( #41
		sgp.content.areas=c('SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2015'),
		sgp.grade.sequences=list(c(8,   'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SCIENCE', 'BIOLOGY'), 
			YEAR=c('2012', '2015'), GRADE=c(8, 'EOCT')),
		sgp.norm.group.preference=9),
	BIOLOGY.2015 = list( #42
		sgp.content.areas=c('SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c(8,   'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SCIENCE', 'BIOLOGY'), 
			YEAR=c('2013', '2015'), GRADE=c(8, 'EOCT')),
		sgp.norm.group.preference=8),
	BIOLOGY.2015 = list( #43
		sgp.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2013', '2015'),
		sgp.grade.sequences=list(c(7,  8,   'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('SCIENCE', 'SCIENCE', 'BIOLOGY'), 
			YEAR=c('2012', '2013', '2015'), GRADE=c(7, 8, 'EOCT')),
		sgp.norm.group.preference=7),
	BIOLOGY.2015 = list( #44
		sgp.content.areas=c('SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c(8,   'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=6),
	BIOLOGY.2015 = list( #45
		sgp.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c(7,  8,   'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	BIOLOGY.2015 = list( #46
		sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2013', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.exclude.sequences = data.table(VALID_CASE = 'VALID_CASE', CONTENT_AREA=c('PHYSICAL_SCIENCE', 'BIOLOGY'), 
			YEAR=c('2013', '2015'), GRADE=c('EOCT', 'EOCT')),
		sgp.norm.group.preference=4),
	BIOLOGY.2015 = list( #47
		sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3), 
	BIOLOGY.2015 = list( #48
		sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c(8,   'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2), 
	BIOLOGY.2015 = list( #49
		sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2013', '2014', '2015'),
		sgp.grade.sequences=list(c(7,  'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1), 
	BIOLOGY.2015 = list( #50 - Repeater
		sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
		sgp.panel.years=c('2014', '2015'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END BIOLOGY_2015.config
