###############################################################################################
###############################################################################################
####
####		Georgia Student Growth Percentiles Analysis 
####		Criterion-Referenced Competency Tests (CRCT) & End of Course Tests (EOCT)
####		VALID_CASE indicator refactoring
####		Adam VanIwaarden/Damian Betebenner - NCIEA
####
###############################################################################################
###############################################################################################

###  Create a strictly VALID_CASE indicator to identify only cases that are truly invalid
###  Cases that are to be used as PRIOR and CURRENT scale scores will be identified with a new indicator

library(data.table)
library(plyr)
library(SGP)

##  Load the Georgia LONG object created December 2012:
setwd("/media/Data/SGP/Georgia")
load("Data/Georgia_Data_LONG-2012_FINAL.Rdata")

#  Create a 'GRADE_REPORTED' variable to retain the info contained in GRADE.
#  Change the GRADE Variable so that any EOCT test has the value 'EOCT' assigned to it:

Georgia_Data_LONG[, GRADE_REPORTED := Georgia_Data_LONG[['GRADE']]]
Georgia_Data_LONG[['GRADE']] <- as.character(Georgia_Data_LONG[['GRADE']])
Georgia_Data_LONG[which(Georgia_Data_LONG[['SUBJECT_CODE']] %in% c('GRADE_9_LIT', 'AMERICAN_LIT', 'BIOLOGY', 'PHYSICAL_SCIENCE', 'MATHEMATICS_I', 'MATHEMATICS_II', 'GEOMETRY', 'ALGEBRA', 'US_HISTORY', 'ECONOMICS')), GRADE := 'EOCT']


##  Rename the 2012 VALID_CASE indicator
setnames(Georgia_Data_LONG, "VALID_CASE", "VC_2012")

##  Begin the production of the VALID_CASE variable.
Georgia_Data_LONG[, VALID_CASE := 'VALID_CASE']

###  Invalidate the EOCT cases that have been indicated as invalid or problematic PRIOR TO 2012 ONLY:
Georgia_Data_LONG[which(!is.na(Georgia_Data_LONG[['ADMIN_INVALIDATION']]) & !Georgia_Data_LONG[['ADMIN_INVALIDATION']] %in% c('2012') &
	Georgia_Data_LONG[['SUBJECT_CODE']] %in% c("ALGEBRA", "GEOMETRY", "GRADE_9_LIT", "AMERICAN_LIT", "BIOLOGY", "PHYSICAL_SCIENCE", "US_HISTORY", "ECONOMICS", "MATHEMATICS_I", "MATHEMATICS_II")), VALID_CASE := 'INVALID_CASE'] # 9,414 Cases

### Invalidate ID's with fewer than 10 digits (or NA)
# This first step of converting GTID to character has been done already in Georgia_Data_LONG.  Left to show what was done originally.
# remove periods if present.  This was NOT done previously.  Probably a handful of cases still in Georgia_Data_LONG
Georgia_Data_LONG[grep('[.]', Georgia_Data_LONG[['GTID']]), GTID := gsub('[.]', '', GTID)]

Georgia_Data_LONG[which(is.na(Georgia_Data_LONG[['GTID']])), VALID_CASE := 'INVALID_CASE']
Georgia_Data_LONG[which(nchar(Georgia_Data_LONG[['GTID']]) != 10), VALID_CASE := 'INVALID_CASE'] # 21,879 total INVALID

## Invalidate NA and 0 scores
Georgia_Data_LONG[which(is.na(Georgia_Data_LONG[['SCALE_SCORE']]) | Georgia_Data_LONG[['SCALE_SCORE']]==0), VALID_CASE := 'INVALID_CASE']

table(Georgia_Data_LONG[['VALID_CASE']]) # 704,039 total Invalid


##  Invalidate cases from schools in Schools_To_Remove and Schools_To_Remove_RETEST

load("Data/Base_Files/Schools_to_Remove.Rdata")
load("Data/Base_Files/Schools_to_Remove_RETEST.Rdata")

attach(Schools_to_Remove_RETEST)
Schools_to_Remove_RETEST <- data.table(data.frame(
        SCHOOL_NUMBER=rep(SCHOOL_NUMBER, 2),
        SCHOOL_YEAR=as.character(rep(YEAR, 2)),
        SUBJECT_CODE=rep(c("READING", "MATHEMATICS"), each=dim(Schools_to_Remove_RETEST)[1]),
        ADMIN_TYPE="Retest", stringsAsFactors=FALSE), key=c('SCHOOL_YEAR', 'SCHOOL_NUMBER', 'SUBJECT_CODE', 'ADMIN_TYPE'))
