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

###  CONTENTS / LAYOUT OF Georgia_Data_LONG-2012.R SCRIPT:

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


### CONTENTS / LAYOUT OF Georgia_Data_LONG-Same_Year_Analyses.R SCRIPT

###############################################################################################
###
###   10)  Add in VALID_CASE indicator for SAME YEAR REPEATERs to use for analysis
###   11)  Create a second VALID_CASE indicator to use for combining results back into LONG data (only last/final case is "VALID")
###
###############################################################################################

library(data.table)
library(plyr)
library(SGP)

##  Load the Georgia LONG object (if not already in current workspace):
setwd("/media/Data/SGP/Georgia")
load("Data/Georgia_Data_LONG-2012_FINAL.Rdata")

##  Subset the data to include only the EOCT cases:
Georgia_Data_LONG <- Georgia_Data_LONG[Georgia_Data_LONG$SUBJECT_CODE %in% 
  c('GRADE_9_LIT', 'AMERICAN_LIT', 'BIOLOGY', 'PHYSICAL_SCIENCE', 'MATHEMATICS_I', 'MATHEMATICS_II', 'US_HISTORY', 'ECONOMICS'),][,c(1:6, 8:9, 16:17, 21:25), with=F]

#  Create a 'GRADE_REPORTED' variable to retain the info contained in GRADE.
#  Change the GRADE Variable so that any EOCT test has the value 'EOCT' assigned to it:
Georgia_Data_LONG[['GRADE_REPORTED']] <- Georgia_Data_LONG[['GRADE']]
Georgia_Data_LONG[['GRADE']] <- 'EOCT'

##  Rename the 2012 VALID_CASE indicator
setnames(Georgia_Data_LONG, 'VALID_CASE', 'VC_2012')

##  Begin the production of the alternate VALID_CASE variables.
Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']] <- 'VALID_CASE'
Georgia_Data_LONG[['VALID_CASE']] <- 'VALID_CASE'

##  Invalidate the EOCT cases that have been indicated as invalid or problematic:

# Not with 2012.  Only 2011 and before.  Makes no difference once you get to duplicate cases!
Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][!is.na(Georgia_Data_LONG[['ADMIN_INVALIDATION']]) & Georgia_Data_LONG[['SCHOOL_YEAR']] != '2012'] <- "INVALID_CASE"
Georgia_Data_LONG[['VALID_CASE']][!is.na(Georgia_Data_LONG[['ADMIN_INVALIDATION']]) & Georgia_Data_LONG[['SCHOOL_YEAR']] != '2012'] <- "INVALID_CASE"

table(Georgia_Data_LONG[['VALID_CASE']])

## GTID's with fewer than 10 digits (or NA)
Georgia_Data_LONG[['GTID']] <- as.character(as.numeric(Georgia_Data_LONG[['GTID']])) # remove leading zeros and other invalid ID's
Georgia_Data_LONG[['GTID']] <- gsub('[.]', '', Georgia_Data_LONG[['GTID']]) # remove periods if present

Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][is.na(Georgia_Data_LONG[['GTID']])] <- "INVALID_CASE"
Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][which(nchar(Georgia_Data_LONG[['GTID']]) != 10)] <- "INVALID_CASE"
Georgia_Data_LONG[['VALID_CASE']][is.na(Georgia_Data_LONG[['GTID']])] <- "INVALID_CASE"
Georgia_Data_LONG[['VALID_CASE']][which(nchar(Georgia_Data_LONG[['GTID']]) != 10)] <- "INVALID_CASE"

## Invalidate NA and 0 scores
Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][is.na(Georgia_Data_LONG[['SCALE_SCORE']]) | Georgia_Data_LONG[['SCALE_SCORE']]==0] <- "INVALID_CASE"
Georgia_Data_LONG[['VALID_CASE']][is.na(Georgia_Data_LONG[['SCALE_SCORE']]) | Georgia_Data_LONG[['SCALE_SCORE']]==0] <- "INVALID_CASE"

