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

dir.create('Goodness_of_Fit/EOCT_Repeaters_Baseline/Baseline_Coeficient_Matrix_Construction', recursive=TRUE)
setwd('Goodness_of_Fit/EOCT_Repeaters_Baseline/Baseline_Coeficient_Matrix_Construction')

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
  for (a in 1:4) Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][[a]][[1]]@Time_Lags[[1]] <- 0L # added 2/18/13

	SGPstateData[['GA']][['Baseline_splineMatrix']][['Coefficient_Matrices']] <- Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']]

	Goodness_of_Fit <- list(EOCT_Repeaters_Baseline_CoefMatrices=Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]])
	Goodness_of_Fit2 <- Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]]
	Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- NULL
	

#  Change Year to Alt Year and switch VALID CASE indicators to run individual year BASELINE analyses

setnames(Georgia_SGP_SameYear@Data, "YEAR", "REPEATER_BASELINE_YEAR")
setnames(Georgia_SGP_SameYear@Data, "REPEATER_YEAR", "YEAR")

setnames(Georgia_SGP_SameYear@Data, "VALID_CASE", "VC_REPEAT_BASELINE")
setnames(Georgia_SGP_SameYear@Data, "VC_SAME_YR_REPEAT", "VALID_CASE")

setkeyv(Georgia_SGP_SameYear@Data, c("VALID_CASE","CONTENT_AREA", "YEAR", "ID"))

setwd('..')
dir.create('Baseline_SGP_Production')
setwd('Baseline_SGP_Production')

GA.config <- list(
        GRADE_9_LIT.2010 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
           sgp.panel.years=c('2010_1', '2010_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT.2010 = list(
           sgp.content.areas=c('AMERICAN_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2010_1', '2010_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        BIOLOGY.2010 = list(
           sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
           sgp.panel.years=c('2010_1', '2010_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       PHYSICAL_SCIENCE.2010 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2010_1', '2010_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

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

	Goodness_of_Fit[["EOCT_Repeaters_Baseline_SGPs"]] <- Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]]
	Goodness_of_Fit2 <- c(Goodness_of_Fit2, Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]])

Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- NULL


###  Math I and Math II Have enough kids to do a cohort analysis, and this matches their other analyses

setwd("../");setwd("../")
dir.create('EOCT_Repeaters_Cohort')
setwd('EOCT_Repeaters_Cohort')

GA.config <- list(
       MATHEMATICS_I.2010 = list(
           sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_I'),
           sgp.panel.years=c('2010_1', '2010_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       MATHEMATICS_II.2010 = list(
           sgp.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
           sgp.panel.years=c('2010_1', '2010_2'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

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

	Goodness_of_Fit[["EOCT_Repeaters_Cohort"]] <- Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]]
	Goodness_of_Fit2 <- c(Goodness_of_Fit2, Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]])
	Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- NULL


##	Run combineSGP for the Same Year repeaters (need to use the REPEATER_YEAR)

	Georgia_SGP_SameYear <- combineSGP(Georgia_SGP_SameYear)

##	Now add the PREFERRED SGP variable for a later sort of duplicates:
	# for (ca in names(Georgia_SGP_SameYear@SGP[['SGPercentiles']])) {
		# Georgia_SGP_SameYear@SGP[['SGPercentiles']][[ca]][['PREFERRED_SGP']] <- 1
	# }
	
###
###		Block Schedule progressions
###

##  DON'T Change back to YEAR (original SCHOOL_YEAR)!  Need the ALT year to distinquish the order (*_1 to *_2)
##  There are lots of kids who take these courses in the same year, and not all in order!  
#  Change Year to Alt Year 2, which gives ONLY order of administration periods
setnames(Georgia_SGP_SameYear@Data, "YEAR", "REPEATER_YEAR")
setnames(Georgia_SGP_SameYear@Data, "BLOCK_BASELINE_YEAR", "YEAR")

setnames(Georgia_SGP_SameYear@Data, "VALID_CASE", "VC_SAME_YR_REPEAT")
setnames(Georgia_SGP_SameYear@Data, "VC_BLOCK_SCHED_BASELINE", "VALID_CASE")

setkeyv(Georgia_SGP_SameYear@Data, c("VALID_CASE","CONTENT_AREA", "YEAR", "ID"))

