################################################################################
###                                                                          ###
###       SGPstateData grade specific (skip-year) projection sequences       ###
###                                                                          ###
################################################################################

###  Only want 1 year projections for 2021 "Fair Trend" metric
SGPstateData[["GA"]][["SGP_Configuration"]][['sgp.projections.max.forward.progression.years']] <- 1
SGPstateData[["GA"]][['SGP_Configuration']][['max.sgp.target.years.forward']] <- 1

###   Set Skip_Year_Projections to TRUE (non-NULL) to allow for skip year
SGPstateData[["GA"]][["SGP_Configuration"]][["Skip_Year_Projections"]] <- TRUE

###   Establish required meta-data for STRAIGHT projection sequences
SGPstateData[["GA"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
    ELA_GRADE_3 = c(3, 5),
    ELA_GRADE_4 = c(3, 4, 6),
    ELA_GRADE_5 = c(3, 4, 5, 7),
    ELA_GRADE_6 = c(3, 4, 5, 6, 8),
    ELA_GRADE_7 = c(3, 4, 5, 6, 7, "EOCT"),
    ELA_GRADE_8 = c(3, 4, 5, 6, 7, 8, "EOCT"), # (!) Not CANONICAL!
    GRADE_9_LIT_GRADE_EOCT = c(8, "EOCT", "EOCT"),
    MATHEMATICS_GRADE_3 = c(3, 5),
    MATHEMATICS_GRADE_4 = c(3, 4, 6),
    MATHEMATICS_GRADE_5 = c(3, 4, 5, 7),
    MATHEMATICS_GRADE_6 = c(3, 4, 5, 6, 8),
    MATH_ALG1_GRADE_7 = c(6, 7, "EOCT"),
    MATH_COORD_ALG_GRADE_7 = c(6, 7, "EOCT"),
    MATH_GEOM_GRADE_8 = c(7, 8, "EOCT"),
    MATH_ANYLTC_GEOM_GRADE_8=c(7, 8, "EOCT"),
    ALGEBRA_I_GRADE_EOCT = c(8, "EOCT", "EOCT"),
    COORDINATE_ALGEBRA_GRADE_EOCT = c(8, "EOCT", "EOCT"))
SGPstateData[["GA"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
    ELA_GRADE_3 = rep("ELA", 2),
    ELA_GRADE_4 = rep("ELA", 3),
    ELA_GRADE_5 = rep("ELA", 4),
    ELA_GRADE_6 = rep("ELA", 5),
    ELA_GRADE_7 = c(rep("ELA", 5), "GRADE_9_LIT"),
    ELA_GRADE_8 = c(rep("ELA", 6), "AMERICAN_LIT"), # (!) Not CANONICAL!
    GRADE_9_LIT_GRADE_EOCT = c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
    MATHEMATICS_GRADE_3 = rep("MATHEMATICS", 2),
    MATHEMATICS_GRADE_4 = rep("MATHEMATICS", 3),
    MATHEMATICS_GRADE_5 = rep("MATHEMATICS", 4),
    MATHEMATICS_GRADE_6 = rep("MATHEMATICS", 5),
    MATH_ALG1_GRADE_7 = c(rep("MATHEMATICS", 2), "ALGEBRA_I"),
    MATH_COORD_ALG_GRADE_7 = c(rep("MATHEMATICS", 2), "COORDINATE_ALGEBRA"),
    MATH_GEOM_GRADE_8 = c(rep("MATHEMATICS", 2), "GEOMETRY"),
    MATH_ANYLTC_GEOM_GRADE_8=c(rep("MATHEMATICS", 2), "ANALYTIC_GEOMETRY"),
    ALGEBRA_I_GRADE_EOCT = c("MATHEMATICS", "ALGEBRA_I", "GEOMETRY"),
    COORDINATE_ALGEBRA_GRADE_EOCT = c("MATHEMATICS", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY"))
SGPstateData[["GA"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
    ELA_GRADE_3 = 1,
    ELA_GRADE_4 = 1,
    ELA_GRADE_5 = 1,
    ELA_GRADE_6 = 1,
    ELA_GRADE_7 = 1,
    ELA_GRADE_8 = 1,
    GRADE_9_LIT_GRADE_EOCT = 1,
    MATHEMATICS_GRADE_3 = 1,
    MATHEMATICS_GRADE_4 = 1,
    MATHEMATICS_GRADE_5 = 1,
    MATHEMATICS_GRADE_6 = 1,
    MATH_ALG1_GRADE_7 = 1,
    MATH_COORD_ALG_GRADE_7 = 1,
    MATH_GEOM_GRADE_8 = 1,
    MATH_ANYLTC_GEOM_GRADE_8=1,
    ALGEBRA_I_GRADE_EOCT = 1,
    COORDINATE_ALGEBRA_GRADE_EOCT = 1)

SGPstateData[["GA"]][["SGP_Configuration"]][["year_lags.projection.sequence"]] <- list(
    ELA_GRADE_3 = 2,
    ELA_GRADE_4 = c(1, 2),
    ELA_GRADE_5 = c(1, 1, 2),
    ELA_GRADE_6 = c(1, 1, 1, 2),
    ELA_GRADE_7 = c(1, 1, 1, 1, 2),
    ELA_GRADE_8 = c(1, 1, 1, 1, 1, 2),
    GRADE_9_LIT_GRADE_EOCT = c(1, 2),
    MATHEMATICS_GRADE_3 = 2,
    MATHEMATICS_GRADE_4 = c(1, 2),
    MATHEMATICS_GRADE_5 = c(1, 1, 2),
    MATHEMATICS_GRADE_6 = c(1, 1, 1, 2),
    MATH_ALG1_GRADE_7 = c(1, 2),
    MATH_COORD_ALG_GRADE_7 = c(1, 2),
    MATH_GEOM_GRADE_8 = c(1, 2),
    MATH_ANYLTC_GEOM_GRADE_8=c(1, 2),
    ALGEBRA_I_GRADE_EOCT = c(1, 2),
    COORDINATE_ALGEBRA_GRADE_EOCT = c(1, 2))
