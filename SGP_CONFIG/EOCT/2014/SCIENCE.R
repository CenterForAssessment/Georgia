#############################################################################
###
### Scripts associated with 2014 EOCT SCIENCE: Physical Science and Biology
###
#############################################################################

### GRADE-LEVEL CRCT SCIENCE - run as custom config to get correct projections sequences

SCIENCE.config <- list(
	SCIENCE.2014 = list(
		sgp.content.areas=rep('SCIENCE', 6),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 5), 'FIRST_OBSERVATION'),
		sgp.panel.years=as.character(2009:2014),
		sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('3', '4', '5', '6'), c('3', '4', '5', '6', '7'), c('3', '4', '5', '6', '7', '8')),
		sgp.projection.sequence = c("SCIENCE_BIO", "SCIENCE_PHYSCI")))


### PHYSICAL_SCIENCE

PHYSICAL_SCIENCE_2014.config <- list(
	PHYSICAL_SCIENCE.2014 = list( #37
		sgp.content.areas=c('SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('8','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=12),
	PHYSICAL_SCIENCE.2014 = list( #38
		sgp.content.areas=c('SCIENCE','SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2011', '2012', '2014'),
		sgp.grade.sequences=list(c('7','8','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=11),
	PHYSICAL_SCIENCE.2014 = list( #39
		sgp.content.areas=c('SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('8','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=10),
	PHYSICAL_SCIENCE.2014 = list( #40
		sgp.content.areas=c('SCIENCE','SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('7','8','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=9),
	PHYSICAL_SCIENCE.2014 = list( #41
		sgp.content.areas=c('SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('7','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=8),
	PHYSICAL_SCIENCE.2014 = list( #42
		sgp.content.areas=c('SCIENCE','SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('6','7','EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=7),
	PHYSICAL_SCIENCE.2014 = list( #43
		sgp.content.areas=c('BIOLOGY','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=6),
	PHYSICAL_SCIENCE.2014 = list( #44
		sgp.content.areas=c('SCIENCE','BIOLOGY','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2011', '2012', '2014'),
		sgp.grade.sequences=list(c('8','EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5),
	PHYSICAL_SCIENCE.2014 = list( #45
		sgp.content.areas=c('BIOLOGY','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4),
	PHYSICAL_SCIENCE.2014 = list( #46
		sgp.content.areas=c('SCIENCE','BIOLOGY','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('8','EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3),
	PHYSICAL_SCIENCE.2014 = list( #47
		sgp.content.areas=c('PHYSICAL_SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	PHYSICAL_SCIENCE.2014 = list( #48
		sgp.content.areas=c('PHYSICAL_SCIENCE','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', c('LAST_OBSERVATION')),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	PHYSICAL_SCIENCE.2014 = list( #49
		sgp.content.areas=c('BIOLOGY','PHYSICAL_SCIENCE'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END PHYSICAL_SCIENCE_2014.config


### BIOLOGY

BIOLOGY_2014.config <- list(
	BIOLOGY.2014 = list( #50
		sgp.content.areas=c('SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=11),
	BIOLOGY.2014 = list( #51
		sgp.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012', '2014'),
		sgp.grade.sequences=list(c('7', '8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=10),
	BIOLOGY.2014 = list( #52
		sgp.content.areas=c('SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=9),
	BIOLOGY.2014 = list( #53
		sgp.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('7', '8', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=8),
	BIOLOGY.2014 = list( #54
		sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=7),
	BIOLOGY.2014 = list( #55
		sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2011', '2012', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=6),
	BIOLOGY.2014 = list( #56
		sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=5), 
	BIOLOGY.2014 = list( #57
		sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=4), 
	BIOLOGY.2014 = list( #58
		sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('7', 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=3), 
	BIOLOGY.2014 = list( #59
		sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=2),
	BIOLOGY.2014 = list( #60
		sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=1),
	BIOLOGY.2014 = list( #61
		sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2014', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.norm.group.preference=0)
) ### END BIOLOGY_2014.config
