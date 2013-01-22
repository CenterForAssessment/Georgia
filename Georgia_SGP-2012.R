#########################################################
###
### Calculate SGPs for Georgia - 2012
###
##########################################################

### Load SGP Package
require(SGP)

### Load Georgia SGP object
setwd("/media/Data/SGP/Georgia")
load("Data/Georgia_SGP-2012.Rdata")

#  Remove all the Old EOCT and all Baseline Matrices from object (keeping 2009-2011)
Georgia_SGP@SGP[['Coefficient_Matrices']] <- Georgia_SGP@SGP[['Coefficient_Matrices']][1:13]

##############################################################################
###
### Grade level CRCT tests
###
##############################################################################

Georgia_SGP <- analyzeSGP(
			Georgia_SGP,
			years='2012',
			content_areas=c("ELA", "READING", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES"),
			sgp.percentiles=TRUE,
			sgp.projections=TRUE,
			sgp.projections.lagged=TRUE,
			sgp.percentiles.baseline=TRUE,
			sgp.projections.baseline=TRUE,
			sgp.projections.lagged.baseline=TRUE,
			simulate.sgps=TRUE,
			parallel.config=list(
				BACKEND="PARALLEL", 
				WORKERS=list(
					PERCENTILES=24, BASELINE_PERCENTILES=24,
					PROJECTIONS=8, LAGGED_PROJECTIONS=8)))

save(Georgia_SGP, file="Data/Georgia_SGP-2012_CRCT.Rdata")

#  Code used to output the CRCT Results for Review.  Do NOT save SGP object after reducing the @Data slot

dim(Georgia_SGP@Data)
Georgia_SGP@Data <- Georgia_SGP@Data[Georgia_SGP@Data$YEAR=='2012',]
Georgia_SGP@Data <- Georgia_SGP@Data[Georgia_SGP@Data$CONTENT_AREA %in% c("ELA", "READING", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES") &
	Georgia_SGP@Data$GRADE %in% 3:8,]
dim(Georgia_SGP@Data)

Georgia_SGP <- combineSGP(Georgia_SGP, year='2012')

outputSGP(Georgia_SGP, output.type="LONG_Data", outputSGP.directory="CRCT_Results")


##############################################################################
###
### Grade level EOC tests
###
##############################################################################

setwd("/media/Data/SGP/Georgia")
load("Data/Georgia_SGP-2012_CRCT.Rdata")

#  Create a 'GRADE_REPORTED' variable to retain the info contained in GRADE.
#  Change the GRADE Variable so that any EOCT test has the value 'EOCT' assigned to it:

Georgia_SGP@Data[['GRADE_REPORTED']] <- Georgia_SGP@Data[['GRADE']]

Georgia_SGP@Data[['GRADE']][!Georgia_SGP@Data[['GRADE']] %in% as.character(3:8)] <- 'EOCT'
#  Turn NA grade subjects into EOCT too
Georgia_SGP@Data[['GRADE']][is.na(Georgia_SGP@Data[['GRADE']]) & 
	!Georgia_SGP@Data[['CONTENT_AREA']] %in% c("ELA", "READING", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES")] <- 'EOCT' 

#  We need to be explicit about the working directory in order to get the goodness of fit plots to all print out.
#  Probably something we should address somehow in the package.

	dir.create('Goodness_of_Fit/EOCT_1_SkipYear')
	setwd('Goodness_of_Fit/EOCT_1_SkipYear')

	Goodness_of_Fit <- list(CRCT=Georgia_SGP@SGP[["Goodness_of_Fit"]])
	Georgia_SGP@SGP[["Goodness_of_Fit"]] <- NULL

###
###  Typical course progressions:  Skip years
###

GA.config <- list(
	#  These must be seperated from the 
        GRADE_9_LIT.2012 = list(
           sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
           sgp.panel.years=c('2010', '2010', '2012'),
           sgp.grade.sequences=list(c(8,8, 'EOCT'))),
        AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2010', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))), # Any skip year progression regardless of grade

	##		ALGEBRA and GEOMETRY new for 2012
	#  Algebra with the skip year is questionable - ~2000 kids, decent fit considering small N ... 
	#  Removed per Qi email 12/17/2012
        # ALGEBRA.2012 = list(
           # sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA'),
           # sgp.panel.years=c('2009', '2010', '2012'),
           # sgp.grade.sequences=list(c(7:8, 'EOCT'))),
        GEOMETRY.2012 = list(
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'GEOMETRY'),
           sgp.panel.years=c('2009', '2010', '2012'),
           sgp.grade.sequences=list(c(7:8, 'EOCT'))),

        MATHEMATICS_I.2012 = list(
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS_I'),
           sgp.panel.years=c('2009', '2010', '2012'),
           sgp.grade.sequences=list(c(7:8, 'EOCT'))),
        MATHEMATICS_II.2012 = list(
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS_I', 'MATHEMATICS_II'),
           sgp.panel.years=c('2009', '2010', '2012'),
           sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT'))),

        PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2009', '2010', '2012'),
           sgp.grade.sequences=list(c(7:8, 'EOCT'))),
        BIOLOGY.2012 = list(
           sgp.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
           sgp.panel.years=c('2009', '2010', '2012'),
           sgp.grade.sequences=list(c(7:8, 'EOCT'))),

        US_HISTORY.2012 = list(
           sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'), 
           sgp.panel.years=c('2010', '2012'),
           sgp.grade.sequences=list(c(8, 'EOCT'))), #8, 10
        ECONOMICS.2012 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('2010', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))


Georgia_SGP <- analyzeSGP(Georgia_SGP,
            sgp.config=GA.config,
            sgp.percentiles=TRUE,
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=TRUE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            simulate.sgps=FALSE,
            parallel.config=list(
                BACKEND="PARALLEL", 
                WORKERS=list(PERCENTILES=12, BASELINE_PERCENTILES=12)))


###  Create an additional variable PREFERRED_SGP to identify which SGP to keep for kids who will have duplicates:
###  4 Will be the LEAST prefered - could have a skip year here, but be a repeater later on.  We should only count their repeater SGP (if it exists)

	SGPercentiles <- Georgia_SGP@SGP[['SGPercentiles']]
	
	for (ca in sapply(names(GA.config), function(x) strsplit(x, "[.]")[[1]][1])) {
		SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']] <- 4
		if (!ca %in% c('GEOMETRY', 'MATHEMATICS_I', 'MATHEMATICS_II', 'US_HISTORY')) {
			SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']] <- 4
		}
	}

	Georgia_SGP@SGP[['SGPercentiles']] <- SGPercentiles

	Goodness_of_Fit[['EOCT_1_SkipYear']] <- Georgia_SGP@SGP[["Goodness_of_Fit"]]
	Georgia_SGP@SGP[["Goodness_of_Fit"]] <- NULL

###
###  Typical course progressions:  Consecutive years
###

	setwd("../")
	dir.create('EOCT_1_Consecutive')
	setwd('EOCT_1_Consecutive')

GA.config <- list(
        GRADE_9_LIT.2012 = list(
           sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
           sgp.panel.years=c('2011', '2011', '2012'),
           sgp.grade.sequences=list(c(8,8, 'EOCT'))),
        AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))), # Any Consecutive course progression of GRADE_9_LIT, AMERICAN_LIT regardless of grade

	###		ALGEBRA and GEOMETRY new for 2012
        ALGEBRA.2012 = list(
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c(7:8, 'EOCT'))),
        # GEOMETRY.2012 = list(
           # sgp.content.areas=c('MATHEMATICS', 'GEOMETRY'),
           # sgp.panel.years=c('2011', '2012'), 
           # sgp.grade.sequences=list(c(8, 'EOCT'))), # Not enough ( < 1,000) 7th grade students in 7:8, 'EOCT' (singular design matrix), 8, EOCT works, but still ~1,000 and rough fit.

       MATHEMATICS_I.2012 = list( #  MATHEMATICS_I.2012_1
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS_I'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(6:8, c(7:8, 'EOCT'))),
       MATHEMATICS_II.2012 = list(
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS_I', 'MATHEMATICS_II'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8,'EOCT', 'EOCT'))),

       PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(6:8, c(7:8, 'EOCT'))),
        BIOLOGY.2012 = list(
           sgp.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c(7:8, 'EOCT'))),

        # US_HISTORY.2012 = list(
           # sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'), 
           # sgp.panel.years=c('2011', '2012'),
           # sgp.grade.sequences=list(c(8, 'EOCT'))), # 8:9  #  Only ~500 in 2012 
        ECONOMICS.2012 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))


