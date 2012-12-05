###############################################################################################
####
####		Georgia Student Growth Percentiles Analysis 
####		Criterion-Referenced Competency Tests (CRCT) & End of Course Tests (EOCT)
####		Data preparation and formating
####		Adam VanIwaarden/Damian Betebenner - NCIEA
####
###############################################################################################

### Load required packages

require(SGP)
setwd("/media/Data/SGP/Georgia")

###  Read in the text file, which is a fixed width format (fwf) and assign object the name "GA":

GA <- read.fwf("Data/Base_Files/crct_2006-2011_output.txt", 
	c(4, 8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 20, 2, 3, 3, 3, 3, 3, 10, 4, 9, 1, 1, 2, 1, 1, 1, 10),
	comment.char="",
	skip=0, 
	buffersize=100000)


GA_RETEST <- read.fwf("Data/Base_Files/rt3_crct_retest_data.txt",
	c(4, 8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 20, 2, 3, 3, 10, 4, 9, 1, 1, 2, 1, 1, 1, 10),
	comment.char="",
	skip=0,
	buffersize=10000)


### assign names to the variables - none provided from .txt file.  Taken from the file_layout_Ads.xls file included with data:

names(GA) <- c('SCHOOL_YEAR', 'AYP_TEST_ID', 'AYP_ADMINREA', 'AYP_ADMINELA', 'AYP_ADMINMAT', 'AYP_ADMINSCI', 'AYP_ADMINSOC', 'TARREA', 
	'TARELA', 'TARMAT', 'TARSCI', 'TARSOC', 'PTNAREA', 'PTNAELA', 'PTNAMAT', 'PTNASCI', 'PTNASOC', 'DNAREA', 'DNAELA', 'DNAMAT', 
	'DNASCI', 'DNASOC', 'AYP_REACTBRC', 'AYP_ELACTBRC', 'AYP_MATCTBRC', 'AYP_SCICTBRC', 'AYP_SOCCTBRC', 'CLSNAME', 'AYP_GRADE', 
	'AYP_REASS', 'AYP_ELASS', 'AYP_MATSS', 'AYP_SCISS', 'AYP_SOCSS', 'SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'SR_STUDENT_ID', 'RACE_CODE', 
	'GENDER_CODE', 'STUDENT_GRADE_LEVEL', 'ED', 'SWD', 'LEP', 'GTID')

names(GA_RETEST) <- c('SCHOOL_YEAR', 'AYP_TEST_ID', 'AYP_ADMINREA', 'AYP_ADMINMAT', 'TARREA', 'TARMAT', 'PTNAREA', 'PTNAMAT',
	'DNAREA', 'DNAMAT', 'AYP_REACTBRC', 'AYP_MATCTBRC', 'CLSNAME', 'AYP_GRADE', 'AYP_REASS', 'AYP_MATSS', 'SR_SYSTEM_ID',
	'SR_SCHOOL_ID', 'SR_STUDENT_ID', 'RACE_CODE', 'GENDER_CODE', 'STUDENT_GRADE_LEVEL', 'ED', 'SWD', 'LEP', 'GTID')


### Save files

save(GA, file="Data/Base_Files/Georgia_Original_Data_2006-2011.Rdata")
save(GA_RETEST, file="Data/Base_Files/GA_RETEST.Rdata")


############################################################################################
###
### Construct CRCT long data file
###
############################################################################################

### Load data from fixed width files and other required data files

load("Data/Base_Files/Georgia_Original_Data_2006-2011.Rdata")
load("Data/Base_Files/GA_RETEST.Rdata")
load("Data/Base_Files/Schools_to_Remove.Rdata")
load("Data/Base_Files/Schools_to_Remove_RETEST.Rdata")


### Make the data even longer than provided - stack CONTENT_AREAs on top of each other:

attach(GA)
GA_CRCT<-data.table(data.frame(
	SCHOOL_YEAR=rep(SCHOOL_YEAR, 5),
        GTID =rep(GTID, 5),
        AYP_TEST_ID=rep(AYP_TEST_ID, 5),
        SR_STUDENT_ID=rep(SR_STUDENT_ID, 5),
        SR_SYSTEM_ID=rep(SR_SYSTEM_ID, 5),
        SR_SCHOOL_ID=rep(SR_SCHOOL_ID, 5),
        STUDENT_GRADE_LEVEL=rep(STUDENT_GRADE_LEVEL, 5),
        AYP_GRADE=rep(as.integer(AYP_GRADE), 5),
        RACE_CODE = rep(RACE_CODE, 5),
        GENDER_CODE=rep(GENDER_CODE, 5),
        ED=rep(ED, 5),
        SWD=rep(SWD, 5),
        LEP=rep(LEP, 5),
        CLSNAME=rep(CLSNAME, 5),
        AYP_ADMIN=c(AYP_ADMINREA, AYP_ADMINELA, AYP_ADMINMAT, AYP_ADMINSCI, AYP_ADMINSOC),
        TAR=c(TARREA, TARELA, TARMAT, TARSCI, TARSOC),
        PTNA=c(PTNAREA, PTNAELA, PTNAMAT, PTNASCI, PTNASOC),
        DNA=c(DNAREA, DNAELA, DNAMAT, DNASCI, DNASOC),
        AYP_CTBRC=c(AYP_REACTBRC, AYP_ELACTBRC, AYP_MATCTBRC, AYP_SCICTBRC, AYP_SOCCTBRC),
        AYP_SS=c(AYP_REASS, AYP_ELASS, AYP_MATSS, AYP_SCISS, AYP_SOCSS),
        CONTENT_AREA=rep(c("READING", "ELA", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES"), each=dim(GA)[1]),
        ADMIN_TYPE="Spring"), key="GTID")  # Change to correspond with Unmatched CRCT data made available in 2012
detach(GA)


attach(GA_RETEST)
GA_CRCT_RETEST <- data.table(data.frame(
        SCHOOL_YEAR=rep(SCHOOL_YEAR, 2),
        GTID =rep(as.factor(GTID), 2),
        AYP_TEST_ID=rep(AYP_TEST_ID, 2),
        SR_STUDENT_ID=rep(SR_STUDENT_ID, 2),
        SR_SYSTEM_ID=rep(SR_SYSTEM_ID, 2),
        SR_SCHOOL_ID=rep(SR_SCHOOL_ID, 2),
        STUDENT_GRADE_LEVEL=rep(STUDENT_GRADE_LEVEL, 2),
        AYP_GRADE=rep(AYP_GRADE, 2),
        RACE_CODE = rep(RACE_CODE, 2),
        GENDER_CODE=rep(GENDER_CODE, 2),
        ED=rep(ED, 2),
        SWD=rep(SWD, 2),
        LEP=rep(LEP, 2),
        CLSNAME=rep(CLSNAME, 2),
        AYP_ADMIN=c(AYP_ADMINREA, AYP_ADMINMAT),
        TAR=c(TARREA, TARMAT),
        PTNA=c(PTNAREA, PTNAMAT),
        DNA=c(DNAREA, DNAMAT),
        AYP_CTBRC=c(AYP_REACTBRC, AYP_MATCTBRC),
        AYP_SS=c(AYP_REASS, AYP_MATSS),
        CONTENT_AREA=rep(c("READING", "MATHEMATICS"), each=dim(GA_RETEST)[1]),
        ADMIN_TYPE="Retest"), key="GTID")  # Change to correspond with Unmatched CRCT data made available in 2012
detach(GA_RETEST)


### Clean up

rm(GA);rm(GA_RETEST) # remove the original GA object because it is so large
gc() # clean up the workspace


### Stack TEST and RETEST data sets

GA_CRCT <- as.data.table(rbind.fill(as.data.frame(GA_CRCT), as.data.frame(GA_CRCT_RETEST)))


### Tidy up GA_CRCT

GA_CRCT[['AYP_TEST_ID']] <- NULL
GA_CRCT[['SR_STUDENT_ID']] <- NULL
levels(GA_CRCT[['GTID']])[1:2] <- NA # Remove the empty string factor (missing) GTID and All 0's replace with NA
GA_CRCT[['SR_SYSTEM_ID']] <- as.integer(GA_CRCT[['SR_SYSTEM_ID']])
GA_CRCT[['STUDENT_GRADE_LEVEL']] <- as.integer(GA_CRCT[['STUDENT_GRADE_LEVEL']])
GA_CRCT[['STUDENT_GRADE_LEVEL']][GA_CRCT[['STUDENT_GRADE_LEVEL']]==12] <- 0L
GA_CRCT[['STUDENT_GRADE_LEVEL']][GA_CRCT[['STUDENT_GRADE_LEVEL']]==13] <- -1L
GA_CRCT[['STUDENT_GRADE_LEVEL']][GA_CRCT[['STUDENT_GRADE_LEVEL']]==14] <- 12
GA_CRCT[['AYP_GRADE']] <- as.integer(GA_CRCT[['AYP_GRADE']])
GA_CRCT[['RACE_CODE']][GA_CRCT[['RACE_CODE']]=="A"] <- "S"
GA_CRCT[['RACE_CODE']]<- factor(GA_CRCT[['RACE_CODE']])
levels(GA_CRCT[['RACE_CODE']]) <- c("African-American/Black", "Hispanic", "American Indian/Alaskan Native", "Two or More Races", "Pacific Islander", "Asian", "White")
levels(GA_CRCT[['GENDER_CODE']]) <- c("Female", "Male")
levels(GA_CRCT[['ED']]) <- c("Economically Disadvantaged: No", "Economically Disadvantaged: Yes")
levels(GA_CRCT[['SWD']]) <- c("Student with Disability: No", "Student with Disability: Yes")
levels(GA_CRCT[['LEP']]) <- c("LEP: No", "LEP: Yes")
GA_CRCT[['AYP_SS']] <- as.numeric(GA_CRCT[['AYP_SS']])
GA_CRCT[['SCHOOL_ENROLLMENT_STATUS']] <- factor(1, levels=1:2, labels=c("Enrolled School: Yes", "Enrolled School: No"))
GA_CRCT[['DISTRICT_ENROLLMENT_STATUS']] <- factor(1, levels=1:2, labels=c("Enrolled District: Yes", "Enrolled District: No"))
GA_CRCT[['STATE_ENROLLMENT_STATUS']] <- factor(1, levels=1:2, labels=c("Enrolled State: Yes", "Enrolled State: No"))

trimWhiteSpace <- function(line) gsub("(^ +)|( +$)", "", line)
levels(GA_CRCT[['CLSNAME']])[1] <- NA
levels(GA_CRCT[['CLSNAME']]) <- trimWhiteSpace(levels(GA_CRCT[['CLSNAME']]))
GA_CRCT[['INSTRUCTOR_NUMBER_1']] <- paste(GA_CRCT[['CLSNAME']], ":", GA_CRCT[['SR_SCHOOL_ID']])
GA_CRCT[['CLSNAME']] <- NULL ## Variable is a mess and unusable. Prefer unique teacher identifier

###
### Create subset contain ONLY CRCT tests
###
### CRCT READING: 2005-2006 to 2011-2012 Grades 3 to 8
### CRCT ELA: 2005-2006 to 2011-2012 Grade 3 to 8
### CRCT MATH: 2005-2006 to 2011-2012 Grade 6, 2006 to 2007: Grade7, Grade 2007-2008 to 2011-2012 Grades 3 to 8 
### 
###

attach(GA_CRCT)
CRCT.tf <- 
		(SCHOOL_YEAR %in% 2006:2011 & CONTENT_AREA=="READING") | 
		(SCHOOL_YEAR %in% 2006:2011 & CONTENT_AREA=="ELA") |
		(SCHOOL_YEAR==2006 & CONTENT_AREA=="MATHEMATICS" & AYP_GRADE==6) |
		(SCHOOL_YEAR==2007 & CONTENT_AREA=="MATHEMATICS" & AYP_GRADE %in% 6:7) |
		(SCHOOL_YEAR %in% 2008:2011 & CONTENT_AREA=="MATHEMATICS") |
		(SCHOOL_YEAR==2006 & CONTENT_AREA=="SCIENCE" & AYP_GRADE %in% 6:7) |
		(SCHOOL_YEAR %in% 2007:2011 & CONTENT_AREA=="SCIENCE" & AYP_GRADE %in% 3:7) |
		(SCHOOL_YEAR %in% 2008:2011 & CONTENT_AREA=="SCIENCE" & AYP_GRADE==8) |
		(SCHOOL_YEAR %in% 2009:2011 & CONTENT_AREA=="SOCIAL_STUDIES" & AYP_GRADE %in% c(3:5,8)) |
		(SCHOOL_YEAR %in% 2010:2011 & CONTENT_AREA=="SOCIAL_STUDIES" & AYP_GRADE %in% 6:7) |
		(SCHOOL_YEAR %in% 2008 & CONTENT_AREA=="SOCIAL_STUDIES" & AYP_GRADE %in% 8)

detach(GA_CRCT)
				
GA_CRCT <- GA_CRCT[CRCT.tf,]
GA_CRCT <- subset(GA_CRCT, SCHOOL_YEAR %in% 2007:2011)
GA_CRCT <- subset(GA_CRCT, AYP_GRADE %in% 3:8)


###  Unique School Identifier - 5/5/11:
###  Most districts have 3 digit numbers - 14 oddballs:

summary(as.factor(GA_CRCT[['SR_SYSTEM_ID']][GA_CRCT[['SR_SYSTEM_ID']]>1000]))
summary(as.factor(GA_CRCT[['SR_SCHOOL_ID']][GA_CRCT[['SR_SYSTEM_ID']]>1000]))

GA_CRCT[['SCHOOL_NUMBER']] <- GA_CRCT[['SR_SYSTEM_ID']]*10000 + GA_CRCT[['SR_SCHOOL_ID']]
GA_CRCT[['SCHOOL_NUMBER']][GA_CRCT[['SR_SYSTEM_ID']]>1000] <- GA_CRCT[['SR_SYSTEM_ID']][GA_CRCT[['SR_SYSTEM_ID']]>1000]
GA_CRCT[['SCHOOL_NUMBER']] <- as.integer(GA_CRCT[['SCHOOL_NUMBER']])

summary(GA_CRCT[['SCHOOL_NUMBER']])


###  Inspect and "Invalidate" some of the student records

# GA_CRCT[['VALID_CASE']] <- factor(1, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE"))
GA_CRCT[['VALID_CASE']] <- "VALID_CASE"

#  Invalidate the cases that have been indicated as invalid or problematic:

GA_CRCT[['VALID_CASE']][GA_CRCT[['TAR']] %in% c(2,3)] <- "INVALID_CASE"
GA_CRCT[['VALID_CASE']][GA_CRCT[['PTNA']]==1] <- "INVALID_CASE"
GA_CRCT[['VALID_CASE']][GA_CRCT[['DNA']]==1] <- "INVALID_CASE"
GA_CRCT[['VALID_CASE']][GA_CRCT[['AYP_CTBRC']] %in% c(1,2,3,4)] <- "INVALID_CASE"
summary(as.factor(GA_CRCT[['VALID_CASE']]))

#  Create a catch all invalidation indicator for future invalidation processes:

GA_CRCT[['ADMIN_INVALIDATION']] <- NA

#  Invalidate the cases that have been indicated as invalid or problematic:

GA_CRCT[['ADMIN_INVALIDATION']][GA_CRCT[['TAR']] %in% c(2,3)] <- "TAR"
GA_CRCT[['ADMIN_INVALIDATION']][GA_CRCT[['PTNA']]==1] <- "PTNA"
GA_CRCT[['ADMIN_INVALIDATION']][GA_CRCT[['DNA']]==1] <- "DNA"
# GA_CRCT[['ADMIN_INVALIDATION']][GA_CRCT[['AYP_CTBRC']] %in% c(1,2,3,4)] <- "AYP_CTBRC" # 1=PTNA, 2 & 4 = TAR, 3=DNA
summary(as.factor(GA_CRCT[['ADMIN_INVALIDATION']]))


# Invalidate the cases with NA as ID
GA_CRCT[['VALID_CASE']][is.na(GA_CRCT[['GTID']])] <- "INVALID_CASE"

# Invalidate cases from schools in Schools_To_Remove and Schools_To_Remove_RETEST

setnames(GA_CRCT, 
	c("SCHOOL_YEAR","GTID", "AYP_GRADE", "AYP_SS", "SR_SYSTEM_ID"),
	c("YEAR", "ID", "GRADE", "SCALE_SCORE", "DISTRICT_NUMBER"))

Schools_to_Remove_RETEST[["ADMIN_TYPE"]] <- "Retest"
Schools_to_Remove_RETEST <- data.table(Schools_to_Remove_RETEST, key=c('YEAR', 'SCHOOL_NUMBER', "ADMIN_TYPE"))
GA_CRCT[["ADMIN_TYPE"]] <- as.character(GA_CRCT[["ADMIN_TYPE"]])
setkey(GA_CRCT, YEAR, SCHOOL_NUMBER, ADMIN_TYPE)
index.tmp <- GA_CRCT[Schools_to_Remove_RETEST, which=TRUE]
GA_CRCT[['VALID_CASE']][index.tmp] <- "INVALID_CASE"

levels(Schools_to_Remove[['YEAR']]) <- as.character(c(1:3,5:7,8,8:10))
Schools_to_Remove[['YEAR']] <- type.convert(as.character(Schools_to_Remove[['YEAR']]))+2000L
setkey(Schools_to_Remove, YEAR, SCHOOL_NUMBER)
setkey(GA_CRCT, YEAR, SCHOOL_NUMBER)
index.tmp <- GA_CRCT[Schools_to_Remove, which=TRUE]
index.tmp <- index.tmp[!is.na(index.tmp)]
GA_CRCT[['VALID_CASE']][index.tmp] <- "INVALID_CASE"

###
###  Invalidate Duplicated Records
###

setkeyv(GA_CRCT, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "ADMIN_TYPE"))
dups <- GA_CRCT[sort(unique(c(which(duplicated(GA_CRCT))-1, which(duplicated(GA_CRCT))))),]
setkeyv(dups, c("ID", "YEAR", "CONTENT_AREA", "VALID_CASE"))
summary(dups[VALID_CASE=="VALID_CASE"])
dim(dups)


### Invalidate lowest score for duplicate, valid cases.

# setkeyv(GA_CRCT, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "GRADE", "SCALE_SCORE", "RETEST"))
# setkeyv(GA_CRCT, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "RETEST"))
# GA_CRCT[['VALID_CASE']][which(duplicated(GA_CRCT))-1] <- "INVALID_CASE"  # RETEST = NA invalidated
# summary(as.factor(GA_CRCT[['VALID_CASE']]))

setkeyv(GA_CRCT, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "SCALE_SCORE"))
setkeyv(GA_CRCT, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
GA_CRCT[['VALID_CASE']][which(duplicated(GA_CRCT))-1] <- "INVALID_CASE"
summary(as.factor(GA_CRCT[['VALID_CASE']]))

###  Create the students' Achievement Levels on CRCT

GA_CRCT[['ACHIEVEMENT_LEVEL']] <- NA

###  Special version of this function because cuts changed in various years.  No need for different content area cuts, just scales.

perlev.recode <- function(scale_scores, cuts) {
   findInterval(scale_scores, cuts)+1
}

### create ACHIEVEMENT_LEVEL

setkeyv(GA_CRCT, c("CONTENT_AREA", "GRADE"))
GA_CRCT[['ACHIEVEMENT_LEVEL']][!is.na(GA_CRCT[['SCALE_SCORE']])] <- GA_CRCT[, perlev.recode(SCALE_SCORE, cuts=c(800, 850))][!is.na(GA_CRCT[['SCALE_SCORE']])]
table(GA_CRCT[['CONTENT_AREA']], GA_CRCT[['ACHIEVEMENT_LEVEL']])


###  Change ACHIEVEMENT_LEVEL into a factor with the appropriate proficiency level labels:

GA_CRCT[['ACHIEVEMENT_LEVEL']] <- 
	factor(GA_CRCT[['ACHIEVEMENT_LEVEL']], levels=1:3, labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)

summary(GA_CRCT[['ACHIEVEMENT_LEVEL']])
summary(GA_CRCT[['SCALE_SCORE']][is.na(GA_CRCT[['ACHIEVEMENT_LEVEL']])])


### NULL out extraneous variables that are no longer needed

GA_CRCT[['SR_SCHOOL_ID']] <- NULL
GA_CRCT[['AYP_ADMIN']] <- NULL
GA_CRCT[['TAR']] <- NULL
GA_CRCT[['PTNA']] <- NULL
GA_CRCT[['DNA']] <- NULL
GA_CRCT[['AYP_CTBRC']] <- NULL
GA_CRCT[['STUDENT_GRADE_LEVEL']] <- NULL
# GA_CRCT[["ADMIN_TYPE"]] <- NULL


### SAVE GA_CRCT

preferred.variable.order <- c("VALID_CASE", "CONTENT_AREA", "YEAR", "GRADE", "ID", "SCALE_SCORE", 
	"INSTRUCTOR_NUMBER_1", "SCHOOL_NUMBER", "DISTRICT_NUMBER", "ACHIEVEMENT_LEVEL", 
	"RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "ADMIN_INVALIDATION", "ADMIN_TYPE",
	"SCHOOL_ENROLLMENT_STATUS", "DISTRICT_ENROLLMENT_STATUS", "STATE_ENROLLMENT_STATUS")

GA_CRCT <- GA_CRCT[,preferred.variable.order,with=FALSE]
GA_CRCT <- as.data.frame(GA_CRCT)

save(GA_CRCT, file='Data/GA_CRCT.Rdata')


#####################################################################################
###    
###  	Construct EOC LONG Data sets
###
#####################################################################################

### EOC Data set: 2006 to 2008.

EOC1 <- read.fwf("Data/Base_Files/eoct_2006-2008_output.txt", 
	c(4,10,4,9,1,1,2,1,1,1,10,5,3,1,12,10,5,1,1,1,1,3,1,7), buffersize = 1000000, stringsAsFactors=FALSE, comment.char="")

names(EOC1) <- c('SCHOOL_YEAR', 'SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'SR_STUDENT_ID', 'RACE_CODE', 'GENDER_CODE', 'STUDENT_GRADE_LEVEL', 'ED', 'SWD', 'LEP', 'GTID', 'ASSESSMENT_SUBJECT_CODE', 'SCALE_SCORE', 'PERF_LEVEL', 'TEACHER_LNAME', 'TEACHER_FNAME', 'PTNA', 'IEP', 'LEP', 'DNA_INDICATOR', 'IRREG_ADMIN_INVALID', 'GRADE_CONVERSION', 'PIV', 'ADMIN_DATE')


### 2009 - 2011 EOC Data set.  5/25/12

EOC2 <- read.fwf("Data/Base_Files/eoct_2009-2011_output.txt", 
	c(4,10,4,9,1,1,2,1,1,1,10,5,3,1,12,10,1,1,1,1,1,3,1,7), buffersize = 100000, stringsAsFactors=FALSE, comment.char="")# PTNA width = 1 in 2011

names(EOC2) <- c('SCHOOL_YEAR', 'SR_SYSTEM_ID', 'SR_SCHOOL_ID', 'SR_STUDENT_ID', 'RACE_CODE', 'GENDER_CODE', 'STUDENT_GRADE_LEVEL', 'ED', 'SWD', 'LEP', 'GTID', 'ASSESSMENT_SUBJECT_CODE', 'SCALE_SCORE', 'PERF_LEVEL', 'TEACHER_LNAME', 'TEACHER_FNAME', 'PTNA', 'IEP', 'LEP', 'DNA_INDICATOR', 'IRREG_ADMIN_INVALID', 'GRADE_CONVERSION', 'PIV', 'ADMIN_DATE')

GA_EOC <- rbind.fill(EOC1, EOC2)
# rm(list=c('EOC1', 'EOC2'))
gc()


###  Convert strings to factors now that they are merged:

for (f in c('GTID', 'RACE_CODE', 'GENDER_CODE', 'STUDENT_GRADE_LEVEL', 'ED', 'SWD', 'LEP', 'IEP',
  'ASSESSMENT_SUBJECT_CODE', 'PTNA', 'DNA_INDICATOR', 'IRREG_ADMIN_INVALID', 'PIV', 'ADMIN_DATE')) {
	GA_EOC[[f]] <- factor(GA_EOC[[f]])
}


###  Match up factor levels with GA_CRCT

levels(GA_EOC[['GTID']])[1:2] <- NA
GA_EOC[['SR_SYSTEM_ID']] <- as.integer(GA_EOC[['SR_SYSTEM_ID']])

levels(GA_EOC[['STUDENT_GRADE_LEVEL']]) <- c('6', '7', '8', '9', '10', '11', '12', '6', '7', '8', '9', 'PK')
GA_EOC[['STUDENT_GRADE_LEVEL']] <- as.integer(GA_EOC[['STUDENT_GRADE_LEVEL']])+5

###  Subset the EOC data similar to CRCT Data 
GA_EOC <- subset(GA_EOC, SCHOOL_YEAR %in% 2007:2011) # No 2006 data - no GTID values
GA_EOC <- subset(GA_EOC, STUDENT_GRADE_LEVEL %in% 8:12) # keep the 8th graders for now...


GA_EOC$RACE_CODE[GA_EOC$RACE_CODE=="A"] <- "S"
GA_EOC$RACE_CODE <- droplevels(GA_EOC$RACE_CODE)
levels(GA_EOC$RACE_CODE) <- c("African-American/Black", "Hispanic", "American Indian/Alaskan Native", "Two or More Races", "Pacific Islander", "Asian", "White")
levels(GA_EOC$GENDER_CODE) <- c("Female", "Male")
levels(GA_EOC$ED) <- c("Economically Disadvantaged: No", "Economically Disadvantaged: Yes")
levels(GA_EOC$IEP) <- c("Student with Disability: No", "Student with Disability: Yes")
levels(GA_EOC$LEP) <- c("LEP: No", "LEP: Yes")

levels(GA_EOC$ASSESSMENT_SUBJECT_CODE) <- c("ALGEBRA", "GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS", "MATHEMATICS_I", "MATHEMATICS_II")
levels(GA_EOC$ADMIN_DATE) <- c(rep("SPRING", 4), rep("WINTER", 4), "SUMMER") #  Add summer for later data addition

GA_EOC[['PERF_LEVEL']] <- factor(GA_EOC[['PERF_LEVEL']], levels=1:3, labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)

### NULL out extraneous variables (DONE ABOVE - here to match)

GA_EOC[['SR_STUDENT_ID']] <- NULL

###  Set up the VALID_CASE variable:

# GA_EOC[['VALID_CASE']] <- factor(1, levels=1:2, labels=c("VALID_CASE", "INVALID_CASE"))
GA_EOC[['VALID_CASE']] <- 'VALID_CASE'

GA_EOC[['VALID_CASE']][is.na(GA_EOC[['GTID']])] <- "INVALID_CASE"

###  Invalidate the cases that have been indicated as invalid or problematic:

GA_EOC[['VALID_CASE']][GA_EOC[['IRREG_ADMIN_INVALID']] =='Y'] <- "INVALID_CASE"
GA_EOC[['VALID_CASE']][GA_EOC[['DNA_INDICATOR']]=='Y'] <- "INVALID_CASE"
GA_EOC[['VALID_CASE']][GA_EOC[['PTNA']]=='Y'] <- "INVALID_CASE"
GA_EOC[['VALID_CASE']][GA_EOC[['PTNA']]=='Y    '] <- "INVALID_CASE"

summary(as.factor(GA_EOC[['VALID_CASE']]))


# Use ADMIN_INVALIDATION for future INVALIDATION processes

GA_EOC[['ADMIN_INVALIDATION']] <- NA

###  Invalidate the cases that have been indicated as invalid or problematic:

GA_EOC[['ADMIN_INVALIDATION']][GA_EOC[['IRREG_ADMIN_INVALID']] =='Y'] <- "IRREG_ADMIN"
GA_EOC[['ADMIN_INVALIDATION']][GA_EOC[['DNA_INDICATOR']]=='Y'] <- "DNA"
GA_EOC[['ADMIN_INVALIDATION']][GA_EOC[['PTNA']]=='Y'] <- "PTNA"
GA_EOC[['ADMIN_INVALIDATION']][GA_EOC[['PTNA']]=='Y    '] <- "PTNA"

summary(as.factor(GA_EOC[['ADMIN_INVALIDATION']]))


#  Not sure how to mesh the PTNA variable - 1/0 in the other dataset, and several levels here (Y/N, numeric values, etc.)
#GA_EOC[['VALID_CASE']][GA_EOC[['PTNA']]=='Y'] <- "INVALID_CASE"


###  Unique School Identifier - 5/5/11:

summary(as.factor(GA_EOC[['SR_SYSTEM_ID']][GA_EOC[['SR_SYSTEM_ID']]>1000]))
summary(as.factor(GA_EOC[['SR_SCHOOL_ID']][GA_EOC[['SR_SYSTEM_ID']]>1000]))

GA_EOC[['SCHOOL_NUMBER']]<- GA_EOC[['SR_SYSTEM_ID']]*10000 + GA_EOC[['SR_SCHOOL_ID']]
GA_EOC[['SCHOOL_NUMBER']][GA_EOC[['SR_SYSTEM_ID']]>1000 & !is.na(GA_EOC[['SR_SYSTEM_ID']])] <- 
	GA_EOC[['SR_SYSTEM_ID']][GA_EOC[['SR_SYSTEM_ID']]>1000 & !is.na(GA_EOC[['SR_SYSTEM_ID']])]

GA_EOC$STATE_ENROLLMENT_STATUS <- factor(1, levels=1:2, c("Enrolled State: Yes", "Enrolled State: No"))
GA_EOC$DISTRICT_ENROLLMENT_STATUS <- factor(1, levels=1:2, c("Enrolled District: Yes", "Enrolled District: No"))
GA_EOC$SCHOOL_ENROLLMENT_STATUS <- factor(1, levels=1:2, c("Enrolled School: Yes", "Enrolled School: No"))


### Invalidate lowest score for duplicate, valid cases.

GA_EOC <- data.table(GA_EOC)
setnames(GA_EOC, 
	c('SCHOOL_YEAR','GTID', "IEP", 'STUDENT_GRADE_LEVEL', 'SR_SCHOOL_ID', 'SR_SYSTEM_ID', 'PERF_LEVEL', 'ASSESSMENT_SUBJECT_CODE', 'DNA_INDICATOR'),
	c('YEAR', 'ID', "SWD", 'GRADE', 'SCHOOL_NUMBER', 'DISTRICT_NUMBER', 'ACHIEVEMENT_LEVEL', 'CONTENT_AREA', 'DNA'))
setkeyv(GA_EOC, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "GRADE", "ADMIN_DATE", "SCALE_SCORE"))
setkeyv(GA_EOC, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "GRADE", "ADMIN_DATE"))

