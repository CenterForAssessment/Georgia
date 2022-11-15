################################################################################
###                                                                          ###
###         Math SGP Configurations for 2021 Learning Loss Analyses          ###
###                                                                          ###
################################################################################

### GRADE-LEVEL MATHEMATICS

MATHEMATICS_2021.config <- list(
  MATHEMATICS.2021 = list(
    sgp.content.areas=rep("MATHEMATICS", 3),
    sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c("3", "5"), c("3", "4", "6"), c("4", "5", "7"), c("5", "6", "8")),
    sgp.projection.sequence = c("MATH_ALG_I", "MATH_COORD_ALG", "G7_MATH_EOC")))


### Coordinate Algebra

COORDINATE_ALGEBRA_2021.config <- list(
  COORDINATE_ALGEBRA.2021 = list( #  --  (No change - gap included in original)
    sgp.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.panel.years=c("2018", "2021"),
    sgp.grade.sequences=list(c(8, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = "VALID_CASE", CONTENT_AREA=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
                                       YEAR=c("2019", "2019"), GRADE=c("8", "EOCT")),
    sgp.norm.group.preference=999),

  COORDINATE_ALGEBRA.2021 = list( #18 (No change - gap included in original)
    sgp.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.panel.years=c("2019", "2021"),
    sgp.grade.sequences=list(c(8, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=6),
  COORDINATE_ALGEBRA.2021 = list( #19 (No change - gap included in original)
    sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c(7, 8, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=5),

  COORDINATE_ALGEBRA.2021 = list( #20
    sgp.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.panel.years=c("2019", "2021"),
    sgp.grade.sequences=list(c(7, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS", # NEW CANONICAL skip 8th
    sgp.norm.group.preference=4),

  COORDINATE_ALGEBRA.2021 = list( #21
    sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c(6, 7, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # NEW CANONICAL skip 8th
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=3),

  COORDINATE_ALGEBRA.2021 = list( #22
    sgp.content.areas=c("MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.panel.years=c("2019", "2021"),
    sgp.grade.sequences=list(c(6, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),

  COORDINATE_ALGEBRA.2021 = list( #23
    sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "COORDINATE_ALGEBRA"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c(5, 6, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=1),

  COORDINATE_ALGEBRA.2021 = list( #  --  <1500 :: Include for SGP_NOTE/BASELINE
    sgp.content.areas=c("COORDINATE_ALGEBRA", "COORDINATE_ALGEBRA"),
    sgp.panel.years=c("2021", "2021"),
    sgp.grade.sequences=list(c("EOCT", "EOCT")),
    sgp.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)
) ### END COORDINATE_ALGEBRA_2021.config


### Algebra I

ALGEBRA_I_2021.config <- list(
  ALGEBRA_I.2021 = list( #29 (No change - gap included in original)
    sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.panel.years=c("2018", "2021"),
    sgp.grade.sequences=list(c("8", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(VALID_CASE = "VALID_CASE", CONTENT_AREA=c("MATHEMATICS", "ALGEBRA_I"),
                                       YEAR=c("2019", "2019"), GRADE=c("8", "EOCT")),
    sgp.norm.group.preference=7),

  ALGEBRA_I.2021 = list( #30 (No change - gap included in original)
    sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.panel.years=c("2019", "2021"),
    sgp.grade.sequences=list(c("8", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=6),

  ALGEBRA_I.2021 = list( #31 (No change - gap included in original)
    sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c("7", "8", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS", # CANONICAL
    sgp.norm.group.preference=5),

  ALGEBRA_I.2021 = list( #35a
    sgp.content.areas=c("MATHEMATICS", "ALGEBRA_I"),
    sgp.panel.years=c("2019", "2021"),
    sgp.grade.sequences=list(c("7", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS", #  NEW CANONICAL
    sgp.norm.group.preference=4),
  ALGEBRA_I.2021 = list( #35b
    sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c("6", "7", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", #  NEW CANONICAL
    sgp.norm.group.preference=3),

  ALGEBRA_I.2021 = list( # NEW
    sgp.content.areas=c("MATHEMATICS", "MATHEMATICS", "ALGEBRA_I"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c("5", "6", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    # sgp.projection.sequence = "G7_MATH_EOC",  #  NEW Advanced
    sgp.norm.group.preference=2),

  ALGEBRA_I.2021 = list( #38a #  --  <1500 :: Include for SGP_NOTE
    sgp.content.areas=c("ALGEBRA_I", "ALGEBRA_I"),
    sgp.panel.years=c("2019", "2021"),
    sgp.grade.sequences=list(c("EOCT", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1),
  ALGEBRA_I.2021 = list( #37
    sgp.content.areas=c("ALGEBRA_I", "ALGEBRA_I"),
    sgp.panel.years=c("2021", "2021"),
    sgp.grade.sequences=list(c("EOCT", "EOCT")),
    sgp.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)
) ### END ALGEBRA_I_2021.config
