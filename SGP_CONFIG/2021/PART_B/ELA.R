################################################################################
###                                                                          ###
###     Configurations for STRAIGHT (skip-year) ELA projections in 2021      ###
###                                                                          ###
################################################################################

ELA_2021.config <- list(
    ELA.2021 = list(
      sgp.content.areas=c("ELA", "ELA"),
      sgp.baseline.content.areas=c("ELA", "ELA"),
      sgp.panel.years=c("2020", "2021"),
      sgp.baseline.panel.years=c("2020", "2021"),
      sgp.grade.sequences=list(c("3", "4")),
      sgp.baseline.grade.sequences=list(c("3", "4")),
      sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = c("ELA"),
      sgp.projection.baseline.panel.years = c("2021"),
      sgp.projection.baseline.grade.sequences=list(c("3")),
      sgp.projection.sequence="ELA_GRADE_3"),
    ELA.2021 = list(
      sgp.content.areas=rep("ELA", 2),
      sgp.baseline.content.areas=rep("ELA", 2),
      sgp.panel.years=c("2020", "2021"),
      sgp.baseline.panel.years=c("2020", "2021"),
      sgp.grade.sequences=list(c("4", "5")),
      sgp.baseline.grade.sequences=list(c("4", "5")),
      sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = c("ELA"),
      sgp.projection.baseline.panel.years = c("2021"),
      sgp.projection.baseline.grade.sequences=list(c("4")),
      sgp.projection.sequence="ELA_GRADE_4"),
    ELA.2021 = list(
      sgp.content.areas=rep("ELA", 2),
      sgp.baseline.content.areas=rep("ELA", 2),
      sgp.panel.years=c("2020", "2021"),
      sgp.baseline.panel.years=c("2020", "2021"),
      sgp.grade.sequences=list(c("5", "6")),
      sgp.baseline.grade.sequences=list(c("5", "6")),
      sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = c("ELA"),
      sgp.projection.baseline.panel.years = c("2021"),
      sgp.projection.baseline.grade.sequences=list(c("5")),
      sgp.projection.sequence="ELA_GRADE_5"),
    ELA.2021 = list(
      sgp.content.areas=rep("ELA", 2),
      sgp.baseline.content.areas=rep("ELA", 2),
      sgp.panel.years=c("2020", "2021"),
      sgp.baseline.panel.years=c("2020", "2021"),
      sgp.grade.sequences=list(c("6", "7")),
      sgp.baseline.grade.sequences=list(c("6", "7")),
      sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = c("ELA"),
      sgp.projection.baseline.panel.years = c("2021"),
      sgp.projection.baseline.grade.sequences=list(c("6")),
      sgp.projection.sequence="ELA_GRADE_6"),
    ELA.2021 = list(
      sgp.content.areas=rep("ELA", 2),
      sgp.baseline.content.areas=rep("ELA", 2),
      sgp.panel.years=c("2020", "2021"),
      sgp.baseline.panel.years=c("2020", "2021"),
      sgp.grade.sequences=list(c("7", "8")),
      sgp.baseline.grade.sequences=list(c("7", "8")),
      sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
      sgp.projection.baseline.content.areas = c("ELA"),
      sgp.projection.baseline.panel.years = c("2021"),
      sgp.projection.baseline.grade.sequences=list(c("7")),
      sgp.projection.sequence="ELA_GRADE_7")
)
