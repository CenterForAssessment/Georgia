###############################################################################
###                                                                         ###
###           Georgia 2019 consecutive-year BASELINE SGP analyses           ###
###               NOTE: Doing this in 2022 thus the file name               ###
###                                                                         ###
###############################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load data
load("Data/Georgia_SGP.Rdata")

###   Add Baseline matrices to SGPstateData
load("Data/GA_Baseline_Matrices.Rdata")
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <-
  GA_Baseline_Matrices

###   Rename the skip-year SGP variables and objects

##    We can simply rename the BASELINE variables. We only have 2019/21 skip yr
# table(Georgia_SGP@Data[!is.na(SGP_BASELINE),
#         .(CONTENT_AREA, YEAR), GRADE], exclude = NULL)
baseline.names <- grep("BASELINE", names(Georgia_SGP@Data), value = TRUE)
setnames(Georgia_SGP@Data,
         baseline.names,
         paste0(baseline.names, "_SKIP_YEAR")
)
sgps.2019 <- grep(".2019.BASELINE", names(Georgia_SGP@SGP[["SGPercentiles"]]))
names(Georgia_SGP@SGP[["SGPercentiles"]])[sgps.2019] <-
    gsub(".2019.BASELINE",
         ".2019.SKIP_YEAR_BASELINE",
         names(Georgia_SGP@SGP[["SGPercentiles"]])[sgps.2019]
    )


##   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2022/PART_A/ELA.R")
source("SGP_CONFIG/2022/PART_A/MATHEMATICS.R")

GA_Baseline_Config_2019 <-
  c(
    ELA_2019.config,
    MATHEMATICS_2019.config
  )


####
##   Run abcSGP analysis
####

Georgia_SGP <-
    abcSGP(
        sgp_object = Georgia_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        years = "2019",
        sgp.config = GA_Baseline_Config_2019,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = FALSE,
        sgp.projections.lagged.baseline = FALSE,
        calculate.simex = TRUE,
        calculate.simex.baseline = list(
            csem.data.vnames = "SCALE_SCORE_CSEM", lambda=seq(0, 2, 0.5),
            simulation.iterations = 75, simex.sample.size = 10000,
            extrapolation = "linear", simex.use.my.coefficient.matrices = TRUE,
            save.matrices = FALSE, use.cohort.for.ranking = FALSE),
        simulate.sgps = FALSE,
        save.intermediate.results = FALSE,
        outputSGP.output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data"),
        parallel.config = list(
          BACKEND = "PARALLEL",
          WORKERS=list(SIMEX = 25))
)

##   Save results
save(Georgia_SGP, file = "./Data/Georgia_SGP.Rdata")
