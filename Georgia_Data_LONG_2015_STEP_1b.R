###############################################################################################
###
###   Prepare and format the 2015 EOGT and EOCT Milestones data provided by GA DOE
###
###############################################################################################

require(data.table)

setwd('~/SGP_Projects/Georgia')

###
###		Load 2015 Raw Data
###

Georgia_Data_LONG_2014 <- as.data.table(read.delim(unz('Data/Base_Files/2014_EOCT_TestOut_Data.zip', 
							'2014_EOCT_TestOut_Data.txt'), sep='|', header=TRUE))

Georgia_Data_LONG_2015 <- as.data.table(read.delim(unz('Data/Base_Files/2015 Georgia Milestones Preliminary Data_12072015.zip', 
							'2015 Georgia Milestones Preliminary Data_wCSEM.txt'), sep='|', header=TRUE))

setnames(Georgia_Data_LONG_2015, c('gender_code', 'CONDSEM'), c('GENDER_CODE', 'SCALE_SCORE_CSEM'))


###  Add CSEM Data to 2014 Test Out Data

load("/media/Data/Dropbox/Github_Repos/Packages/SGPstateData/csem/Georgia/Georgia_CSEM.Rdata")

Georgia_CSEM <- data.table(Georgia_CSEM, key=c("GRADE", "CONTENT_AREA", "SCALE_SCORE"))
setnames(Georgia_CSEM, "CONTENT_AREA", "SUBJECT_CODE")

Georgia_Data_LONG_2014[, SCALE_SCORE_CSEM := as.numeric(NA)]
for (ca in unique(Georgia_Data_LONG_2014$SUBJECT_CODE)) {
	CSEM_Data <- Georgia_CSEM[SUBJECT_CODE == ca]
	for (g in unique(CSEM_Data$GRADE)) {
		CSEM_Data_G <- CSEM_Data[GRADE == g]
		CSEM_Function <- splinefun(CSEM_Data_G[["SCALE_SCORE"]], CSEM_Data_G[["SCALE_SCORE_CSEM"]], method="natural") # Use 'natural' since that's what's used in SIMEX routine.
		Georgia_Data_LONG_2014[which(SUBJECT_CODE == ca & VALID_CASE=="VALID_CASE"), SCALE_SCORE_CSEM := CSEM_Function(SCALE_SCORE)]
	}
}
summary(Georgia_Data_LONG_2014$SCALE_SCORE_CSEM)


###  Combine 2014 Test Out CRCT and 2015 Milestones data
Georgia_Data_LONG_2015 <- rbindlist(list(Georgia_Data_LONG_2014, Georgia_Data_LONG_2015[SUBJECT_CODE != "NULL"]), fill=TRUE)


### Tidy up data

Georgia_Data_LONG_2015[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SCHOOL_NUMBER)]
Georgia_Data_LONG_2015[which(SR_SYSTEM_ID > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2015[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2015[, GRADE := gsub("0", "", GRADE)]
Georgia_Data_LONG_2015[, GRADE_REPORTED := as.integer(GRADE_REPORTED)]

Georgia_Data_LONG_2015[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2015[, SCALE_SCORE_CSEM := as.numeric(SCALE_SCORE_CSEM)]

Georgia_Data_LONG_2015[, ADMINISTRATION_PERIOD := toupper(ADMINISTRATION_PERIOD)]
Georgia_Data_LONG_2015[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, ADMINISTRATION_PERIOD, sep=": ")]

Georgia_Data_LONG_2015[,SCHOOL_ENROLLMENT_STATUS := factor(1, levels=0:1, 
	labels=c("Enrolled School: No", "Enrolled School: Yes"))]

Georgia_Data_LONG_2015[,DISTRICT_ENROLLMENT_STATUS := factor(1, levels=0:1, 
   labels=c("Enrolled District: No", "Enrolled District: Yes"))]

Georgia_Data_LONG_2015[,STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, 
   labels=c("Enrolled State: No", "Enrolled State: Yes"))]


### Save results

save(Georgia_Data_LONG_2015, file="Data/Georgia_Data_LONG_2015.Rdata")


###
###		Create New Georgia SGP object for Milestones Assessments with Only CRCT Priors
###

###  Use @Data from outputSGP in 2014 CRCT analyses as the base for the new object
load("Data/Georgia_SGP_LONG_Data.Rdata")

###  Select out only a subset of the data - Only CRCT EOGT and EOCT subjects and years that will be used as priors.
CRCT_Subjects <- c("ELA", "READING", "SOCIAL_STUDIES", "SCIENCE", "MATHEMATICS")
EOCT_Subjects <- c("GRADE_9_LIT", "AMERICAN_LIT", "ECONOMICS", "US_HISTORY", "BIOLOGY", "PHYSICAL_SCIENCE", "COORDINATE_ALGEBRA", "ANALYTIC_GEOMETRY")

Georgia_LONG_Data <- rbindlist(list( 
						Georgia_SGP_LONG_Data[VALID_CASE == "VALID_CASE" & SCHOOL_YEAR %in% 2012:2014 & SUBJECT_CODE %in% c(CRCT_Subjects, EOCT_Subjects)],
						Georgia_SGP_LONG_Data[VALID_CASE == "VALID_CASE" & SCHOOL_YEAR %in% 2011 & SUBJECT_CODE == "SOCIAL_STUDIES" & GRADE == 8]))

###  Remove all BASELINE SGP variables and HIGH_NEED_STATUS variable (never used and adds considerable time to prepareSGP step)
Georgia_LONG_Data[, grep("BASELINE", names(Georgia_LONG_Data)) := NULL]
Georgia_LONG_Data[, HIGH_NEED_STATUS := NULL]

###  Merge in the CSEM variable with CRCT data to align use Milestones data going forward
setkeyv(Georgia_LONG_Data, c("GRADE", "SUBJECT_CODE", "SCALE_SCORE"))

Georgia_LONG_Data[, SCALE_SCORE_CSEM := as.numeric(NA)]
for (ca in unique(Georgia_CSEM$SUBJECT_CODE)) {
	CSEM_Data <- Georgia_CSEM[SUBJECT_CODE == ca]
	for (g in unique(CSEM_Data$GRADE)) {
		CSEM_Data_G <- CSEM_Data[GRADE == g]
		CSEM_Function <- splinefun(CSEM_Data_G[["SCALE_SCORE"]], CSEM_Data_G[["SCALE_SCORE_CSEM"]], method="natural") # Use 'natural' since that's what's used in SIMEX routine.
		Georgia_LONG_Data[which(SUBJECT_CODE == ca & VALID_CASE=="VALID_CASE"), SCALE_SCORE_CSEM := CSEM_Function(SCALE_SCORE)]
	}
}

summary(Georgia_LONG_Data$SCALE_SCORE_CSEM)
summary(Georgia_CSEM$SCALE_SCORE_CSEM)

###		Create New Georgia_SGP object via prepareSGP

require(SGP)
Georgia_SGP <- prepareSGP(Georgia_LONG_Data, create.additional.variables=FALSE)


###  Save New SGP Object if desired (or just use directly in SGP analysis code)
save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