###  ECON Baseline referenced

	setwd("../")
	dir.create('EOCT_Block_Schedule_Baseline/Baseline_Coeficient_Matrix_Construction', recursive=TRUE)
	setwd('EOCT_Block_Schedule_Baseline/Baseline_Coeficient_Matrix_Construction')
       
GA.config <- list(
        AMERICAN_LIT.BASELINE = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('101', '102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       BIOLOGY.BASELINE = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'),
           sgp.panel.years=c('101', '102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       PHYSICAL_SCIENCE.BASELINE = list(
           sgp.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('101', '102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       ECONOMICS.2012 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('101', '102'),
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

  for (a in 1:4) Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][[a]][[2]] <- NULL # Added 2/18/13 to remove duplicate created in run above (?)

	for (a in 11:14) Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][[a]][[1]]@Time[[1]] <- c("BASELINE", "BASELINE")
  for (a in 11:14) Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][[a]][[1]]@Time_Lags[[1]] <- 0L  # Added 2/18/13 

	Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['PHYSICAL_SCIENCE.BASELINE']] <- 
		c(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['PHYSICAL_SCIENCE.BASELINE']], Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['PHYSICAL_SCIENCE.102']])
	Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['BIOLOGY.BASELINE']] <- 
		c(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['BIOLOGY.BASELINE']], Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['BIOLOGY.102']])
	Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['AMERICAN_LIT.BASELINE']] <- 
		c(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['AMERICAN_LIT.BASELINE']], Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][['AMERICAN_LIT.102']])
	names(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']])[11] <- 'ECONOMICS.BASELINE'
	
	Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][12:14] <- NULL

	SGPstateData[['GA']][['Baseline_splineMatrix']][['Coefficient_Matrices']] <- 
		Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']][grep('BASELINE', names(Georgia_SGP_SameYear@SGP[['Coefficient_Matrices']]))]


	Goodness_of_Fit[["EOCT_Block_Schedule_Baseline_CoefMatrices"]] <- Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]]
	Goodness_of_Fit2 <- c(Goodness_of_Fit2, Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]])
	Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- NULL
	
#  Change Year to Alt Year to run individual year BASELINE analyses
setnames(Georgia_SGP_SameYear@Data, "YEAR", "BLOCK_BASELINE_YEAR") 
setnames(Georgia_SGP_SameYear@Data, "BLOCK_YEAR", "YEAR")

setnames(Georgia_SGP_SameYear@Data, "VALID_CASE", "VC_BLOCK_SCHED_BASELINE")
setnames(Georgia_SGP_SameYear@Data, "VC_BLOCK_SCHEDULE", "VALID_CASE")

setkeyv(Georgia_SGP_SameYear@Data, c("VALID_CASE","CONTENT_AREA", "YEAR", "ID"))

	setwd("../")
	dir.create('Baseline_SGP_Production')
	setwd('Baseline_SGP_Production')
       
