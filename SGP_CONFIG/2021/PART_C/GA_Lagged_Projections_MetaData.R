################################################################################
###                                                                          ###
###   SGPstateData grade specific skip-year (LAGGED) projection sequences    ###
###                                                                          ###
################################################################################

###   Establish required meta-data for LAGGED projection sequences
SGPstateData[["GA"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"

SGPstateData[["GA"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
      ELA_GRADE_3 = c(3, 4, 5, 6, 7, 8),
      ELA_GRADE_4 = c(3, 4, 5, 6, 7, 8),
      ELA_GRADE_5 = c(3, 5, 6, 7, 8),
      ELA_GRADE_6 = c(3, 4, 6, 7, 8),
      ELA_GRADE_7 = c(3, 4, 5, 7, 8),
      ELA_GRADE_8 = c(3, 4, 5, 6, 8),
      AMERICAN_LIT_GRADE_EOCT= c(8, "EOCT", "EOCT"),
      MATHEMATICS_GRADE_3 = c(3, 4, 5, 6, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_4 = c(3, 4, 5, 6, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_5 = c(3, 5, 6, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_6 = c(3, 4, 6, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_7 = c(3, 4, 5, 7, 8, "EOCT"),
      MATHEMATICS_GRADE_8 = c(3, 4, 5, 6, 8, "EOCT"),
      ALGEBRA_I_GRADE_EOCT= c(3, 4, 5, 6, 7, "EOCT"),
      COORDINATE_ALGEBRA_GRADE_EOCT=c(3, 4, 5, 6, 7, "EOCT"))

SGPstateData[["GA"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
      ELA_GRADE_3 = rep("ELA", 6),
      ELA_GRADE_4 = rep("ELA", 6),
      ELA_GRADE_5 = rep("ELA", 5),
      ELA_GRADE_6 = rep("ELA", 5),
      ELA_GRADE_7 = rep("ELA", 5),
      ELA_GRADE_8 = rep("ELA", 5),
      AMERICAN_LIT_GRADE_EOCT= c("ELA", "GRADE_9_LIT", "AMERICAN_LIT"),
      MATHEMATICS_GRADE_3 = c(rep("MATHEMATICS", 6), "ALGEBRA_I"),
      MATHEMATICS_GRADE_4 = c(rep("MATHEMATICS", 6), "ALGEBRA_I"),
      MATHEMATICS_GRADE_5 = c(rep("MATHEMATICS", 5), "ALGEBRA_I"),
      MATHEMATICS_GRADE_6 = c(rep("MATHEMATICS", 5), "ALGEBRA_I"),
      MATHEMATICS_GRADE_7 = c(rep("MATHEMATICS", 5), "ALGEBRA_I"),
      MATHEMATICS_GRADE_8 = c(rep("MATHEMATICS", 5), "ALGEBRA_I"),
      ALGEBRA_I_GRADE_EOCT= c(rep("MATHEMATICS", 5), "ALGEBRA_I"),
      COORDINATE_ALGEBRA_GRADE_EOCT=c(rep("MATHEMATICS", 5), "COORDINATE_ALGEBRA"))

SGPstateData[["GA"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
      ELA_GRADE_3 = 3,
      ELA_GRADE_4 = 3,
      ELA_GRADE_5 = 3,
      ELA_GRADE_6 = 3,
      ELA_GRADE_7 = 3,
      ELA_GRADE_8 = 3,
      AMERICAN_LIT_GRADE_EOCT = 3,
      MATHEMATICS_GRADE_3 = 3,
      MATHEMATICS_GRADE_4 = 3,
      MATHEMATICS_GRADE_5 = 3,
      MATHEMATICS_GRADE_6 = 3,
      MATHEMATICS_GRADE_7 = 3,
      MATHEMATICS_GRADE_8 = 3,
      ALGEBRA_I_GRADE_EOCT= 3,
      COORDINATE_ALGEBRA_GRADE_EOCT=3)

SGPstateData[["GA"]][["SGP_Configuration"]][["year_lags.projection.sequence"]] <- list(
      AMERICAN_LIT_GRADE_EOCT= c(1, 2),
      MATHEMATICS_GRADE_3 = rep(1, 6),
      MATHEMATICS_GRADE_4 = rep(1, 6),
      MATHEMATICS_GRADE_5 = c(2, 1, 1, 1, 1),
      MATHEMATICS_GRADE_6 = c(1, 2, 1, 1, 1),
      MATHEMATICS_GRADE_7 = c(1, 1, 2, 1, 1),
      MATHEMATICS_GRADE_8 = c(1, 1, 1, 2, 1),
      ALGEBRA_I_GRADE_EOCT= c(1, 1, 1, 1, 2),
      COORDINATE_ALGEBRA_GRADE_EOCT=c(1, 1, 1, 1, 2))