table(Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']])
table(Georgia_Data_LONG[['VALID_CASE']]) # 22,105

# NO invalidation of Schools_To_Remove and Schools_To_Remove_RETEST
# All of these were CRCT scores

#  Construct an integer variable to use for sorting duplicates
Georgia_Data_LONG[['ADMIN_ORDER']] <- factor(Georgia_Data_LONG[['ADMINISTRATION_PERIOD']])
levels(Georgia_Data_LONG[['ADMIN_ORDER']]) <- c("2", "3", "1") # Order to correspond with TIME
Georgia_Data_LONG[['ADMIN_ORDER']] <- as.integer(as.character(Georgia_Data_LONG[['ADMIN_ORDER']]))

#  Duplicate cases:  Totally identical rows (including scores)...
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMIN_ORDER", "SCALE_SCORE"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 2,327 duplicate cases

#  Invalidate the variable named "VALID_CASE" last since that's what we're keying on.
#  If you invalidate it first, the others won't get invalidated (records are no longer duplicated)!
Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE"
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE" # Just take one of them since total duplicate


#  Different scale score, but duplicate in the same YEAR and Admin Period
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMIN_ORDER"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 27,204 duplicate cases

Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE"
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))-1] <- "INVALID_CASE" # Take the highest score if same grade and same Admin period


#  Different matched case status (same "ADMIN_ORDER").  Take the matched case if available.
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "ADMIN_ORDER"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 501 duplicate cases

Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # INVALIDate UNmatched case.
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE"


#  Different scale score AND Admin Period.  These are the repeaters that we're interested in for same year repeater.
#  Note that this is done only to identify which cases repeaters, and should be INVALIDATED for BLOCK SCHEDULE.
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 67,748 duplicate cases

# Invalidate the duplicate case ONLY for BLOCK SCHED (different than first round).  First score can be used as current score, but not second (duplicate).  
# The duplicate will be used in the the same year repeater analysis as last/current score, so it can't be both.
# Only invalidate possible current year Block Schedule subjects
Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][which(duplicated(Georgia_Data_LONG) 
  & Georgia_Data_LONG[['SUBJECT_CODE']] %in% c('AMERICAN_LIT', 'BIOLOGY', 'PHYSICAL_SCIENCE', 'MATHEMATICS_II', 'ECONOMICS'))] <- "INVALID_CASE"

##  Create alternate YEAR variable to use for these cases.
##  Assign first occurrence (probably Winter or Spring) 1, and ALL SUBSEQUENT (duplicates) a 2 for now.  Multiple duplicates sorted out below.
Georgia_Data_LONG[['REPEATER_YEAR']] <- NA
Georgia_Data_LONG[['REPEATER_BASELINE_YEAR']] <- NA
Georgia_Data_LONG[['REPEATER_YEAR']][which(duplicated(Georgia_Data_LONG))-1] <- paste(Georgia_Data_LONG[['SCHOOL_YEAR']][which(duplicated(Georgia_Data_LONG))-1], 1, sep="_")
Georgia_Data_LONG[['REPEATER_YEAR']][which(duplicated(Georgia_Data_LONG))] <- paste(Georgia_Data_LONG[['SCHOOL_YEAR']][which(duplicated(Georgia_Data_LONG))-1], 2, sep="_")
Georgia_Data_LONG[['REPEATER_BASELINE_YEAR']][which(duplicated(Georgia_Data_LONG))-1] <- '1'
Georgia_Data_LONG[['REPEATER_BASELINE_YEAR']][which(duplicated(Georgia_Data_LONG))] <- '2'

#  Kids with MORE THAN 2 duplicates in a year
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "REPEATER_YEAR", "SUBJECT_CODE", "GTID", "ADMIN_ORDER", "SCALE_SCORE")) # Add scale score in case any 2 duplicates within Admin time
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "REPEATER_YEAR", "SUBJECT_CODE", "GTID"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 198,568  # dim(dups[!is.na(dups$REPEATER_YEAR)]["VALID_CASE"])/2 # 694 (VALID) duplicates on REPEATER_YEAR (5094 are already invalid)

Georgia_Data_LONG[['REPEATER_BASELINE_YEAR']][which(duplicated(Georgia_Data_LONG) & !is.na(Georgia_Data_LONG[['REPEATER_BASELINE_YEAR']]))] <- '3'

