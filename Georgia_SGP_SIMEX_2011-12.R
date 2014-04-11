#########################################################
###
### Calculate SIMEX SGPs for Georgia for 2011 & 2012
###
##########################################################

### Load SGP Package

require(SGP)


### Load Georgia SGP object

load("Georgia_SGP.Rdata")

###
###	 analyzeSGP : Grade level CRCT content areas
###

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		years=c('2011'), #'2012', # Run seperate
		content_areas=c("ELA", "READING", "MATHEMATICS", "SCIENCE"), # NO BASELINE SOCIAL_STUDIES in 2011 or 2012
		sgp.percentiles= FALSE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps = FALSE,
		calculate.simex.baseline = TRUE,
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(BASELINE_PERCENTILES=8)))

save(Georgia_SGP, file="Georgia_SGP.Rdata")

### analyzeSGP:  Baseline EOCT content areas

### Load EOCT configurations
### NO BASELINE US_HISTORY in 2011 or 2012

source("SGP_CONFIG/EOCT/2011/ELA.R")
source("SGP_CONFIG/EOCT/2011/SCIENCE.R")
source("SGP_CONFIG/EOCT/2011/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2012/ELA.R")
source("SGP_CONFIG/EOCT/2012/SCIENCE.R")
source("SGP_CONFIG/EOCT/2012/SOCIAL_STUDIES.R")

GA_EOCT_2011.config <- c(
                AMERICAN_LIT_2011.config,
                BIOLOGY_2011.config,
                ECONOMICS_2011.config,
                GRADE_9_LIT_2011.config,
                PHYSICAL_SCIENCE_2011.config)

GA_EOCT_2012.config <- c(
                AMERICAN_LIT_2012.config,
                BIOLOGY_2012.config,
                ECONOMICS_2012.config,
                GRADE_9_LIT_2012.config,
                PHYSICAL_SCIENCE_2012.config)

GA_EOCT.config <- c(GA_EOCT_2011.config, GA_EOCT_2012.config)

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config=GA_EOCT.config,
		sgp.percentiles= FALSE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps = FALSE,
		calculate.simex.baseline = TRUE,
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(SIMEX=25)))

### 2012 contains duplicates in math and reading, so remove those from Georgia_SGP@SGP$SGProjections before saving.

dup.subjects <- c("READING", "MATHEMATICS", "SCIENCE")
dup.var.names <- c("ID", "LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT")
valid.var.names <- c("ID", "LEVEL_1_SGP_TARGET_YEAR_1", "LEVEL_2_SGP_TARGET_YEAR_1")

for (n in dup.subjects) {
	### Find ALL duplicates
	tmp.dups <- data.table(Georgia_SGP@SGP$SGProjections[[paste(n, ".2012.BASELINE", sep="")]][, dup.var.names], key="ID")
	tmp.dups <- data.table(tmp.dups[c(which(duplicated(tmp.dups))-1, which(duplicated(tmp.dups)))], key="ID")
	
	### Narrow down dups to find which one is
	tmp.valid <- data.table(Georgia_SGP@SGP$SGProjections[[paste(n, ".2013.LAGGED.BASELINE", sep="")]][, valid.var.names], key="ID")
	tmp.valid <- tmp.dups[tmp.valid, allow.cartesian=TRUE]
	tmp.valid <- data.table(tmp.valid[LEVEL_1_SGP_TARGET_YEAR_1_CURRENT==LEVEL_1_SGP_TARGET_YEAR_1 & LEVEL_2_SGP_TARGET_YEAR_1_CURRENT==LEVEL_2_SGP_TARGET_YEAR_1][, 
		list(ID, LEVEL_1_SGP_TARGET_YEAR_1, LEVEL_2_SGP_TARGET_YEAR_1)], key="ID")
	
	tmp.dups <- tmp.valid[data.table(Georgia_SGP@SGP$SGProjections[[paste(n, ".2012.BASELINE", sep="")]], key="ID")]
	tmp.dups <- tmp.dups[is.na(LEVEL_1_SGP_TARGET_YEAR_1) | LEVEL_1_SGP_TARGET_YEAR_1_CURRENT == LEVEL_1_SGP_TARGET_YEAR_1]
	Georgia_SGP@SGP$SGProjections[[paste(n, ".2012.BASELINE", sep="")]] <- data.frame(
		tmp.dups[-c(which(duplicated(tmp.dups))-1, which(duplicated(tmp.dups)))])[, -(2:3)]
}

for (j in c(grep(".2011.BASELINE", names(Georgia_SGP@SGP$SGPercentiles)), grep(".2012.BASELINE", names(Georgia_SGP@SGP$SGPercentiles)))) {
	Georgia_SGP@SGP$SGPercentiles[[j]] <- Georgia_SGP@SGP$SGPercentiles[[j]][!is.na(Georgia_SGP@SGP$SGPercentiles[[j]]$SGP_SIMEX_BASELINE),]
}

Georgia_SGP <- combineSGP(Georgia_SGP, years=c('2011', '2012'), sgp.percentiles = FALSE, sgp.percentiles.baseline = TRUE, sgp.projections = FALSE, sgp.projections.baseline = FALSE, sgp.projections.lagged = FALSE, sgp.projections.lagged.baseline = FALSE)

save(Georgia_SGP, file="Georgia_SGP.Rdata")

outputSGP(Georgia_SGP, output.type = "LONG_Data")

Georgia_SGP <- summarizeSGP(Georgia_SGP, parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SUMMARY=8)))
