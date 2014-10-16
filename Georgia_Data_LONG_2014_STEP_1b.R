###################################################################################
###
### Script to read in data and create LONG data in R for 2014 Georgia CRCT/EOCT
###
###################################################################################

### Load packages

require(data.table)


### Load data

Georgia_Data_LONG_2014 <- fread("Data/Base_Files/Georgia_Data_LONG_2014_Step_1a.txt", colClasses=rep("character", 27))


### Tidy up date

Georgia_Data_LONG_2014[,SCHOOL_YEAR:=as.character(SCHOOL_YEAR)]

Georgia_Data_LONG_2014[, SR_SYSTEM_ID:=as.integer(SR_SYSTEM_ID)]
Georgia_Data_LONG_2014[, SCHOOL_NUMBER:=as.integer(SCHOOL_NUMBER)]
Georgia_Data_LONG_2014$SCHOOL_NUMBER <- Georgia_Data_LONG_2014$SR_SYSTEM_ID*10000 + Georgia_Data_LONG_2014$SCHOOL_NUMBER
Georgia_Data_LONG_2014[which(SR_SYSTEM_ID >1000), SCHOOL_NUMBER:=SR_SYSTEM_ID]

Georgia_Data_LONG_2014[, FIRST_NAME:=as.factor(FIRST_NAME)]
Georgia_Data_LONG_2014[, MIDDLE_NAME:=as.factor(MIDDLE_NAME)]
Georgia_Data_LONG_2014[, LAST_NAME:=as.factor(LAST_NAME)]

Georgia_Data_LONG_2014[GRADE=="03", GRADE:="3"]
Georgia_Data_LONG_2014[GRADE=="04", GRADE:="4"]
Georgia_Data_LONG_2014[GRADE=="05", GRADE:="5"]
Georgia_Data_LONG_2014[GRADE=="06", GRADE:="6"]
Georgia_Data_LONG_2014[GRADE=="07", GRADE:="7"]
Georgia_Data_LONG_2014[GRADE=="08", GRADE:="8"]

Georgia_Data_LONG_2014[, GRADE_REPORTED:=as.integer(GRADE_REPORTED)]

Georgia_Data_LONG_2014[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]

Georgia_Data_LONG_2014[ADMIN_INVALIDATION=="",ADMIN_INVALIDATION:=as.character(NA)]

Georgia_Data_LONG_2014[, ADMINISTRATION_PERIOD:=toupper(ADMINISTRATION_PERIOD)]
Georgia_Data_LONG_2014[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, ADMINISTRATION_PERIOD, sep=": ")]

Georgia_Data_LONG_2014[,RACE_CODE:=as.factor(RACE_CODE)]
levels(Georgia_Data_LONG_2014$RACE_CODE)[1] <- NA

Georgia_Data_LONG_2014[,GENDER_CODE:=as.factor(GENDER_CODE)]
levels(Georgia_Data_LONG_2014$GENDER_CODE)[1] <- NA

Georgia_Data_LONG_2014[,ED:=as.factor(ED)]
levels(Georgia_Data_LONG_2014$ED)[1] <- NA

Georgia_Data_LONG_2014[,SWD:=as.factor(SWD)]
levels(Georgia_Data_LONG_2014$SWD)[1] <- NA

Georgia_Data_LONG_2014[,LEP:=as.factor(LEP)]
levels(Georgia_Data_LONG_2014$LEP)[1] <- NA

Georgia_Data_LONG_2014[,GIFT:=as.factor(GIFT)]
levels(Georgia_Data_LONG_2014$GIFT)[1] <- NA

Georgia_Data_LONG_2014[,PERFORMANCE_LEVEL:=factor(PERFORMANCE_LEVEL, levels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)]

Georgia_Data_LONG_2014[,SCHOOL_ENROLLMENT_STATUS:=factor(SCHOOL_ENROLLMENT_STATUS, levels=c("Enrolled School: No", "Enrolled School: Yes"), labels=c("Enrolled School: No", "Enrolled School: Yes"))]

Georgia_Data_LONG_2014[,DISTRICT_ENROLLMENT_STATUS:=factor(DISTRICT_ENROLLMENT_STATUS, levels=c("Enrolled District: No", "Enrolled District: Yes"), labels=c("Enrolled District: No", "Enrolled District: Yes"))]

Georgia_Data_LONG_2014[,STATE_ENROLLMENT_STATUS:=factor(STATE_ENROLLMENT_STATUS, levels=c("Enrolled State: No", "Enrolled State: Yes"), labels=c("Enrolled State: No", "Enrolled State: Yes"))]

### Save results

save(Georgia_Data_LONG_2014, file="Data/Georgia_Data_LONG_2014.Rdata")

###############################################################################################
###
###   Update the SGP object with the 2014 data
###   Manual update of @Data - much quicker than using updateSGP with prepareSGP step
###
###############################################################################################

load('../Georgia_SGP.Rdata')

require(plyr)

GA_2014 <- prepareSGP(Georgia_Data_LONG_2014)
sgp.key <- key(Georgia_SGP@Data)
Georgia_SGP@Data <- data.table(rbind.fill(Georgia_SGP@Data, GA_2014@Data), key=sgp.key)

Georgia_SGP <- prepareSGP(Georgia_SGP)

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")

