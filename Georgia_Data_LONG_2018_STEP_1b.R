#####################################################################################
###                                                                               ###
###           Prepare and format the 2018 EOG and EOC Georgia Milestones data     ###
###                                                                               ###
#####################################################################################

### Load required packages
require(data.table)

###
###		Load 2018 Raw Data
###

###  GADOE data loading process
setwd('U:/DATA/SGP/Data/2018 SGPs/SGP Calculation/Working Directory_QQ/')

####  Load 2018 Milestones Data ####

Georgia_Data_LONG_2017_Testout <- fread("U:/DATA/SGP/Data/2018 SGPs/Computer Matched Data/2017_Georgia_Milestones_EOC_TestOut.txt",  header = TRUE, sep = "|", colClasses=rep("character", 28))
Georgia_Data_LONG_2018 <- fread("U:/DATA/SGP/Data/2018 SGPs/Computer Matched Data/EOG_Prelim_Data_2018.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))
###   GA DOE   ###


###   Start EOG
Georgia_Data_LONG_2018 <- fread("./Data/Base_Files/EOG_Prelim_Data_2018.txt",  header = TRUE, sep = "|", colClasses=rep("character", 29))
###   End EOG

###   Start EOC
Georgia_Data_LONG_2017_Testout <- fread("./Data/Base_Files/2018 SGP Preliminary Data/2017_Georgia_Milestones_EOC_TestOut.txt",  header = TRUE, sep = "|", colClasses=rep("character", 28))
Georgia_Data_LONG_2018 <- fread("./Data/Base_Files/2018_Georgia_Milestones_EOC_Prelim_Data.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))


### Combine 2017 test out priors with 2018 current data
eoc.subjects <- c("GRADE_9_LIT", "AMERICAN_LIT", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY", "ALGEBRA_I", "GEOMETRY")

Georgia_Data_LONG_2017_Testout[, VALID_CASE := "VALID_CASE"]
Georgia_Data_LONG_2017_Testout[is.na(as.numeric(SCALE_SCORE)), VALID_CASE := "INVALID_CASE"]
Georgia_Data_LONG_2018 <- rbindlist(list(Georgia_Data_LONG_2017_Testout[SUBJECT_CODE %in% eoc.subjects], Georgia_Data_LONG_2018[SUBJECT_CODE %in% eoc.subjects]), fill=TRUE)
###   End EOC


###   Tidy up data

setnames(Georgia_Data_LONG_2018, 'CONDSEM', 'SCALE_SCORE_CSEM')

Georgia_Data_LONG_2018[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
Georgia_Data_LONG_2018[which(as.numeric(SR_SYSTEM_ID) > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2018[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2018[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2018[, SCALE_SCORE_CSEM := as.numeric(SCALE_SCORE_CSEM)]

Georgia_Data_LONG_2018[, GRADE := gsub("0", "", GRADE)]

Georgia_Data_LONG_2018[PERFORMANCE_LEVEL=="", PERFORMANCE_LEVEL := NA] # Avoid NOTE in prepareSGP / checkSGP ##  PRELIM CODE  ##

Georgia_Data_LONG_2018[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, toupper(ADMINISTRATION_PERIOD), sep=": ")]

Georgia_Data_LONG_2018[, SCHOOL_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled School: No", "Enrolled School: Yes"))]
Georgia_Data_LONG_2018[, DISTRICT_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled District: No", "Enrolled District: Yes"))]
Georgia_Data_LONG_2018[, STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled State: No", "Enrolled State: Yes"))]

# Georgia_Data_LONG_2018[, Rownumber_dup1 := NULL]
# Georgia_Data_LONG_2018[, Rownumber_dup2 := NULL]

###  Invalidate duplicates (No duplicate cases in 2018 prelim data)
setkey(Georgia_Data_LONG_2018, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID, SCALE_SCORE)
setkey(Georgia_Data_LONG_2018, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
# sum(duplicated(Georgia_Data_LONG_2018[VALID_CASE != "INVALID_CASE"], by=key(Georgia_Data_LONG_2018))) # 285 EOC duplicates with valid GTIDs - (((take the highest score if any exist)))
# dups <- data.table(Georgia_Data_LONG_2018[unique(c(which(duplicated(Georgia_Data_LONG_2018, by=key(Georgia_Data_LONG_2018)))-1, which(duplicated(Georgia_Data_LONG_2018, by=key(Georgia_Data_LONG_2018))))), ], key=key(Georgia_Data_LONG_2018))
Georgia_Data_LONG_2018[which(duplicated(Georgia_Data_LONG_2018, by=key(Georgia_Data_LONG_2018)))-1, VALID_CASE := "INVALID_CASE"]


### Save results

###  EOG
save(Georgia_Data_LONG_2018, file="./Data/Georgia_Data_LONG_2018_EOG.Rdata")

###  EOC
save(Georgia_Data_LONG_2018, file="./Data/Georgia_Data_LONG_2018_EOC.Rdata")
