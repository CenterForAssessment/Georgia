###############################################################################################
###
###   Prepare and format the 2013 CRCT and EOCT data using business rules for CURRENT year data
###
###############################################################################################

require(data.table)
require(plyr)

#setwd('~/SGP_Projects/Georgia/Data/Base_Files')
setwd('Data/Base_Files')


###
###		2013 CRCT Data
###

###  Read in 2013 CRCT pipe delimited text files:

SPR <- read.delim('fy2013_crct-spring_run20130920_pipe.txt', sep='|', header=TRUE)
UNM_SPR <- read.delim('fy2013_crct-UNMATCHED-spring_run20130920_pipe.txt', sep='|', header=TRUE)

SPR[['MATCH_STATUS']] <- 'M'
levels(SPR[['SUBJECT_CODE']]) <- c('ELA', 'MATHEMATICS', 'READING', 'SCIENCE', 'SOCIAL_STUDIES')  # ALL NA SUBJECT_CODE's are NA SCORES: table(SPR$SUBJECT_CODE, is.na(SPR$AYP_SCALE_SCORE)) 
SPR[['SUBJECT_CODE']] <- as.character(SPR[['SUBJECT_CODE']])
SPR[['GTID']] <- as.character(SPR[['GTID']])

UNM_SPR[['MATCH_STATUS']] <- 'U'
levels(UNM_SPR[['SUBJECT_CODE']]) <- c('ELA', 'MATHEMATICS', 'READING', 'SCIENCE', 'SOCIAL_STUDIES')
UNM_SPR[['SUBJECT_CODE']] <- as.character(UNM_SPR[['SUBJECT_CODE']])
UNM_SPR[['GTID']] <- as.character(UNM_SPR[['GTID']])
names(UNM_SPR)[2:4] <- c('SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'SR_STUDENT_ID') # Change from 'TEST_*_ID' to correspond to the "matched" files
names(UNM_SPR)[c(8,10, 14:15)] <- c("MIDDLE_NAME", "STUDENT_GRADE_LEVEL", "RACE_CODE", "GENDER_CODE")


###  Combine all the small data files into one data object

CRC <- data.table(rbind.fill(SPR, UNM_SPR))

##  Create the same catch all invalidation indicator as above.
##  Shouldn't have to invalidate these, but keep for data checking and reference:

CRC[['ADMIN_INVALIDATION']] <- NA

CRC[['ADMIN_INVALIDATION']][CRC[['TAR']] %in% c(2,3)] <- "TAR"
CRC[['ADMIN_INVALIDATION']][CRC[['PTNA']]==1] <- "PTNA"
CRC[['ADMIN_INVALIDATION']][CRC[['DNA']]==1] <- "DNA"
#CRC[['ADMIN_INVALIDATION']][CRC[['AYP_CTBRC']] %in% c(1,2,3,4)] <- "AYP_CTBRC" # Does't provide new info: 1=PTNA, 2 & 4 = TAR, 3=DNA
# CRC[['ADMIN_INVALIDATION']][!is.na(CRC[['ADMIN_INVALIDATION']])] <- paste(CRC[['DNA']], CRC[['PTNA']], CRC[['TAR']]) #multiple flags?  Not needed

table(CRC[['ADMIN_INVALIDATION']])

## NULL out extraneous variables that are no longer needed
CRC[, TAR := NULL]
CRC[, PTNA := NULL]
CRC[, DNA := NULL]
CRC[, AYP_CTBRC := NULL]

# CRC[, MIDDLE_NAME := NULL]
CRC[, SR_STUDENT_ID := NULL]
CRC[, ADMIN_TYPE := NULL] # RETEST_INDICATOR has same info now (N ~= 'Spring')
CRC[, TEST_TYPE := NULL]
# CRC[, STUDENT_GRADE_LEVEL := NULL] # Keep this temporarily for invalidation purposes below (then remove)

## Fix names to correspond with what we will have in @Names
setnames(CRC, c('AYP_GRADE', 'AYP_SCALE_SCORE', 'AYP_PERF_LEVEL'), c('GRADE', 'SCALE_SCORE', 'PERFORMANCE_LEVEL'))

###
###		2013 EOCT Data
###

###  Read in 2013 pipe delimited text files:

EOC <- read.delim('fy2013_eoct_run20130917_pipe_woRetest.txt', sep='|', header=TRUE)
UNM_EOC <- read.delim('fy2013_eoct-unmatched_run20130917_pipe.txt', sep='|', header=TRUE)
names(UNM_EOC)[2:5] <- c('SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'STUDENT_ID', 'STUDENT_GRADE_LEVEL') # Change from 'TEST_*_ID' to correspond to the "matched" files
names(UNM_EOC)[7:9] <- c("LAST_NAME", "FIRST_NAME", "MIDDLE_NAME") # Change name variables to correspong to matched file
EOC$MID_INITIAL <- NULL # remove this variable - all NA's

##  Remove non-Alternative Schools and districts other than GA Virtual School and Dept of Juv Justice
#UNM_EOC <- UNM_EOC[UNM_EOC[['SR_SCHOOL_ID']] > 6000 | UNM_EOC[['SR_SYSTEM_ID']] %in% c(794, 891),]
# table(UNM_EOC[['SR_SCHOOL_ID']], UNM_EOC[['SR_SYSTEM_ID']])

EOC[['MATCH_STATUS']] <- 'M'
UNM_EOC[['MATCH_STATUS']] <- 'U'

EOC <- data.table(rbind.fill(EOC, UNM_EOC))

levels(EOC[['ADMINISTRATION_PERIOD']]) <- c("SPRING", "SUMMER", "WINTER")

##  Rename subject code
levels(EOC[['SUBJ_CODE']]) <- c("ALGEBRA", "GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS", "MATHEMATICS_I", "MATHEMATICS_II", "COORDINATE_ALGEBRA")

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

Georgia_Data_LONG <- data.table(rbind.fill(CRC, EOC))

##  Create a 'GRADE_REPORTED' variable to retain the info contained in GRADE.
##  Change the GRADE Variable so that any EOCT test has the value 'EOCT' assigned to it:

Georgia_Data_LONG[, GRADE_REPORTED := Georgia_Data_LONG[['GRADE']]]
Georgia_Data_LONG[['GRADE']] <- as.character(Georgia_Data_LONG[['GRADE']])
Georgia_Data_LONG[which(Georgia_Data_LONG[['SUBJECT_CODE']] %in% c('GRADE_9_LIT', 'AMERICAN_LIT', 'BIOLOGY', 'PHYSICAL_SCIENCE', 'MATHEMATICS_I', 'MATHEMATICS_II', 'GEOMETRY', 'ALGEBRA', 'COORDINATE_ALGEBRA', 'US_HISTORY', 'ECONOMICS')), GRADE := 'EOCT']


###  Clean up other issues:

##  Clean up demographic variables
levels(Georgia_Data_LONG[['RACE_CODE']]) <- c("Asian", "African-American/Black", "Hispanic", "American Indian/Alaskan Native", "Two or More Races", "Pacific Islander", "Asian", "White", NA, NA)
levels(Georgia_Data_LONG[['GENDER_CODE']]) <- c("Female", "Male", NA, NA)
levels(Georgia_Data_LONG[['ED']]) <- c("Economically Disadvantaged: No", "Economically Disadvantaged: Yes")
levels(Georgia_Data_LONG[['SWD']]) <- c("Student with Disability: No", "Student with Disability: Yes")
levels(Georgia_Data_LONG[['LEP']]) <- c("LEP: No", "LEP: Yes")

#  Create an Enrollment status inclusion variable dummies:  
Georgia_Data_LONG[['SCHOOL_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled School: No", "Enrolled School: Yes"))
Georgia_Data_LONG[['DISTRICT_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled District: No", "Enrolled District: Yes"))
Georgia_Data_LONG[['STATE_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled State: No", "Enrolled State: Yes"))

##  Unique School Identifier.  Continue to do this for consistency...

Georgia_Data_LONG[, SCHOOL_NUMBER := SR_SYSTEM_ID*10000 + SR_SCHOOL_ID]
Georgia_Data_LONG[which(SR_SYSTEM_ID >1000), SCHOOL_NUMBER := SR_SYSTEM_ID]
Georgia_Data_LONG[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

##  Get Variables into the appropriate class
Georgia_Data_LONG[, SCALE_SCORE := as.numeric(SCALE_SCORE)]

Georgia_Data_LONG[, PERFORMANCE_LEVEL := factor(PERFORMANCE_LEVEL, levels=1:3, 
	labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)]

## Create YEAR_WITHIN (1 = Winter, 2 = Spring, 3 = Summer)

Georgia_Data_LONG[ADMINISTRATION_PERIOD=="WINTER", YEAR_WITHIN:="1"]
Georgia_Data_LONG[ADMINISTRATION_PERIOD=="SPRING", YEAR_WITHIN:="2"]
Georgia_Data_LONG[ADMINISTRATION_PERIOD=="SUMMER", YEAR_WITHIN:="3"]


###
###  Invalidate problematic cases:
###

##  Invalidate cases with missing ID and NA Scores

Georgia_Data_LONG[, VALID_CASE := 'VALID_CASE']

### Invalidate ID's with fewer than 10 digits (or NA)
# This first step of converting GTID to character has been done already in Georgia_Data_LONG.  Left to show what was done originally.
# remove periods if present.  This was NOT done previously.  Probably a handful of cases still in Georgia_Data_LONG
Georgia_Data_LONG[grep('[.]', Georgia_Data_LONG[['GTID']]), GTID := gsub('[.]', '', GTID)]

Georgia_Data_LONG[which(is.na(Georgia_Data_LONG[['GTID']])), VALID_CASE := 'INVALID_CASE']
Georgia_Data_LONG[which(nchar(Georgia_Data_LONG[['GTID']]) != 10), VALID_CASE := 'INVALID_CASE']

## Invalidate NA and 0 scores
Georgia_Data_LONG[which(is.na(Georgia_Data_LONG[['SCALE_SCORE']]) | Georgia_Data_LONG[['SCALE_SCORE']]==0), VALID_CASE := 'INVALID_CASE']

table(Georgia_Data_LONG[['VALID_CASE']]) # 75,208

###  Duplicate case invalidation/removal:

# Totally identical rows on all important variables (including scores)...
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMINISTRATION_PERIOD", "SCALE_SCORE"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 31 duplicate cases

Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG))-1, VALID_CASE := 'INVALID_CASE']


#  Different scale score, but duplicate in the same GRADE and Admin Period.  Take highest Grade
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 817 ADDITIONAL duplicate cases 

Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG))-1, VALID_CASE := 'INVALID_CASE']


#  Different matched case status (same "ADMINISTRATION_PERIOD").  Take the matched case if available.
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 27 ADDITIONAL duplicate cases 

Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG)), VALID_CASE := 'INVALID_CASE']

