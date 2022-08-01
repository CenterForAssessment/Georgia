################################################################################
###                                                                          ###
###             Georgia 2022 (Cohort and Baseline) SGP Analyses              ###
###               * Includes 2019 consecutive-year baselines *               ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load cleaned 2021 SGP object and 2022 LONG data
load("./Data/Georgia_SGP.Rdata")
load("./Data/Georgia_Data_LONG_2022.Rdata")

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences
##    Add Baseline matrices calculated in 2019 STEP 2A to SGPstateData
load("./Data/GA_Baseline_Matrices.Rdata")
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- GA_Baseline_Matrices


###  Might not run baselines...

#####
###   PART A -- 2019 Consecutive Year Baseline SGPs
#####

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
         ".2019.SKIP_YEAR_BLINE",
         names(Georgia_SGP@SGP[["SGPercentiles"]])[sgps.2019])


###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2022/PART_A/ELA.R")
source("SGP_CONFIG/2022/PART_A/MATHEMATICS.R")

GA_Baseline_Config_2019 <- c(
    ELA_2019.config,
    MATHEMATICS_2019.config,

    AMERICAN_LIT_2019.config,
    ALGEBRA_I_2019.config,
    COORDINATE_ALGEBRA_2019.config
)


###   Run abcSGP analysis
Georgia_SGP <-
    abcSGP(
        sgp_object = Georgia_SGP,
        years = "2019",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = GA_Baseline_Config_2019,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE,
        sgp.projections.lagged.baseline = TRUE,
        simulate.sgps = FALSE#,
        # parallel.config = parallel.config # Don't run parallel in Windows
    )

###   Save results after 2019 consecutive year analyses
save(Georgia_SGP, file = "./Data/Georgia_SGP.Rdata")


#####
###   PART B -- 2022 Cohort and Baseline SGP Analyses
#####

###   Read in BASELINE projections configuration scripts and combine
source("./SGP_CONFIG/2022/PART_B/ELA.R")
source("./SGP_CONFIG/2022/PART_B/MATHEMATICS.R")

Georgia_Config_2022 <- c(
    ELA_2022.config,
    MATHEMATICS_2022.config,

    AMERICAN_LIT_2022.config,
    ALGEBRA_I_2022.config,
    COORDINATE_ALGEBRA_2022.config
)

###   Run updateSGP analysis
Georgia_SGP <-
    updateSGP(
        what_sgp_object = Georgia_SGP,
        with_sgp_data_LONG = Georgia_Data_LONG_2022,
        years = "2022",
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = Georgia_Config_2022,
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = TRUE,
        sgp.projections.baseline = TRUE,
        sgp.projections.lagged.baseline = TRUE,
        calculate.simex = TRUE,
        calculate.simex.baseline = list(
            csem.data.vnames = "SCALE_SCORE_CSEM", lambda = seq(0, 2, 0.5),
            simulation.iterations = 75, simex.sample.size = 10000, extrapolation = "linear",
            save.matrices = FALSE, simex.use.my.coefficient.matrices = TRUE,
            use.cohort.for.ranking = FALSE), # use baseline cohort for RANKING!
        outputSGP.output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data"),
        save.intermediate.results = FALSE#,
        # parallel.config = parallel.config # Don't run parallel in Windows
    )


###   Save results
save(Georgia_SGP, file = "./Data/Georgia_SGP.Rdata")