Georgia_SGP <- analyzeSGP(Georgia_SGP,
            sgp.config=GA.config,
            sgp.percentiles=TRUE,
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=TRUE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            simulate.sgps=FALSE,
            parallel.config=list(
                BACKEND="PARALLEL", 
                WORKERS=list(PERCENTILES=12, BASELINE_PERCENTILES=12)))

###  Create an additional variable PREFERRED_SGP to identify which SGP to keep for kids who will have duplicates:

	SGPercentiles <- Georgia_SGP@SGP[['SGPercentiles']]
	
	for (ca in sapply(names(GA.config), function(x) strsplit(x, "[.]")[[1]][1])) {
		if (ca == "ALGEBRA") {
			SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']] <- 3 # Algebra is new now and no BASELINE
		} else {
			SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']])] <- 3
			if (!ca %in% c('MATHEMATICS_I', 'MATHEMATICS_II')) { # 'ALGEBRA', 'GEOMETRY', 'US_HISTORY' #  Don't have BASELINES
				SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']])] <- 3
			}
		}
	}

	Georgia_SGP@SGP[['SGPercentiles']] <- SGPercentiles

	Goodness_of_Fit[['EOCT_1_Consecutive']] <- Georgia_SGP@SGP[["Goodness_of_Fit"]]
	Georgia_SGP@SGP[["Goodness_of_Fit"]] <- NULL

