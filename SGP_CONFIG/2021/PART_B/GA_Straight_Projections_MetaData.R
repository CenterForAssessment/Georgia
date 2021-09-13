################################################################################
###                                                                          ###
###  SGPstateData grade specific skip-year (STRAIGHT) projection sequences   ###
###                                                                          ###
################################################################################

###   Establish required meta-data for STRAIGHT projection sequences

SGPstateData[["GA"]][["SGP_Configuration"]][["sgp.target.scale.scores.merge"]] <- NULL

SGPstateData[["GA"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
      ELA_GRADE_3 = c(3, 4, 5, 6, 7, 8),
      ELA_GRADE_4 = c(3, 4, 5, 6, 7, 8),
      ELA_GRADE_5 = c(3, 4, 5, 6, 7, 8),
      ELA_GRADE_6 = c(3, 4, 5, 6, 7, 8),
      ELA_GRADE_7 = c(3, 4, 5, 6, 7, 8),
      MATHEMATICS_GRADE_3 = c(3, 4, 5, 6, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_4 = c(3, 4, 5, 6, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_5 = c(3, 4, 5, 6, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_6 = c(3, 4, 5, 6, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_7 = c(3, 4, 5, 6, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_8 = c(3, 4, 5, 6, 7, 8, "EOCT"))

SGPstateData[["GA"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
      ELA_GRADE_3 = rep("ELA", 6),
      ELA_GRADE_4 = rep("ELA", 6),
      ELA_GRADE_5 = rep("ELA", 6),
      ELA_GRADE_6 = rep("ELA", 6),
      ELA_GRADE_7 = rep("ELA", 6),
      MATHEMATICS_GRADE_3 = c(rep("MATHEMATICS", 6), "ALGEBRA_I"),
      MATHEMATICS_GRADE_4 = c(rep("MATHEMATICS", 6), "ALGEBRA_I"),
      MATHEMATICS_GRADE_5 = c(rep("MATHEMATICS", 6), "ALGEBRA_I"),
      MATHEMATICS_GRADE_6 = c(rep("MATHEMATICS", 6), "ALGEBRA_I"),
      MATHEMATICS_GRADE_7 = c(rep("MATHEMATICS", 6), "ALGEBRA_I"),
      MATHEMATICS_GRADE_8 = c(rep("MATHEMATICS", 6), "ALGEBRA_I"))

SGPstateData[["GA"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
      ELA_GRADE_3 = 3,
      ELA_GRADE_4 = 3,
      ELA_GRADE_5 = 3,
      ELA_GRADE_6 = 3,
      ELA_GRADE_7 = 3,
      MATHEMATICS_GRADE_3 = 3,
      MATHEMATICS_GRADE_4 = 3,
      MATHEMATICS_GRADE_5 = 3,
      MATHEMATICS_GRADE_6 = 3,
      MATHEMATICS_GRADE_7 = 3,
      MATHEMATICS_GRADE_8 = 3)
