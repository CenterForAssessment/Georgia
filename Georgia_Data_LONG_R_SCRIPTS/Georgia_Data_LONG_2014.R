###############################################################################################
###
###   Prepare and format the 2014 CRCT and EOCT data using business rules for CURRENT year data
###
###############################################################################################

require(data.table)
require(plyr)

setwd('~/SGP_Projects/Georgia/Data/Base_Files')

###
###		2014 CRCT Data
###

###  Read in 2014 CRCT pipe delimited text files:

SPR <- read.delim('fy2014_crct-matched_20140904_pipe.txt', sep='|', header=TRUE)
UNM_SPR <- read.delim('crct2014_unmatched_sys89x_pipe.txt', sep='|', header=TRUE)

SPR[['MATCH_STATUS']] <- 'M'
levels(SPR[['SUBJECT_CODE']]) <- c('ELA', 'MATHEMATICS', 'READING', 'SCIENCE', 'SOCIAL_STUDIES') # table(SPR[['SUBJECT_CODE']], exclude=NULL) :: No NA SUBJECT_CODE's for 2014 :)
SPR[['SUBJECT_CODE']] <- as.character(SPR[['SUBJECT_CODE']])
SPR[['GTID']] <- as.character(SPR[['GTID']])

UNM_SPR[['MATCH_STATUS']] <- 'U'
levels(UNM_SPR[['SUBJECT_CODE']]) <- c('ELA', 'MATHEMATICS', 'READING', 'SCIENCE', 'SOCIAL_STUDIES') # table(UNM_SPR[['SUBJECT_CODE']], exclude=NULL) :: No NA SUBJECT_CODE's for 2014 :)
UNM_SPR[['SUBJECT_CODE']] <- as.character(UNM_SPR[['SUBJECT_CODE']])
UNM_SPR[['GTID']] <- as.character(UNM_SPR[['GTID']])
names(SPR)[!names(SPR) %in% names(UNM_SPR)]
names(UNM_SPR)[!names(UNM_SPR) %in% names(SPR)]