###
###  Less typical course sequences: Skip year.
###

	setwd("../")
	dir.create('EOCT_2_SkipYear')
	setwd('EOCT_2_SkipYear')

GA.config <- list(
       GRADE_9_LIT.2012 = list(
           sgp.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
           sgp.panel.years=c('2009', '2009', '2010', '2010', '2012'),
           sgp.grade.sequences=list(c(7,7,8,8, 'EOCT'))), # ~ 7, 8, 10 ONLY (exact grade progression = TRUE when multiple content areas in a single year)
       AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2009', '2009', '2010', '2012'),
           sgp.grade.sequences=list(c(8,8, 'EOCT', 'EOCT'))), # ~ 8,9,11 ONLY (exact grade progression = TRUE)

       BIOLOGY.2012 = list(
           sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
           sgp.panel.years=c('2009', '2010', '2012'),
           sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT'))), # ~ 8,9, 11 and ANY Skip year
       PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2009', '2010', '2012'),
           sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT'))),  # ~ 8,9, 11 and ANY Skip year

        US_HISTORY.2012 = list(
           sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'), 
           sgp.panel.years=c('2009', '2012'),
           sgp.grade.sequences=list(c(8, 'EOCT')))) # 8, 11


Georgia_SGP <- analyzeSGP(Georgia_SGP,
            sgp.config=GA.config, 
            sgp.percentiles=TRUE,
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=TRUE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            sgp.percentiles.baseline.max.order=4, #  Need this for Grade 9 Lit Baselines
            simulate.sgps=FALSE,
            parallel.config=list(
                BACKEND="PARALLEL", 
                WORKERS=list(PERCENTILES=6, BASELINE_PERCENTILES=6)))      


#  Replace the NA in the PREFERRED_SGP with a 1 now for those content areas progressions with a) more priors, or b) more desirable progression

	SGPercentiles <- Georgia_SGP@SGP[['SGPercentiles']]
	
	for (ca in sapply(names(GA.config), function(x) strsplit(x, "[.]")[[1]][1])) {
		SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']])] <- 2
		if (!ca %in% c('US_HISTORY')) { # 'ALGEBRA', 'GEOMETRY', 'MATHEMATICS_I', 'MATHEMATICS_II' #  Don't have BASELINES
			SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']])] <- 2
		}
	}

	Georgia_SGP@SGP[['SGPercentiles']] <- SGPercentiles

	Goodness_of_Fit[["EOCT_2_SkipYear"]] <- Georgia_SGP@SGP[["Goodness_of_Fit"]]
	Georgia_SGP@SGP[["Goodness_of_Fit"]] <- NULL

###
###  Less typical course sequences:  Consecutive years.
###

	setwd("../") #  set wd back to Goodness_of_Fit
	dir.create('EOCT_2_Consecutive')
	setwd('EOCT_2_Consecutive')

GA.config <- list(
       GRADE_9_LIT.2012 = list(
           sgp.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
           sgp.panel.years=c('2010', '2010', '2011', '2011', '2012'),
           sgp.grade.sequences=list(c(7,7,8,8, 'EOCT'))), # ~ 7:9 ONLY (exact grade progression = TRUE)
       AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2010', '2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8,8, 'EOCT', 'EOCT'))), # ~ 8:10 ONLY (exact grade progression = TRUE)

       BIOLOGY.2012 = list(
           sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT'))), # ~ 8:10
       PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8, 'EOCT', 'EOCT')))) # ~ 8:10


