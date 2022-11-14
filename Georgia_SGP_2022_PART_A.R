#########################################################################################
###                                                                                   ###
###          Georgia 2018-2019 consecutive-year BASELINE SGP analyses                 ###
###          NOTE: Doing this in 2021-2022 thus the file name                         ###
###                                                                                   ###
#########################################################################################

###   Load packages
require(SGP)
require(data.table)
require(SGPmatrices)

###   Load data
load("Data/Georgia_SGP.Rdata")

###   Add Baseline matrices to SGPstateData
load("Data/GA_Baseline_Matrices.Rdata")
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- GA_Baseline_Matrices
SGPstateData[["GA"]][["Assessment_Program_Information"]][["CSEM"]] <- NULL

###   Rename the skip-year SGP variables and objects

##    We can simply rename the BASELINE variables. We only have 2019/21 skip yr
# table(Georgia_SGP@Data[!is.na(SGP_BASELINE),
#         .(CONTENT_AREA, YEAR), GRADE], exclude = NULL)
baseline.names <- grep("BASELINE", names(Georgia_SGP@Data), value = TRUE)
setnames(Georgia_SGP@Data,
         baseline.names,
         paste0(baseline.names, "_SKIP_YEAR"))

sgps.2019 <- grep(".2019.BASELINE", names(Georgia_SGP@SGP[["SGPercentiles"]]))
names(Georgia_SGP@SGP[["SGPercentiles"]])[sgps.2019] <-
    gsub(".2019.BASELINE",
         ".2019.SKIP_YEAR_BASELINE",
         names(Georgia_SGP@SGP[["SGPercentiles"]])[sgps.2019])


###   Read in SGP Configuration Scripts and Combine
#source("SGP_CONFIG/2021_2022/PART_A/ELA.R")
#source("SGP_CONFIG/2021_2022/PART_A/MATHEMATICS.R")

#GA_Baseline_Config_2019 <- c(
#  ELA.2019.config,
#  MATHEMATICS.2019.config
#)

###   Parallel Config
#parallel.config <- list(BACKEND = "PARALLEL",
#                        WORKERS = list(BASELINE_PERCENTILES = 8))


#####
###   Run abcSGP analysis
#####

#Georgia_SGP <-
#    abcSGP(sgp_object = Georgia_SGP,
#           years = "2019",
#           steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
#           sgp.config = GA_Baseline_Config_2019,
#           sgp.percentiles = FALSE,
#           sgp.projections = FALSE,
#           sgp.projections.lagged = FALSE,
#           sgp.percentiles.baseline = TRUE,
#           sgp.projections.baseline = FALSE,
#           sgp.projections.lagged.baseline = FALSE,
#           simulate.sgps = FALSE,
#           parallel.config = parallel.config)

###   Save results
#save(Georgia_SGP, file = "Data/Georgia_SGP.Rdata")
