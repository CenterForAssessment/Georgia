#########################################################################################################################
###
### Scripts associated with 2017 EOG & EOC MATHEMATICS (Coordinate Algebra, Analytic Geometry, Algebra I, and Geometry)
###
#########################################################################################################################

### GRADE-LEVEL MATHEMATICS  - Use this code to run with EOCT & get all results at once.

MATHEMATICS_2017.config <- list(
	MATHEMATICS.2017 = list(
		sgp.content.areas=rep('MATHEMATICS', 2),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.panel.years=c('2016', '2017'),
		sgp.grade.sequences=list(c('3', '4'), c('4', '5'), c('5', '6'), c('6', '7'), c('7', '8')),
		sgp.exact.grade.progression=list(TRUE, TRUE, TRUE, TRUE, TRUE),
		sgp.projection.sequence = c("MATH_COORD_ALG", "MATH_ALG_I"),
		sgp.norm.group.preference=2),
	MATHEMATICS.2017 = list(
		sgp.content.areas=rep('MATHEMATICS', 3),
		sgp.panel.years.within=c(rep('LAST_OBSERVATION', 2), 'FIRST_OBSERVATION'),
		sgp.panel.years=c('2015', '2016', '2017'),
		sgp.grade.sequences=list(c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8')),
		sgp.exact.grade.progression=list(TRUE, TRUE, TRUE, TRUE),
		sgp.projection.grade.sequences=list("NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS", "NO_PROJECTIONS"), # Projections with Milestones data only!
		sgp.norm.group.preference=1))


