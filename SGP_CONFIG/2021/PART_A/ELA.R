################################################################################
###                                                                          ###
###          ELA SGP Configurations for 2021 Learning Loss Analyses          ###
###                                                                          ###
################################################################################


ELA_2021.config <- list(
  ELA.2021 = list(
    sgp.content.areas=c("ELA", "ELA", "ELA"),
    sgp.panel.years.within=c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c("3", "5"), c("3", "4", "6"), c("4", "5", "7"), c("5", "6", "8")))
)

### AMERICAN_LIT

AMERICAN_LIT_2021.config <- list(
  AMERICAN_LIT.2021 = list( #  --  <1500 :: Skip Year
    sgp.content.areas=c("ELA", "AMERICAN_LIT"),
    sgp.panel.years=c("2019", "2021"),
    sgp.grade.sequences=list(c(7, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=999),

  AMERICAN_LIT.2021 = list( # 10 (No change - gap included in original)
    sgp.content.areas=c("GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.panel.years=c("2018", "2021"),
    sgp.grade.sequences=list(c("EOCT", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exclude.sequences = data.table(VALID_CASE = "VALID_CASE", CONTENT_AREA=c("GRADE_9_LIT", "AMERICAN_LIT"),
                                       YEAR=c("2019", "2019"), GRADE=c("EOCT", "EOCT")),  # , "2018", "2018" not needed (wouldn"t know, in theory, if existed)
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=7),

  AMERICAN_LIT.2021 = list( # 11 (No change - gap included in original)
    sgp.content.areas=c("GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.panel.years=c("2019", "2021"),
    sgp.grade.sequences=list(c("EOCT", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    # sgp.projection.grade.sequences="NO_PROJECTIONS",  #
    sgp.norm.group.preference=6),

  AMERICAN_LIT.2021 = list( # 12 (No change - gap included in original)
    sgp.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c(7, "EOCT", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=5),

  AMERICAN_LIT.2021 = list( # 13 (No change - gap included in original)
    sgp.content.areas=c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c(8, "EOCT", "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exact.grade.progression=TRUE,
    # sgp.projection.grade.sequences="NO_PROJECTIONS", # New CANONICAL
    sgp.norm.group.preference=4),

  AMERICAN_LIT.2021 = list( #  NEW 2 prior + 2 Year skip - skip G9 Lit
    sgp.content.areas=c("ELA", "ELA", "AMERICAN_LIT"),
    sgp.panel.years=c("2017", "2018", "2021"),
    sgp.grade.sequences=list(c(7, 8, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exclude.sequences = data.table(VALID_CASE = "VALID_CASE", CONTENT_AREA=c("GRADE_9_LIT", "AMERICAN_LIT"),
                                       YEAR=c("2019", "2019"), GRADE=c("EOCT", "EOCT")), # , "2018", "2018" not needed (wouldn"t know, in theory, if existed)
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=3),

  AMERICAN_LIT.2021 = list( # 15 - NEW 1 prior - skip G9 Lit
    sgp.content.areas=c("ELA", "AMERICAN_LIT"),
    sgp.panel.years=c("2019", "2021"),
    sgp.grade.sequences=list(c(8, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=2),
  AMERICAN_LIT.2021 = list( # 15 - NEW 2 prior - skip G9 Lit
    sgp.content.areas=c("ELA", "ELA", "AMERICAN_LIT"),
    sgp.panel.years=c("2018", "2019", "2021"),
    sgp.grade.sequences=list(c(7, 8, "EOCT")),
    sgp.panel.years.within=c("LAST_OBSERVATION", "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.exact.grade.progression=TRUE,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=1),

  AMERICAN_LIT.2021 = list( # 17
    sgp.content.areas=c("AMERICAN_LIT", "AMERICAN_LIT"),
    sgp.panel.years=c("2021", "2021"),
    sgp.grade.sequences=list(c("EOCT", "EOCT")),
    sgp.panel.years.within=c("FIRST_OBSERVATION", "LAST_OBSERVATION"),
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.norm.group.preference=0)
) ### END AMERICAN_LIT.2021.config
