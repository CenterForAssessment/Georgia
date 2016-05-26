###############################################################################################
###
###   Prepare and format the 2016 EOGT and EOCT Milestones data provided by GA DOE
###
###############################################################################################

require(data.table)

setwd('~/SGP_Projects/Georgia')

###
###		Load 2016 Raw Data
###

Georgia_Data_LONG_2015 <- as.data.table(read.delim(unz('Data/Base_Files/2015_EOCT_TestOut_Data.zip', 
							'2015_EOCT_TestOut_Data.txt'), sep='|', header=TRUE, stringsAsFactors=FALSE))

Georgia_Data_LONG_2016 <- as.data.table(read.delim(unz('Data/Base_Files/2016_Georgia_Milestones_All_Data.zip', 
							'2016_Georgia_Milestones_All_Data.txt'), sep='|', header=TRUE, stringsAsFactors=FALSE))
Georgia_Data_LONG_2016[, RESCORE := 0]

Georgia_2016_Rescores <- as.data.table(read.delim(unz('Data/Base_Files/2016_Georgia_Milestones_rescore.zip', 
							'2016_Georgia_Milestones_rescore.txt'), sep='|', header=TRUE, stringsAsFactors=FALSE))
Georgia_2016_Rescores[, RESCORE := 1]

setnames(Georgia_Data_LONG_2015, 'ACHIVEMENT_LEVEL', 'PERFORMANCE_LEVEL')
setnames(Georgia_Data_LONG_2016, 'CONDSEM', 'SCALE_SCORE_CSEM')
setnames(Georgia_2016_Rescores, 'CONDSEM', 'SCALE_SCORE_CSEM')


###  Combine 2015 Test Out CRCT and 2016 Milestones data
Georgia_Data_LONG_2016 <- rbindlist(list(Georgia_Data_LONG_2015, Georgia_Data_LONG_2016[SUBJECT_CODE != "NULL"], Georgia_2016_Rescores), fill=TRUE)


### Tidy up data

Georgia_Data_LONG_2016[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SCHOOL_NUMBER)]
Georgia_Data_LONG_2016[which(SR_SYSTEM_ID > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2016[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2016[, GRADE := gsub("0", "", GRADE)]
Georgia_Data_LONG_2016[, GRADE_REPORTED := as.integer(GRADE_REPORTED)]

Georgia_Data_LONG_2016[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2016[, SCALE_SCORE_CSEM := as.numeric(SCALE_SCORE_CSEM)]

Georgia_Data_LONG_2016[, ADMINISTRATION_PERIOD := toupper(ADMINISTRATION_PERIOD)]
Georgia_Data_LONG_2016[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, ADMINISTRATION_PERIOD, sep=": ")]
Georgia_Data_LONG_2016[which(ADMINISTRATION_PERIOD == "1: "), ADMINISTRATION_PERIOD := "1: WINTER"]
Georgia_Data_LONG_2016[which(ADMINISTRATION_PERIOD == "2: "), ADMINISTRATION_PERIOD := "2: SPRING"]
Georgia_Data_LONG_2016[which(ADMINISTRATION_PERIOD == "3: "), ADMINISTRATION_PERIOD := "3: SUMMER"]

Georgia_Data_LONG_2016[,SCHOOL_ENROLLMENT_STATUS := factor(1, levels=0:1, 
	labels=c("Enrolled School: No", "Enrolled School: Yes"))]

Georgia_Data_LONG_2016[,DISTRICT_ENROLLMENT_STATUS := factor(1, levels=0:1, 
   labels=c("Enrolled District: No", "Enrolled District: Yes"))]

Georgia_Data_LONG_2016[,STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, 
   labels=c("Enrolled State: No", "Enrolled State: Yes"))]

###  Remove known duplicate cases:
Georgia_Data_LONG_2016<-Georgia_Data_LONG_2016[-which(Georgia_Data_LONG_2016$GTID %in% c('3105982299','1747050385','2723026345') & Georgia_Data_LONG_2016$SCHOOL_YEAR=='2015'),]

###  Remove original rescored cases
setkey(Georgia_Data_LONG_2016, VALID_CASE, SUBJECT_CODE, SCHOOL_YEAR, YEAR_WITHIN, GRADE, GTID, RESCORE)
setkey(Georgia_Data_LONG_2016, VALID_CASE, SUBJECT_CODE, SCHOOL_YEAR, YEAR_WITHIN, GRADE, GTID)
# sum(duplicated(Georgia_Data_LONG_2016[VALID_CASE != "INVALID_CASE"])) # 10 duplicates with valid SSIDs -- all have same SSID and esID, so appear valid - take the highest score
# dups <- data.table(Georgia_Data_LONG_2016[unique(c(which(duplicated(Georgia_Data_LONG_2016))-1, which(duplicated(Georgia_Data_LONG_2016)))), ], key=key(Georgia_Data_LONG_2016))
Georgia_Data_LONG_2016[which(duplicated(Georgia_Data_LONG_2016))-1, VALID_CASE := "INVALID_CASE"]

### Save results

save(Georgia_Data_LONG_2016, file="Data/Georgia_Data_LONG_2016.Rdata")


###
###		Create New Georgia SGP object for Milestones Assessments with Only CRCT Priors
###

###  Use @Data from outputSGP in 2015 CRCT analyses as the base for the new object
#load("Data/Georgia_SGP_LONG_Data.Rdata")
load("Data/Archive/December_2016/Georgia_SGP_LONG_Data.Rdata")

###  Select out only a subset of the data - Only CRCT EOGT and EOCT subjects and years that will be used as priors.
CRCT_Subjects <- c("ELA", "READING", "SOCIAL_STUDIES", "SCIENCE", "MATHEMATICS")
EOCT_Subjects <- c("GRADE_9_LIT", "AMERICAN_LIT", "ECONOMICS", "US_HISTORY", "BIOLOGY", "PHYSICAL_SCIENCE", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")

Georgia_LONG_Data <- rbindlist(list( 
						Georgia_SGP_LONG_Data[VALID_CASE == "VALID_CASE" & SCHOOL_YEAR %in% 2013:2015 & SUBJECT_CODE %in% c(CRCT_Subjects, EOCT_Subjects)],
						Georgia_SGP_LONG_Data[VALID_CASE == "VALID_CASE" & SCHOOL_YEAR %in% 2012 & SUBJECT_CODE == "SOCIAL_STUDIES" & GRADE == 8]))

###  Remove all BASELINE SGP variables and HIGH_NEED_STATUS variable (never used and adds considerable time to prepareSGP step)
Georgia_LONG_Data[, grep("BASELINE", names(Georgia_LONG_Data)) := NULL]
Georgia_LONG_Data[, HIGH_NEED_STATUS := NULL]


###		Create New Georgia_SGP object via prepareSGP

require(SGP)
Georgia_SGP <- prepareSGP(Georgia_LONG_Data, create.additional.variables=FALSE)


###  Save New SGP Object if desired (or just use directly in SGP analysis code)
save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