### Change names to correspond to the "matched" files (including 'TEST_*_ID' vars)
names(UNM_SPR)[c(2:4, 6:8,10, 15)] <- c('SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'SR_STUDENT_ID', "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME", "STUDENT_GRADE_LEVEL", "GENDER_CODE")


###  Combine all the small data files into one data object

CRC <- data.table(rbind.fill(SPR, UNM_SPR))

##  Create the same catch all invalidation indicator as above.
##  Shouldn't have to invalidate these, but keep for data checking and reference:

CRC[['ADMIN_INVALIDATION']] <- NA

# Only TAR = 1 in 2014 data.  All else NA
CRC[['ADMIN_INVALIDATION']][CRC[['TAR']] %in% c(2,3)] <- "TAR"
CRC[['ADMIN_INVALIDATION']][CRC[['PTNA']]==1] <- "PTNA"
CRC[['ADMIN_INVALIDATION']][CRC[['DNA']]==1] <- "DNA"

table(CRC[['ADMIN_INVALIDATION']])

## NULL out extraneous variables that are no longer needed
CRC[, TAR := NULL]
CRC[, PTNA := NULL]
CRC[, DNA := NULL]
CRC[, AYP_CTBRC := NULL]

CRC[, SR_STUDENT_ID := NULL]

## Fix names to correspond with EOC files and what we will have in @Names
setnames(CRC, c('AYP_GRADE', 'AYP_SCALE_SCORE', 'AYP_PERF_LEVEL'), c('GRADE', 'SCALE_SCORE', 'PERFORMANCE_LEVEL'))

levels(CRC[['ADMINISTRATION_PERIOD']]) <- "SPRING"


###
###		2014 EOCT Data
###

###  Read in 2014 pipe delimited text files:

EOC <- read.delim('fy2014_eoct-matched_20140904_pipe.txt', sep='|', header=TRUE)
UNM_EOC <- read.delim('eoct2014_unmatched_sys777-89x_pipe.txt', sep='\t', header=TRUE) # Tab delimited this year despite file name.

# Change Unmatched names to correspond to the "matched" files, and EOC names to match CRC / @Names
names(UNM_EOC)[c(2:5, 7:9, 11)] <- c('SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'STUDENT_ID', 'GRADE', 'LAST_NAME', 'FIRST_NAME', 'MIDDLE_NAME', 'SUBJECT_CODE')
names(EOC)[c(8, 12)] <- c('GRADE', 'SUBJECT_CODE')

EOC[['MATCH_STATUS']] <- 'M'
UNM_EOC[['MATCH_STATUS']] <- 'U'

EOC <- data.table(rbind.fill(EOC, UNM_EOC))

levels(EOC[['ADMINISTRATION_PERIOD']]) <- c("SPRING", "SUMMER", "WINTER", "WINTER") # 1 Winter Restest in Unmatched file?

##  Rename subject codes : "02GEO" "039TH" "04AME" "05BIO" "06PHY" "07USH" "08ECO" "10MA2" "11CAL" "12AGE"
levels(EOC[['SUBJECT_CODE']]) <- c("GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS", "MATHEMATICS_II", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")
EOC[['SUBJECT_CODE']] <- as.character(EOC[['SUBJECT_CODE']])

##  Remove kids with missing or malformed student ID's (34 in 2014 - all from Unmatched file)
length(EOC$GTID[which(nchar(EOC[['GTID']]) < 10)]); summary(as.factor(nchar(EOC[['GTID']])))
EOC <- EOC[!is.na(EOC[['GTID']]),]
EOC <- EOC[which(nchar(EOC[['GTID']]) == 10),]
EOC[['GTID']] <- as.character(EOC[['GTID']])


##  Create the same catch all invalidation indicator as above.
##  Shouldn't have to invalidate these, but keep for data checking and reference:

EOC[['ADMIN_INVALIDATION']] <- NA

EOC[['ADMIN_INVALIDATION']][EOC[['DNA_INDICATOR']]=='Y'] <- "DNA"
EOC[['ADMIN_INVALIDATION']][EOC[['PTNA_INDICATOR']]=='Y'] <- "PTNA"
EOC[['ADMIN_INVALIDATION']][EOC[['TEST_OUT_ADMINISTRATION']]=='Y'] <- "TEST_OUT"

# EOC[['ADMIN_INVALIDATION']][EOC[['IRREGULAR_ADMIN_INDICATOR']] =='Y'] <- "IRREG_ADMIN" # Don't use this flag ever according to Qi.
# summary(EOC[['SCALE_SCORE']][!is.na(EOC[['ADMIN_INVALIDATION']])]) #  PTNA and DNA are all NA's.  Test outs still have scores

### NULL out extraneous variables that are no longer needed
EOC[, IRREGULAR_ADMIN_INDICATOR := NULL]
EOC[, TEST_OUT_ADMINISTRATION := NULL]
EOC[, PTNA_INDICATOR := NULL]
EOC[, DNA_INDICATOR := NULL]
EOC[, PIV_INDICATOR := NULL]

EOC[, STUDENT_ID := NULL]
EOC[, TEST_RECORD_GRADE_FIELD := NULL]
EOC[, GRADE_CONVERSION := NULL]
EOC[, IEP := NULL]


###
###		Combine the 2014 CRCT and EOCT data files
###

Georgia_Data_LONG <- data.table(rbind.fill(CRC, EOC))

##  Create a 'GRADE_REPORTED' variable to retain the info contained in GRADE.
##  Change the GRADE Variable so that any EOCT test has the value 'EOCT' assigned to it:

Georgia_Data_LONG[, GRADE_REPORTED := Georgia_Data_LONG[['GRADE']]]
Georgia_Data_LONG[['GRADE']] <- as.character(Georgia_Data_LONG[['GRADE']])
Georgia_Data_LONG[which(Georgia_Data_LONG[['SUBJECT_CODE']] %in% c('GRADE_9_LIT', 'AMERICAN_LIT', 'BIOLOGY', 'PHYSICAL_SCIENCE', 'MATHEMATICS_I', 'MATHEMATICS_II', 'ALGEBRA', 'COORDINATE_ALGEBRA', 'GEOMETRY', 'ANALYTIC_GEOMETRY', 'US_HISTORY', 'ECONOMICS')), GRADE := 'EOCT']


###  Clean up other issues:

##  Clean up demographic variables
levels(Georgia_Data_LONG[['RACE_CODE']]) <- c("African-American/Black", "Hispanic", "American Indian/Alaskan Native", "Two or More Races", "Pacific Islander", "Asian", "White", NA, "Asian/Pacific Islander")
levels(Georgia_Data_LONG[['GENDER_CODE']]) <- c("Female", "Male", NA)
levels(Georgia_Data_LONG[['ED']]) <- c("Economically Disadvantaged: No", "Economically Disadvantaged: Yes")
levels(Georgia_Data_LONG[['SWD']]) <- c("Student with Disability: No", "Student with Disability: Yes")
levels(Georgia_Data_LONG[['LEP']]) <- c("LEP: No", "LEP: Yes")

#  Create an Enrollment status inclusion variable dummies:  
Georgia_Data_LONG[['SCHOOL_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled School: No", "Enrolled School: Yes"))
Georgia_Data_LONG[['DISTRICT_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled District: No", "Enrolled District: Yes"))
Georgia_Data_LONG[['STATE_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled State: No", "Enrolled State: Yes"))

##  Unique School Identifier.  Continue to do this for consistency...

Georgia_Data_LONG$SCHOOL_NUMBER <- Georgia_Data_LONG$SR_SYSTEM_ID*10000 + Georgia_Data_LONG$SR_SCHOOL_ID
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

##  Create VALID_CASE var and start with all valid.
Georgia_Data_LONG[, VALID_CASE := 'VALID_CASE']

##  Invalidate ADMIN_INVALIDATION
Georgia_Data_LONG[!is.na(ADMIN_INVALIDATION), VALID_CASE := 'INVALID_CASE']
table(Georgia_Data_LONG[['VALID_CASE']]) # 3,862

## Invalidate ID's with fewer than 10 digits (or NA)
# remove periods if present.
Georgia_Data_LONG[grep('[.]', Georgia_Data_LONG[['GTID']]), GTID := gsub('[.]', '', GTID)]

Georgia_Data_LONG[which(is.na(Georgia_Data_LONG[['GTID']])), VALID_CASE := 'INVALID_CASE']
Georgia_Data_LONG[which(nchar(Georgia_Data_LONG[['GTID']]) != 10), VALID_CASE := 'INVALID_CASE']

## Invalidate NA and 0 scores
Georgia_Data_LONG[which(is.na(Georgia_Data_LONG[['SCALE_SCORE']]) | Georgia_Data_LONG[['SCALE_SCORE']]==0), VALID_CASE := 'INVALID_CASE']

table(Georgia_Data_LONG[['VALID_CASE']]) # 4,682

###  Duplicate case invalidation/removal:

# Totally identical rows on all important variables (including scores)...
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMINISTRATION_PERIOD", "SCALE_SCORE"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 81 duplicate cases

Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG))-1, VALID_CASE := 'INVALID_CASE']


#  Different scale score, but duplicate in the same GRADE and Admin Period.  Take highest Scale Score
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 1,616 ADDITIONAL duplicate cases 

Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG))-1, VALID_CASE := 'INVALID_CASE']


#  Different matched case status (same "ADMINISTRATION_PERIOD").  Take the matched case if available.
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 6 ADDITIONAL duplicate cases 

Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG)), VALID_CASE := 'INVALID_CASE']

