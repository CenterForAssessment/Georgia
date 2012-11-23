###############################################################################################
###############################################################################################
####
####		Georgia Student Growth Percentiles Analysis 
####		Criterion-Referenced Competency Tests (CRCT) & End of Course Tests (EOCT)
####		Data preparation and formating
####		Adam VanIwaarden/Damian Betebenner - NCIEA
####
###############################################################################################
###############################################################################################

###  CONTENTS / LAYOUT OF SCRIPT:

##  1)  Prepare the missing 2007-2011 EOCT Summer Data
##  2)  Prepare the unmatched CRCT and EOCT data from 2007-2011
##  3)  Combine the new 2007-2011 data formated above with the existing LONG data set
##  4)  Re-construct the previous VALID_CASE variable to conform to official business rules to re-produce 2011 EOCT SGPs after 2012 SGPs produced
##	    -- New VALID_CASE variable saved as "VC_2011_CORRECTED" 
##	    -- OLD VALID_CASE variable saved as "VC_2011_ORIGINAL" 
##  5)  Construct the VALID_CASE variable for use of 2007-20011 data as PRIORS (which follow different business rules as those for the CURRENT year data)

##  6)  Prepare and format the 2012 CRCT and EOCT data using business rules for CURRENT year data
##  7)  Combine the 2012 data with the 2007-11 data

##  8)  Reformat the previous SGP object, particularly the existing coefficient matrices.
##  9)  Replace the existing @Data slot of the SGP object with the 2007-2012 LONG data produced in steps 1 to 7

### Load required packages

require(SGP)
setwd("/media/Data/SGP/Georgia")

###############################################################################################
###
###  1)  Prepare the missing 2007-2011 EOCT Summer Data		
###
###############################################################################################

##  The 'layout**.csv' files are files Adam put together to read in the needed data for the DOE File Layouts to be read in from Fixed width format

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)

###  2011
l11 <- read.csv('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/layout11.csv', header=T, stringsAsFactors=F)
var.name <- trimWhiteSpace(l11$FIELD.NAME[!is.na(l11$LENGTH)])
var.name <- toupper(gsub(" ", "_", var.name))
wid <- l11$LENGTH[!is.na(l11$LENGTH)]

d11 <- read.fwf('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/EOCTSummer2011.txt', widths=wid, buffersize=100000, comment.char="")
names(d11) <- var.name

