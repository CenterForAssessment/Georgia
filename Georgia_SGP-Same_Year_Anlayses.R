################################################################################
###
### Calculate SGPs for Georgia - Same year repeaters and Block Schedule SGPs
###
#################################################################################

### Load SGP Package
library(data.table)
library(plyr)
library(SGP)

### Load Georgia SGP object (REDUCED object for same year repeater and block schedule)
setwd("/media/Data/SGP/Georgia_Same_Year")
load("Data/Georgia_SGP-Same_Year_Analyses.Rdata")

###
###		Same year repeaters
###

#  The US_HISTORY repeaters - Didn't run for different year repeaters, still a small number here, so don't run 
#  The ECONOMICS repeaters  - Didn't run for different year repeaters, still a small number here, so don't run 
#  The Math I & II repeaters  - ran as cohort for different year repeaters, so do that here too (small N, but decent 3k-4k kids)

#  Change Year to Alt Year (REPEATER_BASELINE_YEAR), which gives the order of administration periods
setnames(Georgia_SGP_SameYear@Data, "YEAR", "SCHOOL_YEAR")
setnames(Georgia_SGP_SameYear@Data, "REPEATER_BASELINE_YEAR", "YEAR")

setkeyv(Georgia_SGP_SameYear@Data, c("VALID_CASE","CONTENT_AREA", "YEAR", "ID"))

	dir.create('Goodness_of_Fit/EOCT_Repeaters_Baseline', recursive=TRUE)
	setwd('Goodness_of_Fit/EOCT_Repeaters_Baseline')

