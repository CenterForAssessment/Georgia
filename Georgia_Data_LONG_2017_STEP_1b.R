#####################################################################################
###                                                                               ###
###           Prepare and format the 2017 EOG and EOC Georgia Milestones data     ###
###                                                                               ###
#####################################################################################

### Load required packages
require(data.table)


###
###		Load 2017 Raw Data
###

###  GADOE data loading process
setwd('U:/DATA/SGP/Data/2017 SGPs/SGP Calculation/Working Directory_QQ/')

##### Load 2017 EOG Data# ####
###   GA DOE   ###
Georgia_Data_LONG_2016_Testout <- fread("U:/DATA/SGP/Data/2017 SGPs/Computer Matched Data/2016_Georgia_Milestones_EOC_TestOut.txt",  header = TRUE, sep = "|", colClasses=rep("character", 28))
Georgia_Data_LONG_2017 <- fread("U:/DATA/SGP/Data/2017 SGPs/Computer Matched Data/2017_Georgia_Milestones_EOG_EOC_preliminary.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))

###   NCIEA   ###
Georgia_Data_LONG_2016_Testout <- fread("./Data/Base_Files/2017 SGP Preliminary Data/2016_Georgia_Milestones_EOC_TestOut.txt",  header = TRUE, sep = "|", colClasses=rep("character", 28))
Georgia_Data_LONG_2017 <- fread("./Data/Base_Files/2017 SGP Preliminary Data/2017_Georgia_Milestones_EOG_EOC_preliminary.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))

### Combine 2016 test out priors with 2017 current data
Georgia_Data_LONG_2017 <- rbindlist(list(Georgia_Data_LONG_2016_Testout, Georgia_Data_LONG_2017), fill=TRUE)


###   Tidy up data

setnames(Georgia_Data_LONG_2017, 'CONDSEM', 'SCALE_SCORE_CSEM') # --XXX##XXX--

Georgia_Data_LONG_2017[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
Georgia_Data_LONG_2017[which(as.numeric(SR_SYSTEM_ID) > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2017[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2017[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2017[, SCALE_SCORE_CSEM := as.numeric(SCALE_SCORE_CSEM)]

Georgia_Data_LONG_2017[, GRADE := gsub("0", "", GRADE)]

Georgia_Data_LONG_2017[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, toupper(ADMINISTRATION_PERIOD), sep=": ")]

Georgia_Data_LONG_2017[, SCHOOL_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled School: No", "Enrolled School: Yes"))]
Georgia_Data_LONG_2017[, DISTRICT_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled District: No", "Enrolled District: Yes"))]
Georgia_Data_LONG_2017[, STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled State: No", "Enrolled State: Yes"))]


###  Invalidate duplicates(No duplicate cases)
#setkey(Georgia_Data_LONG_2017, VALID_CASE, SUBJECT_CODE, SCHOOL_YEAR, YEAR_WITHIN, GTID, SCALE_SCORE)
#setkey(Georgia_Data_LONG_2017, VALID_CASE, SUBJECT_CODE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
#sum(duplicated(Georgia_Data_LONG_2017[VALID_CASE != "INVALID_CASE"], by=key(Georgia_Data_LONG_2017))) # 0 duplicates with valid GTIDs - take the highest score
#dups <- data.table(Georgia_Data_LONG_2017[unique(c(which(duplicated(Georgia_Data_LONG_2017, by=key(Georgia_Data_LONG_2017)))-1, which(duplicated(Georgia_Data_LONG_2017, by=key(Georgia_Data_LONG_2017))))), ], key=key(Georgia_Data_LONG_2017))
#Georgia_Data_LONG_2017[which(duplicated(Georgia_Data_LONG_2017, by=key(Georgia_Data_LONG_2017)))-1, VALID_CASE := "INVALID_CASE"]

### Save results

save(Georgia_Data_LONG_2017, file="./Data/Georgia_Data_LONG_2017.Rdata")
