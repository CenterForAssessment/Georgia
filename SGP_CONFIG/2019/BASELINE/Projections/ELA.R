################################################################################
###                                                                          ###
###     Configurations for STRAIGHT (skip-year) ELA projections in 2019      ###
###                                                                          ###
################################################################################

ELA_2019.config <- list(
    ELA.2019 = list(
      sgp.content.areas=c("ELA", "ELA"),
      sgp.baseline.content.areas=c("ELA", "ELA"),
      sgp.panel.years=c("2017", "2019"),
      sgp.baseline.panel.years=c("2017", "2019"),
      sgp.grade.sequences=list(c("3", "5")),
      sgp.baseline.grade.sequences=list(c("3", "5")),
      sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas=c("ELA"),
      sgp.projection.baseline.panel.years=c("2019"),
      sgp.projection.baseline.grade.sequences=list(c("3")),
      sgp.projection.sequence="ELA_GRADE_3"),
    ELA.2019 = list(
      sgp.content.areas=rep("ELA", 3),
      sgp.baseline.content.areas=rep("ELA", 3),
      sgp.panel.years=c("2016", "2017", "2019"),
      sgp.baseline.panel.years=c("2016", "2017", "2019"),
      sgp.grade.sequences=list(c("3", "4", "6")),
      sgp.baseline.grade.sequences=list(c("3", "4", "6")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = rep("ELA", 2),
      sgp.projection.baseline.panel.years=c("2018", "2019"),
      sgp.projection.baseline.grade.sequences=list(c("3", "4")),
      sgp.projection.sequence="ELA_GRADE_4"),
    ELA.2019 = list(
      sgp.content.areas=rep("ELA", 3),
      sgp.baseline.content.areas=rep("ELA", 3),
      sgp.panel.years=c("2016", "2017", "2019"),
      sgp.baseline.panel.years=c("2016", "2017", "2019"),
      sgp.grade.sequences=list(c("4", "5", "7")),
      sgp.baseline.grade.sequences=list(c("4", "5", "7")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = rep("ELA", 2),
      sgp.projection.baseline.panel.years=c("2018", "2019"),
      sgp.projection.baseline.grade.sequences=list(c("4", "5")),
      sgp.projection.sequence="ELA_GRADE_5"),
    ELA.2019 = list(
      sgp.content.areas=rep("ELA", 3),
      sgp.baseline.content.areas=rep("ELA", 3),
      sgp.panel.years=c("2016", "2017", "2019"),
      sgp.baseline.panel.years=c("2016", "2017", "2019"),
      sgp.grade.sequences=list(c("5", "6", "8")),
      sgp.baseline.grade.sequences=list(c("5", "6", "8")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = rep("ELA", 2),
      sgp.projection.baseline.panel.years=c("2018", "2019"),
      sgp.projection.baseline.grade.sequences=list(c("5", "6")),
      sgp.projection.sequence="ELA_GRADE_6"),
    ELA.2019 = list(
      sgp.content.areas=c("ELA", "ELA", "GRADE_9_LIT"),
      sgp.baseline.content.areas=c("ELA", "ELA", "GRADE_9_LIT"),
      sgp.panel.years=c("2016", "2017", "2019"),
      sgp.baseline.panel.years=c("2016", "2017", "2019"),
      sgp.grade.sequences=list(c("6", "7", "EOCT")),
      sgp.baseline.grade.sequences=list(c("6", "7", "EOCT")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = rep("ELA", 2),
      sgp.projection.baseline.panel.years=c("2018", "2019"),
      sgp.projection.baseline.grade.sequences=list(c("6", "7")),
      sgp.projection.sequence="ELA_GRADE_7"),

    ELA.2019 = list( # Not canonical
      sgp.content.areas=c("ELA", "ELA", "GRADE_9_LIT"),
      sgp.baseline.content.areas=c("ELA", "ELA", "GRADE_9_LIT"),
      sgp.panel.years=c("2016", "2017", "2019"),
      sgp.baseline.panel.years=c("2016", "2017", "2019"),
      sgp.grade.sequences=list(c("7", "8", "EOCT")),
      sgp.baseline.grade.sequences=list(c("7", "8", "EOCT")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = rep("ELA", 2),
      sgp.projection.baseline.panel.years=c("2018", "2019"),
      sgp.projection.baseline.grade.sequences=list(c("7", "8")),
      sgp.projection.sequence="ELA_GRADE_8")
)

GRADE_9_LIT_2019.config <- list(
    GRADE_9_LIT.2019 = list(
      sgp.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
      sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
      sgp.panel.years=c("2016", "2017", "2019"),
      sgp.baseline.panel.years=c("2016", "2017", "2019"),
      sgp.grade.sequences=list(c("8", "EOCT", "EOCT")),
      sgp.baseline.grade.sequences=list(c("8", "EOCT", "EOCT")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas=c("ELA", "GRADE_9_LIT"),
      sgp.projection.baseline.panel.years=c("2018", "2019"),
      sgp.projection.baseline.grade.sequences=list(c("EOCT", "EOCT")),
      sgp.projection.sequence="GRADE_9_LIT_GRADE_EOCT")
)
