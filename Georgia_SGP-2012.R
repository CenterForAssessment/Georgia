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
					PROJECTIONS=11, LAGGED_PROJECTIONS=11)))

Georgia_Simulated_SGPs <- Georgia_SGP@SGP[['Simulated_SGPs']]
Georgia_SGP@SGP[['Simulated_SGPs']] <- NULL

save(Georgia_SGP, file="Data/Georgia_SGP-2012.Rdata")
save(Georgia_Simulated_SGPs, file="Data/Georgia_Simulated_SGPs-2012.Rdata")

#  Code used to output the CRCT Results for Review on week of 11/26
# Georgia_SGP <- combineSGP(Georgia_SGP)
# Georgia_SGP@Data <- Georgia_SGP@Data[Georgia_SGP@Data$CONTENT_AREA %in% c("ELA", "READING", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES") &
	# Georgia_SGP@Data$GRADE %in% 3:8,]

# summary(as.factor(Georgia_SGP@Data$CONTENT_AREA))
# table(Georgia_SGP@Data$CONTENT_AREA, !is.na(Georgia_SGP@Data$SGP), Georgia_SGP@Data$YEAR)
# table(Georgia_SGP@Data$CONTENT_AREA, !is.na(Georgia_SGP@Data$SGP_BASELINE), Georgia_SGP@Data$YEAR)
# dim(Georgia_SGP@Data)

# outputSGP(Georgia_SGP, output.type="LONG_Data", outputSGP.directory="CRCT_Results")

# dim(Georgia_SGP@Data)
# Georgia_SGP@Data <- Georgia_SGP@Data[Georgia_SGP@Data$YEAR=='2012',]
# dim(Georgia_SGP@Data)



##############################################################################
###
### Grade level EOC tests
###
##############################################################################

Georgia_SGP@Data[['GRADE']][Georgia_SGP@Data[['GRADE']]> 8] <- 'EOCT' #  Look at NA grade subjects - could these be turned into EOCT too?

load('/media/Data/SGP/Georgia/Data/Baseline_Matrices/GA_Baseline_Matrices.Rdata')
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- GA_Baseline_Matrices

#  Straightforward progressions with Middle school priors available

GA.config <- list(
        GRADE_9_LIT.2012 = list(
           sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8,8, 'EOCT'))),
        AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),        

	###		ALGEBRA and GEOMETRY new for 2012
        ALGEBRA.2012 = list(
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'ALGEBRA'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c(7:8, 'EOCT'))), # , c(7:8, NA, 'EOCT') - less than 2,000 kids.  Marginal fit ... 
        GEOMETRY.2012 = list(
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'GEOMETRY'),
           sgp.panel.years=c('2009', '2010', '2011', '2012'),
           sgp.grade.sequences=list(c(7:8, NA, 'EOCT'))), # NO 7th grade students in students c(7:8, 'EOCT'), ~ 1000 with 8th grade - c(8, 'EOCT'), ugly fit

        MATHEMATICS_I.2012 = list(
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS_I'),
           sgp.panel.years=c('2009', '2010', '2011', '2012'),
           sgp.grade.sequences=list(c('6', '7', '8'), c(7:8, 'EOCT'), c(7:8, NA, 'EOCT'))),
        MATHEMATICS_II.2012 = list(
           sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS_I', 'MATHEMATICS_II'),
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8,'EOCT', 'EOCT'), c('EOCT', 'EOCT'))),

        PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('SCIENCE', 'SCIENCE', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2009', '2010', '2011', '2012'),
           sgp.grade.sequences=list(c('6', '7', '8'), c(7:8, 'EOCT'), c(7:8, NA, 'EOCT'))),
        BIOLOGY.2012 = list(
           sgp.content.areas=c('SCIENCE', 'SCIENCE', 'BIOLOGY'),
           sgp.panel.years=c('2009', '2010', '2011', '2012'),
           sgp.grade.sequences=list(c(7:8, 'EOCT'), c(7:8, NA, 'EOCT'))),

        US_HISTORY.2012 = list(
           sgp.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'), 
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8, 'EOCT'), c(8, NA, 'EOCT'))), # 8:9, 8, 10
        ECONOMICS.2012 = list(
           sgp.content.areas=c('US_HISTORY', 'ECONOMICS'), 
           sgp.panel.years=c('2010', '2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'), c('EOCT', NA, 'EOCT'))))


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
                WORKERS=list(PERCENTILES=24, BASELINE_PERCENTILES=24)))


###  Create an additional variable PREFERRED_SGP to identify which SGP to keep for kids who will have duplicates:

multiple.content.areas <- c('AMERICAN_LIT', 'GRADE_9_LIT', 'PHYSICAL_SCIENCE', 'BIOLOGY')

	for (ca in multiple.content.areas) {
		Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']] <- 2
		Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']] <- 2
	}


#  Less typical course sequences:

GA.config <- list(
        GRADE_9_LIT.2012 = list(
           sgp.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
           sgp.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
           sgp.grade.sequences=list(c(7,7,8,8, 'EOCT'))),
        AMERICAN_LIT.2012 = list(
           sgp.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8,8, 'EOCT', 'EOCT'), c(8,8, 'EOCT', NA, 'EOCT'))), # 8:10, and 8,9,11

       BIOLOGY.2012 = list(
           sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
           sgp.panel.years=c('2008', '2009', '2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8,8, 'EOCT', 'EOCT'))), # 8:10
       PHYSICAL_SCIENCE.2012 = list(
           sgp.content.areas=c('SCIENCE', 'BIOLOGY', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2008', '2009', '2010', '2011', '2012'),
           sgp.grade.sequences=list(c(8,8, 'EOCT', 'EOCT'))), # 8:10
           
###
###		Repeaters - new to 2012
###

        GRADE_9_LIT_REPEATERS.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'GRADE_9_LIT'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
        AMERICAN_LIT_REPEATERS.2012 = list(
           sgp.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

       BIOLOGY_REPEATERS.2012 = list(
           sgp.content.areas=c('BIOLOGY', 'BIOLOGY'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
       PHYSICAL_SCIENCE_REPEATERS.2012 = list(
           sgp.content.areas=c('PHYSICAL_SCIENCE', 'PHYSICAL_SCIENCE'),
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),

        US_HISTORY.2012 = list(
           sgp.content.areas=c('US_HISTORY', 'US_HISTORY'), 
           sgp.panel.years=c('2011', '2012'),
           sgp.grade.sequences=list(c('EOCT', 'EOCT'))),
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
                WORKERS=list(PERCENTILES=6, BASELINE_PERCENTILES=6)))      


#  Replace the NA in the PREFERRED_SGP with a 1 now for those content areas that may have duplicates

	for (ca in multiple.content.areas) {
		Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']][
			is.na(Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, sep='.')]][['PREFERRED_SGP']])] <- 1
		Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']][
			is.na(Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, 'BASELINE', sep='.')]][['PREFERRED_SGP']])] <- 1
	}

#  Check to see the N on each Content Area analysis as well as the Median SGP
tot<-0
for(i in names(Georgia_SGP@SGP[['SGPercentiles']])[-grep("BASELINE", names(Georgia_SGP@SGP[['SGPercentiles']]))]) {
	print(paste(i, "N =", dim(Georgia_SGP@SGP[['SGPercentiles']][[i]])[1], " :  Median SGP,", median(Georgia_SGP@SGP[['SGPercentiles']][[i]][["SGP"]])))
	tot <- tot+(dim(Georgia_SGP@SGP[['SGPercentiles']][[i]])[1])
}
tot #

###  Sort and choose the proper SGP for the duplicated cases

	for (ca in multiple.content.areas) {
		tmp.sgp <- data.table(Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, sep='.')]], key=c('ID', 'PREFERRED_SGP'))
		setkeyv(tmp.sgp, "ID")
		Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, sep='.')]] <- data.frame(tmp.sgp[which(!duplicated(tmp.sgp)),][, -dim(tmp.sgp)[2], with=FALSE])

		tmp.sgp <- data.table(Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, 'BASELINE', sep='.')]], key=c('ID', 'PREFERRED_SGP'))
		setkeyv(tmp.sgp, "ID")
		Georgia_SGP@SGP[['SGPercentiles']][[paste(ca, 2012, 'BASELINE', sep='.')]] <- data.frame(tmp.sgp[which(!duplicated(tmp.sgp)),][, -dim(tmp.sgp)[2], with=FALSE])
	}

#  Check to see the N on each Content Area analysis (should be fewer than before) as well as the Median SGP (should still be ~50)
tot<-0
for(i in names(Georgia_SGP@SGP[['SGPercentiles']])[-grep("BASELINE", names(Georgia_SGP@SGP[['SGPercentiles']]))]) {
	print(paste(i, "N =", dim(Georgia_SGP@SGP[['SGPercentiles']][[i]])[1], " :  Median SGP,", median(Georgia_SGP@SGP[['SGPercentiles']][[i]][["SGP"]])))
	tot <- tot+(dim(Georgia_SGP@SGP[['SGPercentiles']][[i]])[1])
}
tot #

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")