Georgia_SGP <- analyzeSGP(Georgia_SGP,
            sgp.config=GA.config, 
            sgp.percentiles=TRUE,
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=TRUE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            sgp.percentiles.baseline.max.order=4, #  Need this for Grade 9 Lit Baselines
            simulate.sgps=FALSE,
            parallel.config=list(
                BACKEND="PARALLEL", 
                WORKERS=list(PERCENTILES=6, BASELINE_PERCENTILES=6)))      


#  Replace the NA in the PREFERRED_SGP with a 1 now for those content areas progressions with a) more priors, or b) more desirable progression

	SGPercentiles <- Georgia_SGP@SGP[['SGPercentiles']]
	
	for (ca in sapply(names(GA.config), function(x) strsplit(x, "[.]")[[1]][1])) {
		SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']])] <- 1
		SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']])] <- 1
	}

	Georgia_SGP@SGP[['SGPercentiles']] <- SGPercentiles

	Goodness_of_Fit[["EOCT_2_Consecutive"]] <- Georgia_SGP@SGP[["Goodness_of_Fit"]]
	Georgia_SGP@SGP[["Goodness_of_Fit"]] <- NULL

           
###
###		Repeaters - new to 2012
###

##  These subjects don't have enough kids to do a cohort analysis but baseline referenced analyses are possible.

	setwd("../")
	dir.create('EOCT_Repeaters_Baseline')
	setwd('EOCT_Repeaters_Baseline')

GA.config <- list(
        GRADE_9_LIT.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

       BIOLOGY.2012 = list(
           sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

#  Removed per Qi email 12/17/2012
#  The US_HISTORY repeaters has a decent number of kids (~4,000), but the goodness of fit is VERY questionable!  
#  Did something happen with the test SCALE?  Not sure we should use this cohort...
        # US_HISTORY.2012 = list(  
           # sgp.content.areas=c('US_HISTORY', 'US_HISTORY'), 
           # sgp.panel.years=c('2011', '2012'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

# #  The ECONOMICS repeaters does not have enough kids ( < 1,000).  I would recomend NOT using this group.  
        # ECONOMICS.2012 = list(
           # sgp.content.areas=c('ECONOMICS', 'ECONOMICS'), 
           # sgp.panel.years=c('2011', '2012'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))))


Georgia_SGP <- analyzeSGP(Georgia_SGP,
            sgp.config=GA.config, 
            sgp.percentiles=FALSE, # Only BASELINE matrices here
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=TRUE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            simulate.sgps=FALSE,
            parallel.config=list(
                BACKEND="PARALLEL", 
                WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4)))      

	SGPercentiles <- Georgia_SGP@SGP[['SGPercentiles']]
	
	for (ca in sapply(names(GA.config), function(x) strsplit(x, "[.]")[[1]][1])) {
		SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']])] <- 0
	}

	Georgia_SGP@SGP[['SGPercentiles']] <- SGPercentiles

	Goodness_of_Fit[["EOCT_Repeaters_Baseline"]] <- Georgia_SGP@SGP[["Goodness_of_Fit"]]
	Georgia_SGP@SGP[["Goodness_of_Fit"]] <- NULL

##  Math I and Math II Have enough kids to do a cohort analysis, and this matches their other analyses

	setwd("../")
	dir.create('EOCT_Repeaters_Cohort')
	setwd('EOCT_Repeaters_Cohort')

GA.config <- list(
       MATHEMATICS_I.2012 = list(
           sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_I'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       MATHEMATICS_II.2012 = list(
           sgp.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

Georgia_SGP <- analyzeSGP(Georgia_SGP,
            sgp.config=GA.config, 
            sgp.percentiles=TRUE,
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=FALSE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            simulate.sgps=FALSE,
            parallel.config=list(
                BACKEND="PARALLEL", 
                WORKERS=list(PERCENTILES=2, BASELINE_PERCENTILES=2)))      

	SGPercentiles <- Georgia_SGP@SGP[['SGPercentiles']]
	
	for (ca in sapply(names(GA.config), function(x) strsplit(x, "[.]")[[1]][1])) {
		SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']])] <- 0
	}

	Georgia_SGP@SGP[['SGPercentiles']] <- SGPercentiles

	Goodness_of_Fit[["EOCT_Repeaters_Cohort"]] <- Georgia_SGP@SGP[["Goodness_of_Fit"]]
	Georgia_SGP@SGP[["Goodness_of_Fit"]] <- Goodness_of_Fit #  Finally replace this slot with the temp list we've kept updated


	save(Georgia_SGP, file="Data/Georgia_SGP-2012.Rdata")


###
###		Same year repeaters
###


###  THIS SECTION DONE AS SEPERATE ANALYSIS: 1/22/13
###	See Georgia_Data_LONG-Same_Year_Analyses.R & Georgia_SGP-Same_Year_Anlayses.R


#  Check to see the N on each Content Area analysis as well as the Median SGP
tot<-0
for(i in names(Georgia_SGP@SGP[['SGPercentiles']])[-grep("BASELINE", names(Georgia_SGP@SGP[['SGPercentiles']]))]) {
	print(paste(i, "N =", dim(Georgia_SGP@SGP[['SGPercentiles']][[i]])[1], " :  Median SGP,", median(Georgia_SGP@SGP[['SGPercentiles']][[i]][["SGP"]])))
	tot <- tot+(dim(Georgia_SGP@SGP[['SGPercentiles']][[i]])[1])
}
tot #  9,961,147 Baseline / 11,462,222 Cohort



###
###  Sort and choose the proper SGP for the duplicated cases
###

	SGPercentiles <- Georgia_SGP@SGP[['SGPercentiles']]

	eoc.content.areas <- c('GRADE_9_LIT', 'AMERICAN_LIT', 'ALGEBRA', 'GEOMETRY', 'MATHEMATICS_I', 'MATHEMATICS_II', 'PHYSICAL_SCIENCE', 'BIOLOGY', 'US_HISTORY', 'ECONOMICS')
	
	for (ca in eoc.content.areas) {
		if (ca %in% sapply(names(Georgia_SGP@SGP[['SGPercentiles']])[-grep("BASELINE", names(Georgia_SGP@SGP[['SGPercentiles']]))], function(x) strsplit(x, "[.]")[[1]][1])) {
			tmp.sgp <- data.table(SGPercentiles[[paste(ca, 2012, sep='.')]], key=c('ID', 'PREFERRED_SGP'))
			setkeyv(tmp.sgp, "ID")
			SGPercentiles[[paste(ca, 2012, sep='.')]] <- data.frame(tmp.sgp[which(!duplicated(tmp.sgp)),][, -dim(tmp.sgp)[2], with=FALSE])
		}

		if (ca %in% sapply(names(Georgia_SGP@SGP[['SGPercentiles']])[grep("BASELINE", names(Georgia_SGP@SGP[['SGPercentiles']]))], function(x) strsplit(x, "[.]")[[1]][1])) {
			tmp.sgp <- data.table(SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]], key=c('ID', 'PREFERRED_SGP'))
			setkeyv(tmp.sgp, "ID")
			SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]] <- data.frame(tmp.sgp[which(!duplicated(tmp.sgp)),][, -dim(tmp.sgp)[2], with=FALSE])
		}
	}

	Georgia_SGP@SGP[['SGPercentiles']] <- SGPercentiles


