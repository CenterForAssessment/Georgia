###################################################################################
###
### Creation of Long Teacher Data files - March 2016
###
###################################################################################

### Load packages

require(SGP)
require(data.table)

setwd('/home/avi/SGP_Projects/Georgia')

### Load data


system("unzip '/media/Data/Dropbox/SGP/Georgia/Data/Base_Files/Georgia_SGP_Teacher_Link_SGP_ALL_primaryfirst.zip'")
GA_INSTRUCTOR_2015 <- fread("Georgia_SGP_Teacher_Link_SGP_ALL_primaryfirst.txt", 
					sep='|', header=TRUE, colClasses=rep("character", 30))
unlink("Georgia_SGP_Teacher_Link_SGP_ALL_primaryfirst.txt")


### Clean up variable names

my.variable.names <- c("FISCAL_YEAR", 
  "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER", "SCHOOL_NAME", "TEACHER_NAME", "INSTRUCTOR_NUMBER", 
  "CONTENT_AREA", "CONTENT_AREA_SECTION", 
  "STUDENT_NAME", "YEAR", "ID", "UNIQUE_ID", "GRADE", "ADMINISTRATION_PERIOD", 
  "SCALE_SCORE", "ACHIEVEMENT_LEVEL", "SGP_SIMEX", "SGP_SIMEX_LEVEL", "SGP", "SGP_LEVEL",
  "RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", 
  "SCALE_SCORE_PRIOR_1", "SCALE_SCORE_PRIOR_STANDARDIZED", "PERFORMANCE_LEVEL_PRIOR_1", "Primaryfirst")

setnames(GA_INSTRUCTOR_2015, my.variable.names)


### Create INSTRUCTOR_FIRST_NAME and INSTRUCTOR_LAST_NAME

my.tmp <- strsplit(as.character(GA_INSTRUCTOR_2015$TEACHER_NAME), ",")
my.tmp.first_name <- factor(sapply(my.tmp, '[', 2))
levels(my.tmp.first_name) <- sapply(sapply(strsplit(levels(my.tmp.first_name), " "), '[', 2), capwords)
my.tmp.last_name <- factor(sapply(my.tmp, '[', 1))
levels(my.tmp.last_name) <- sapply(levels(my.tmp.last_name), capwords)
GA_INSTRUCTOR_2015[, INSTRUCTOR_FIRST_NAME := as.character(my.tmp.first_name)]
GA_INSTRUCTOR_2015[, INSTRUCTOR_LAST_NAME  := as.character(my.tmp.last_name)]


### Create YEAR_WITHIN & INSTRUCTOR_ENROLLMENT_STATUS Variables

GA_INSTRUCTOR_2015[, YEAR_WITHIN := sapply(ADMINISTRATION_PERIOD, function(x) strsplit(x, "")[[1]][1])]

GA_INSTRUCTOR_2015[, INSTRUCTOR_ENROLLMENT_STATUS:=factor(1, levels=0:1, labels=c("Enrolled Instructor: No", "Enrolled Instructor: Yes"))]
GA_INSTRUCTOR_2015 <- GA_INSTRUCTOR_2015[, list(CONTENT_AREA, YEAR, YEAR_WITHIN, ID, DISTRICT_NUMBER, DISTRICT_NAME, SCHOOL_NUMBER, SCHOOL_NAME,  INSTRUCTOR_NUMBER, INSTRUCTOR_FIRST_NAME, INSTRUCTOR_LAST_NAME, INSTRUCTOR_ENROLLMENT_STATUS)]

###  Set up SCHOOL_NUMBER to match @Data

GA_INSTRUCTOR_2015$SCHOOL_NUMBER <- as.numeric(GA_INSTRUCTOR_2015$DISTRICT_NUMBER)*10000 + as.numeric(GA_INSTRUCTOR_2015$SCHOOL_NUMBER)
GA_INSTRUCTOR_2015[which(as.numeric(DISTRICT_NUMBER) > 1000), SCHOOL_NUMBER := as.numeric(DISTRICT_NUMBER)]
GA_INSTRUCTOR_2015[, SCHOOL_NUMBER := as.character(SCHOOL_NUMBER)]


### Remove duplicates

setkey(GA_INSTRUCTOR_2015, CONTENT_AREA, YEAR, YEAR_WITHIN, INSTRUCTOR_NUMBER, ID)
GA_INSTRUCTOR_2015 <- unique(GA_INSTRUCTOR_2015)
setkey(GA_INSTRUCTOR_2015, ID, CONTENT_AREA, YEAR)

GA_INSTRUCTOR_2015[, VALID_CASE := "VALID_CASE"]

### Save results
save(GA_INSTRUCTOR_2015, file="Data/Base_Files/GA_INSTRUCTOR_2015.Rdata")

###
###  Merge 2014 data with existing @Data_Supplementary$INSTRUCTOR_NUMBER
###

load('Data/Georgia_SGP.Rdata')

### Create the Data_Supplementary > INSTRUCTOR_NUMBER slot in the new SGP object
Georgia_SGP@Data_Supplementary[["INSTRUCTOR_NUMBER"]] <- GA_INSTRUCTOR_2015

# You may want to save Georgia_SGP and restart before running summarizeSGP 
# if CPU memory is now exhausted.  Just to be safe ...


###  Summarize Results
Georgia_SGP <- summarizeSGP(
	Georgia_SGP,
	parallel.config=list(
		# BACKEND="PARALLEL",
		BACKEND="FOREACH", TYPE="doParallel", SNOW_TEST=TRUE, 
		WORKERS=list(SUMMARY=5))
)

#  Extract and save the summary tables seperately

Georgia_Summary <- Georgia_SGP@Summary
save(Georgia_Summary, file="Data/Georgia_Summary_2015.Rdata")

Georgia_SGP@Summary <- NULL


