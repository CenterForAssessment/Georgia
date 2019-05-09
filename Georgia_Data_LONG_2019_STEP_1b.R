#####################################################################################
###                                                                               ###
###           Prepare and format the 2019 EOG and EOC Georgia Milestones data     ###
###                                                                               ###
#####################################################################################

### Load required packages
require(data.table)

###
###		Load 2019 Raw Data
###

###  GADOE data loading process
setwd('U:/DATA/SGP/Data/2019 SGPs/SGP Calculation/Working Directory_QQ/')

####  Load 2019 Milestones Data ####

Georgia_Data_LONG_2018_Testout <- fread("U:/DATA/SGP/Data/2019 SGPs/Computer Matched Data/2018_Georgia_Milestones_EOC_TestOut.txt",  header = TRUE, sep = "|", colClasses=rep("character", 28))
Georgia_Data_LONG_2019 <- fread("U:/DATA/SGP/Data/2019 SGPs/Computer Matched Data/EOG_EOC_Final_Data_2019.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))
###   END GA DOE   ###


###   Start EOG
Georgia_Data_LONG_2019 <- fread("./Data/Base_Files/EOG_Final_Data_2019.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))
###   End EOG


###   Start EOC
###
Georgia_Data_LONG_2018_Testout <- fread("./Data/Base_Files/2019 SGP Preliminary Data/EOC_Final_TestOut_Data_2018.txt",  header = TRUE, sep = "|", colClasses=rep("character", 29))
Georgia_Data_LONG_2019 <- rbindlist(list(
          fread("./Data/Base_Files/EOC_Final_Spring_Winter_Data_2019.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31)),
          fread("./Data/Base_Files/EOC_Final_Summer_Data_2019.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))))
          # fread("./Data/Base_Files/2019 SGP Preliminary Data/EOC_Prelim_Summer_Data_2019.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))))

### Combine 2018 test out priors with 2019 current data
eoc.subjects <- c("GRADE_9_LIT", "AMERICAN_LIT", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY", "ALGEBRA_I", "GEOMETRY")

Georgia_Data_LONG_2018_Testout[is.na(as.numeric(SCALE_SCORE)), VALID_CASE := "INVALID_CASE"]
Georgia_Data_LONG_2019 <- rbindlist(list(Georgia_Data_LONG_2018_Testout, Georgia_Data_LONG_2019), fill=TRUE)
###
###   End EOC


###   Tidy up data

Georgia_Data_LONG_2019[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
Georgia_Data_LONG_2019[which(as.numeric(SR_SYSTEM_ID) > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2019[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2019[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2019[, CONDSEM := as.numeric(CONDSEM)]

Georgia_Data_LONG_2019[, GRADE := gsub("0", "", GRADE)]

Georgia_Data_LONG_2019[PERFORMANCE_LEVEL=="", PERFORMANCE_LEVEL := NA] # Avoid NOTE in prepareSGP / checkSGP ##  PRELIM CODE  ##

Georgia_Data_LONG_2019[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, toupper(ADMINISTRATION_PERIOD), sep=": ")]

Georgia_Data_LONG_2019[, SCHOOL_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled School: No", "Enrolled School: Yes"))]
Georgia_Data_LONG_2019[, DISTRICT_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled District: No", "Enrolled District: Yes"))]
Georgia_Data_LONG_2019[, STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled State: No", "Enrolled State: Yes"))]

Georgia_Data_LONG_2019[, c("Rownumber_dup1", "Rownumber_dup2") := NULL]

###  Invalidate duplicates (No duplicate cases in 2019 prelim data)

setkey(Georgia_Data_LONG_2019, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID, SCALE_SCORE)
setkey(Georgia_Data_LONG_2019, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
# sum(duplicated(Georgia_Data_LONG_2019[VALID_CASE != "INVALID_CASE"], by=key(Georgia_Data_LONG_2019))) # 285 EOC duplicates with valid GTIDs - (((take the highest score if any exist)))
# dups <- data.table(Georgia_Data_LONG_2019[unique(c(which(duplicated(Georgia_Data_LONG_2019, by=key(Georgia_Data_LONG_2019)))-1, which(duplicated(Georgia_Data_LONG_2019, by=key(Georgia_Data_LONG_2019))))), ], key=key(Georgia_Data_LONG_2019))
Georgia_Data_LONG_2019[which(duplicated(Georgia_Data_LONG_2019, by=key(Georgia_Data_LONG_2019)))-1, VALID_CASE := "INVALID_CASE"]


### Save results

###  EOG
save(Georgia_Data_LONG_2019, file="./Data/Georgia_Data_LONG_2019_EOG.Rdata")

###  EOC
# save(Georgia_Data_LONG_2019, file="./Data/Georgia_Data_LONG_2019_EOC.Rdata")