#  Check to see the N on each Content Area analysis (should be fewer than before) as well as the Median SGP (should still be ~50)
tot<-0
for(i in names(Georgia_SGP@SGP[['SGPercentiles']])[-grep("BASELINE", names(Georgia_SGP@SGP[['SGPercentiles']]))]) {
	if (length(grep('2012' , i)) >0) {
		print(paste(i, "N =", dim(Georgia_SGP@SGP[['SGPercentiles']][[i]])[1], " :  Median SGP,", median(Georgia_SGP@SGP[['SGPercentiles']][[i]][["SGP"]])))
		tot <- tot+(dim(Georgia_SGP@SGP[['SGPercentiles']][[i]])[1])
	}
}
tot #  2,827,192 Baseline / 3,734,429 Cohort in 2012.


###
###		combineSGP and outputSGP to produce .txt file of LONG data fro review

	setwd("/media/Data/SGP/Georgia")  # Set wd to SGP/Georgia


Georgia_SGP <- combineSGP(Georgia_SGP, year='2012')


# save(Georgia_SGP, file="Data/Georgia_SGP-2012.Rdata")


###  Reduce file size for outputSGP (don't save SGP object after this!)

dim(Georgia_SGP@Data)
Georgia_SGP@Data <- Georgia_SGP@Data[Georgia_SGP@Data[['YEAR']]=='2012',]
Georgia_SGP@Data <- Georgia_SGP@Data[Georgia_SGP@Data[['CONTENT_AREA']]%in% eoc.content.areas & Georgia_SGP@Data[['GRADE']]%in% 'EOCT',]
dim(Georgia_SGP@Data)

outputSGP(Georgia_SGP, output.type="LONG_Data", outputSGP.directory="EOCT_Results")



