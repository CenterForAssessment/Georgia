###
### Configurations for calculating STRAIGHT PROJECTIONS in 2019
###

MATHEMATICS_2019.config <- list(
    MATHEMATICS.2019 = list(
        sgp.content.areas=c("MATHEMATICS", "MATHEMATICS"),
        sgp.baseline.content.areas=c("MATHEMATICS", "MATHEMATICS"),
        sgp.panel.years=c("2017", "2019"),
        sgp.baseline.panel.years=c("2017", "2019"),
        sgp.grade.sequences=list(c("3", "5")),
        sgp.baseline.grade.sequences=list(c("3", "5")),
        sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
        sgp.projection.baseline.content.areas=c("MATHEMATICS"),
        sgp.projection.baseline.panel.years=c("2019"),
        sgp.projection.baseline.grade.sequences=list(c("3")),
        sgp.projection.sequence="MATHEMATICS_GRADE_3"),
    MATHEMATICS.2019 = list(
        sgp.content.areas = rep("MATHEMATICS", 3),
        sgp.baseline.content.areas = rep("MATHEMATICS", 3),
        sgp.panel.years = c("2016", "2017", "2019"),
        sgp.baseline.panel.years = c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("3", "4", "6")),
        sgp.baseline.grade.sequences=list(c("3", "4", "6")),
        sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
        sgp.projection.baseline.content.areas = rep("MATHEMATICS", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("3", "4")),
        sgp.projection.sequence="MATHEMATICS_GRADE_4"),
    MATHEMATICS.2019 = list(
        sgp.content.areas = rep("MATHEMATICS", 3),
        sgp.baseline.content.areas = rep("MATHEMATICS", 3),
        sgp.panel.years = c("2016", "2017", "2019"),
        sgp.baseline.panel.years = c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("4", "5", "7")),
        sgp.baseline.grade.sequences=list(c("4", "5", "7")),
        sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
        sgp.projection.baseline.content.areas = rep("MATHEMATICS", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("4", "5")),
        sgp.projection.sequence="MATHEMATICS_GRADE_5"),
    MATHEMATICS.2019 = list(
        sgp.content.areas = rep("MATHEMATICS", 3),
        sgp.baseline.content.areas = rep("MATHEMATICS", 3),
        sgp.panel.years = c("2016", "2017", "2019"),
        sgp.baseline.panel.years = c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("5", "6", "8")),
        sgp.baseline.grade.sequences=list(c("5", "6", "8")),
        sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
        sgp.projection.baseline.content.areas = rep("MATHEMATICS", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("5", "6")),
        sgp.projection.sequence="MATHEMATICS_GRADE_6"),
    MATHEMATICS.2019 = list(#33 -- skip year  --  Came online in 2016  --  Not enough DATA for two priors
        sgp.content.areas = c(rep("MATHEMATICS", 2), "ALGEBRA_I"),
        sgp.baseline.content.areas = c(rep("MATHEMATICS", 2), "ALGEBRA_I"),
        sgp.panel.years = c("2016", "2017", "2019"),
        sgp.baseline.panel.years = c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("6", "7", "EOCT")),
        sgp.baseline.grade.sequences=list(c("6", "7", "EOCT")),
        sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
        sgp.projection.baseline.content.areas = rep("MATHEMATICS", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("6", "7")),
        sgp.projection.sequence="MATH_ALG1_GRADE_7"),
    MATHEMATICS.2019 = list(
        sgp.content.areas = c(rep("MATHEMATICS", 2), "COORDINATE_ALGEBRA"),
        sgp.baseline.content.areas = c(rep("MATHEMATICS", 2), "COORDINATE_ALGEBRA"),
        sgp.panel.years = c("2016", "2017", "2019"),
        sgp.baseline.panel.years = c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("6", "7", "EOCT")),
        sgp.baseline.grade.sequences=list(c("6", "7", "EOCT")),
        sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
        sgp.projection.baseline.content.areas = rep("MATHEMATICS", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("6", "7")),
        sgp.projection.sequence="MATH_COORD_ALG_GRADE_7"),
    MATHEMATICS.2019 = list( # dup 1
        sgp.content.areas = c(rep("MATHEMATICS", 2), "GEOMETRY"),
        sgp.baseline.content.areas = c(rep("MATHEMATICS", 2), "GEOMETRY"),
        sgp.panel.years = c("2016", "2017", "2019"),
        sgp.baseline.panel.years = c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("7", "8", "EOCT")),
        sgp.baseline.grade.sequences=list(c("7", "8", "EOCT")),
        sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
        sgp.projection.baseline.content.areas = rep("MATHEMATICS", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("7", "8")),
        sgp.projection.sequence="MATH_GEOM_GRADE_8"),
    MATHEMATICS.2019 = list(
        sgp.content.areas = c(rep("MATHEMATICS", 2), "ANALYTIC_GEOMETRY"),
        sgp.baseline.content.areas = c(rep("MATHEMATICS", 2), "ANALYTIC_GEOMETRY"),
        sgp.panel.years = c("2016", "2017", "2019"),
        sgp.baseline.panel.years = c("2016", "2017", "2019"),
        sgp.grade.sequences=list(c("7", "8", "EOCT")),
        sgp.baseline.grade.sequences=list(c("7", "8", "EOCT")),
        sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
        sgp.projection.baseline.content.areas = rep("MATHEMATICS", 2),
        sgp.projection.baseline.panel.years=c("2018", "2019"),
        sgp.projection.baseline.grade.sequences=list(c("7", "8")),
        sgp.projection.sequence="MATH_ANYLTC_GEOM_GRADE_8")
)


ALGEBRA_I_2019.config <- list(
  ALGEBRA_I.2019 = list(
       sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
       sgp.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
       sgp.panel.years=c("2016", "2017", "2019"),
       sgp.baseline.panel.years=c("2016", "2017", "2019"),
       sgp.grade.sequences=list(c("8", "EOCT", "EOCT")),
       sgp.baseline.grade.sequences=list(c("8", "EOCT", "EOCT")),
       sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
       sgp.projection.baseline.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
       sgp.projection.baseline.panel.years=c("2018", "2019"),
       sgp.projection.baseline.grade.sequences=list(c("8", "EOCT")),
       sgp.projection.sequence="ALGEBRA_I_GRADE_EOCT")
)

COORDINATE_ALGEBRA_2019.config <- list(
  COORDINATE_ALGEBRA.2019 = list(
       sgp.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"),
       sgp.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"),
       sgp.panel.years=c("2016", "2017", "2019"),
       sgp.baseline.panel.years=c("2016", "2017", "2019"),
       sgp.grade.sequences=list(c("8", "EOCT", "EOCT")),
       sgp.baseline.grade.sequences=list(c("8", "EOCT", "EOCT")),
       sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
       sgp.projection.baseline.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
       sgp.projection.baseline.panel.years=c("2018", "2019"),
       sgp.projection.baseline.grade.sequences=list(c("8", "EOCT")),
       sgp.projection.sequence="COORDINATE_ALGEBRA_GRADE_EOCT")
)
