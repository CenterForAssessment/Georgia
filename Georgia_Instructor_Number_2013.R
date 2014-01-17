###################################################################################
###
### Creation of Long Teacher Data files
###
###################################################################################

### Load packages

require(SGP)
require(data.table)
require(plyr)

setwd('/home/avi/SGP_Projects/Georgia')

### Load data

my.col.classes.crct <- c("character", "integer", "factor", "integer", "factor", "factor", "character", "character", "character", "factor", "character", "character", "character",
	"character", "character", "integer", "factor", "integer", "factor", "factor", "factor", "factor", "factor", "factor", "integer", "integer", "numeric", "integer")
my.col.classes.eoct <- c("character", "integer", "factor", "integer", "factor", "factor", "character", "character", "character", "character", "factor", "character", "character", 
	"character", "character", "character", "integer", "factor", "factor", "factor", "factor", "factor", "factor", "integer", "integer", "factor", "character", "integer")

CRCT_2013_INSTRUCTOR <- fread("Data/Base_Files/2013_system_school_Teacher_Linked_SGP/2013_System_School_Teacher_Section_Student_CourseData_ForCRCT_FromSR2013_SGPLinked.txt", 
	sep="|", header=TRUE, colClasses=my.col.classes.crct)
EOCT_2013_INSTRUCTOR <- fread("Data/Base_Files/2013_system_school_Teacher_Linked_SGP/2013_System_School_Teacher_Section_Student_CourseData_ForEOCT_FromSR2013_SGPLinked.txt", 
	sep="|", header=TRUE, colClasses=my.col.classes.eoct)


### Clean up names