detach(Schools_to_Remove_RETEST)

setkey(Georgia_Data_LONG, SCHOOL_YEAR, SCHOOL_NUMBER, SUBJECT_CODE, ADMIN_TYPE)
index.tmp <- Georgia_Data_LONG[Schools_to_Remove_RETEST, which=TRUE]

Georgia_Data_LONG[index.tmp, VALID_CASE := 'INVALID_CASE'] # 704,161 total INVALID
table(Georgia_Data_LONG[['VALID_CASE']])


crct.subjs <- c("ELA", "READING", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES")
levels(Schools_to_Remove[['YEAR']]) <- as.character(c(1:3,5:7,8,8:10))
Schools_to_Remove[['YEAR']] <- as.character(type.convert(as.character(Schools_to_Remove[['YEAR']]))+2000L)

attach(Schools_to_Remove)
Schools_to_Remove <- data.table(data.frame(
        SCHOOL_NUMBER=rep(SCHOOL_NUMBER, length(crct.subjs)),
        SCHOOL_YEAR=rep(YEAR, length(crct.subjs)),
        SUBJECT_CODE=rep(crct.subjs, each=dim(Schools_to_Remove)[1]), stringsAsFactors=FALSE), key=c('SCHOOL_YEAR', 'SCHOOL_NUMBER', 'SUBJECT_CODE'))
detach(Schools_to_Remove)

setkey(Georgia_Data_LONG, SCHOOL_YEAR, SCHOOL_NUMBER, SUBJECT_CODE)
index.tmp <- Georgia_Data_LONG[Schools_to_Remove, which=TRUE]
index.tmp <- index.tmp[!is.na(index.tmp)]

Georgia_Data_LONG[index.tmp, VALID_CASE := 'INVALID_CASE'] # 770,919 total INVALID
table(Georgia_Data_LONG[['VALID_CASE']]) 


### REMOVE cases that are not GPS assessments
###
### Create subset contain ONLY CRCT tests
###
### CRCT READING: 2005-2006 to 2011-2012 Grades 3 to 8
### CRCT ELA: 2005-2006 to 2011-2012 Grade 3 to 8
### CRCT MATH: 2005-2006 to 2011-2012 Grade 6, 2006 to 2007: Grade7, Grade 2007-2008 to 2011-2012 Grades 3 to 8 
### 
### GPS Alg and Geom came online in 2012 according to Allison - 11/18.  None in this file anyway for 2011 (but some included pre-2012)
### 

#  These have already been REMOVED, but checked anyway 2/5/13.  All GPS.tf == TRUE

# attach(Georgia_Data_LONG)
# GPS.tf <- 
# # CRCT
		# (SCHOOL_YEAR %in% 2006:2012 & SUBJECT_CODE=="READING") | 
		# (SCHOOL_YEAR %in% 2006:2012 & SUBJECT_CODE=="ELA") |
		# (SCHOOL_YEAR==2006 & SUBJECT_CODE=="MATHEMATICS" & GRADE==6) |
		# (SCHOOL_YEAR==2007 & SUBJECT_CODE=="MATHEMATICS" & GRADE %in% 6:7) |
		# (SCHOOL_YEAR %in% 2008:2012 & SUBJECT_CODE=="MATHEMATICS") |
		# (SCHOOL_YEAR==2006 & SUBJECT_CODE=="SCIENCE" & GRADE %in% 6:7) |
		# (SCHOOL_YEAR %in% 2007:2012 & SUBJECT_CODE=="SCIENCE" & GRADE %in% 3:7) |
		# (SCHOOL_YEAR %in% 2008:2012 & SUBJECT_CODE=="SCIENCE" & GRADE==8) |
		# (SCHOOL_YEAR %in% 2009:2012 & SUBJECT_CODE=="SOCIAL_STUDIES" & GRADE %in% c(3:5,8)) |
		# (SCHOOL_YEAR %in% 2010:2012 & SUBJECT_CODE=="SOCIAL_STUDIES" & GRADE %in% 6:7) |
		# (SCHOOL_YEAR %in% 2008 & SUBJECT_CODE=="SOCIAL_STUDIES" & GRADE %in% 8) |
# # EOCT
		# (SCHOOL_YEAR %in% 2012 & SUBJECT_CODE=="ALGEBRA") | 
		# (SCHOOL_YEAR %in% 2012 & SUBJECT_CODE=="GEOMETRY") | 
		# (SCHOOL_YEAR %in% 2010:2012 & SUBJECT_CODE=="MATHEMATICS_I") | 
		# (SCHOOL_YEAR %in% 2010:2012 & SUBJECT_CODE=="MATHEMATICS_II") | 
		# (SCHOOL_YEAR %in% 2008:2012 & SUBJECT_CODE=="US_HISTORY") | 
		# (SCHOOL_YEAR %in% 2008:2012 & SUBJECT_CODE=="ECONOMICS") | 
		# (SCHOOL_YEAR %in% 2007:2012 & SUBJECT_CODE=="GRADE_9_LIT") | 
		# (SCHOOL_YEAR %in% 2007:2012 & SUBJECT_CODE=="AMERICAN_LIT") | 
		# (SCHOOL_YEAR %in% 2007:2012 & SUBJECT_CODE=="PHYSICAL_SCIENCE") | 
		# (SCHOOL_YEAR %in% 2007:2012 & SUBJECT_CODE=="BIOLOGY")
# detach(Georgia_Data_LONG)

# Georgia_Data_LONG <- Georgia_Data_LONG[GPS.tf,]


###  Duplicate case invalidation/removal:

#  First construct a numeric variable to use for sorting duplicates
#  Two different variables will be needed - 1 to sort duplicates for use as a prior and another to sort for use as the current year.

Georgia_Data_LONG[['ADMINISTRATION_PERIOD']] <- factor(Georgia_Data_LONG[['ADMINISTRATION_PERIOD']])
levels(Georgia_Data_LONG[['ADMINISTRATION_PERIOD']]) <- c("2: SPRING", "3: SUMMER", "1: WINTER") # Order to correspond to time
Georgia_Data_LONG[['ADMINISTRATION_PERIOD']] <- as.character(Georgia_Data_LONG[['ADMINISTRATION_PERIOD']])
table(Georgia_Data_LONG$ADMINISTRATION_PERIOD)


#  Duplicate cases:  Totally identical rows on all important variables (including scores)...
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMINISTRATION_PERIOD", "SCALE_SCORE"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 359,003 ADDITIONAL duplicate cases

Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG))-1, VALID_CASE := 'INVALID_CASE'] # (1,129,922 Total)


