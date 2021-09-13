################################################################################
###                                                                          ###
###      Configurations for LAGGED (skip-year) ELA projections in 2021       ###
###                                                                          ###
################################################################################

ELA_2021.config <- list(
   ELA.2021 = list(
      sgp.content.areas = rep("ELA", 2),
      sgp.baseline.content.areas = rep("ELA", 2),
      sgp.panel.years = c("2019", "2021"),
      sgp.baseline.panel.years = c("2019", "2021"),
      sgp.grade.sequences=list(c("3", "5")),
      sgp.baseline.grade.sequences=list(c("3", "5")),
      sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
      sgp.projection.sequence="ELA_GRADE_5"),
   ELA.2021 = list(
      sgp.content.areas = rep("ELA", 3),
      sgp.baseline.content.areas = rep("ELA", 3),
      sgp.baseline.panel.years = c("2018", "2019", "2021"),
      sgp.panel.years = c("2018", "2019", "2021"),
      sgp.grade.sequences=list(c("3", "4", "6")),
      sgp.baseline.grade.sequences=list(c("3", "4", "6")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.sequence="ELA_GRADE_6"),
   ELA.2021 = list(
      sgp.content.areas = rep("ELA", 3),
      sgp.baseline.content.areas = rep("ELA", 3),
      sgp.baseline.panel.years = c("2018", "2019", "2021"),
      sgp.panel.years = c("2018", "2019", "2021"),
      sgp.grade.sequences=list(c("4", "5", "7")),
      sgp.baseline.grade.sequences=list(c("4", "5", "7")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.sequence="ELA_GRADE_7"),
   ELA.2021 = list(
      sgp.content.areas = rep("ELA", 3),
      sgp.baseline.content.areas = rep("ELA", 3),
      sgp.baseline.panel.years = c("2018", "2019", "2021"),
      sgp.panel.years = c("2018", "2019", "2021"),
      sgp.grade.sequences=list(c("5", "6", "8")),
      sgp.baseline.grade.sequences=list(c("5", "6", "8")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.sequence="ELA_GRADE_8")
)


###   American Lit
AMERICAN_LIT_2021.config <- list(
  AMERICAN_LIT.2021 = list( # 13 (No change - gap included in original)
    sgp.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.baseline.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.baseline.panel.years = c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c(8, "EOCT", "EOCT")),
    sgp.baseline.grade.sequences=list(c(8, "EOCT", "EOCT")),
    sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.projection.sequence="AMERICAN_LIT_GRADE_EOCT")
)