dups <- data.table(GA_EOC[c(which(duplicated(GA_EOC))-1, which(duplicated(GA_EOC))),], key=c("YEAR", "CONTENT_AREA", "ID"))
GA_EOC[['VALID_CASE']][which(duplicated(GA_EOC))-1] <- "INVALID_CASE"
summary(as.factor(GA_EOC[['VALID_CASE']]))

###  What to do about multiple ADMIN_DATE in same Year/Content area?

# setkeyv(GA_EOC, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "GRADE", "ADMIN_DATE"))
setkeyv(GA_EOC, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "GRADE"))
dups <- data.table(GA_EOC[c(which(duplicated(GA_EOC))-1, which(duplicated(GA_EOC))),], key=c("YEAR", "CONTENT_AREA", "ID"))
summary(dups[dups$VALID_CASE=="VALID_CASE",])
summary(dups$ACHIEVEMENT_LEVEL[dups$VALID_CASE=="VALID_CASE" & dups$ADMIN_DATE=="WINTER"])
summary(dups$ACHIEVEMENT_LEVEL[dups$VALID_CASE=="VALID_CASE" & dups$ADMIN_DATE=="SPRING"])

###  Just get one ADMIN DATE row.  For now just use SPRING until official decision made?
# GA_EOC[['VALID_CASE']][which(duplicated(GA_EOC))] <- "INVALID_CASE"