Georgia_Data_LONG[['REPEATER_YEAR']][which(duplicated(Georgia_Data_LONG) & !is.na(Georgia_Data_LONG[['REPEATER_YEAR']]))] <- 
	paste(Georgia_Data_LONG[['SCHOOL_YEAR']][which(duplicated(Georgia_Data_LONG) & !is.na(Georgia_Data_LONG[['REPEATER_YEAR']]))], 3, sep="_")

table(Georgia_Data_LONG[['REPEATER_BASELINE_YEAR']], Georgia_Data_LONG[['ADMINISTRATION_PERIOD']])
table(Georgia_Data_LONG[['REPEATER_BASELINE_YEAR']], Georgia_Data_LONG[['VALID_CASE']])

#  Invalidate the "Final" repeat for same year repeaters (2009-2012 Block schedule dealt with in more detail below)
#  Not totally necessary since analyses won't use any "3" values.  This does get rid of alot of cases we won't be using anyways.
Georgia_Data_LONG[['VALID_CASE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE"


#  More repeaters in multiple years.  Not "just" same year repeaters (but probably that too).  
#  Invalidate these records since we don't know if the different repeats happened in previous subsequent years.
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "REPEATER_BASELINE_YEAR", "REPEATER_YEAR", "SUBJECT_CODE", "GTID"))
setkeyv(Georgia_Data_LONG, c("VALID_CASE", "REPEATER_BASELINE_YEAR", "SUBJECT_CODE", "GTID"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 1088

#  Create a seperate VC for producing repeater baseline SGPs.  VALID_CASE will now be used to produce baseline matrices ONLY.
#  This lets us keep these cases for computing BASELINE SGPs on an annual basis.
#  (just keeps them out of the baseline matrix construction, which was causing problems when multiple rows matched the 1 or 2 year value)
Georgia_Data_LONG[['VC_SAME_YR_REPEAT']] <- Georgia_Data_LONG[['VALID_CASE']]
Georgia_Data_LONG[['VALID_CASE']][c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG)))] <- "INVALID_CASE"

#  Shows the available 'cohorts' for Within year repeaters
table(Georgia_Data_LONG[['REPEATER_BASELINE_YEAR']], Georgia_Data_LONG[['SUBJECT_CODE']], Georgia_Data_LONG[['VALID_CASE']])
table(Georgia_Data_LONG[['REPEATER_YEAR']], Georgia_Data_LONG[['SUBJECT_CODE']], Georgia_Data_LONG[['VC_SAME_YR_REPEAT']])
table(Georgia_Data_LONG[['REPEATER_YEAR']], Georgia_Data_LONG[['REPEATER_BASELINE_YEAR']])

###
###  Block Schedule.  Need to diferentiate which kids are on Block schedule and which are just repeaters in one course & taking second course for 1st time...
###

#  Different scale score AND Admin Period.  Same year and match status
#  Invalidate repeat in SAME year if one exists
# setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "MATCH_STATUS", "ADMIN_ORDER", "SCALE_SCORE"))
# setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "MATCH_STATUS"))
# dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
# setkeyv(dups, key(Georgia_Data_LONG))
# dim(dups["VALID_CASE"]) #  65,245 duplicate cases
# # head(dups["VALID_CASE"], 20)
# d <- data.table(dups[J("VALID_CASE", '2012')][SUBJECT_CODE %in% c('MATHEMATICS_I', 'MATHEMATICS_II')], key=c("SCHOOL_YEAR", "SUBJECT_CODE", "GTID"))
# 
# #   These are all "priors" subjects - G9 Lit, math I and US Hist.
# #   Leave for now.  Should get sorted out in the analyses.
# # Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # Take FIRST Admin period ONLY.
# 
# #  Invalidate unmatched record if one exists
# setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID", "MATCH_STATUS"))
# setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SCHOOL_YEAR", "SUBJECT_CODE", "GTID"))
# dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
# setkeyv(dups, key(Georgia_Data_LONG))
# dim(dups["VALID_CASE"]) # 2503
# 
# Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # Take matched case
# 
# 
# #  Invalidate repeat in different year if one exists
# setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SUBJECT_CODE", "GTID", "SCHOOL_YEAR", "SCALE_SCORE"))
# setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SUBJECT_CODE", "GTID"))
# dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
# setkeyv(dups, key(Georgia_Data_LONG))
# dim(dups["VALID_CASE"]) # ? 211,546
# 
# Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][which(duplicated(Georgia_Data_LONG))] <- "INVALID_CASE" # Take FIRST Admin period ONLY.  Don't want second year repeaters confused with "block schedule"

