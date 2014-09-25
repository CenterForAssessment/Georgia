#########################################################
###
### Calculate EOCT SGPs for Georgia for 2014
###
##########################################################

### Load SGP Package

require(SGP)


### Load Georgia SGP object
setwd('/media/Data/Dropbox/SGP/Georgia')
load("Data/Georgia_SGP.Rdata")
load('Data/Georgia_Baseline_Matrices.Rdata' )


SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- Georgia_Baseline_Matrices

### Replace original baseline matrices with updated matrices (original + additional US Hist and ELA progressions)
Georgia_SGP@SGP$Coefficient_Matrices <- Georgia_SGP@SGP$Coefficient_Matrices[-grep("BASELINE", names(Georgia_SGP@SGP$Coefficient_Matrices))]
Georgia_SGP@SGP$Coefficient_Matrices <- c(Georgia_SGP@SGP$Coefficient_Matrices, Georgia_Baseline_Matrices)


####################################################################################
###
### EOCT Analyses
###
####################################################################################


###
###		Cohort referenced EOCT content areas - run seperate to keep SIMEX production limited to "official" version
###

### Load EOCT configurations
setwd('/media/Data/Dropbox/Github_Repos/Projects/Georgia')

source("SGP_CONFIG/EOCT/2014/ELA.R")
source("SGP_CONFIG/EOCT/2014/SCIENCE.R")
source("SGP_CONFIG/EOCT/2014/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2014/MATHEMATICS.R")

GA_EOCT.config <- c(
		MATHEMATICS_2014.config,
		
		ANALYTIC_GEOMETRY_2014.config,
		COORDINATE_ALGEBRA_2014.config,
		MATHEMATICS_II_2014.config,

		SCIENCE_2014.config,
		BIOLOGY_2014.config,
		PHYSICAL_SCIENCE_2014.config,

		ELA_2014.config,
		READING_2014.config,
		GRADE_9_LIT_2014.config,
		AMERICAN_LIT_2014.config,

		SOCIAL_STUDIES_2014.config,
		ECONOMICS_2014.config,
		US_HISTORY_2014.config)

setwd('/media/Data/Dropbox/SGP/Georgia')

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config=GA_EOCT.config,
		sgp.percentiles=TRUE,
		sgp.projections= TRUE,
		sgp.projections.lagged= TRUE,
		sgp.percentiles.baseline= TRUE,
		sgp.projections.baseline= TRUE,
		sgp.projections.lagged.baseline= TRUE,
		simulate.sgps = TRUE,
		# sgp.use.my.coefficient.matrices = TRUE,
		goodness.of.fit.print=FALSE,
		# calculate.simex = TRUE,
		# calculate.simex.baseline = TRUE,
		# parallel.config=list(BACKEND='PARALLEL', WORKERS=list(TAUS=5, SIMEX=5)))
		# parallel.config=list(BACKEND='PARALLEL', WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=3, LAGGED_PROJECTIONS=3))) # AVI
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(PERCENTILES=6, BASELINE_PERCENTILES=6, PROJECTIONS=6, LAGGED_PROJECTIONS=6))) # EC2


save(Georgia_SGP, file="Georgia_SGP.Rdata")

### combineSGP

Georgia_SGP <- combineSGP(Georgia_SGP, years='2014')

### Save results
save(Georgia_SGP, file="Georgia_SGP.Rdata")


### summarizeSGP (Produces aggregate tables)

Georgia_SGP <- summarizeSGP(Georgia_SGP, parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SUMMARY=20)))


### outputSGP

# Custom FORMATTED output script

### Save results

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
