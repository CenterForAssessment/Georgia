###############################################################################################
###
###   Prepare and format the 2015 EOGT and EOCT data provided by GA DOE
###
###############################################################################################

require(data.table)
require(plyr)

setwd('~/SGP_Projects/Georgia')

###
###		Load 2015 Raw Data
###

Georgia_Data_LONG <- as.data.table(read.delim(unz('Data/Base_Files/2015 Georgia Milestones Preliminary Data_12142015.zip', 
									'2015 Georgia Milestones Preliminary Data.txt'), sep='|', header=TRUE))

### Tidy up date

Georgia_Data_LONG_2015[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SCHOOL_NUMBER)]
Georgia_Data_LONG_2015[which(SR_SYSTEM_ID > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2015[, SCHOOL_NUMBER:=as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2015[GRADE=="03", GRADE:="3"]
Georgia_Data_LONG_2015[GRADE=="04", GRADE:="4"]
Georgia_Data_LONG_2015[GRADE=="05", GRADE:="5"]
Georgia_Data_LONG_2015[GRADE=="06", GRADE:="6"]
Georgia_Data_LONG_2015[GRADE=="07", GRADE:="7"]
Georgia_Data_LONG_2015[GRADE=="08", GRADE:="8"]

Georgia_Data_LONG_2015[, GRADE_REPORTED:=as.integer(GRADE_REPORTED)]

Georgia_Data_LONG_2015[, SCALE_SCORE:=as.numeric(SCALE_SCORE)]

Georgia_Data_LONG_2015[, ADMINISTRATION_PERIOD:=toupper(ADMINISTRATION_PERIOD)]

Georgia_Data_LONG_2015[,SCHOOL_ENROLLMENT_STATUS:=factor(1, levels=0:1, 
	labels=c("Enrolled School: No", "Enrolled School: Yes"))]

Georgia_Data_LONG_2015[,DISTRICT_ENROLLMENT_STATUS:=factor(1, levels=0:1, 
   labels=c("Enrolled District: No", "Enrolled District: Yes"))]

Georgia_Data_LONG_2015[,STATE_ENROLLMENT_STATUS:=factor(1, levels=0:1, 
   labels=c("Enrolled State: No", "Enrolled State: Yes"))]


### Save results

save(Georgia_Data_LONG_2015, file="Data/Georgia_Data_LONG_2015.Rdata")
