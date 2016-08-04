#####################################################################################
###                                                                               ###
###           Prepare and format the 2016 EOGT and EOCT Milestones data           ###
###                                                                               ###
#####################################################################################

require(data.table)

setwd('~/SGP_Projects/Georgia')


###
###		Load 2016 Raw Data
###

Georgia_Data_LONG_2015 <- fread('Data/Base_Files/2016 SGP Prelimimary Data/Testout_Data_2015.txt', sep='|', header=TRUE, colClasses=rep("character", 29))
Georgia_Data_LONG_2016 <- fread('Data/Base_Files/2016 SGP Prelimimary Data/ALLData_2016_preliminary_cleaned.txt', sep='|', header=TRUE, colClasses=rep("character", 31))


###  Combine 2015 Test Out CRCT and 2016 Milestones data
Georgia_Data_LONG_2016 <- rbindlist(list(Georgia_Data_LONG_2015, Georgia_Data_LONG_2016[SUBJECT_CODE != "NULL"]), fill=TRUE)
setnames(Georgia_Data_LONG_2016, 'CONDSEM', 'SCALE_SCORE_CSEM')


### Tidy up data

Georgia_Data_LONG_2016[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
Georgia_Data_LONG_2016[which(SR_SYSTEM_ID > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2016[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2016[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2016[, SCALE_SCORE_CSEM := as.numeric(SCALE_SCORE_CSEM)]

Georgia_Data_LONG_2016[, GRADE := gsub("0", "", GRADE)]

Georgia_Data_LONG_2016[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, toupper(ADMINISTRATION_PERIOD), sep=": ")]
Georgia_Data_LONG_2016[which(ADMINISTRATION_PERIOD == "1: FALL"), ADMINISTRATION_PERIOD := "1: WINTER"]

Georgia_Data_LONG_2016[,SCHOOL_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled School: No", "Enrolled School: Yes"))]
Georgia_Data_LONG_2016[,DISTRICT_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled District: No", "Enrolled District: Yes"))]
Georgia_Data_LONG_2016[,STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled State: No", "Enrolled State: Yes"))]

 
### Drop unused variables
Georgia_Data_LONG_2016[, Rownumber_dup1 := NULL]
Georgia_Data_LONG_2016[, Rownumber_dup2 := NULL]

###  Invalidate duplicates
setkey(Georgia_Data_LONG_2016, VALID_CASE, SUBJECT_CODE, SCHOOL_YEAR, YEAR_WITHIN, GRADE, GTID, SCALE_SCORE)
setkey(Georgia_Data_LONG_2016, VALID_CASE, SUBJECT_CODE, SCHOOL_YEAR, YEAR_WITHIN, GRADE, GTID)
# sum(duplicated(Georgia_Data_LONG_2016[VALID_CASE != "INVALID_CASE"])) # 131 duplicates with valid GTIDs - take the highest score
# dups <- data.table(Georgia_Data_LONG_2016[unique(c(which(duplicated(Georgia_Data_LONG_2016))-1, which(duplicated(Georgia_Data_LONG_2016)))), ], key=key(Georgia_Data_LONG_2016))
Georgia_Data_LONG_2016[which(duplicated(Georgia_Data_LONG_2016))-1, VALID_CASE := "INVALID_CASE"]

### Save results

save(Georgia_Data_LONG_2016, file="Data/Base_Files/2016 SGP Prelimimary Data/Georgia_Data_LONG_2016.Rdata")