##  Create a more general subject variable to create the right YEAR variable for the BLOCK SCHEDULE analyses
Georgia_Data_LONG[['BLOCK_SUBJECT']] <- NA
Georgia_Data_LONG[['BLOCK_SUBJECT']][Georgia_Data_LONG[['SUBJECT_CODE']] %in% c('GRADE_9_LIT', 'AMERICAN_LIT')] <- "LIT"
Georgia_Data_LONG[['BLOCK_SUBJECT']][Georgia_Data_LONG[['SUBJECT_CODE']] %in% c('BIOLOGY', 'PHYSICAL_SCIENCE')] <- "SCIENCE"
Georgia_Data_LONG[['BLOCK_SUBJECT']][Georgia_Data_LONG[['SUBJECT_CODE']] %in% c('MATHEMATICS_I', 'MATHEMATICS_II')] <- "MATH"
Georgia_Data_LONG[['BLOCK_SUBJECT']][Georgia_Data_LONG[['SUBJECT_CODE']] %in% c('US_HISTORY', 'ECONOMICS')] <- "ECON"

table(Georgia_Data_LONG[['BLOCK_SUBJECT']])

#  Set up the BLOCK_YEAR(s) to use with baseline matrix construction and SGP computation.
setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SCHOOL_YEAR", "BLOCK_SUBJECT", "GTID", "ADMIN_ORDER"))
setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SCHOOL_YEAR", "BLOCK_SUBJECT", "GTID"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"]) # 122,629 duplicate cases

##  Create alternate YEAR variable to use for these cases
##  Have to use a different convention than the *_1 and *_2 used above to keep things straight between the two analyses in combineSGP
Georgia_Data_LONG[['BLOCK_YEAR']] <- NA
Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']] <- NA
Georgia_Data_LONG[['BLOCK_YEAR']][which(duplicated(Georgia_Data_LONG))-1] <- paste(Georgia_Data_LONG[['SCHOOL_YEAR']][which(duplicated(Georgia_Data_LONG))-1], '101', sep="_")
Georgia_Data_LONG[['BLOCK_YEAR']][which(duplicated(Georgia_Data_LONG))] <- paste(Georgia_Data_LONG[['SCHOOL_YEAR']][which(duplicated(Georgia_Data_LONG))], '102', sep="_")
Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']][which(duplicated(Georgia_Data_LONG))-1] <- '101'
Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']][which(duplicated(Georgia_Data_LONG))] <- '102'

table(Georgia_Data_LONG[['BLOCK_YEAR']], Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']])

#  Kids with MORE THAN 2 BLOCK SCHED courses in a year
setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "BLOCK_YEAR", "BLOCK_SUBJECT", "SUBJECT_CODE", "GTID", "ADMIN_ORDER", "SCALE_SCORE")) # Add scale score in case any 2 duplicates within Admin time
setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "BLOCK_YEAR", "BLOCK_SUBJECT", "SUBJECT_CODE", "GTID"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"][!is.na(dups["VALID_CASE"]$BLOCK_YEAR)]) # 1741

Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']][which(duplicated(Georgia_Data_LONG) & !is.na(Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']]))] <- '103'

Georgia_Data_LONG[['BLOCK_YEAR']][which(duplicated(Georgia_Data_LONG) & !is.na(Georgia_Data_LONG[['BLOCK_YEAR']]))] <- 
  paste(Georgia_Data_LONG[['SCHOOL_YEAR']][which(duplicated(Georgia_Data_LONG) & !is.na(Georgia_Data_LONG[['BLOCK_YEAR']]))], '103', sep="_")

table(Georgia_Data_LONG[['BLOCK_YEAR']], Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']])
table(Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']], Georgia_Data_LONG[['ADMINISTRATION_PERIOD']])
table(Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']], Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']])

