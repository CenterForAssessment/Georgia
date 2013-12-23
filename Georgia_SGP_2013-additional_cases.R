###############################################################################################
###
###		Prepare and format the additional 2013 EOCT data using business rules for 2013 data
###		Run updateSGP on current object with new data. 
###
###############################################################################################

require(data.table)
require(plyr)

setwd('~/SGP_Projects/Georgia/Data/Base_Files')

###
###		2013 EOCT Data
###

###  Read in 2013 pipe delimited text files:

EOC <- read.delim('Catoosa 121013/2013-Catoosa_eoct-matched_pipe.txt', sep='|', header=TRUE)
UNM_EOC <- read.delim('Catoosa 121013/2013-Catoosa_eoct-!UN!matched_pipe.txt', sep='|', header=TRUE)
names(UNM_EOC)[2:5] <- c('SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'STUDENT_ID', 'STUDENT_GRADE_LEVEL') # Change from 'TEST_*_ID' to correspond to the "matched" files
names(UNM_EOC)[7:9] <- c("LAST_NAME", "FIRST_NAME", "MIDDLE_NAME") # Change name variables to correspong to matched file
EOC$MID_INITIAL <- NULL # remove this variable - all NA's

##  Remove non-Alternative Schools and districts other than GA Virtual School and Dept of Juv Justice
#UNM_EOC <- UNM_EOC[UNM_EOC[['SR_SCHOOL_ID']] > 6000 | UNM_EOC[['SR_SYSTEM_ID']] %in% c(794, 891),]
# table(UNM_EOC[['SR_SCHOOL_ID']], UNM_EOC[['SR_SYSTEM_ID']])

EOC[['MATCH_STATUS']] <- 'M'
UNM_EOC[['MATCH_STATUS']] <- 'U'

EOC <- data.table(rbind.fill(EOC, UNM_EOC))

levels(EOC[['ADMINISTRATION_PERIOD']]) <- "WINTER"

##  Rename subject code
levels(EOC[['SUBJ_CODE']]) <- c("GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS", "MATHEMATICS_I", "MATHEMATICS_II", "COORDINATE_ALGEBRA")

EOC[['SUBJ_CODE']] <- as.character(EOC[['SUBJ_CODE']])

length(EOC$GTID[which(nchar(EOC[['GTID']]) < 10)]); summary(as.factor(nchar(EOC[['GTID']])))
EOC <- EOC[!is.na(EOC[['GTID']]),]
EOC <- EOC[which(nchar(EOC[['GTID']]) == 10),]
EOC[['GTID']] <- as.character(EOC[['GTID']])


##  Create the same catch all invalidation indicator as above.
##  Shouldn't have to invalidate these, but keep for data checking and reference:

EOC[['ADMIN_INVALIDATION']] <- NA

EOC[['ADMIN_INVALIDATION']][EOC[['DNA_INDICATOR']]=='Y'] <- "DNA"
EOC[['ADMIN_INVALIDATION']][EOC[['PTNA_INDICATOR']]=='Y'] <- "PTNA"
# EOC[['ADMIN_INVALIDATION']][EOC[['IRREGULAR_ADMIN_INDICATOR']] =='Y'] <- "IRREG_ADMIN" # Don't use this flag ever according to Qi.
# table(EOC[['IRREGULAR_ADMIN_INDICATOR']], EOC[['ADMIN_INVALIDATION]]) #  All irreg admin covered by DNA and PTNA too
summary(EOC[['SCALE_SCORE']][!is.na(EOC[['ADMIN_INVALIDATION']])]) #  all NA's

# EOC[['VALID_CASE']][!is.na(CRC[['ADMIN_INVALIDATION']])] <- "INVALID_CASE"

### NULL out extraneous variables that are no longer needed
# EOC[, RETEST_INDICATOR := NULL]  #  Still keep since it is in 2013 and prior data
EOC[, IRREGULAR_ADMIN_INDICATOR := NULL]
EOC[, DNA_INDICATOR := NULL]
EOC[, PTNA_INDICATOR := NULL]
EOC[, PIV_INDICATOR := NULL]

# EOC[, MID_INITIAL := NULL]
EOC[, STUDENT_ID := NULL]
EOC[, TEST_RECORD_GRADE_FIELD := NULL]
EOC[, GRADE_CONVERSION := NULL]
EOC[, IEP := NULL]

## Fix names to correspond with what we will have in @Names
setnames(EOC, c('STUDENT_GRADE_LEVEL', 'SUBJ_CODE'), c('GRADE', 'SUBJECT_CODE'))


###
###		Combine the 2013 CRCT and EOCT data files
###

Catoosa_Data_LONG <- EOC

##  Create a 'GRADE_REPORTED' variable to retain the info contained in GRADE.
##  Change the GRADE Variable so that any EOCT test has the value 'EOCT' assigned to it:

Catoosa_Data_LONG[, GRADE_REPORTED := Catoosa_Data_LONG[['GRADE']]]
Catoosa_Data_LONG[['GRADE']] <- as.character(Catoosa_Data_LONG[['GRADE']])
Catoosa_Data_LONG[which(Catoosa_Data_LONG[['SUBJECT_CODE']] %in% c('GRADE_9_LIT', 'AMERICAN_LIT', 'BIOLOGY', 'PHYSICAL_SCIENCE', 'MATHEMATICS_I', 'MATHEMATICS_II', 'GEOMETRY', 'ALGEBRA', 'COORDINATE_ALGEBRA', 'US_HISTORY', 'ECONOMICS')), GRADE := 'EOCT']


###  Clean up other issues:

##  Clean up demographic variables
levels(Catoosa_Data_LONG[['RACE_CODE']]) <- c("African-American/Black", "Hispanic", "American Indian/Alaskan Native", "Two or More Races", "Pacific Islander", "Asian", "White")
levels(Catoosa_Data_LONG[['GENDER_CODE']]) <- c("Female", "Male")
levels(Catoosa_Data_LONG[['ED']]) <- c("Economically Disadvantaged: No", "Economically Disadvantaged: Yes")
levels(Catoosa_Data_LONG[['SWD']]) <- c("Student with Disability: No", "Student with Disability: Yes")
levels(Catoosa_Data_LONG[['LEP']]) <- c("LEP: No", "LEP: Yes")

#  Create an Enrollment status inclusion variable dummies:  
Catoosa_Data_LONG[['SCHOOL_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled School: No", "Enrolled School: Yes"))
Catoosa_Data_LONG[['DISTRICT_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled District: No", "Enrolled District: Yes"))
Catoosa_Data_LONG[['STATE_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled State: No", "Enrolled State: Yes"))

##  Unique School Identifier.  Continue to do this for consistency...

Catoosa_Data_LONG$SCHOOL_NUMBER <- Catoosa_Data_LONG$SR_SYSTEM_ID*10000 + Catoosa_Data_LONG$SR_SCHOOL_ID
Catoosa_Data_LONG[which(SR_SYSTEM_ID >1000), SCHOOL_NUMBER := SR_SYSTEM_ID]
Catoosa_Data_LONG[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

##  Get Variables into the appropriate class
Catoosa_Data_LONG[, SCALE_SCORE := as.numeric(SCALE_SCORE)]

Catoosa_Data_LONG[, PERFORMANCE_LEVEL := factor(PERFORMANCE_LEVEL, levels=1:3, 
	labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)]

## Create YEAR_WITHIN (1 = Winter, 2 = Spring, 3 = Summer)
##  All WINTER for Catoosa data

Catoosa_Data_LONG[ADMINISTRATION_PERIOD=="WINTER", YEAR_WITHIN:="1"]


###
###  Invalidate problematic cases:
###

##  Invalidate cases with missing ID and NA Scores

Catoosa_Data_LONG[, VALID_CASE := 'VALID_CASE']

### Invalidate ID's with fewer than 10 digits (or NA)
# This first step of converting GTID to character has been done already in Catoosa_Data_LONG.  Left to show what was done originally.
# remove periods if present.  This was NOT done previously.  Probably a handful of cases still in Catoosa_Data_LONG
Catoosa_Data_LONG[grep('[.]', Catoosa_Data_LONG[['GTID']]), GTID := gsub('[.]', '', GTID)]

Catoosa_Data_LONG[which(is.na(Catoosa_Data_LONG[['GTID']])), VALID_CASE := 'INVALID_CASE']
Catoosa_Data_LONG[which(nchar(Catoosa_Data_LONG[['GTID']]) != 10), VALID_CASE := 'INVALID_CASE']

## Invalidate NA and 0 scores
Catoosa_Data_LONG[which(is.na(Catoosa_Data_LONG[['SCALE_SCORE']]) | Catoosa_Data_LONG[['SCALE_SCORE']]==0), VALID_CASE := 'INVALID_CASE']

table(Catoosa_Data_LONG[['VALID_CASE']]) # 20

###  Duplicate case invalidation/removal:

#  Different scale score.  Take highest Score
setkeyv(Catoosa_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID"))
dups <- Catoosa_Data_LONG[c(which(duplicated(Catoosa_Data_LONG))-1, which(duplicated(Catoosa_Data_LONG))),]
setkeyv(dups, key(Catoosa_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 1 duplicate cases 

Catoosa_Data_LONG[which(duplicated(Catoosa_Data_LONG))-1, VALID_CASE := 'INVALID_CASE']

###  Duplicate cases from Georgia_SGP object (already in 2013 data)

# Catoosa_Data_LONG[GTID== 5700515512 & SUBJECT_CODE == 'ECONOMICS']$VALID_CASE <- 'INVALID_CASE'
# Catoosa_Data_LONG[GTID==4393002172 & SUBJECT_CODE == 'PHYSICAL_SCIENCE']$VALID_CASE <- 'INVALID_CASE'

table(Catoosa_Data_LONG$VALID_CASE) # 21 total invalids

###  Final removal of extraneous variables and save LONG data.  LEAVE NAMES AND BDAY - per Qi.

Catoosa_Data_LONG[, SR_SCHOOL_ID := NULL]
Catoosa_Data_LONG[, STUDENT_GRADE_LEVEL := NULL]
Catoosa_Data_LONG[, SCHOOL_YEAR := as.character(SCHOOL_YEAR)]

save(Catoosa_Data_LONG, file="../Catoosa_Data_LONG.Rdata")

###############################################################################################
###
###   Update the SGP object with the 2013 data
###
###############################################################################################

###
###		Additional cases from Catoosa Distrit
###

library(SGP)
library(data.table)
setwd('~/SGP_Projects/Georgia')
load('Data/Catoosa_Data_LONG.Rdata')
load('Data/Georgia_SGP.Rdata')

###  Create Subsets of new data based on whether the subject is cohort or baseline referenced.
###  Need to run these two sets seperately becuase we don't have full sets of SIMEX matrices for both SGP types (only have what we absolutely need...)
Catoosa_Baseline <- Catoosa_Data_LONG[SUBJECT_CODE %in% c('AMERICAN_LIT', 'BIOLOGY', 'ECONOMICS', 'GRADE_9_LIT', 'PHYSICAL_SCIENCE', 'US_HISTORY')]
Catoosa_Cohort <- Catoosa_Data_LONG[SUBJECT_CODE %in% c('COORDINATE_ALGEBRA', 'MATHEMATICS_I', 'MATHEMATICS_II')]

###  Temporarily remove the High needs status var.  If present updateSGP re-creates the variable.  
###  Doing this takes 20 minutes, so just do it once at the end using prepareSGP(...)
Georgia_SGP@Data[, HIGH_NEED_STATUS := NULL]

###  Invalidate 2 kids that have duplicate records.  Invalidate the existing becuase re-submissions scores are higher (per Qi and Alison)
sgp.key <- key(Georgia_SGP@Data)
Georgia_SGP@Data[ID == 5700515512 & CONTENT_AREA == 'ECONOMICS']$VALID_CASE <- 'INVALID_CASE'
Georgia_SGP@Data[ID == 4393002172 & CONTENT_AREA == 'PHYSICAL_SCIENCE']$VALID_CASE <- 'INVALID_CASE'

setkeyv(Georgia_SGP@Data, sgp.key)

###
### updateSGP:  Baseline EOCT content areas
###

SGPstateData[["GA"]][["SGP_Configuration"]]$goodness.of.fit.minimum.n <- 25000  #  UPdate this so that no GoFit plots are produced
# SGPstateData[["GA"]][["SGP_Configuration"]][["return.prior.scale.score.standardized"]] <- FALSE # this is set internally now.

### Load EOCT configurations

source("SGP_CONFIG/EOCT/2013/ELA.R")
source("SGP_CONFIG/EOCT/2013/SCIENCE.R")
source("SGP_CONFIG/EOCT/2013/SOCIAL_STUDIES.R")

GA_EOCT.config <- c(
		AMERICAN_LIT_2013.config,
		BIOLOGY_2013.config,
		ECONOMICS_2013.config,
		GRADE_9_LIT_2013.config,
		PHYSICAL_SCIENCE_2013.config,
		US_HISTORY_2013.config)

sum(is.na(Georgia_SGP@Data$SGP_SIMEX_BASELINE))
dim(Georgia_SGP@Data)

Georgia_SGP <- updateSGP(what_sgp_object = Georgia_SGP, with_sgp_data_LONG = Catoosa_Baseline, 
		steps = c("prepareSGP", "analyzeSGP"), # NO "combineSGP" yet
		sgp.config= GA_EOCT.config,
		sgp.percentiles = TRUE, # Both Cohort and Baseline SGPs
		sgp.projections = FALSE,# No projections - all EOCT subjects
		sgp.projections.lagged = FALSE,
		sgp.percentiles.baseline = TRUE, # Both Cohort and Baseline SGPs
		sgp.projections.baseline = FALSE,
		sgp.projections.lagged.baseline = FALSE,
		sgp.use.my.coefficient.matrices=TRUE,
		calculate.simex.baseline = TRUE,
        parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=6, BASELINE_PERCENTILES=6)))
		
sum(is.na(Georgia_SGP@Data$SGP_SIMEX_BASELINE))
dim(Georgia_SGP@Data)

# save(Georgia_SGP, file="Georgia_SGP.Rdata")

###  Rename results from updateSGP GEORGIA_SGP_Update_2013_Baseline_Subjects.Rdata


###
###		Math subjects - all cohort referenced
###

source("SGP_CONFIG/EOCT/2013/MATHEMATICS.R")

GA_EOCT.config <- c(
		# GEOMETRY_2013.config, # No Geometry in Catoosa 2013
		COORDINATE_ALGEBRA_2013.config,
		MATHEMATICS_II_2013.config,
		MATHEMATICS_I_2013.config)

Georgia_SGP <- updateSGP(what_sgp_object = Georgia_SGP, with_sgp_data_LONG = Catoosa_Cohort, 
		steps = c("prepareSGP", "analyzeSGP", "combineSGP"),  #
		sgp.config= GA_EOCT.config,
		sgp.percentiles = TRUE, # Only Cohort ref'd SGPs
		sgp.projections = FALSE,# No projections - all EOCT subjects
		sgp.projections.lagged = FALSE,
		sgp.percentiles.baseline = FALSE,
		sgp.projections.baseline = FALSE,
		sgp.projections.lagged.baseline = FALSE,
		sgp.use.my.coefficient.matrices=TRUE,
		calculate.simex = TRUE,
        parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=5)))

###		Fix the 2013 ADMINISTRATION_PERIOD variables to allign with previous years.
Georgia_SGP@Data[ which(ADMINISTRATION_PERIOD=='1'), ADMINISTRATION_PERIOD := "2: SPRING"]
Georgia_SGP@Data[ which(ADMINISTRATION_PERIOD=='2'), ADMINISTRATION_PERIOD := "3: SUMMER"]
Georgia_SGP@Data[ which(ADMINISTRATION_PERIOD=='3'), ADMINISTRATION_PERIOD := "1: WINTER"]

###  Run prepareSGP again to re-establish the "HIGH_NEEDS" variable
Georgia_SGP <- prepareSGP(Georgia_SGP)

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")

###  Rename results from updateSGP GEORGIA_SGP_Update_2013_Baseline_Cohort.Rdata

###
###		output the new data (for Dan and Derek)
###

Georgia_SGP <- outputSGP(Georgia_SGP, output.type = c("LONG_Data", "LONG_FINAL_YEAR_Data"))


###
###		output the data for Qi and Allison
###

setwd('~/SGP_Projects/Georgia')
library(data.table)
library(plyr)
library(SGP)

load('/home/avi/SGP_Projects/Georgia/Data/GEORGIA_SGP_Update_2013_Baseline_Subjects.Rdata')
outputSGP(GEORGIA_SGP_Update_2013, output.type = "LONG_FINAL_YEAR_Data")
##  Rename results from outputSGP Georgia_SGP_LONG_Data_2013_Baseline_Subjects.Rdata

load('/home/avi/SGP_Projects/Georgia/Data/GEORGIA_SGP_Update_2013_Cohort_Subjects.Rdata' )
outputSGP(GEORGIA_SGP_Update_2013, output.type = "LONG_FINAL_YEAR_Data")
##  Rename results from outputSGP Georgia_SGP_LONG_Data_2013_Cohort_Subjects.Rdata

load('Data/Georgia_SGP_LONG_Data_2013_Baseline_Subjects.Rdata')
Georgia_SGP_LONG_Data_2013_Baseline_Subjects <- Georgia_SGP_LONG_Data_2013[CONTENT_AREA %in% c('AMERICAN_LIT', 'BIOLOGY', 'ECONOMICS', 'GRADE_9_LIT', 'PHYSICAL_SCIENCE', 'US_HISTORY')]
Georgia_SGP_LONG_Data_2013_Baseline_Subjects$SCALE_SCORE_PRIOR_STANDARDIZED <- NULL

load('Data/Georgia_SGP_LONG_Data_2013_Cohort_Subjects.Rdata')
Georgia_SGP_LONG_Data_2013_Cohort_Subjects <- Georgia_SGP_LONG_Data_2013[CONTENT_AREA %in% c('COORDINATE_ALGEBRA', 'MATHEMATICS_I', 'MATHEMATICS_II')]
Georgia_SGP_LONG_Data_2013_Cohort_Subjects$SGP_BASELINE <- Georgia_SGP_LONG_Data_2013_Cohort_Subjects$SGP

Catoosa_SGP_LONG_Data_2013 <- rbind.fill(Georgia_SGP_LONG_Data_2013_Baseline_Subjects, Georgia_SGP_LONG_Data_2013_Cohort_Subjects)

save(Catoosa_SGP_LONG_Data_2013, file="Data/Catoosa_SGP_LONG_Data_2013.Rdata")