#  Different scale score, but duplicate in the same GRADE and Admin Period.  Take highest Grade
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 434,765 ADDITIONAL duplicate cases 

Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG))-1, VALID_CASE := 'INVALID_CASE'] # (1,564,687 Total)


#  Different matched case status (same "ADMINISTRATION_PERIOD").  Take the matched case if available.
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 661 ADDITIONAL duplicate cases 

Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG))-1, VALID_CASE := 'INVALID_CASE'] # (1,565,348 Total)


#  Different GRADE.  (Keep "ADMINISTRATION_PERIOD" in key/sort for EOCT Tests.  All CRCT are NA)
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 278 ADDITIONAL duplicate cases 

#  First take only matched students (only 5)
Georgia_Data_LONG[intersect(c(which(duplicated(Georgia_Data_LONG)), which(duplicated(Georgia_Data_LONG))-1), which(Georgia_Data_LONG$MATCH_STATUS=="U")) , VALID_CASE := 'INVALID_CASE'] # (1,565,353 Total)

#  Different GRADE.  Take the highest grade level.  (Keep "ADMINISTRATION_PERIOD" in key/sort for EOCT Tests.  All CRCT are NA)
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "GRADE", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD"))
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "ADMINISTRATION_PERIOD"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
(dim(dups["VALID_CASE"])[1])/2 # 273 ADDITIONAL duplicate cases 

#  Now take highest grade level
Georgia_Data_LONG[which(duplicated(Georgia_Data_LONG))-1, VALID_CASE := 'INVALID_CASE'] # (1,565,626 Total)

table(Georgia_Data_LONG$VALID_CASE)


# Create YEAR_WITHIN (1 Winter, 2 Spring, 3 Summer)

Georgia_Data_LONG$YEAR_WITHIN <- as.character(as.integer(Georgia_Data_LONG$ADMINISTRATION_PERIOD))

###  Save LONG data and create new SGP Object

save(Georgia_Data_LONG, file="Data/Georgia_Data_LONG.Rdata")