# Create YEAR_WITHIN for CRCT

Georgia_Data_LONG$YEAR_WITHIN[Georgia_Data_LONG$SUBJECT_CODE %in% c("MATHEMATICS", "ELA", "READING", "SCIENCE", "SOCIAL_STUDIES") & Georgia_Data_LONG$SCHOOL_YEAR=="2013" & Georgia_Data_LONG$VALID_CASE=="VALID_CASE"] <- "2"
#  Different GRADE.  (Keep "ADMINISTRATION_PERIOD" in key/sort for EOCT Tests.  All CRCT are NA)
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 4 ADDITIONAL duplicate cases 

#  First take matched student when duplicate is unmatched (not an issue in 2013)
# Georgia_Data_LONG[intersect(c(which(duplicated(Georgia_Data_LONG)), which(duplicated(Georgia_Data_LONG))-1), which(Georgia_Data_LONG$MATCH_STATUS=="U")) , VALID_CASE := 'INVALID_CASE']

#  Given BIRTH_DATE and STUDENT_GRADE_LEVEL, take grade that matches the STUDENT_GRADE_LEVEL
Georgia_Data_LONG[intersect(c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))), 
	which(STUDENT_GRADE_LEVEL != GRADE)), VALID_CASE := 'INVALID_CASE']

table(Georgia_Data_LONG$VALID_CASE) # 76,087 total cases (10/9/13)

###  Final removal of extraneous variables and save LONG data.  LEAVE NAMES AND BDAY - per Qi.

# Georgia_Data_LONG[, LAST_NAME := NULL]
# Georgia_Data_LONG[, FIRST_NAME := NULL]
# Georgia_Data_LONG[, BIRTH_DATE := NULL]
Georgia_Data_LONG[, SR_SCHOOL_ID := NULL]
Georgia_Data_LONG[, STUDENT_GRADE_LEVEL := NULL]
Georgia_Data_LONG[, SCHOOL_YEAR:=as.character(SCHOOL_YEAR)]

Georgia_Data_LONG_2013 <- Georgia_Data_LONG
save(Georgia_Data_LONG_2013, file="Georgia_Data_LONG_2013.Rdata")

###############################################################################################
###
###   Update the SGP object with the 2013 data
###
###############################################################################################

#load('../Georgia_SGP.Rdata')
#Georgia_SGP <- updateSGP(what_sgp_object=Georgia_SGP, with_sgp_data_LONG=Georgia_Data_LONG_2013, steps='prepareSGP')

#save(Georgia_SGP, file="../Georgia_SGP.Rdata")
