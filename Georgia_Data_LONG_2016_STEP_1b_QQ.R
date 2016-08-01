require(data.table)
require(plyr)
require(SGP)
devtools::install_github("centerforassessment/SGP")
#devtools::install_github("adamvi/SGP", force = TRUE)

#######Set working directory


setwd('U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/Working Directory_QQ/')

#####Load 2015 testout and 2016 Data#####

Georgia_Data_LONG_2015 <- read.delim("U:/DATA/SGP/Data/2016 SGPs/Computer matched data/2016 SGP Prelimimary Data/Testout_Data_2015.txt",  header = TRUE, sep = "|")
Georgia_Data_LONG_2016 <- read.delim("U:/DATA/SGP/Data/2016 SGPs/Computer matched data/2016 SGP Prelimimary Data/ALLData_2016_preliminary_cleaned.txt",  header = TRUE, sep = "|")
Georgia_Data_LONG_2015<-data.table(Georgia_Data_LONG_2015)
Georgia_Data_LONG_2016<-data.table(Georgia_Data_LONG_2016)

###  Combine 2015 Test Out data and 2016 Milestones data
Georgia_Data_LONG_2016 <- rbindlist(list(Georgia_Data_LONG_2015, Georgia_Data_LONG_2016[SUBJECT_CODE != "NULL"]), fill=TRUE)


### Tidy up data

Georgia_Data_LONG_2016[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
Georgia_Data_LONG_2016[which(SR_SYSTEM_ID > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2016[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

levels(Georgia_Data_LONG_2016$GRADE) <- c("EOCT","3", "4", "5", "6","7","8")

Georgia_Data_LONG_2016[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2016[, SCALE_SCORE_CSEM := as.numeric(CONDSEM)]

Georgia_Data_LONG_2016[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, ADMINISTRATION_PERIOD, sep=": ")]
Georgia_Data_LONG_2016[which(ADMINISTRATION_PERIOD == "1: "), ADMINISTRATION_PERIOD := "1: WINTER"]
Georgia_Data_LONG_2016[which(ADMINISTRATION_PERIOD == "2: "), ADMINISTRATION_PERIOD := "2: SPRING"]
Georgia_Data_LONG_2016[which(ADMINISTRATION_PERIOD == "3: "), ADMINISTRATION_PERIOD := "3: SUMMER"]

Georgia_Data_LONG_2016[,SCHOOL_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled School: No", "Enrolled School: Yes"))]

Georgia_Data_LONG_2016[,DISTRICT_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled District: No", "Enrolled District: Yes"))]

Georgia_Data_LONG_2016[,STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled State: No", "Enrolled State: Yes"))]

 
### Drop unused variables
Georgia_Data_LONG_2016$CONDSEM <- NULL
Georgia_Data_LONG_2016$Rownumber_dup1<-NULL
Georgia_Data_LONG_2016$Rownumber_dup2<-NULL


### Save 2016 data object

save(Georgia_Data_LONG_2016, file="U:/DATA/SGP/Data/2016 SGPs/Computer matched data/2016 SGP Prelimimary Data/Georgia_Data_LONG_2016.Rdata")