my.variable.names.crct <- c("FISCAL_YEAR", "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER", "SCHOOL_NAME", "TEACHER_NAME", "INSTRUCTOR_NUMBER", "CONTENT_AREA", "CONTENT_AREA_SECTION", 
	"STUDENT_NAME", "YEAR", "ID", "UNIQUE_ID", "GRADE", "ADMIN_TYPE", "SCALE_SCORE", "ACHIEVEMENT_LEVEL", "SCHOOL_YEAR_PRIOR_1", "ACHIEVEMENT_LEVEL_PRIOR_1",
	"RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "SGP", "SGP_BASELINE", "SGP_STANDARD_ERROR", "Primaryfirst")
my.variable.names.eoct <- c("FISCAL_YEAR", "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER", "SCHOOL_NAME", "TEACHER_NAME", "INSTRUCTOR_NUMBER", "CONTENT_AREA", "CONTENT_AREA_SECTION", "MARKING_PERIOD", "STUDENT_NAME", "YEAR", "ID", "UNIQUE_ID", "GRADE", "ADMIN_TYPE", "SCALE_SCORE", "RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "ACHIEVEMENT_LEVEL", "SGP_BASELINE", "SCALE_SCORE_PRIOR_1", "ACHIEVEMENT_LEVEL_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "Primaryfirst")

setnames(CRCT_2013_INSTRUCTOR, my.variable.names.crct)
setnames(EOCT_2013_INSTRUCTOR, my.variable.names.eoct)


### Create INSTRUCTOR_FIRST_NAME and INSTRUCTOR_LAST_NAME

my.tmp <- strsplit(as.character(CRCT_2013_INSTRUCTOR$TEACHER_NAME), ",")
my.tmp.first_name <- factor(sapply(my.tmp, '[', 2))
levels(my.tmp.first_name) <- sapply(sapply(strsplit(levels(my.tmp.first_name), " "), '[', 2), capwords)
my.tmp.last_name <- factor(sapply(my.tmp, '[', 1))
levels(my.tmp.last_name) <- sapply(levels(my.tmp.last_name), capwords)
CRCT_2013_INSTRUCTOR$INSTRUCTOR_FIRST_NAME <- my.tmp.first_name
CRCT_2013_INSTRUCTOR$INSTRUCTOR_LAST_NAME <- my.tmp.last_name

my.tmp <- strsplit(as.character(EOCT_2013_INSTRUCTOR$TEACHER_NAME), ",")
my.tmp.first_name <- factor(sapply(my.tmp, '[', 2))
levels(my.tmp.first_name) <- sapply(sapply(strsplit(levels(my.tmp.first_name), " "), '[', 2), capwords)
my.tmp.last_name <- factor(sapply(my.tmp, '[', 1))
levels(my.tmp.last_name) <- sapply(levels(my.tmp.last_name), capwords)
EOCT_2013_INSTRUCTOR$INSTRUCTOR_FIRST_NAME <- my.tmp.first_name
EOCT_2013_INSTRUCTOR$INSTRUCTOR_LAST_NAME <- my.tmp.last_name

### Create YEAR_WITHIN Varaible

CRCT_2013_INSTRUCTOR$YEAR_WITHIN <- "2"

setnames(EOCT_2013_INSTRUCTOR, "MARKING_PERIOD", "YEAR_WITHIN")
EOCT_2013_INSTRUCTOR$YEAR_WITHIN <- as.factor(EOCT_2013_INSTRUCTOR$YEAR_WITHIN)
levels(EOCT_2013_INSTRUCTOR$YEAR_WITHIN) <- c("2", "1")
EOCT_2013_INSTRUCTOR[, YEAR_WITHIN := as.character(YEAR_WITHIN)]

### Merge together CRCT/EOCT files

INSTRUCTOR_NUMBER <- as.data.table(rbind.fill(CRCT_2013_INSTRUCTOR, EOCT_2013_INSTRUCTOR))
INSTRUCTOR_NUMBER[,INSTRUCTOR_ENROLLMENT_STATUS:=factor(1, levels=0:1, labels=c("Enrolled Instructor: No", "Enrolled Instructor: Yes"))]
INSTRUCTOR_NUMBER <- INSTRUCTOR_NUMBER[, list(CONTENT_AREA, YEAR, YEAR_WITHIN, ID, DISTRICT_NUMBER, DISTRICT_NAME, SCHOOL_NUMBER, SCHOOL_NAME,  INSTRUCTOR_NUMBER, INSTRUCTOR_FIRST_NAME, INSTRUCTOR_LAST_NAME, INSTRUCTOR_ENROLLMENT_STATUS)]

###  Set up SCHOOL_NUMBER to match @Data

INSTRUCTOR_NUMBER$SCHOOL_NUMBER <- INSTRUCTOR_NUMBER$DISTRICT_NUMBER*10000 + INSTRUCTOR_NUMBER$SCHOOL_NUMBER
INSTRUCTOR_NUMBER[which(DISTRICT_NUMBER >1000), SCHOOL_NUMBER := DISTRICT_NUMBER]
INSTRUCTOR_NUMBER[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]


### Remove duplicates

setkey(INSTRUCTOR_NUMBER, CONTENT_AREA, YEAR, YEAR_WITHIN, INSTRUCTOR_NUMBER, ID)
INSTRUCTOR_NUMBER <- unique(INSTRUCTOR_NUMBER)
setkey(INSTRUCTOR_NUMBER, ID, CONTENT_AREA, YEAR)

INSTRUCTOR_NUMBER[, VALID_CASE := "VALID_CASE"]

### Save results

save(INSTRUCTOR_NUMBER, file="../INSTRUCTOR_NUMBER-2013.Rdata")

###	Merge 2013 data with existing (2011 & 12) Data_Supplementary

load('/home/avi/SGP_Projects/Georgia/Data/Georgia_SGP.Rdata')

Georgia_SGP@Data_Supplementary$INSTRUCTOR_NUMBER <- as.data.table(rbind.fill(Georgia_SGP@Data_Supplementary$INSTRUCTOR_NUMBER, INSTRUCTOR_NUMBER))

save(Georgia_SGP, file='/home/avi/SGP_Projects/Georgia/Data/Georgia_SGP.Rdata')