GA.config <- list(
        AMERICAN_LIT.2010 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
           sgp.panel.years=c('2010_101', '2010_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT.2011 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
           sgp.panel.years=c('2011_101', '2011_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'), 
           sgp.panel.years=c('2012_101', '2012_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        BIOLOGY.2010 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'), 
           sgp.panel.years=c('2010_101', '2010_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        BIOLOGY.2011 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'), 
           sgp.panel.years=c('2011_101', '2011_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        BIOLOGY.2012 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'BIOLOGY'), 
           sgp.panel.years=c('2012_101', '2012_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        PHYSICAL_SCIENCE.2010 = list(
           sgp.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'), 
           sgp.panel.years=c('2010_101', '2010_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        PHYSICAL_SCIENCE.2011 = list(
           sgp.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'), 
           sgp.panel.years=c('2011_101', '2011_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('BIOLOGY', 'PHYSICAL_SCIENCE'), 
           sgp.panel.years=c('2012_101', '2012_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        ECONOMICS.2010 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('2010_101', '2010_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        ECONOMICS.2011 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('2011_101', '2011_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        ECONOMICS.2012 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('2012_101', '2012_102'),
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

	Goodness_of_Fit[["EOCT_Block_Schedule_Baseline_Production"]] <- Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]]
	Goodness_of_Fit2 <- c(Goodness_of_Fit2, Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]])
	Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- NULL


##  Math I and Math II Block Schedule (same year different course)

	setwd("../"); setwd("../")
	dir.create('EOCT_Block_Schedule_Cohort')
	setwd('EOCT_Block_Schedule_Cohort')

# comments like ### kids ; now ### are what I found by eliminating prior year repeaters and after:  # Before ; now # After
GA.config <- list(
       MATHEMATICS_II.2010 = list( #3,784 ; now
           sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
           sgp.panel.years=c('2010_101', '2010_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       MATHEMATICS_II.2011 = list( #1,546 ; now
           sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
           sgp.panel.years=c('2011_101', '2011_102'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       MATHEMATICS_II.2012 = list( #1,379 ; now
           sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
           sgp.panel.years=c('2012_101', '2012_102'),
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
	Goodness_of_Fit2 <- c(Goodness_of_Fit2, Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]])
	Georgia_SGP_SameYear@SGP[["Goodness_of_Fit_Seperated"]] <- Goodness_of_Fit
	Georgia_SGP_SameYear@SGP[["Goodness_of_Fit"]] <- Goodness_of_Fit2

	# SGPercentiles <- Georgia_SGP_SameYear@SGP[['SGPercentiles']]

	# for (ca in names(SGPercentiles)) {
		# if (!is.null(SGPercentiles[[ca]][['PREFERRED_SGP']])) {
			# SGPercentiles[[ca]][['PREFERRED_SGP']][is.na(SGPercentiles[[ca]][['PREFERRED_SGP']])] <- 2
		# }
	# }

	# setwd("/media/Data/SGP/Georgia_Same_Year")
	# save(SGPercentiles, file='Data/Georgia_Same_Year_Percentiles_ALL.Rdata')
	

###
###  Sort and choose the proper SGP for the duplicated cases
###
	
	# tot <- 0
	# for (n in names(Georgia_SGP_SameYear@SGP$SGPercentiles)) {
	  # tmp.dt <- data.table(Georgia_SGP_SameYear@SGP$SGPercentiles[[n]], key="ID")
	  # dups <- tmp.dt[c(which(duplicated(tmp.dt))-1, which(duplicated(tmp.dt))),]
	  # print(paste(n, ": ", dim(dups)[1], " Duplicates"), sep="")
	  # tot <- tot+dim(dups)[1]
	# }
	# print(paste("Total Duplicates:", tot/2))

	# for (ca in names(SGPercentiles)) {
		# if (!is.null(SGPercentiles[[ca]][['PREFERRED_SGP']])) {
			# tmp.sgp <- data.table(SGPercentiles[[ca]], key=c('ID', 'PREFERRED_SGP'))
			# setkeyv(tmp.sgp, "ID")
			# SGPercentiles[[ca]] <- data.frame(tmp.sgp[which(!duplicated(tmp.sgp)),][, -dim(tmp.sgp)[2], with=FALSE])
		# }
	# }

	# Georgia_SGP_SameYear@SGP[['SGPercentiles']] <- SGPercentiles

	# tot <- 0
	# for (n in names(Georgia_SGP_SameYear@SGP$SGPercentiles)) {
	  # tmp.dt <- data.table(Georgia_SGP_SameYear@SGP$SGPercentiles[[n]], key="ID")
	  # dups <- tmp.dt[c(which(duplicated(tmp.dt))-1, which(duplicated(tmp.dt))),]
	  # print(paste(n, ": ", dim(dups)[1], " Duplicates"), sep="")
	  # tot <- tot+dim(dups)[1]
	# }
	# print(paste("Total Duplicates:", tot/2))

###
###		combineSGP
###

	Georgia_SGP_SameYear <- combineSGP(Georgia_SGP_SameYear, years=c("2010_102", "2011_102", "2012_102"))

	tot<-0
	for(i in names(Georgia_SGP_SameYear@SGP[['SGPercentiles']])) {
	  print(paste(i, "N =", dim(Georgia_SGP_SameYear@SGP[['SGPercentiles']][[i]])[1], " :  Median SGP,", median(Georgia_SGP_SameYear@SGP[['SGPercentiles']][[i]][[2]])))
	  tot <- tot+(dim(Georgia_SGP_SameYear@SGP[['SGPercentiles']][[i]])[1])
	}
	tot #  
	sum(!is.na(Georgia_SGP_SameYear@Data$SGP))
	sum(!is.na(Georgia_SGP_SameYear@Data$SGP_BASELINE))

