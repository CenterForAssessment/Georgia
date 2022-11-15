###############################################################################
###                                                                         ###
###      Spring 2019 MATHEMATICS consecutive-year baseline SGP configs      ###
###                                                                         ###
###############################################################################

### GRADE-LEVEL MATHEMATICS

MATHEMATICS_2019.config <- list(
    MATHEMATICS.2019 = list(
        sgp.content.areas = rep("MATHEMATICS", 3),
        sgp.panel.years = c("2017", "2018", "2019"),
        sgp.panel.years.within =
            c(rep("LAST_OBSERVATION", 2), "FIRST_OBSERVATION"),
        sgp.grade.sequences = list(
            c("3", "4"), c("3", "4", "5"),
            c("4", "5", "6"), c("5", "6", "7"), c("6", "7", "8")
        )
    )
)