### No, use highest score...  Might need to go back and recalculate some SGPs for some ?
setkeyv(GA_EOC, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "GRADE", "SCALE_SCORE"))
setkeyv(GA_EOC, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID", "GRADE"))
GA_EOC[['VALID_CASE']][which(duplicated(GA_EOC))-1] <- "INVALID_CASE"

### Also further dups where the students have different grade levels in same year.  Similar to ADMIN_DATE, but something like 9th grade in WINTER, 10th grade in SPRING...
###  These kids took same test in winter and spring, but given different grade levels.  

setkeyv(GA_EOC, c("VALID_CASE", "YEAR", "CONTENT_AREA", "ID"))
dups <- data.table(GA_EOC[c(which(duplicated(GA_EOC))-1, which(duplicated(GA_EOC))),], key=c("YEAR", "CONTENT_AREA", "ID"))
GA_EOC[['VALID_CASE']][which(duplicated(GA_EOC))-1] <- "INVALID_CASE"


### Create bad INSTRUCTOR_NUMBER_1 (needs to get better)

cleanNames <- function(line) {
	line <- gsub("[[:punct:]]", "", line)
	line <- gsub("(^ +)|( +$)", "", line)
	return(line)
}

GA_EOC$TEACHER_FNAME <- factor(GA_EOC$TEACHER_FNAME)
GA_EOC$TEACHER_LNAME <- factor(GA_EOC$TEACHER_LNAME)
levels(GA_EOC$TEACHER_FNAME) <- cleanNames(levels(GA_EOC$TEACHER_FNAME))
levels(GA_EOC$TEACHER_LNAME) <- cleanNames(levels(GA_EOC$TEACHER_LNAME))
levels(GA_EOC$TEACHER_FNAME) <- toupper(levels(GA_EOC$TEACHER_FNAME))
levels(GA_EOC$TEACHER_LNAME) <- toupper(levels(GA_EOC$TEACHER_LNAME))
levels(GA_EOC$TEACHER_FNAME) <- gsub("  ", " ", levels(GA_EOC$TEACHER_FNAME))
levels(GA_EOC$TEACHER_LNAME) <- gsub("  ", " ", levels(GA_EOC$TEACHER_LNAME))
levels(GA_EOC$TEACHER_FNAME)[1] <- NA
levels(GA_EOC$TEACHER_LNAME)[1] <- NA

GA_EOC$INSTRUCTOR_NUMBER_1 <- factor(paste(GA_EOC$TEACHER_FNAME, GA_EOC$TEACHER_LNAME, ":", GA_EOC$SR_SCHOOL_ID))


### Invalidate cases that are not GPS assessments and remove 2006 data

attach(GA_EOC)
EOC.tf <- (YEAR %in% 2010:2011 & CONTENT_AREA=="MATHEMATICS_I") | 
	(YEAR %in% 2010:2011 & CONTENT_AREA=="MATHEMATICS_II") | 
	(YEAR %in% 2008:2011 & CONTENT_AREA=="US_HISTORY") | 
	(YEAR %in% 2008:2011 & CONTENT_AREA=="ECONOMICS") | 
	(YEAR %in% 2007:2011 & CONTENT_AREA=="GRADE_9_LIT") | 
	(YEAR %in% 2007:2011 & CONTENT_AREA=="AMERICAN_LIT") | 
	(YEAR %in% 2007:2011 & CONTENT_AREA=="PHYSICAL_SCIENCE") | 
	(YEAR %in% 2007:2011 & CONTENT_AREA=="BIOLOGY")
detach(GA_EOC)

GA_EOC <- GA_EOC[EOC.tf,]


### Remove extraneous variables

extraneous.variables <- c("SR_SCHOOL_ID", "LEP_TPC", "TEACHER_LNAME", "TEACHER_FNAME", "PTNA", "DNA", "IRREG_ADMIN_INVALID", "PIV", "GRADE_CONVERSION")
for (i in extraneous.variables) {
	GA_EOC[[i]] <- NULL
}

### Save GA_EOC

save(GA_EOC, file="Data/GA_EOC.Rdata")


#####################################################################################
###
### Combine GA_CRCT and GA_EOC
###
#####################################################################################

GA_CRCT$ID <- as.character(GA_CRCT$ID)
GA_EOC$ID <- as.character(GA_EOC$ID)
Georgia_Data_LONG <- rbind.fill(GA_CRCT, GA_EOC)

save(Georgia_Data_LONG, file="Data/Georgia_Data_LONG_Pre-AddPriors_120412.Rdata")

#  Keep as character now for data.table 1.8.2
#Georgia_Data_LONG[['ID']] <- as.factor(Georgia_Data_LONG[['ID']])

#####################################################################################
###
### Create the Georgia_SGP object 
###
#####################################################################################

# Georgia_SGP <- prepareSGP(Georgia_Data_LONG)
# 
# ### Save results
# 
# save(Georgia_SGP, file="Data/Georgia_SGP-LONG_ONLY.Rdata")