d11 <- data.table(d11, key="GTID")
d11 <- d11[,c("GTID",  "SECTION_NAME", "GRADE", "SCALE_SCORE", "PERFORMANCE_LEVEL", "GRADE_CONVERSION", "SYSTEM_CODE", "SCHOOL_CODE", "GENDER", "REPORTED_RACE/ETHNICITY", "IEP", "ELL/TPC", "ADMIN_DATE", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION_(RESOLVED)", "INVALID_ADMINISTRATION_(RESOLVED)"), with=FALSE]

setnames(d11, 
	c('SECTION_NAME', 'SCHOOL_CODE', 'SYSTEM_CODE', 'GENDER', "REPORTED_RACE/ETHNICITY", "ELL/TPC", "IEP", "ADMIN_DATE", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION_(RESOLVED)", "INVALID_ADMINISTRATION_(RESOLVED)"), 
	c('SUBJECT_CODE', 'SR_SCHOOL_ID', 'SR_SYSTEM_ID', 'GENDER_CODE', 'RACE_CODE', 'LEP', 'SWD', "ADMINISTRATION_PERIOD", "PTNA_INDICATOR", "DNA_INDICATOR","IRREGULAR_ADMIN_INDICATOR", "INVALID_ADMINISTRATION_INDICATOR"))

#  Create YEAR variable
d11[['SCHOOL_YEAR']] <- 2011L

#  Content area clean up
levels(d11[['SUBJECT_CODE']]) <- substring(levels(d11[['SUBJECT_CODE']]), 1, 5)
levels(d11[['SUBJECT_CODE']]) <- c("GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS", "MATHEMATICS_I", "MATHEMATICS_II")
d11[['SUBJECT_CODE']] <- as.character(d11[['SUBJECT_CODE']])

###  2010
l10 <- read.csv('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/layout10.csv', header=T, stringsAsFactors=F)
var.name <- trimWhiteSpace(l10$FIELD.NAME[!is.na(l10$LENGTH)])
var.name <- toupper(gsub(" ", "_", var.name))
wid <- l10$LENGTH[!is.na(l10$LENGTH)]

d10 <- read.fwf('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/EOCTSummer2010.txt', widths=wid, buffersize=100000, comment.char="")
names(d10) <- var.name

names.11 <- c("GTID",  "SECTION_NAME", "GRADE", "SCALE_SCORE", "PERFORMANCE_LEVEL", "GRADE_CONVERSION", "SYSTEM_CODE", "SCHOOL_CODE", "GENDER", "REPORTED_RACE/ETHNICITY", "IEP", "ELL/TPC", "ADMIN_DATE", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION_(RESOLVED)", "INVALID_ADMINISTRATION_(RESOLVED)")

for (i in names.11) {
	print(paste(i, "column", grep(i, names(d10)))) 
	grep(i, names(d10))->q
	print(names(d10)[q])
} #IRREGULAR_ADMINISTRATION_(RESOLVED)

d10 <- data.table(d10, key="GTID")
d10 <- d10[,c("GTID",  "SECTION_NAME", "GRADE", "SCALE_SCORE", "PERFORMANCE_LEVEL", "GRADE_CONVERSION", "SYSTEM_CODE", "SCHOOL_CODE", "GENDER", "REPORTED_RACE/ETHNICITY", "IEP", "ELL/TPC", "ADMIN_DATE", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION", "INVALID_ADMINISTRATION_(RESOLVED)"), with=FALSE]

setnames(d10, c('SECTION_NAME', 'SCHOOL_CODE', 'SYSTEM_CODE', 'GENDER', "REPORTED_RACE/ETHNICITY", "ELL/TPC", "IEP", "ADMIN_DATE", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION", "INVALID_ADMINISTRATION_(RESOLVED)"), c('SUBJECT_CODE', 'SR_SCHOOL_ID', 'SR_SYSTEM_ID', 'GENDER_CODE', 'RACE_CODE', 'LEP', 'SWD', "ADMINISTRATION_PERIOD", "PTNA_INDICATOR", "DNA_INDICATOR","IRREGULAR_ADMIN_INDICATOR", "INVALID_ADMINISTRATION_INDICATOR"))

#  Create YEAR variable
d10[['SCHOOL_YEAR']] <- 2010L

#  Content area clean up
levels(d10[['SUBJECT_CODE']]) <- substring(levels(d10[['SUBJECT_CODE']]), 1, 5)
levels(d10[['SUBJECT_CODE']]) <- c("GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS", "MATHEMATICS_I", "MATHEMATICS_II")
d10[['SUBJECT_CODE']] <- as.character(d10[['SUBJECT_CODE']])

###  2009
l09 <- read.csv('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/layout09.csv', header=T, stringsAsFactors=F)
var.name <- trimWhiteSpace(l09$FIELD.NAME[!is.na(l09$LENGTH)])
var.name <- toupper(gsub(" ", "_", var.name))
wid <- l09$LENGTH[!is.na(l09$LENGTH)]

d09 <- read.fwf('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/EOCTSummer2009.txt', widths=wid, buffersize=100000, comment.char="")
names(d09) <- var.name

for (i in names.11) {
	print(paste(i, "column", grep(i, names(d09)))) 
	grep(i, names(d09))->q
	print(names(d09)[q])
} #IRREGULAR_ADMINISTRATION_(RESOLVED)

d09 <- data.table(d09, key="GTID")
d09 <- d09[,c("GTID",  "SECTION_NAME", "GRADE", "SCALE_SCORE", "PERFORMANCE_LEVEL", "GRADE_CONVERSION", "SYSTEM_CODE", "SCHOOL_CODE", "GENDER", "RACE", "IEP", "ELL/TPC", "ADMIN", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION", "INVALID_ADMINISTRATION"), with=FALSE]

setnames(d09, c('SECTION_NAME', 'SCHOOL_CODE', 'SYSTEM_CODE', 'GENDER', "RACE", "ELL/TPC", "IEP", "ADMIN", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION", "INVALID_ADMINISTRATION"), c('SUBJECT_CODE', 'SR_SCHOOL_ID', 'SR_SYSTEM_ID', 'GENDER_CODE', 'RACE_CODE', 'LEP', 'SWD', "ADMINISTRATION_PERIOD", "PTNA_INDICATOR", "DNA_INDICATOR","IRREGULAR_ADMIN_INDICATOR", "INVALID_ADMINISTRATION_INDICATOR"))

#  Create YEAR variable
d09[['SCHOOL_YEAR']] <- 2009L

#  Content area clean up
levels(d09[['SUBJECT_CODE']]) <- substring(levels(d09[['SUBJECT_CODE']]), 1, 5)
levels(d09[['SUBJECT_CODE']]) <- c("ALGEBRA", "GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS")
d09[['SUBJECT_CODE']] <- as.character(d09[['SUBJECT_CODE']])

levels(d09[['GRADE']]) <- c(NA, "8", "9", "10", "11", "12", NA, NA)
d09[['GRADE']] <- as.integer(as.character(d09[['GRADE']]))

###  2008
l08 <- read.csv('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/layout08.csv', header=T, stringsAsFactors=F)
var.name <- trimWhiteSpace(l08$FIELD.NAME[!is.na(l08$LENGTH)])
var.name <- toupper(gsub(" ", "_", var.name))
wid <- l08$LENGTH[!is.na(l08$LENGTH)]

d08 <- read.fwf('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/EOCTSummer2008.txt', widths=wid, buffersize=100000, comment.char="")
names(d08) <- var.name

for (i in names.11) {
	print(paste(i, "column", grep(i, names(d08)))) 
	grep(i, names(d08))->q
	print(names(d08)[q])
} #IRREGULAR_ADMINISTRATION_(RESOLVED)

d08 <- data.table(d08, key="GTID")
d08 <- d08[,c("GTID",  "SECTION_NAME", "GRADE", "SCALE_SCORE", "PERFORMANCE_LEVEL", "GRADE_CONVERSION", "SYSTEM_CODE", "SCHOOL_CODE", "GENDER", "RACE", "IEP", "ELL/TPC", "ADMIN_DATE", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION", "INVALID_ADMINISTRATION"), with=FALSE]

setnames(d08, c('SECTION_NAME', 'SCHOOL_CODE', 'SYSTEM_CODE', 'GENDER', "RACE", "ELL/TPC", "IEP", "ADMIN_DATE", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION", "INVALID_ADMINISTRATION"), c('SUBJECT_CODE', 'SR_SCHOOL_ID', 'SR_SYSTEM_ID', 'GENDER_CODE', 'RACE_CODE', 'LEP', 'SWD', "ADMINISTRATION_PERIOD", "PTNA_INDICATOR", "DNA_INDICATOR","IRREGULAR_ADMIN_INDICATOR", "INVALID_ADMINISTRATION_INDICATOR"))

#  Create YEAR variable
d08[['SCHOOL_YEAR']] <- 2008L

#  Content area clean up
levels(d08[['SUBJECT_CODE']]) <- substring(levels(d08[['SUBJECT_CODE']]), 1, 5)
levels(d08[['SUBJECT_CODE']]) <- c("ALGEBRA","GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS")
d08[['SUBJECT_CODE']] <- as.character(d08[['SUBJECT_CODE']])

###  2007
l07 <- read.csv('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/layout07.csv', header=T, stringsAsFactors=F)
var.name <- trimWhiteSpace(l07$FIELD.NAME[!is.na(l07$LENGTH)])
var.name <- toupper(gsub(" ", "_", var.name))
wid <- l07$LENGTH[!is.na(l07$LENGTH)]

d07 <- read.fwf('Data/Base_Files/2007-11_Data/September 2012 - EOCT Summer 2006-2011/EOCTSummer2007.txt', widths=wid, buffersize=100000, comment.char="")
names(d07) <- var.name

for (i in names.11) {
	print(paste(i, "column", grep(i, names(d07)))) 
	grep(i, names(d07))->q
	print(names(d07)[q])
} #IRREGULAR_ADMINISTRATION_(RESOLVED)


d07 <- data.table(d07, key="GTID")
d07 <- d07[,c("GTID",  "SECTION_NAME", "GRADE", "SCALE_SCORE", "PERFORMANCE_LEVEL", "GRADE_CONVERSION", "SYSTEM_CODE", "SCHOOL_CODE", "GENDER", "RACE", "IEP", "ELL/TPC", "ADMIN_DATE", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION", "INVALID_ADMINISTRATION"), with=FALSE]

setnames(d07, c('SECTION_NAME', 'SCHOOL_CODE', 'SYSTEM_CODE', 'GENDER', "RACE", "ELL/TPC", "IEP", "ADMIN_DATE", "PTNA_FLAG", "DID_NOT_ATTEMPT_INDICATOR", "IRREGULAR_ADMINISTRATION", "INVALID_ADMINISTRATION"), c('SUBJECT_CODE', 'SR_SCHOOL_ID', 'SR_SYSTEM_ID', 'GENDER_CODE', 'RACE_CODE', 'LEP', 'SWD', "ADMINISTRATION_PERIOD", "PTNA_INDICATOR", "DNA_INDICATOR","IRREGULAR_ADMIN_INDICATOR", "INVALID_ADMINISTRATION_INDICATOR"))

#  Create YEAR variable
d07[['SCHOOL_YEAR']] <- 2007L

#  Content area clean up
levels(d07[['SUBJECT_CODE']]) <- substring(levels(d07[['SUBJECT_CODE']]), 1, 5)
levels(d07[['SUBJECT_CODE']]) <- c("ALGEBRA", "GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS")
d07[['SUBJECT_CODE']] <- as.character(d07[['SUBJECT_CODE']])

###  Combine 5 years into one data object

SUMMER_EOC <- data.table(rbind.fill(d07, d08, d09, d10, d11))

###  Case VALIDATION

SUMMER_EOC[['VALID_CASE']] <- "VALID_CASE"

#  Incorrect GTID (not 10 digit) or Missing ID

levels(SUMMER_EOC[['GTID']]) <- as.numeric(trimWhiteSpace(levels(SUMMER_EOC[['GTID']])))
SUMMER_EOC[['VALID_CASE']][is.na(SUMMER_EOC[['GTID']])] <- "INVALID_CASE"

SUMMER_EOC[['GTID']] <- as.character(SUMMER_EOC[['GTID']])
SUMMER_EOC[['VALID_CASE']][which(nchar(SUMMER_EOC[['GTID']]) < 10)] <- "INVALID_CASE"
summary(as.factor(SUMMER_EOC[['VALID_CASE']]))

#  Missing GRADE level:
SUMMER_EOC[['VALID_CASE']][!SUMMER_EOC[['GRADE']] %in% 8:12] <- "INVALID_CASE" # Still no 7th graders right?  Verify on progressions doc.
SUMMER_EOC[['GRADE']][SUMMER_EOC[['GRADE']]==99] <- NA
table(SUMMER_EOC[['GRADE']], SUMMER_EOC[['SUBJECT_CODE']], SUMMER_EOC[['VALID_CASE']])

##  Invalidate the cases that have been indicated as invalid or problematic:
##  This should only be a problem for pre-2012 data (for EOCT only) - Allison email 11/18/12

#  Create 'ADMIN_INVALIDATION' variable as a catch all for these.
SUMMER_EOC[['ADMIN_INVALIDATION']] <- NA

SUMMER_EOC[['ADMIN_INVALIDATION']][SUMMER_EOC[['DNA_INDICATOR']]=='Y'] <- "DNA"
SUMMER_EOC[['ADMIN_INVALIDATION']][SUMMER_EOC[['PTNA_INDICATOR']]=='Y'] <- "PTNA"
SUMMER_EOC[['ADMIN_INVALIDATION']][SUMMER_EOC[['INVALID_ADMINISTRATION_INDICATOR']]=='Y'] <- "INVALID_ADMIN"  #  Keep this one - Qi's 11/19/12 email
# SUMMER_EOC[['ADMIN_INVALIDATION']][SUMMER_EOC[['IRREGULAR_ADMIN_INDICATOR']] =='Y'] <- "IRREG_ADMIN"  #  Not actually invalid - Qi's 11/16/12 email.

# levels(SUMMER_EOC[['INVALID_ADMINISTRATION_INDICATOR']]) <- c(NA, 'INVALID_ADMIN')
# levels(SUMMER_EOC[['DNA_INDICATOR']]) <- c(NA, 'DNA', NA)
# levels(SUMMER_EOC[['PTNA_INDICATOR']]) <- c(NA, 'PTNA', NA)
# SUMMER_EOC[['ADMIN_INVALIDATION']] <- paste(SUMMER_EOC[['DNA_INDICATOR']], SUMMER_EOC[['PTNA_INDICATOR']], SUMMER_EOC[['INVALID_ADMINISTRATION_INDICATOR']]) # allow for multiple flags -  NOT NEEDED HERE.

summary(as.factor(SUMMER_EOC[['ADMIN_INVALIDATION']]))

##  EOCT pre-2012
SUMMER_EOC[['VALID_CASE']][!is.na(SUMMER_EOC[['ADMIN_INVALIDATION']])] <- "INVALID_CASE"

##  Duplicate cases

setkeyv(SUMMER_EOC, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "SCALE_SCORE")) # , 'ADMIN_INVALIDATION' - same results without this flag(s)
setkeyv(SUMMER_EOC, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID"))
dups <- SUMMER_EOC[c(which(duplicated(SUMMER_EOC))-1, which(duplicated(SUMMER_EOC))),]
setkeyv(dups, c("VALID_CASE", "GTID", "SCHOOL_YEAR", "SUBJECT_CODE"))
dim(dups["VALID_CASE"]) # 41 duplicated records. 3 dups with same score (just combine here).  Some kids have different grades levels...
head(dups["VALID_CASE"], 20)

#  Take the HIGHER score
SUMMER_EOC[['VALID_CASE']][which(duplicated(SUMMER_EOC))-1] <- "INVALID_CASE"

##
##  Clean up demographic variables
##

levels(SUMMER_EOC[['RACE_CODE']]) <- c(NA, NA, "Asian", "African-American/Black", "Hispanic", "American Indian/Alaskan Native", "White", "Two or More Races") 
levels(SUMMER_EOC[['GENDER_CODE']]) <- c(NA, "Female", "Male")
# levels(SUMMER_EOC[['ED']]) <- c("Economically Disadvantaged: No", "Economically Disadvantaged: Yes")  #  No ED data in files
levels(SUMMER_EOC[['LEP']]) <- c("LEP: No", "LEP: Yes")
levels(SUMMER_EOC[['SWD']]) <- c("Student with Disability: No", "Student with Disability: Yes")

#  Does Georgia have any Enrollment status inclusion variables/criteria that we should include?  
SUMMER_EOC[['SCHOOL_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled School: No", "Enrolled School: Yes"))
SUMMER_EOC[['DISTRICT_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled District: No", "Enrolled District: Yes"))
SUMMER_EOC[['STATE_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled State: No", "Enrolled State: Yes"))

levels(SUMMER_EOC[['ADMINISTRATION_PERIOD']]) <- rep("SUMMER", 5)
SUMMER_EOC[['ADMINISTRATION_PERIOD']] <- as.character(SUMMER_EOC[['ADMINISTRATION_PERIOD']])

###  Unique School Identifier.  Continue to do this for consistency...

SUMMER_EOC[['SCHOOL_NUMBER']] <- SUMMER_EOC[['SR_SYSTEM_ID']]*10000 + SUMMER_EOC[['SR_SCHOOL_ID']]
SUMMER_EOC[['SCHOOL_NUMBER']][SUMMER_EOC[['SR_SYSTEM_ID']]>1000] <- SUMMER_EOC[['SR_SYSTEM_ID']][SUMMER_EOC[['SR_SYSTEM_ID']]>1000]
SUMMER_EOC[['SCHOOL_NUMBER']] <- as.integer(SUMMER_EOC[['SCHOOL_NUMBER']])


###  Get Variables into the appropriate class
SUMMER_EOC[['SCALE_SCORE']] <- as.numeric(SUMMER_EOC[['SCALE_SCORE']])

SUMMER_EOC[['PERFORMANCE_LEVEL']] <- 
	factor(SUMMER_EOC[['PERFORMANCE_LEVEL']], levels=1:3, labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)

SUMMER_EOC[['INVALID_ADMINISTRATION_INDICATOR']] <- NULL
SUMMER_EOC[['IRREGULAR_ADMIN_INDICATOR']] <- NULL
SUMMER_EOC[['DNA_INDICATOR']] <- NULL
SUMMER_EOC[['PTNA_INDICATOR']] <- NULL
SUMMER_EOC[['GRADE_CONVERSION']] <- NULL


###############################################################################################
###
###   2) Prepare the unmatched CRCT and EOCT data from Winter and Spring 2007-2011
###
###############################################################################################

UNM_PRIORS <- read.delim('Data/Base_Files/2012_Data/eoct2007-2011_unmatched_add-grade_20121108_pipe.txt', sep='|', header=TRUE)
names(UNM_PRIORS)[c(2:4, 14)] <- c('SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'SR_STUDENT_ID', 'SWD') 

UNM_PRIORS[['GTID']] <- as.numeric(as.character(UNM_PRIORS[['GTID']]))
UNM_PRIORS[['GTID']] <- as.character(UNM_PRIORS[['GTID']])
UNM_PRIORS <- UNM_PRIORS[which(nchar(UNM_PRIORS[['GTID']]) == 10),] # length(UNM_PRIORS[['GTID']][which(nchar(UNM_PRIORS[['GTID']]) < 10)])
head(levels(as.factor(UNM_PRIORS[['GTID']])), 20)
tail(levels(as.factor(UNM_PRIORS[['GTID']])), 20)
UNM_PRIORS <- UNM_PRIORS[!is.na(UNM_PRIORS[['GTID']]),]
UNM_PRIORS <- UNM_PRIORS[UNM_PRIORS[['GTID']] != '662423.005',]
UNM_PRIORS <- UNM_PRIORS[!is.na(UNM_PRIORS[['SCALE_SCORE']]),]

### Create bad INSTRUCTOR_NUMBER_1 (needs to get better)

cleanNames <- function(line) {
	line <- gsub("[[:punct:]]", "", line)
	line <- gsub("(^ +)|( +$)", "", line)
	return(line)
}

levels(UNM_PRIORS$TEACHER_FNAME) <- cleanNames(levels(UNM_PRIORS$TEACHER_FNAME))
levels(UNM_PRIORS$TEACHER_LNAME) <- cleanNames(levels(UNM_PRIORS$TEACHER_LNAME))
levels(UNM_PRIORS$TEACHER_FNAME) <- toupper(levels(UNM_PRIORS$TEACHER_FNAME))
levels(UNM_PRIORS$TEACHER_LNAME) <- toupper(levels(UNM_PRIORS$TEACHER_LNAME))
levels(UNM_PRIORS$TEACHER_FNAME) <- gsub("  ", " ", levels(UNM_PRIORS$TEACHER_FNAME))
levels(UNM_PRIORS$TEACHER_LNAME) <- gsub("  ", " ", levels(UNM_PRIORS$TEACHER_LNAME))
levels(UNM_PRIORS$TEACHER_FNAME)[1] <- NA

UNM_PRIORS$INSTRUCTOR_NUMBER_1 <- factor(paste(UNM_PRIORS$TEACHER_FNAME, UNM_PRIORS$TEACHER_LNAME, ":", UNM_PRIORS$SR_SCHOOL_ID))
UNM_PRIORS$TEACHER_FNAME <- NULL
UNM_PRIORS$TEACHER_LNAME <- NULL


##  Invalidate the cases that have been indicated as invalid or problematic:
##  This should only be a problem for pre-2012 data (for EOCT only) - Allison email 11/18/12

# Create ADMIN_INVALIDATION for future INVALIDATION processes (used below)
UNM_PRIORS[['ADMIN_INVALIDATION']] <- NA
UNM_PRIORS[['ADMIN_INVALIDATION']][UNM_PRIORS[['DNA_INDICATOR']]=='Y'] <- "DNA"
UNM_PRIORS[['ADMIN_INVALIDATION']][UNM_PRIORS[['PTNA']]=='Y'] <- "PTNA"
# UNM_PRIORS[['ADMIN_INVALIDATION']][UNM_PRIORS[['IRREG_ADMIN_INVALID']] =='Y'] <- "IRREG_ADMIN"
# UNM_PRIORS[['ADMIN_INVALIDATION']][UNM_PRIORS[['PIV']]=='Y'] <- "PIV"	# No PIV
# UNM_PRIORS[['ADMIN_INVALIDATION']][!is.na(UNM_PRIORS[['ADMIN_INVALIDATION']])] <- paste(
	# UNM_PRIORS[['DNA_INDICATOR']][!is.na(UNM_PRIORS[['ADMIN_INVALIDATION']])], 
	# UNM_PRIORS[['PTNA']][!is.na(UNM_PRIORS[['ADMIN_INVALIDATION']])], 
	# UNM_PRIORS[['IRREG_ADMIN_INVALID']][!is.na(UNM_PRIORS[['ADMIN_INVALIDATION']])]) # allow for multiple flags.  Not needed here.
summary(as.factor(UNM_PRIORS[['ADMIN_INVALIDATION']]))

UNM_PRIORS[['SR_STUDENT_ID']] <- NULL
UNM_PRIORS[['GRADE_CONVERSION']] <- NULL
UNM_PRIORS[['IRREG_ADMIN_INVALID']] <- NULL
UNM_PRIORS[['DNA_INDICATOR']] <- NULL
UNM_PRIORS[['PTNA']] <- NULL
UNM_PRIORS[['PIV']] <- NULL

UNM_PRIORS[['SCHOOL_NUMBER']] <- UNM_PRIORS[['SR_SYSTEM_ID']]*10000 + UNM_PRIORS[['SR_SCHOOL_ID']]
UNM_PRIORS[['SCHOOL_NUMBER']][UNM_PRIORS[['SR_SYSTEM_ID']]>1000] <- UNM_PRIORS[['SR_SYSTEM_ID']][UNM_PRIORS[['SR_SYSTEM_ID']]>1000]
UNM_PRIORS[['SCHOOL_NUMBER']] <- as.integer(UNM_PRIORS[['SCHOOL_NUMBER']])

summary(UNM_PRIORS[['SCHOOL_NUMBER']])

# Enrollment status inclusion variable dummies 
UNM_PRIORS[['SCHOOL_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled School: No", "Enrolled School: Yes"))
UNM_PRIORS[['DISTRICT_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled District: No", "Enrolled District: Yes"))
UNM_PRIORS[['STATE_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled State: No", "Enrolled State: Yes"))

UNM_PRIORS[['MATCH_STATUS']] <- "U"
SUMMER_EOC[['MATCH_STATUS']] <- "M"

UNM_PRIORS <- data.table(UNM_PRIORS)
setnames(UNM_PRIORS, c('PERF_LEVEL', 'ADMIN_DATE', 'LEP_TPC'),  c('PERFORMANCE_LEVEL', 'ADMINISTRATION_PERIOD', 'LEP'))

levels(UNM_PRIORS[['LEP']]) <- c("LEP: No", "LEP: Yes")
levels(UNM_PRIORS[['SWD']]) <- c("Student with Disability: No", "Student with Disability: Yes")

levels(UNM_PRIORS[['SUBJECT_CODE']]) <- c("ALGEBRA", "GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS", "MATHEMATICS_I", "MATHEMATICS_II")

levels(UNM_PRIORS[['GRADE']]) <- c(NA, '8', '9', '10', '11', '12', '9', NA, NA)
UNM_PRIORS[['GRADE']] <- as.numeric(as.character(UNM_PRIORS[['GRADE']]))

UNM_PRIORS[['PERFORMANCE_LEVEL']] <- factor(UNM_PRIORS[['PERFORMANCE_LEVEL']], levels=1:3, 
	labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)

levels(UNM_PRIORS[['ADMINISTRATION_PERIOD']]) <- c(rep("SPRING", 4), rep("WINTER", 4))
UNM_PRIORS[['ADMINISTRATION_PERIOD']] <- as.character(UNM_PRIORS[['ADMINISTRATION_PERIOD']])

UNM_PRIORS[['GTID']] <- as.character(UNM_PRIORS[['GTID']]) 
UNM_PRIORS[['SUBJECT_CODE']] <- as.character(UNM_PRIORS[['SUBJECT_CODE']]) 
UNM_PRIORS[['SCALE_SCORE']] <- as.numeric(UNM_PRIORS[['SCALE_SCORE']]) 

##  Establish Valid cases:

UNM_PRIORS[['VALID_CASE']] <- 'VALID_CASE'
UNM_PRIORS[['VALID_CASE']][UNM_PRIORS[['SCALE_SCORE']]== 0] <- "INVALID_CASE"
UNM_PRIORS[['VALID_CASE']][!is.na(UNM_PRIORS[['ADMIN_INVALIDATION']])] <- "INVALID_CASE"

#  Total duplicates.  Just remove these
setkeyv(UNM_PRIORS, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GRADE", "GTID", "ADMINISTRATION_PERIOD", "SCALE_SCORE"))
dups <- UNM_PRIORS[c(which(duplicated(UNM_PRIORS))-1, which(duplicated(UNM_PRIORS))),]
setkeyv(dups, key(UNM_PRIORS))
dim(dups["VALID_CASE"]) # 196
head(dups["VALID_CASE"], 20)

UNM_PRIORS <- UNM_PRIORS[which(!duplicated(UNM_PRIORS)),]

setkeyv(UNM_PRIORS, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GRADE", "GTID", "ADMINISTRATION_PERIOD"))
dups <- UNM_PRIORS[c(which(duplicated(UNM_PRIORS))-1, which(duplicated(UNM_PRIORS))),]
setkeyv(dups, key(UNM_PRIORS))
dim(dups["VALID_CASE"]) # 163
head(dups["VALID_CASE"], 20)

#  Take the HIGHER score
UNM_PRIORS[['VALID_CASE']][which(duplicated(UNM_PRIORS))-1] <- "INVALID_CASE"

#  Different Admin periods (repeaters/retakers/retesters/etc.)
setkeyv(UNM_PRIORS, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GRADE", "GTID"))
dups <- UNM_PRIORS[c(which(duplicated(UNM_PRIORS))-1, which(duplicated(UNM_PRIORS))),]
setkeyv(dups, key(UNM_PRIORS))
dim(dups["VALID_CASE"]) # 403
head(dups["VALID_CASE"], 20)

#  Take the LAST score (SPRING admin period) since these will be used as priors
UNM_PRIORS[['VALID_CASE']][which(duplicated(UNM_PRIORS))] <- "INVALID_CASE"

#  Now different Grades.  If admin period is the same here, take the highest score.
setkeyv(UNM_PRIORS, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD", "SCALE_SCORE"))
setkeyv(UNM_PRIORS, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD"))
dups <- UNM_PRIORS[c(which(duplicated(UNM_PRIORS))-1, which(duplicated(UNM_PRIORS))),]
setkeyv(dups, key(UNM_PRIORS))
dim(dups["VALID_CASE"]) # 59
head(dups["VALID_CASE"], 20)

#  Take the HIGHEST score (Grade will be ignored later)
UNM_PRIORS[['VALID_CASE']][which(duplicated(UNM_PRIORS))-1] <- "INVALID_CASE"

#  Now different Grades.  Still take latest Admin period as GRADE will be ignored/changed later.  
#  If admin period is the same here, take the highest score.
setkeyv(UNM_PRIORS, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID"))
dups <- UNM_PRIORS[c(which(duplicated(UNM_PRIORS))-1, which(duplicated(UNM_PRIORS))),]
setkeyv(dups, key(UNM_PRIORS))
dim(dups["VALID_CASE"]) # 135
head(dups["VALID_CASE"], 20)

#  Take the LATEST admin period (Grade will be ignored later)
UNM_PRIORS[['VALID_CASE']][which(duplicated(UNM_PRIORS))] <- "INVALID_CASE"


###
###   Combine All new priors into one data object and look for duplicates within these two files
###

NEW_PRIORS <- data.table(rbind.fill(SUMMER_EOC, UNM_PRIORS))

### REMOVE cases that are not GPS assessments

attach(NEW_PRIORS)
EOC.tf <- #  GPS Alg and Geom came online in 2012 according to Allison - 11/18.  None in this file anyway for 2011 (but some included pre-2012)
		# (SCHOOL_YEAR %in% 2011 & SUBJECT_CODE=="ALGEBRA") | 
		# (SCHOOL_YEAR %in% 2011 & SUBJECT_CODE=="GEOMETRY") | 
		(SCHOOL_YEAR %in% 2010:2011 & SUBJECT_CODE=="MATHEMATICS_I") | 
		(SCHOOL_YEAR %in% 2010:2011 & SUBJECT_CODE=="MATHEMATICS_II") | 
		(SCHOOL_YEAR %in% 2008:2011 & SUBJECT_CODE=="US_HISTORY") | 
		(SCHOOL_YEAR %in% 2008:2011 & SUBJECT_CODE=="ECONOMICS") | 
		(SCHOOL_YEAR %in% 2007:2011 & SUBJECT_CODE=="GRADE_9_LIT") | 
		(SCHOOL_YEAR %in% 2007:2011 & SUBJECT_CODE=="AMERICAN_LIT") | 
		(SCHOOL_YEAR %in% 2007:2011 & SUBJECT_CODE=="PHYSICAL_SCIENCE") | 
		(SCHOOL_YEAR %in% 2007:2011 & SUBJECT_CODE=="BIOLOGY")
detach(NEW_PRIORS)

NEW_PRIORS <- NEW_PRIORS[EOC.tf,]


#  Duplicates on SGP package's manditory variables with (possibly) different grade levels.  Take the Matched case if it exists.
setkeyv(NEW_PRIORS, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "MATCH_STATUS"))
setkeyv(NEW_PRIORS, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID"))
dups <- NEW_PRIORS[c(which(duplicated(NEW_PRIORS))-1, which(duplicated(NEW_PRIORS))),]
setkeyv(dups, key(NEW_PRIORS))
dim(dups["VALID_CASE"]) # 417
head(dups["VALID_CASE"], 20)

NEW_PRIORS[['VALID_CASE']][which(duplicated(NEW_PRIORS))] <- "INVALID_CASE" # invalidate BOTTOM CASE (U - unmatched)

#  Final clean up of the new PRIORs data
NEW_PRIORS[['SR_SCHOOL_ID']] <- NULL
NEW_PRIORS[['INSTRUCTOR_NUMBER_1']] <- as.character(NEW_PRIORS[['INSTRUCTOR_NUMBER_1']])

save(NEW_PRIORS, file="Data/Georgia_2012_NEW_PRIORS.Rdata")

###############################################################################################
###
###   3)  Combine the new 2007-2011 data formated above with the existing LONG data set
###   4)  Re-construct the previous VALID_CASE variable to conform to official business rules to re-produce 2011 EOCT SGPs after 2012 SGPs produced
###	     -- New VALID_CASE variable saved as "VC_2011_CORRECTED" 
###	     -- OLD VALID_CASE variable saved as "VC_2011_ORIGINAL" 
###   5)  Construct the VALID_CASE variable for use of 2007-20011 data as PRIORS (which follow different business rules as those for the CURRENT year data)
###
###############################################################################################

#  Load and clean up the LONG data
load("Data/Georgia_Data_LONG_Pre-AddPriors_111212.Rdata")
Georgia_Data_LONG <- data.table(Georgia_Data_LONG)

#  Change names in LONG Data back to the "original"  Georgia names:
setnames(Georgia_Data_LONG, c('ADMIN_DATE'), c('ADMINISTRATION_PERIOD'))
Georgia_Data_LONG[['ADMINISTRATION_PERIOD']] <- as.character(Georgia_Data_LONG[['ADMINISTRATION_PERIOD']])

##  Change names in old LONG Data back to the "original" Georgia names:

SGPstateData[["GA"]][["Variable_Name_Lookup"]] <- read.csv('/home/avi/Dropbox/GitHub_Repos/SGPstateData/Variable_Name_Lookup/GA_Variable_Name_Lookup.csv', colClasses=c(rep("character",4), "logical"))

eval(parse(text=paste("setnames(Georgia_Data_LONG, c(", 
	paste("'", paste(SGPstateData[["GA"]][["Variable_Name_Lookup"]][["names.sgp"]], collapse="','"), "'", sep=""), "),", "c(",
	paste("'", paste(SGPstateData[["GA"]][["Variable_Name_Lookup"]][["names.provided"]], collapse="','"), "'", sep=""), "))")))

Georgia_Data_LONG[['GRADE_CONVERSION']] <- NULL
Georgia_Data_LONG[['MATCH_STATUS']] <- "M"

###  Combine the two data objects

Georgia_Data_LONG <- data.table(rbind.fill(Georgia_Data_LONG, NEW_PRIORS))

#  Begin the re-production of the VALID_CASE for use of these data as PRIORS for 2012

Georgia_Data_LONG[['VC_2011_ORIGINAL']] <- Georgia_Data_LONG[['VALID_CASE']]
Georgia_Data_LONG[['VC_2011_CORRECTED']] <- 'VALID_CASE'
Georgia_Data_LONG[['VALID_CASE']] <- 'VALID_CASE'

###  Invalidate the EOCT cases that have been indicated as invalid or problematic:

eocts <- c("ALGEBRA", "GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS", "MATHEMATICS_I", "MATHEMATICS_II")

Georgia_Data_LONG[['VALID_CASE']][!is.na(Georgia_Data_LONG[['ADMIN_INVALIDATION']]) & Georgia_Data_LONG[['SUBJECT_CODE']] %in% eocts] <- "INVALID_CASE"
Georgia_Data_LONG[['VC_2011_CORRECTED']][!is.na(Georgia_Data_LONG[['ADMIN_INVALIDATION']]) & Georgia_Data_LONG[['SUBJECT_CODE']] %in% eocts] <- "INVALID_CASE"

summary(as.factor(Georgia_Data_LONG[['VALID_CASE']]))

### Invalidate NA scores and GTID's with fewer than 10 digits (or NA)
Georgia_Data_LONG[['GTID']] <- as.character(as.numeric(Georgia_Data_LONG[['GTID']]))
Georgia_Data_LONG[['VALID_CASE']][is.na(Georgia_Data_LONG[['GTID']])] <- "INVALID_CASE"
Georgia_Data_LONG[['VALID_CASE']][which(nchar(Georgia_Data_LONG[['GTID']]) != 10)] <- "INVALID_CASE"
Georgia_Data_LONG[['VALID_CASE']][is.na(Georgia_Data_LONG[['SCALE_SCORE']])] <- "INVALID_CASE"

Georgia_Data_LONG[['VC_2011_CORRECTED']][is.na(Georgia_Data_LONG[['GTID']])] <- "INVALID_CASE"
Georgia_Data_LONG[['VC_2011_CORRECTED']][which(nchar(Georgia_Data_LONG[['GTID']]) != 10)] <- "INVALID_CASE"
Georgia_Data_LONG[['VC_2011_CORRECTED']][is.na(Georgia_Data_LONG[['SCALE_SCORE']])] <- "INVALID_CASE"

summary(as.factor(Georgia_Data_LONG[['VALID_CASE']]))
summary(as.factor(Georgia_Data_LONG[['VC_2011_CORRECTED']]))

###  Duplicate case invalidation/removal:

#  First construct a numeric variable to use for sorting duplicates
#  Two different variables will be needed - 1 to sort duplicates for use as a prior and another to sort for use as the current year.

Georgia_Data_LONG[['ADMIN_ORDER']] <- factor(Georgia_Data_LONG[['ADMINISTRATION_PERIOD']])
levels(Georgia_Data_LONG[['ADMIN_ORDER']]) <- c("2", "1", "3") # Order so that the LAST period is on top to select it (per Allison)
Georgia_Data_LONG[['ADMIN_ORDER']] <- as.integer(as.character(Georgia_Data_LONG[['ADMIN_ORDER']]))


#  Duplicate cases:  Totally identical rows (including scores)...
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GRADE", "GTID", "MATCH_STATUS", "ADMIN_ORDER", "SCALE_SCORE"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 10,480 duplicate cases
# head(dups["VALID_CASE"], 20)
# summary(dups["VALID_CASE"])

Georgia_Data_LONG[['VC_2011_CORRECTED']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE"
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE" # Just take one of them since total duplicate

#  Different scale score, but duplicate in the same GRADE and Admin Period
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GRADE", "GTID", "MATCH_STATUS", "ADMIN_ORDER"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 341,634 duplicate cases
# head(dups["VALID_CASE"], 20)

Georgia_Data_LONG[['VC_2011_CORRECTED']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE" # Take the highest score if same grade and same Admin period
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE" # Take the highest score if same grade and same Admin period

#  Different scale score AND Admin Period.  Take LAST score
#  Note that this is done differently for scores to be used as PRIORS for 2012 (VALID_CASE) and those for re-running 2011 SGPs (VC_2011_CORRECTED)
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GRADE", "GTID", "MATCH_STATUS"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 44,273 duplicate cases
# head(dups["VALID_CASE"], 20)

Georgia_Data_LONG[['VC_2011_CORRECTED']][which(duplicated(Georgia_Data_LONG) & Georgia_Data_LONG[['SCHOOL_YEAR']] != '2011')] <- "INVALID_CASE" # Take LAST Admin periods other than 2011.
Georgia_Data_LONG[['VC_2011_CORRECTED']][which(duplicated(Georgia_Data_LONG) & Georgia_Data_LONG[['SCHOOL_YEAR']] == '2011')-1] <- "INVALID_CASE" # Keep FIRST Admin periods in 2011.
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # Keep LAST Admin period to use as PRIOR.


#  Different matched case status.  Take the matched case if available.
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GRADE", "GTID"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 2,207 duplicate cases
# head(dups["VALID_CASE"], 20)

Georgia_Data_LONG[['VC_2011_CORRECTED']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # Keep matched case for all years.
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # Keep matched Case.

##  Now re-run the previous three without looking at GRADE.
##  We could probably start here, but this shows exactly how many kids have different values for grade within a single year.

#  Different scale score, but duplicate in the same GRADE and Admin Period
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMIN_ORDER"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 309 duplicate cases (only 3 with same scale score - combined here)
# head(dups["VALID_CASE"], 20)

Georgia_Data_LONG[['VC_2011_CORRECTED']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE" # Take the highest score if same grade and same Admin period
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE" # Take the highest score if same grade and same Admin period

#  Different scale score AND Admin Period.  Take LAST score
#  Note that this is done differently for scores to be used as PRIORS for 2012 (VALID_CASE) and those for re-running 2011 SGPs (VC_2011_CORRECTED)
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "MATCH_STATUS"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 4,039 duplicate cases
# head(dups["VALID_CASE"], 20)

Georgia_Data_LONG[['VC_2011_CORRECTED']][which(duplicated(Georgia_Data_LONG) & Georgia_Data_LONG[['SCHOOL_YEAR']] != '2011')] <- "INVALID_CASE" # Take LAST Admin periods other than 2011.
Georgia_Data_LONG[['VC_2011_CORRECTED']][which(duplicated(Georgia_Data_LONG) & Georgia_Data_LONG[['SCHOOL_YEAR']] == '2011')-1] <- "INVALID_CASE" # Keep FIRST Admin periods in 2011.
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # Keep LAST Admin period to use as PRIOR.


#  Different matched case status.  Take the matched case if available.
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 617 duplicate cases 
# head(dups["VALID_CASE"], 20)

Georgia_Data_LONG[['VC_2011_CORRECTED']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # Keep matched case for all years.
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # Keep matched Case.

summary(as.factor(Georgia_Data_LONG[['VALID_CASE']]))
summary(as.factor(Georgia_Data_LONG[['VC_2011_CORRECTED']])) #  Same number of Valids/Invalids
table(Georgia_Data_LONG[['VC_2011_CORRECTED']], Georgia_Data_LONG[['VALID_CASE']])
table(Georgia_Data_LONG[['VC_2011_ORIGINAL']], Georgia_Data_LONG[['VALID_CASE']])
table(Georgia_Data_LONG[['VC_2011_CORRECTED']], Georgia_Data_LONG[['VC_2011_ORIGINAL']])

Georgia_Data_LONG[['ADMIN_ORDER']] <- NULL

save(Georgia_Data_LONG, file="Data/Georgia_Data_LONG-Post-AddPriors_111912")

###############################################################################################
###
###   6)  Prepare and format the 2012 CRCT and EOCT data using business rules for CURRENT year data
###
###############################################################################################

###
###		2012 CRCT Data
###

###  Read in 2012 CRCT pipe delimited text files:

SPR <- read.table('Data/Base_Files/2012_Data/fy2012_crct-spring_run20121030_pipe.txt', sep='|', header=TRUE)
UNM_SPR <- read.table('Data/Base_Files/2012_Data/crct2012_SPRING_unmatched_pipe.txt', sep='|', header=TRUE)

RET <- read.table('Data/Base_Files/2012_Data/fy2012_crct-retest_run20121030_pipe.txt', sep='|', header=TRUE)
UNM_RET <- read.table('Data/Base_Files/2012_Data/crct2012_RETEST_unmatched_pipe.txt', sep='|', header=TRUE)
MAR <- read.table('Data/Base_Files/2012_Data/Marietta_City_Missing_Data_pipe.txt', sep='|', header=TRUE)
names(MAR)[13] <- "AYP_CTBRC"
MAR[['GTID']] <- as.character(MAR[['GTID']])

UNM_RET <- rbind.fill(UNM_RET, MAR)

SPR[['RETEST']] <- FALSE
SPR[['MATCH_STATUS']] <- 'M'
levels(SPR[['SUBJECT_CODE']]) <- c('ELA', 'MATHEMATICS', 'READING', 'SCIENCE', 'SOCIAL_STUDIES')
SPR[['SUBJECT_CODE']] <- as.character(SPR[['SUBJECT_CODE']])
SPR[['GTID']] <- as.character(SPR[['GTID']])

UNM_SPR[['RETEST']] <- FALSE
UNM_SPR[['MATCH_STATUS']] <- 'U'
levels(UNM_SPR[['SUBJECT_CODE']]) <- c('ELA', 'MATHEMATICS', 'READING', 'SCIENCE', 'SOCIAL_STUDIES')
UNM_SPR[['SUBJECT_CODE']] <- as.character(UNM_SPR[['SUBJECT_CODE']])
UNM_SPR[['GTID']] <- as.character(UNM_SPR[['GTID']])
names(UNM_SPR)[2:4] <- c('SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'SR_STUDENT_ID') # Change from 'TEST_*_ID' to correspond to the "matched" files
# length(UNM_SPR$GTID[which(nchar(UNM_SPR[['GTID']]) < 10)]); summary(nchar(UNM_SPR[['GTID']]))  #  No GTID with less than 10 characters

RET[['RETEST']] <- TRUE
RET[['MATCH_STATUS']] <- 'M'
levels(RET[['SUBJECT_CODE']]) <- c('MATHEMATICS', 'READING')
RET[['SUBJECT_CODE']]<- as.character(RET[['SUBJECT_CODE']])
RET[['GTID']]<- as.character(RET[['GTID']])

UNM_RET[['RETEST']] <- TRUE
UNM_RET[['MATCH_STATUS']] <- 'U'
levels(UNM_RET[['SUBJECT_CODE']]) <- c('MATHEMATICS', 'READING')
UNM_RET[['SUBJECT_CODE']]<- as.character(UNM_RET[['SUBJECT_CODE']])
UNM_RET[['GTID']]<- as.character(UNM_RET[['GTID']])
names(UNM_RET)[2:4] <- c('SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'SR_STUDENT_ID') # Change from 'TEST_*_ID' to correspond to the "matched" files
# length(UNM_RET$GTID[which(nchar(UNM_RET[['GTID']]) < 10)]); summary(nchar(UNM_RET[['GTID']]))  #  No GTID with less than 10 characters

###  Combine all the small data files into one data object

CRC <- data.table(rbind.fill(SPR, UNM_SPR, RET, UNM_RET))

###
###  Invalidate the cases that have been indicated as invalid or problematic:
###

CRC[['VALID_CASE']] <- "VALID_CASE"

##  Don't invalidate CRCT tests based on these flags per Allison's email 11/18/12

# CRC[['VALID_CASE']][CRC[['TAR']] %in% c(2,3)] <- "INVALID_CASE"
# CRC[['VALID_CASE']][CRC[['PTNA']]==1] <- "INVALID_CASE"
# CRC[['VALID_CASE']][CRC[['DNA']]==1] <- "INVALID_CASE"
# CRC[['VALID_CASE']][CRC[['AYP_CTBRC']] %in% c(1,2,3,4)] <- "INVALID_CASE" # 1=PTNA, 2 & 4 = TAR, 3=DNA -- nothing new here.

##  Create the same catch all invalidation indicator as above.
##  Shouldn't have to invalidate these, but keep for data checking and reference:

CRC[['ADMIN_INVALIDATION']] <- NA

CRC[['ADMIN_INVALIDATION']][CRC[['TAR']] %in% c(2,3)] <- "TAR"
CRC[['ADMIN_INVALIDATION']][CRC[['PTNA']]==1] <- "PTNA"
CRC[['ADMIN_INVALIDATION']][CRC[['DNA']]==1] <- "DNA"
#CRC[['ADMIN_INVALIDATION']][CRC[['AYP_CTBRC']] %in% c(1,2,3,4)] <- "AYP_CTBRC" # Does't provide new info: 1=PTNA, 2 & 4 = TAR, 3=DNA
# CRC[['ADMIN_INVALIDATION']][!is.na(CRC[['ADMIN_INVALIDATION']])] <- paste(CRC[['DNA']], CRC[['PTNA']], CRC[['TAR']]) #multiple flags?  Not needed

summary(as.factor(CRC[['ADMIN_INVALIDATION']]))

## NULL out extraneous variables that are no longer needed
CRC[['TAR']] <- NULL
CRC[['PTNA']] <- NULL
CRC[['DNA']] <- NULL
CRC[['AYP_CTBRC']] <- NULL

##  Invalidate cases based on bad GTID and NA Scores
CRC[['GTID']] <- as.character(as.numeric(CRC[['GTID']]))
CRC[['VALID_CASE']][is.na(CRC[['GTID']])] <- "INVALID_CASE"
CRC[['VALID_CASE']][which(nchar(CRC[['GTID']]) != 10)] <- "INVALID_CASE"

CRC[['VALID_CASE']][is.na(CRC[['AYP_SCALE_SCORE']])] <- "INVALID_CASE"

summary(as.factor(CRC[['VALID_CASE']]))

#  21 kids switched schools and have a (different) score in both schools...
#  Take highest score.
setkeyv(CRC, c("VALID_CASE", "SUBJECT_CODE", "AYP_GRADE", "GTID", "RETEST", "MATCH_STATUS", "AYP_SCALE_SCORE"))
setkeyv(CRC, c("VALID_CASE", "SUBJECT_CODE", "AYP_GRADE", "GTID", "RETEST", "MATCH_STATUS"))
dups <- CRC[c(which(duplicated(CRC))-1, which(duplicated(CRC))),]
setkeyv(dups, key(CRC))
dim(dups[VALID_CASE=="VALID_CASE"]) # 21 duplicate cases

CRC[['VALID_CASE']][which(duplicated(CRC))-1] <- "INVALID_CASE"

# 15 Kids in both Matched and Unmatched files:
setkeyv(CRC, c("VALID_CASE", "SUBJECT_CODE", "AYP_GRADE", "GTID", "RETEST"))
dups <- CRC[c(which(duplicated(CRC))-1, which(duplicated(CRC))),]
setkeyv(dups, key(CRC))
dim(dups[VALID_CASE=="VALID_CASE"]) # 15 cases

CRC[['VALID_CASE']][which(duplicated(CRC))] <- "INVALID_CASE" # Unmatched is on bottom, so invalidate it (take the matched case)

#  All kids with a test and RETEST.
#  Take the HIGHER score per Allison.
setkeyv(CRC, c("VALID_CASE", "SUBJECT_CODE", "AYP_GRADE", "GTID", "MATCH_STATUS", "AYP_SCALE_SCORE")) # 
setkeyv(CRC, c("VALID_CASE", "SUBJECT_CODE", "AYP_GRADE", "GTID", "MATCH_STATUS"))
dups <- CRC[c(which(duplicated(CRC))-1, which(duplicated(CRC))),]
setkeyv(dups, key(CRC))
dim(dups[VALID_CASE=="VALID_CASE"]) # 71,594 kids

CRC[['VALID_CASE']][which(duplicated(CRC))-1] <- "INVALID_CASE"

#  Kids with duplicate records from both matched and unmatched data files
#  Take the record from the MATCHED data file
setkeyv(CRC, c("VALID_CASE", "SUBJECT_CODE", "AYP_GRADE", "GTID"))
dups <- CRC[c(which(duplicated(CRC))-1, which(duplicated(CRC))),]
setkeyv(dups, key(CRC))
dim(dups[VALID_CASE=="VALID_CASE"]) # 122

CRC[['VALID_CASE']][which(duplicated(CRC))] <- "INVALID_CASE" # Unmatched is on bottom, so invalidate it (take the matched case)

#  Leave out invalidation without considering grade for CRCT.  Hopefully these will sort themselves out in the analyses ...
#  Remove the handful of duplicates that are UNMATCHED though
setkeyv(CRC, c("VALID_CASE", "SUBJECT_CODE", "GTID", "MATCH_STATUS"))
setkeyv(CRC, c("VALID_CASE", "SUBJECT_CODE", "GTID"))
dups <- CRC[c(which(duplicated(CRC))-1, which(duplicated(CRC))),]
setkeyv(dups, key(CRC))
dim(dups[VALID_CASE=="VALID_CASE"]) # 42 cases

CRC[['VALID_CASE']][which(duplicated(CRC) & CRC[['MATCH_STATUS']] == 'U')] <- "INVALID_CASE" # Unmatched is on bottom, so invalidate it (take the matched case)

summary(as.factor(CRC[['VALID_CASE']]))
table(CRC[['VALID_CASE']], CRC[['MATCH_STATUS']])


###
###  Clean up other issues:
###

##  Out-of-grade test takers? Not an issue in FINAL data
#  table(CRC[['AYP_GRADE']], CRC[['SUBJECT_CODE']], CRC[['VALID_CASE']])
#  CRC[['VALID_CASE']][!CRC[['AYP_GRADE']] %in% 3:8] <- "INVALID_CASE"

###  Clean up demographic variables
levels(CRC[['RACE_CODE']]) <- c("African-American/Black", "Hispanic", "American Indian/Alaskan Native", "Two or More Races", "Pacific Islander", "Asian", "White")
levels(CRC[['GENDER_CODE']]) <- c("Female", "Male")
levels(CRC[['ED']]) <- c("Economically Disadvantaged: No", "Economically Disadvantaged: Yes")
levels(CRC[['SWD']]) <- c("Student with Disability: No", "Student with Disability: Yes")
levels(CRC[['LEP']]) <- c("LEP: No", "LEP: Yes")

#  Create an Enrollment status inclusion variable dummies:  
CRC[['SCHOOL_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled School: No", "Enrolled School: Yes"))
CRC[['DISTRICT_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled District: No", "Enrolled District: Yes"))
CRC[['STATE_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled State: No", "Enrolled State: Yes"))

#  Add this to match EOCT below
CRC[['RETEST_INDICATOR']] <- CRC[['ADMIN_TYPE']]
levels(CRC[['RETEST_INDICATOR']]) <- c("N", "Y")
CRC[['RETEST']] <- NULL # table(CRC$ADMIN_TYPE, CRC$RETEST) -- same indicator...  keep official one.

###  Unique School Identifier.  Continue to do this for consistency...

CRC[['SCHOOL_NUMBER']] <- CRC[['SR_SYSTEM_ID']]*10000 + CRC[['SR_SCHOOL_ID']]
CRC[['SCHOOL_NUMBER']][CRC[['SR_SYSTEM_ID']]>1000] <- CRC[['SR_SYSTEM_ID']][CRC[['SR_SYSTEM_ID']]>1000]
CRC[['SCHOOL_NUMBER']] <- as.integer(CRC[['SCHOOL_NUMBER']])

summary(CRC[['SCHOOL_NUMBER']])

###  Get Variables into the appropriate class
CRC[['AYP_SCALE_SCORE']] <- as.numeric(CRC[['AYP_SCALE_SCORE']])

CRC[['AYP_PERF_LEVEL']] <- 
	factor(CRC[['AYP_PERF_LEVEL']], levels=1:3, labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)


###
###		2012 EOCT Data
###

###  Read in 2012 pipe delimited text files:

EOC <- read.delim('Data/Base_Files/2012_Data/fy2012_eoct_all-admins_run20121030_pipe.txt', sep='|', header=TRUE)
UNM_EOC <- read.delim('Data/Base_Files/2012_Data/eoct2012_unmatched_pipe.txt', sep='|', header=TRUE)
names(UNM_EOC)[c(2:4, 6, 16)] <- c('SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'STUDENT_ID', 'STUDENT_GRADE_LEVEL', 'ADMINISTRATION_PERIOD') # Change from 'TEST_*_ID' to correspond to the "matched" files

##  Remove non-Alternative Schools and districts other than GA Virtual School and Dept of Juv Justice
UNM_EOC <- UNM_EOC[UNM_EOC[['SR_SCHOOL_ID']] > 6000 | UNM_EOC[['SR_SYSTEM_ID']] %in% c(794, 891),]
# table(UNM_EOC[['SR_SCHOOL_ID']], UNM_EOC[['SR_SYSTEM_ID']])

levels(EOC[['ADMINISTRATION_PERIOD']]) <- c("SPRING", "SPRING", "SUMMER", "WINTER", "WINTER", "WINTER")
levels(UNM_EOC[['ADMINISTRATION_PERIOD']]) <- c("SPRING", "SPRING", "SUMMER", "WINTER", "WINTER")
EOC[['MATCH_STATUS']] <- 'M'
UNM_EOC[['MATCH_STATUS']] <- 'U'

EOC <- data.table(rbind.fill(EOC, UNM_EOC))


#  Check for out-of-grade test takers:
table(EOC[['STUDENT_GRADE_LEVEL']], EOC[['ASSESSMENT_SUBJECT_CODE']])
EOC[['STUDENT_GRADE_LEVEL']][EOC[['STUDENT_GRADE_LEVEL']]==99] <- NA
EOC <- subset(EOC, STUDENT_GRADE_LEVEL %in% c(8:12, NA)) # keep the 8th graders and NA's for now...


levels(EOC[['ASSESSMENT_SUBJECT_CODE']]) <- c("GRADE_9_LIT", "ALGEBRA", "AMERICAN_LIT", "BIOLOGY", "ECONOMICS", "GEOMETRY", "MATHEMATICS_I", "MATHEMATICS_II", "PHYSICAL_SCIENCE", "US_HISTORY")
levels(EOC[['RETEST_INDICATOR']]) <- c(NA, "N", "Y")

EOC[['ASSESSMENT_SUBJECT_CODE']] <- as.character(EOC[['ASSESSMENT_SUBJECT_CODE']])

length(EOC$GTID[which(nchar(EOC[['GTID']]) < 10)]); summary(as.factor(nchar(EOC[['GTID']])))
EOC <- EOC[!is.na(EOC[['GTID']]),]
EOC <- EOC[which(nchar(EOC[['GTID']]) == 10),]
EOC[['GTID']] <- as.character(EOC[['GTID']])

EOC[['VALID_CASE']] <- "VALID_CASE"

##  Create the same catch all invalidation indicator as above.
##  Shouldn't have to invalidate these, but keep for data checking and reference:

EOC[['ADMIN_INVALIDATION']] <- NA

EOC[['ADMIN_INVALIDATION']][EOC[['DNA_INDICATOR']]=='Y'] <- "DNA"
EOC[['ADMIN_INVALIDATION']][EOC[['PTNA_INDICATOR']]=='Y'] <- "PTNA"
# EOC[['ADMIN_INVALIDATION']][EOC[['IRREGULAR_ADMIN_INDICATOR']] =='Y'] <- "IRREG_ADMIN" # Don't use this flag ever according to Qi.
# EOC[['ADMIN_INVALIDATION']][!is.na(EOC[['ADMIN_INVALIDATION']])] <- paste(
	# EOC[['DNA_INDICATOR']][!is.na(EOC[['ADMIN_INVALIDATION']])], 
	# EOC[['PTNA_INDICATOR']][!is.na(EOC[['ADMIN_INVALIDATION']])]) # allow for multiple flags ::  Not needed again.

summary(EOC[['SCALE_SCORE']][!is.na(EOC[['ADMIN_INVALIDATION']])]) #  all NA's

# EOC[['VALID_CASE']][!is.na(CRC[['ADMIN_INVALIDATION']])] <- "INVALID_CASE"

### NULL out extraneous variables that are no longer needed
EOC[['IRREGULAR_ADMIN_INDICATOR']] <- NULL
EOC[['DNA_INDICATOR']] <- NULL
EOC[['PTNA_INDICATOR']] <- NULL
EOC[['PIV_INDICATOR']] <- NULL # All NA's
# EOC[['RETEST_INDICATOR']] <- NULL # Keep this

### Invalidate NA scores
EOC[['VALID_CASE']][is.na(EOC[['SCALE_SCORE']])] <- "INVALID_CASE"

summary(as.factor(EOC[['VALID_CASE']]))

###  Duplicate case invalidation/removal:

EOC[['ADMIN_ORDER']] <- EOC[['ADMINISTRATION_PERIOD']]
levels(EOC[['ADMIN_ORDER']]) <- c("2", "3", "1")
EOC[['ADMIN_ORDER']] <- as.integer(as.character(EOC[['ADMIN_ORDER']]))

#  Looks like these are totally identical rows (including scores)...
setkeyv(EOC, c("VALID_CASE", "ASSESSMENT_SUBJECT_CODE", "GTID", "RETEST_INDICATOR", "ADMIN_ORDER", "MATCH_STATUS", "SCALE_SCORE"))
dups <- EOC[c(which(duplicated(EOC))-1, which(duplicated(EOC))),]
setkeyv(dups, key(EOC))
dim(dups["VALID_CASE"]) #544 duplicate cases
# head(dups["VALID_CASE"], 20)
# summary(dups["VALID_CASE"])

#  Just remove these rows since they appear to just be total duplicates
EOC <- EOC[which(!duplicated(EOC)),]

#  These are identical except for SCORE
setkeyv(EOC, c("VALID_CASE", "ASSESSMENT_SUBJECT_CODE", "GTID", "RETEST_INDICATOR", "ADMIN_ORDER", "MATCH_STATUS"))
dups <- EOC[c(which(duplicated(EOC))-1, which(duplicated(EOC))),]
setkeyv(dups, key(EOC))
dim(dups["VALID_CASE"]) # 550

EOC[['VALID_CASE']][which(duplicated(EOC))-1] <- "INVALID_CASE" # Keep highest score


#  Note - these are kids who have RETAKEN a test (NON-Retest!) with same match status
#  Take FIRST TEST score.
setkeyv(EOC, c("VALID_CASE", "ASSESSMENT_SUBJECT_CODE", "GTID", "RETEST_INDICATOR", "MATCH_STATUS"))
dups <- EOC[c(which(duplicated(EOC))-1, which(duplicated(EOC))),]
setkeyv(dups, key(EOC))
dim(dups["VALID_CASE"]) # 10,277

EOC[['VALID_CASE']][which(duplicated(EOC))] <- "INVALID_CASE" # keep TOP case (FIRST ATTEMPT)


#  Note - these are kids who have RETAKEN a test (NON-Retest!) with different match status
#  Take FIRST TEST score -- the matched record
setkeyv(EOC, c("VALID_CASE", "ASSESSMENT_SUBJECT_CODE", "GTID", "RETEST_INDICATOR"))
dups <- EOC[c(which(duplicated(EOC))-1, which(duplicated(EOC))),]
setkeyv(dups, key(EOC))
dim(dups["VALID_CASE"]) # 45

EOC[['VALID_CASE']][which(duplicated(EOC))] <- "INVALID_CASE" # Keep the matched record and invalidate the unmatched.


#  Invalidate duplicates with different RETEST_INDICATOR by taking highest score.  
setkeyv(EOC, c("VALID_CASE", "ASSESSMENT_SUBJECT_CODE", "GTID", "SCALE_SCORE", "RETEST_INDICATOR", "MATCH_STATUS"))
setkeyv(EOC, c("VALID_CASE", "ASSESSMENT_SUBJECT_CODE", "GTID", "MATCH_STATUS"))
dups <- EOC[c(which(duplicated(EOC))-1, which(duplicated(EOC))),]
setkeyv(dups, key(EOC))
dim(dups["VALID_CASE"]) # 32,258

#  Take the HIGHER score per Allison.
EOC[['VALID_CASE']][which(duplicated(EOC))-1] <- "INVALID_CASE"

setkeyv(EOC, c("VALID_CASE", "ASSESSMENT_SUBJECT_CODE", "GTID"))
dups <- EOC[c(which(duplicated(EOC))-1, which(duplicated(EOC))),]
setkeyv(dups, key(EOC))
dim(dups["VALID_CASE"]) # 187

#  Take the MATCHED record.
EOC[['VALID_CASE']][which(duplicated(EOC))] <- "INVALID_CASE"


###  Clean up other issues:

##  Clean up demographic variables
levels(EOC[['RACE_CODE']]) <- c("African-American/Black", "Hispanic", "American Indian/Alaskan Native", "Two or More Races", "Pacific Islander", "Asian", "White")
levels(EOC[['GENDER_CODE']]) <- c("Female", "Male")
levels(EOC[['ED']]) <- c("Economically Disadvantaged: No", "Economically Disadvantaged: Yes")
levels(EOC[['SWD']]) <- c("Student with Disability: No", "Student with Disability: Yes")
levels(EOC[['LEP']]) <- c("LEP: No", "LEP: Yes")
levels(EOC[['IEP']]) <- c("IEP: No", "IEP: Yes") #  Did we keep / change levels in old data?

#  Create an Enrollment status inclusion variable dummies:  
EOC[['SCHOOL_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled School: No", "Enrolled School: Yes"))
EOC[['DISTRICT_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled District: No", "Enrolled District: Yes"))
EOC[['STATE_ENROLLMENT_STATUS']] <- factor(2, levels=1:2, labels=c("Enrolled State: No", "Enrolled State: Yes"))

##  Unique School Identifier.  Continue to do this for consistency...

EOC[['SCHOOL_NUMBER']] <- EOC[['SR_SYSTEM_ID']]*10000 + EOC[['SR_SCHOOL_ID']]
EOC[['SCHOOL_NUMBER']][EOC[['SR_SYSTEM_ID']]>1000] <- EOC[['SR_SYSTEM_ID']][EOC[['SR_SYSTEM_ID']]>1000]
EOC[['SCHOOL_NUMBER']] <- as.integer(EOC[['SCHOOL_NUMBER']])

###  Get Variables into the appropriate class
EOC[['SCALE_SCORE']] <- as.numeric(EOC[['SCALE_SCORE']])

EOC[['PERFORMANCE_LEVEL']] <- 
	factor(EOC[['PERFORMANCE_LEVEL']], levels=1:3, labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)

###
###		Combine the 2012 CRCT and EOCT data files
###

 # Fix names to correspond with what we will have in @Names
setnames(CRC, c('AYP_GRADE', 'AYP_SCALE_SCORE', 'AYP_PERF_LEVEL'), c('GRADE', 'SCALE_SCORE', 'PERFORMANCE_LEVEL'))
setnames(EOC, c('STUDENT_GRADE_LEVEL', 'ASSESSMENT_SUBJECT_CODE'), c('GRADE', 'SUBJECT_CODE'))

CRC[['SR_STUDENT_ID']] <- NULL
CRC[['SR_SCHOOL_ID']] <- NULL
CRC[['STUDENT_GRADE_LEVEL']] <- NULL
CRC[['ADMIN_TYPE']] <- NULL # RETEST_INDICATOR has same info now (N ~= 'Spring')
CRC[['TEST_TYPE']] <- NULL

EOC[['STUDENT_ID']] <- NULL
EOC[['SR_SCHOOL_ID']] <- NULL
EOC[['TEST_TYPE']] <- NULL
EOC[['ADMIN_ORDER']] <- NULL
EOC[['TEST_RECORD_GRADE_FIELD']] <- NULL
EOC[['GRADE_CONVERSION']] <- NULL
EOC[['IEP']] <- NULL

GA_2012 <- data.table(rbind.fill(CRC, EOC))

GA_2012[['ADMINISTRATION_PERIOD']] <- as.character(GA_2012[['ADMINISTRATION_PERIOD']])

save(GA_2012, file="Data/Georgia_Data_LONG-2012.Rdata")


###############################################################################################
###
###   7)  Combine the 2012 data with the 2007-11 data
###
###############################################################################################

# load("Data/Georgia_Data_LONG-2012.Rdata")
Georgia_Data_LONG <- data.table(rbind.fill(Georgia_Data_LONG, GA_2012))
levels(Georgia_Data_LONG[['SWD']]) <- rep(c("Student with Disability: No", "Student with Disability: Yes"), 2)

save(Georgia_Data_LONG, file="Data/Georgia_Data_LONG-2012_FINAL.Rdata")


###############################################################################################
###
###   8)  Reformat the previous SGP object, particularly the existing coefficient matrices.
###   9)  Replace the existing @Data slot of the SGP object with the 2007-2012 LONG data produced in steps 1 to 7
###
###############################################################################################

##  Load the "original" Georgia SGP object from this summer:
load("Data/Georgia_SGP.Rdata") # or Georgia_SGP-2012_DRAFT.Rdata

#  Replace the existing @Data slot
Georgia_SGP@Data <- Georgia_Data_LONG

#  Get rid of EOCT results and coefficient matrices.  We will re-construct these without using grade progressions later:
Georgia_SGP@SGP$Coefficient_Matrices <- Georgia_SGP@SGP$Coefficient_Matrices[1:17] #[c(1:13,35:38)] in Georgia_SGP-2012_DRAFT
Georgia_SGP@SGP$SGPercentiles <- Georgia_SGP@SGP$SGPercentiles[c(37:61)]
# Georgia_SGP@Summary <- NULL # already NULLed out in my SGP object
Georgia_SGP@Version <- NULL

#  Rename the "official" Georgia variable names with the generic SGP names.  Also add GRADE_CONVERSION variable until SGPstateData has been updated.
Georgia_SGP@Names <- read.csv('/home/avi/Dropbox/GitHub_Repos/SGPstateData/Variable_Name_Lookup/GA_Variable_Name_Lookup.csv', colClasses=c(rep("character",4), "logical"))

eval(parse(text=paste("setnames(Georgia_SGP@Data, c(", 
                      paste("'", paste(SGPstateData[["GA"]][["Variable_Name_Lookup"]][["names.provided"]], collapse="','"), "'", sep=""), "),", "c(",
                      paste("'", paste(SGPstateData[["GA"]][["Variable_Name_Lookup"]][["names.sgp"]], collapse="','"), "'", sep=""), "))")))

##  run prepareSGP (with a new version of SGP package from Github!) to convert coefficient matrices.
Georgia_SGP <- prepareSGP(Georgia_SGP)

save(Georgia_SGP, file="Data/Georgia_SGP-2012.Rdata")