#  Re-order keying on admin order
setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "BLOCK_YEAR", "BLOCK_SUBJECT", "GTID", "ADMIN_ORDER"))
setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "BLOCK_YEAR", "BLOCK_SUBJECT", "GTID"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"][!is.na(dups["VALID_CASE"]$BLOCK_YEAR)]) # 1258

Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']][which(duplicated(Georgia_Data_LONG) & !is.na(Georgia_Data_LONG[['BLOCK_BASELINE_YEAR']]))] <- '104'

Georgia_Data_LONG[['BLOCK_YEAR']][which(duplicated(Georgia_Data_LONG) & !is.na(Georgia_Data_LONG[['BLOCK_YEAR']]))] <- 
  paste(Georgia_Data_LONG[['SCHOOL_YEAR']][which(duplicated(Georgia_Data_LONG) & !is.na(Georgia_Data_LONG[['BLOCK_YEAR']]))], '104', sep="_")

#  Let this sort itself out with the analyses now.  Overlap with REPEATER_YEAR in the *_102 semester (used in both analyses) is now mostly with BLOCK prior subjects.
# Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']][c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG)))] <- "INVALID_CASE" #  INVALIDate all potential block sched subjects that occur in the same admin period

#  Re-order keying on admin order, block year, and SUBJECT_CODE to get sort/key situated correctly.
#  Remove duplicates in multiple years from baseline matrix formation.  Diff year repeaters mess up the within year restriction (or appear twice).
#  e.g. 2011_101, 2012_101, 2012_102 translates to two 101:102 progressions
setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SUBJECT_CODE", "GTID", "BLOCK_BASELINE_YEAR", "BLOCK_YEAR"))
setkeyv(Georgia_Data_LONG, c("VC_BLOCK_SCHEDULE", "SUBJECT_CODE", "GTID", "BLOCK_BASELINE_YEAR"))
dups <- Georgia_Data_LONG[c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG))),]
setkeyv(dups, key(Georgia_Data_LONG))
dim(dups["VALID_CASE"][!is.na(dups["VALID_CASE"]$BLOCK_YEAR)]) # 3277

#  Create a seperate VC for producing block schedule baseline SGPs baseline matrices.
#  This lets us keep these cases for computing BASELINE SGPs on an annual basis.
#  (just keeps them out of the baseline matrix construction, which was causing problems when multiple rows matched the 1 or 2 year value)
Georgia_Data_LONG[['VC_BLOCK_SCHED_BASELINE']] <- Georgia_Data_LONG[['VC_BLOCK_SCHEDULE']]
Georgia_Data_LONG[['VC_BLOCK_SCHED_BASELINE']][c(which(duplicated(Georgia_Data_LONG))-1, which(duplicated(Georgia_Data_LONG)))] <- "INVALID_CASE"

table(Georgia_Data_LONG$BLOCK_BASELINE_YEAR, Georgia_Data_LONG$VC_BLOCK_SCHED_BASELINE)
table(Georgia_Data_LONG$BLOCK_YEAR, Georgia_Data_LONG$BLOCK_BASELINE_YEAR)
table(Georgia_Data_LONG$SUBJECT_CODE, Georgia_Data_LONG$BLOCK_YEAR, Georgia_Data_LONG$VC_BLOCK_SCHEDULE)
table(Georgia_Data_LONG$BLOCK_SUBJECT, Georgia_Data_LONG$BLOCK_YEAR, Georgia_Data_LONG$VC_BLOCK_SCHEDULE)

#  Possible overlap / duplicates:
table(Georgia_Data_LONG$BLOCK_YEAR, Georgia_Data_LONG$REPEATER_YEAR, Georgia_Data_LONG$VC_BLOCK_SCHEDULE)

setwd("/media/Data/SGP/Georgia_Same_Year")
save(Georgia_Data_LONG, file="Data/Georgia_Data_LONG-Same_Year_Analyses.Rdata")

Georgia_SGP_SameYear <- prepareSGP(Georgia_Data_LONG)
save(Georgia_SGP_SameYear, file="Data/Georgia_SGP-Same_Year_Analyses.Rdata")