GA.config <- list(
        GRADE_9_LIT.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
           sgp.panel.years=c('1', '2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('1', '2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        
        BIOLOGY.2012 = list(
           sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
           sgp.panel.years=c('1', '2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('1', '2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

Georgia_SGP_SameYear <- analyzeSGP(Georgia_SGP_SameYear,
            sgp.config=GA.config, 
            sgp.percentiles=TRUE, # Creates analog to BASELINE matrices here
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=FALSE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            simulate.sgps=FALSE)

	Georgia_SGP_SameYear@SGP[['SGPercentiles']] <- NULL # Only keep the matrices for now.  All results here are from different years...
	names(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']]) <- gsub("2", "BASELINE", names(Georgia_SGP_SameYear@SGP$Coefficient_Matrices))
	for (a in 1:4) Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][[a]][[1]]@Time[[1]] <- c("BASELINE", "BASELINE")

	SGPstateData[['GA']][['Baseline_splineMatrix']][['Coefficient_Matrices']] <- Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']]

	# for (ca in sapply(names(GA.config), function(x) strsplit(x, "[.]")[[1]][1])) {
		# SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']])] <- 0
	# }

	# Georgia_SGP_SameYear@SGP[['SGPercentiles']] <- SGPercentiles


#  Change Year to Alt Year to run individual year BASELINE analyses
setnames(Georgia_SGP_SameYear@Data, "YEAR", "REPEATER_BASELINE_YEAR")
setnames(Georgia_SGP_SameYear@Data, "REPEATER_YEAR", "YEAR")

GA.config <- list(
        # GRADE_9_LIT.2009 = list(
           # sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
           # sgp.panel.years=c('2009_1', '2009_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        # AMERICAN_LIT.2009 = list(
           # sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
           # sgp.panel.years=c('2009_1', '2009_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        # BIOLOGY.2009 = list(
           # sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
           # sgp.panel.years=c('2009_1', '2009_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       # PHYSICAL_SCIENCE.2009 = list(
           # sgp.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
           # sgp.panel.years=c('2009_1', '2009_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        # GRADE_9_LIT.2010 = list(
           # sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        # AMERICAN_LIT.2010 = list(
           # sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        # BIOLOGY.2010 = list(
           # sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       # PHYSICAL_SCIENCE.2010 = list(
           # sgp.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        GRADE_9_LIT.2011 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
           sgp.panel.years=c('2011_1', '2011_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT.2011 = list(
           sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2011_1', '2011_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        BIOLOGY.2011 = list(
           sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
           sgp.panel.years=c('2011_1', '2011_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       PHYSICAL_SCIENCE.2011 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2011_1', '2011_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        GRADE_9_LIT.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        BIOLOGY.2012 = list(
           sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

Georgia_SGP_SameYear <- analyzeSGP(Georgia_SGP_SameYear,
                                   sgp.config=GA.config, 
                                   sgp.percentiles=FALSE,
                                   sgp.projections=FALSE,
                                   sgp.projections.lagged=FALSE,
                                   sgp.percentiles.baseline=TRUE,
                                   sgp.projections.baseline= FALSE,
                                   sgp.projections.lagged.baseline=FALSE,
                                   simulate.sgps=FALSE)

	Goodness_of_Fit <- list(EOCT_Repeaters_Baseline=Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]])
	Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- NULL


###  Math I and Math II Have enough kids to do a cohort analysis, and this matches their other analyses

	setwd("../")
	dir.create('EOCT_Repeaters_Cohort')
	setwd('EOCT_Repeaters_Cohort')

GA.config <- list(
       # MATHEMATICS_I.2010 = list(
           # sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_I'),
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       # MATHEMATICS_II.2010 = list(
           # sgp.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

       MATHEMATICS_I.2011 = list(
         sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_I'),
         sgp.panel.years=c('2011_1', '2011_2'),
         sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       MATHEMATICS_II.2011 = list(
         sgp.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
         sgp.panel.years=c('2011_1', '2011_2'),
         sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

       MATHEMATICS_I.2012 = list(
           sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_I'),
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       MATHEMATICS_II.2012 = list(
           sgp.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

Georgia_SGP_SameYear <- analyzeSGP(Georgia_SGP_SameYear,
            sgp.config=GA.config, 
            sgp.percentiles=TRUE,
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=FALSE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            simulate.sgps=FALSE)      

	# SGPercentiles <- Georgia_SGP_SameYear@SGP[['SGPercentiles']]
	
	# for (ca in sapply(names(GA.config), function(x) strsplit(x, "[.]")[[1]][1])) {
		# SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']][is.na(SGPercentiles[[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']])] <- 0
	# }

	# Georgia_SGP_SameYear@SGP[['SGPercentiles']] <- SGPercentiles

	Goodness_of_Fit[["EOCT_Repeaters_Cohort"]] <- Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]]
	Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- NULL

###
###		Block Schedule progressions
###

##  DON'T Change back to YEAR (original SCHOOL_YEAR)!  Need the ALT year to distinquish the order (*_1 to *_2)
##  There are lots of kids who take these courses in the same year, and not all in order!  
#  Change Year to Alt Year 2, which gives ONLY order of administration periods
setnames(Georgia_SGP_SameYear@Data, "YEAR", "REPEATER_YEAR")
setnames(Georgia_SGP_SameYear@Data, "BLOCK_BASELINE_YEAR", "YEAR")

setnames(Georgia_SGP_SameYear@Data, "VALID_CASE", "VC_SAME_YR_REPEAT")
setnames(Georgia_SGP_SameYear@Data, "VC_BLOCK_SCHEDULE", "VALID_CASE")

setkeyv(Georgia_SGP_SameYear@Data, c("VALID_CASE","CONTENT_AREA", "YEAR", "ID"))

###  ECON Baseline referenced

	setwd("../")
	dir.create('EOCT_Block_Schedule_Baseline')
	setwd('EOCT_Block_Schedule_Baseline')
       
GA.config <- list(
        AMERICAN_LIT.BASELINE = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('1', '2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       BIOLOGY.BASELINE = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
           sgp.panel.years=c('1', '2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       PHYSICAL_SCIENCE.BASELINE = list(
           sgp.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('1', '2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       ECONOMICS.2012 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('1', '2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

Georgia_SGP_SameYear <- analyzeSGP(Georgia_SGP_SameYear,
            sgp.config=GA.config, 
            sgp.percentiles=TRUE, # Creates analog to BASELINE matrices here
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=FALSE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            simulate.sgps=FALSE)

	Georgia_SGP_SameYear@SGP[['SGPercentiles']][1:4] <- NULL # Only keep the matrices for now.  All results here are from different years...

	for (a in 9:12) Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][[a]][[1]]@Time[[1]] <- c("BASELINE", "BASELINE") # 11:14
	
	Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['PHYSICAL_SCIENCE.BASELINE']] <- 
		c(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['PHYSICAL_SCIENCE.BASELINE']], Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['PHYSICAL_SCIENCE.2']])
	Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['BIOLOGY.BASELINE']] <- 
		c(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['BIOLOGY.BASELINE']], Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['BIOLOGY.2']])
	Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['AMERICAN_LIT.BASELINE']] <- 
		c(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['AMERICAN_LIT.BASELINE']], Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['AMERICAN_LIT.2']])
	
	names(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']])[9] <- 'ECONOMICS.BASELINE'
	Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['ECONOMICS.BASELINE']][[1]]@Time[[1]] <- c("BASELINE", "BASELINE")
	
	Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][10:12] <- NULL

	SGPstateData[['GA']][['Baseline_splineMatrix']][['Coefficient_Matrices']] <- 
		Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][grep('BASELINE', names(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']]))]

#  Change Year to Alt Year to run individual year BASELINE analyses
setnames(Georgia_SGP_SameYear@Data, "YEAR", "BLOCK_BASELINE_YEAR") 
setnames(Georgia_SGP_SameYear@Data, "BLOCK_YEAR", "YEAR")

setkeyv(Georgia_SGP_SameYear@Data, c("VALID_CASE","CONTENT_AREA", "YEAR", "ID"))

GA.config <- list(
        # AMERICAN_LIT.2009 = list(
           # sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
           # sgp.panel.years=c('2009_1', '2009_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        # AMERICAN_LIT.2010 = list(
           # sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT.2011 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
           sgp.panel.years=c('2011_1', '2011_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        # BIOLOGY.2009 = list(
           # sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'), 
           # sgp.panel.years=c('2009_1', '2009_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        # BIOLOGY.2010 = list(
           # sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'), 
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        BIOLOGY.2011 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'), 
           sgp.panel.years=c('2011_1', '2011_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        BIOLOGY.2012 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'), 
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        # PHYSICAL_SCIENCE.2009 = list(
           # sgp.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'), 
           # sgp.panel.years=c('2009_1', '2009_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        # PHYSICAL_SCIENCE.2010 = list(
           # sgp.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'), 
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        PHYSICAL_SCIENCE.2011 = list(
           sgp.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'), 
           sgp.panel.years=c('2011_1', '2011_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'), 
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        # ECONOMICS.2009 = list(
           # sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           # sgp.panel.years=c('2009_1', '2009_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        # ECONOMICS.2010 = list(
           # sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        ECONOMICS.2011 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('2011_1', '2011_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        ECONOMICS.2012 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

Georgia_SGP_SameYear <- analyzeSGP(Georgia_SGP_SameYear,
            sgp.config=GA.config, 
            sgp.percentiles=FALSE,
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=TRUE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            simulate.sgps=FALSE)

Goodness_of_Fit[["EOCT_Block_Schedule_Baseline"]] <- Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]]
Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- NULL


##  Math I and Math II Block Schedule (same year different course)

	setwd("../")
	dir.create('EOCT_Block_Schedule_Cohort')
	setwd('EOCT_Block_Schedule_Cohort')

# comments like ### kids ; now ### are what I found before eliminating prior year repeaters and after:  # Before ; now # After
GA.config <- list(
       # MATHEMATICS_II.2010 = list( #3728 ; now 3,784
           # sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
           # sgp.panel.years=c('2010_1', '2010_2'),
           # sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       MATHEMATICS_II.2011 = list( #3965 ; now 1,546
           sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
           sgp.panel.years=c('2011_1', '2011_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       MATHEMATICS_II.2012 = list( #3058 ; now 1,379
           sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
           sgp.panel.years=c('2012_1', '2012_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))))

Georgia_SGP_SameYear <- analyzeSGP(Georgia_SGP_SameYear,
            sgp.config=GA.config, 
            sgp.percentiles=TRUE,
            sgp.projections=FALSE,
            sgp.projections.lagged=FALSE,
            sgp.percentiles.baseline=FALSE,
            sgp.projections.baseline= FALSE,
            sgp.projections.lagged.baseline=FALSE,
            simulate.sgps=FALSE)      

	Goodness_of_Fit[["EOCT_Block_Schedule_Cohort"]] <- Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]]
	Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- Goodness_of_Fit

Georgia_SGP_SameYear@Data[['COMBINE_YEAR']] <- Georgia_SGP_SameYear@Data[['REPEATER_YEAR']]
Georgia_SGP_SameYear@Data[['COMBINE_YEAR']][is.na(Georgia_SGP_SameYear@Data[['REPEATER_YEAR']])] <- Georgia_SGP_SameYear@Data[['YEAR']][is.na(Georgia_SGP_SameYear@Data[['REPEATER_YEAR']])]

setnames(Georgia_SGP_SameYear@Data, "YEAR", "BLOCK_YEAR") 
setnames(Georgia_SGP_SameYear@Data, "COMBINE_YEAR", "YEAR")

setkeyv(Georgia_SGP_SameYear@Data, c("VALID_CASE","CONTENT_AREA", "YEAR", "ID"))

Georgia_SGP_SameYear <- combineSGP(Georgia_SGP_SameYear)