# Create YEAR_WITHIN for CRCT

Georgia_Data_LONG$YEAR_WITHIN[Georgia_Data_LONG$SUBJECT_CODE %in% c("MATHEMATICS", "ELA", "READING", "SCIENCE", "SOCIAL_STUDIES") & Georgia_Data_LONG$SCHOOL_YEAR=="2014" & Georgia_Data_LONG$VALID_CASE=="VALID_CASE"] <- "2"
#  Different GRADE.  (Keep "ADMINISTRATION_PERIOD" in key/sort for EOCT Tests.  All CRCT are NA)
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 243 ADDITIONAL duplicate cases 

#  First take matched student when duplicate is unmatched
Georgia_Data_LONG[intersect(c(which(duplicated(Georgia_Data_LONG)), which(duplicated(Georgia_Data_LONG))-1), which(Georgia_Data_LONG$MATCH_STATUS=="U")) , VALID_CASE := 'INVALID_CASE']

#  Given BIRTH_DATE and STUDENT_GRADE_LEVEL, take grade that matches the STUDENT_GRADE_LEVEL
#  Look into this further.  Might want to take the highest GRADE so that the kid gets an SGP next year.
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "BIRTH_DATE", "YEAR_WITHIN"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 233 ADDITIONAL duplicate cases 
Georgia_Data_LONG[intersect(c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))), 
	which(as.numeric(STUDENT_GRADE_LEVEL) != GRADE)), VALID_CASE := 'INVALID_CASE']

table(Georgia_Data_LONG$VALID_CASE) # 6637 total cases (9/19/14)

setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "YEAR_WITHIN"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 1 ADDITIONAL duplicate case. Two different grade levels. She shows up as 6th grade last year so invalidate 6th this year. (Both exceeds scores in 2014)
Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG))-1, VALID_CASE := 'INVALID_CASE']

table(Georgia_Data_LONG$VALID_CASE) # 6638 total cases (9/19/14)


###  Final removal of extraneous variables and save LONG data.  LEAVE NAMES AND BDAY - per Qi.

# Georgia_Data_LONG[, MIDDLE_NAME := NULL] # Keep as of 2013
Georgia_Data_LONG[, SR_SCHOOL_ID := NULL]
Georgia_Data_LONG[, STUDENT_GRADE_LEVEL := NULL]

Georgia_Data_LONG[, SCHOOL_YEAR:=as.character(SCHOOL_YEAR)]

Georgia_Data_LONG_2014 <- Georgia_Data_LONG
save(Georgia_Data_LONG_2014, file="../Georgia_Data_LONG_2014.Rdata")

###############################################################################################
###
###   Update the SGP object with the 2014 data
###
###############################################################################################

load('../Georgia_SGP.Rdata')

GA_2014 <- prepareSGP(Georgia_Data_LONG_2014)
sgp.key <- key(Georgia_SGP@Data)
Georgia_SGP@Data <- data.table(rbind.fill(Georgia_SGP@Data, GA_2014@Data), key=sgp.key)

Georgia_SGP <- prepareSGP(Georgia_SGP)

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")


