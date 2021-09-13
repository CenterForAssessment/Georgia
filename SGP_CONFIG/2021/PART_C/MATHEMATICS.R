################################################################################
###                                                                          ###
###      Configurations for LAGGED (skip-year) MATH projections in 2021      ###
###                                                                          ###
################################################################################

MATHEMATICS_2021.config <- list(
   MATHEMATICS.2021 = list(
      sgp.content.areas = rep("MATHEMATICS", 2),
      sgp.baseline.content.areas = rep("MATHEMATICS", 2),
      sgp.panel.years = c("2019", "2021"),
      sgp.baseline.panel.years = c("2019", "2021"),
      sgp.grade.sequences=list(c("3", "5")),
      sgp.baseline.grade.sequences=list(c("3", "5")),
      sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
      sgp.projection.sequence="MATHEMATICS_GRADE_5"),
   MATHEMATICS.2021 = list(
      sgp.content.areas = rep("MATHEMATICS", 3),
      sgp.baseline.content.areas = rep("MATHEMATICS", 3),
      sgp.baseline.panel.years = c("2018", "2019", "2021"),
      sgp.panel.years = c("2018", "2019", "2021"),
      sgp.grade.sequences=list(c("3", "4", "6")),
      sgp.baseline.grade.sequences=list(c("3", "4", "6")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.sequence="MATHEMATICS_GRADE_6"),
   MATHEMATICS.2021 = list(
      sgp.content.areas = rep("MATHEMATICS", 3),
      sgp.baseline.content.areas = rep("MATHEMATICS", 3),
      sgp.baseline.panel.years = c("2018", "2019", "2021"),
      sgp.panel.years = c("2018", "2019", "2021"),
      sgp.grade.sequences=list(c("4", "5", "7")),
      sgp.baseline.grade.sequences=list(c("4", "5", "7")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.sequence="MATHEMATICS_GRADE_7"),
   MATHEMATICS.2021 = list(
      sgp.content.areas = rep("MATHEMATICS", 3),
      sgp.baseline.content.areas = rep("MATHEMATICS", 3),
      sgp.baseline.panel.years = c("2018", "2019", "2021"),
      sgp.panel.years = c("2018", "2019", "2021"),
      sgp.grade.sequences=list(c("5", "6", "8")),
      sgp.baseline.grade.sequences=list(c("5", "6", "8")),
      sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
      sgp.projection.sequence="MATHEMATICS_GRADE_8")
)

ALGEBRA_I_2021.config <- list(
   ALGEBRA_I.2021 = list(
     sgp.content.areas = c(rep("MATHEMATICS", 2), "ALGEBRA_I"),
     sgp.panel.years = c("2018", "2019", "2021"),
     sgp.grade.sequences=list(c("6", "7", "EOCT")),
     sgp.baseline.content.areas = c(rep("MATHEMATICS", 2), "ALGEBRA_I"),
     sgp.baseline.panel.years = c("2018", "2019", "2021"),
     sgp.baseline.grade.sequences=list(c("6", "7", "EOCT")),
     sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
     sgp.projection.sequence="ALGEBRA_I_GRADE_EOCT")
)


COORDINATE_ALGEBRA_2021.config <- list(
   COORDINATE_ALGEBRA_I.2021 = list(
     sgp.content.areas = c(rep("MATHEMATICS", 2), "COORDINATE_ALGEBRA"),
     sgp.panel.years = c("2018", "2019", "2021"),
     sgp.grade.sequences=list(c("6", "7", "EOCT")),
     sgp.baseline.content.areas = c(rep("MATHEMATICS", 2), "COORDINATE_ALGEBRA"),
     sgp.baseline.panel.years = c("2018", "2019", "2021"),
     sgp.baseline.grade.sequences=list(c("6", "7", "EOCT")),
     sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
     sgp.projection.sequence="COORDINATE_ALGEBRA_GRADE_EOCT")
)
