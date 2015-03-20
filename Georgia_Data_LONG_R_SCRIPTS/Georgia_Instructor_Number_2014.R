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

my.col.classes <- c(rep("character", 26), "integer", "integer")

GA_INSTRUCTOR_2014 <- fread("Data/Base_Files/2014_Teacher_SIMEX_SGP_multiple_Teachers.txt", sep="|", header=TRUE, colClasses=my.col.classes)


### Clean up names

my.variable.names <- c("FISCAL_YEAR", "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER", "SCHOOL_NAME", "TEACHER_NAME", "INSTRUCTOR_NUMBER", 
	"CONTENT_AREA", "CONTENT_AREA_DESC", "CONTENT_AREA_SECTION", "STUDENT_NAME", "YEAR", "ID", "UNIQUE_ID", "GRADE", "ADMIN_TYPE", 
	"SCALE_SCORE", "ACHIEVEMENT_LEVEL", "SCALE_SCORE_PRIOR_1", "ACHIEVEMENT_LEVEL_PRIOR_1",
	"RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "Primaryfirst", "SGP_SIMEX", "SGP_SIMEX_BASELINE")

setnames(GA_INSTRUCTOR_2014, my.variable.names)


### Create INSTRUCTOR_FIRST_NAME and INSTRUCTOR_LAST_NAME

my.tmp <- strsplit(as.character(GA_INSTRUCTOR_2014$TEACHER_NAME), ",")
my.tmp.first_name <- factor(sapply(my.tmp, '[', 2))
levels(my.tmp.first_name) <- sapply(sapply(strsplit(levels(my.tmp.first_name), " "), '[', 2), capwords)
my.tmp.last_name <- factor(sapply(my.tmp, '[', 1))
levels(my.tmp.last_name) <- sapply(levels(my.tmp.last_name), capwords)
GA_INSTRUCTOR_2014[, INSTRUCTOR_FIRST_NAME := as.character(my.tmp.first_name)]
GA_INSTRUCTOR_2014[, INSTRUCTOR_LAST_NAME  := as.character(my.tmp.last_name)]


### Create YEAR_WITHIN Varaible

GA_INSTRUCTOR_2014[, YEAR_WITHIN := "Spring"]

table(GA_INSTRUCTOR_2014$CONTENT_AREA, GA_INSTRUCTOR_2014$CONTENT_AREA_DESC)
setnames(GA_INSTRUCTOR_2014, "CONTENT_AREA_DESC", "ADMIN_PERIOD")

GA_INSTRUCTOR_2014[which(ADMIN_PERIOD %in% c("Spring", "Winter")), YEAR_WITHIN := ADMIN_PERIOD]

GA_INSTRUCTOR_2014[, YEAR_WITHIN := as.factor(YEAR_WITHIN)]
levels(GA_INSTRUCTOR_2014$YEAR_WITHIN) <- c("2", "1")
GA_INSTRUCTOR_2014[, YEAR_WITHIN := as.character(YEAR_WITHIN)]

GA_INSTRUCTOR_2014[,INSTRUCTOR_ENROLLMENT_STATUS:=factor(1, levels=0:1, labels=c("Enrolled Instructor: No", "Enrolled Instructor: Yes"))]
GA_INSTRUCTOR_2014 <- GA_INSTRUCTOR_2014[, list(CONTENT_AREA, YEAR, YEAR_WITHIN, ID, DISTRICT_NUMBER, DISTRICT_NAME, SCHOOL_NUMBER, SCHOOL_NAME,  INSTRUCTOR_NUMBER, INSTRUCTOR_FIRST_NAME, INSTRUCTOR_LAST_NAME, INSTRUCTOR_ENROLLMENT_STATUS)]

###  Set up SCHOOL_NUMBER to match @Data

GA_INSTRUCTOR_2014$SCHOOL_NUMBER <- as.numeric(GA_INSTRUCTOR_2014$DISTRICT_NUMBER)*10000 + as.numeric(GA_INSTRUCTOR_2014$SCHOOL_NUMBER)
GA_INSTRUCTOR_2014[which(as.numeric(DISTRICT_NUMBER) > 1000), SCHOOL_NUMBER := as.numeric(DISTRICT_NUMBER)]
GA_INSTRUCTOR_2014[, SCHOOL_NUMBER := as.character(SCHOOL_NUMBER)]


### Remove duplicates

setkey(GA_INSTRUCTOR_2014, CONTENT_AREA, YEAR, YEAR_WITHIN, INSTRUCTOR_NUMBER, ID)
GA_INSTRUCTOR_2014 <- unique(GA_INSTRUCTOR_2014)
setkey(GA_INSTRUCTOR_2014, ID, CONTENT_AREA, YEAR)

GA_INSTRUCTOR_2014[, VALID_CASE := "VALID_CASE"]

# tmp <- GA_INSTRUCTOR_2014[c(which(duplicated(GA_INSTRUCTOR_2014))-1, which(duplicated(GA_INSTRUCTOR_2014)))]
### Save results

save(GA_INSTRUCTOR_2014, file="../GA_INSTRUCTOR_2013-14.Rdata")

###	Merge 2014 data with existing @Data_Supplementary$INSTRUCTOR_NUMBER

load('/home/avi/SGP_Projects/Georgia/Data/Georgia_SGP.Rdata')

unlist(sapply(Georgia_SGP@Data_Supplementary[[1]], class)) # LName FName to character
Georgia_SGP@Data_Supplementary[[1]][, INSTRUCTOR_LAST_NAME := as.character(INSTRUCTOR_LAST_NAME)]
Georgia_SGP@Data_Supplementary[[1]][, INSTRUCTOR_FIRST_NAME := as.character(INSTRUCTOR_FIRST_NAME)]

Georgia_SGP@Data_Supplementary[["INSTRUCTOR_NUMBER"]] <- rbind(Georgia_SGP@Data_Supplementary[["INSTRUCTOR_NUMBER"]], GA_INSTRUCTOR_2014)

save(Georgia_SGP, file='/home/avi/SGP_Projects/Georgia/Data/Georgia_SGP.Rdata')
