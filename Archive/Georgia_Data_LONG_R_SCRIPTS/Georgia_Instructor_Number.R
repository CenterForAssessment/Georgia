###################################################################################
###
### Creation of Long Teacher Data files
###
###################################################################################

### Load packages

require(SGP)
require(data.table)
require(plyr)


### Load data

my.col.classes.crct <- c("character", "integer", "factor", "integer", "factor", "factor", "character", "character", "character", "factor", "character")
my.col.classes.eoct <- c("character", "integer", "factor", "integer", "factor", "factor", "character", "character", "character", "character", "character", "factor", "character")
CRCT_2011_2012_INSTRUCTOR <- as.data.table(read.table("2011_2012_System_School_Teacher_Section_Student_CourseData_For_CRCT_encrypted.txt", sep="|", quote="", header=TRUE, 
	colClasses=my.col.classes.crct))
EOCT_2011_2012_INSTRUCTOR <- as.data.table(read.table("2011_2012_System_School_Teacher_Section_Student_CourseData_For_EOCT_encrypted.txt", sep="|", quote="", header=TRUE, 
	colClasses=my.col.classes.eoct))


### Clean up names

my.variable.names.crct <- c("YEAR", "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER", "SCHOOL_NAME", "TEACHER_NAME", "INSTRUCTOR_NUMBER",
	"CONTENT_AREA", "CONTENT_AREA_SECTION", "STUDENT_NAME", "ID")
my.variable.names.eoct <- c("YEAR", "DISTRICT_NUMBER", "DISTRICT_NAME", "SCHOOL_NUMBER", "SCHOOL_NAME", "TEACHER_NAME", "INSTRUCTOR_NUMBER", "MARKING_PERIOD", "MARKING_PERIOD_DESCRIPTION", 
	"CONTENT_AREA", "CONTENT_AREA_SECTION", "STUDENT_NAME", "ID")

setnames(CRCT_2011_2012_INSTRUCTOR, my.variable.names.crct)
setnames(EOCT_2011_2012_INSTRUCTOR, my.variable.names.eoct)


### Create INSTRUCTOR_FIRST_NAME and INSTRUCTOR_LAST_NAME

my.tmp <- strsplit(as.character(CRCT_2011_2012_INSTRUCTOR$TEACHER_NAME), ",")
my.tmp.first_name <- factor(sapply(my.tmp, '[', 1))
levels(my.tmp.first_name) <- sapply(levels(my.tmp.first_name), capwords)
my.tmp.last_name <- factor(sapply(my.tmp, '[', 2))
levels(my.tmp.last_name) <- sapply(sapply(strsplit(levels(my.tmp.last_name), " "), '[', 2), capwords)
CRCT_2011_2012_INSTRUCTOR$INSTRUCTOR_FIRST_NAME <- my.tmp.first_name
CRCT_2011_2012_INSTRUCTOR$INSTRUCTOR_LAST_NAME <- my.tmp.last_name
CRCT_2011_2012_INSTRUCTOR$TEACHER_NAME <- NULL

my.tmp <- strsplit(as.character(EOCT_2011_2012_INSTRUCTOR$TEACHER_NAME), ",")
my.tmp.first_name <- factor(sapply(my.tmp, '[', 1))
levels(my.tmp.first_name) <- sapply(levels(my.tmp.first_name), capwords)
my.tmp.last_name <- factor(sapply(my.tmp, '[', 2))
levels(my.tmp.last_name) <- sapply(sapply(strsplit(levels(my.tmp.last_name), " "), '[', 2), capwords)
EOCT_2011_2012_INSTRUCTOR$INSTRUCTOR_FIRST_NAME <- my.tmp.first_name
EOCT_2011_2012_INSTRUCTOR$INSTRUCTOR_LAST_NAME <- my.tmp.last_name
EOCT_2011_2012_INSTRUCTOR$TEACHER_NAME <- NULL


### Eliminate STUDENT_NAME

CRCT_2011_2012_INSTRUCTOR$STUDENT_NAME <- NULL
EOCT_2011_2012_INSTRUCTOR$STUDENT_NAME <- NULL

### REMOVE CONTENT_AREA_SECTION

CRCT_2011_2012_INSTRUCTOR$CONTENT_AREA_SECTION <- NULL
EOCT_2011_2012_INSTRUCTOR$CONTENT_AREA_SECTION <- NULL


### RECODE CONTENT_AREA

CRCT_2011_2012_INSTRUCTOR$CONTENT_AREA <- as.factor(CRCT_2011_2012_INSTRUCTOR$CONTENT_AREA)
levels(CRCT_2011_2012_INSTRUCTOR$CONTENT_AREA) <- c("ELA", "SCIENCE", "MATHEMATICS", "MATHEMATICS", "SCIENCE", "SCIENCE", "SCIENCE", "SOCIAL_STUDIES", "ELA", "SCIENCE", "MATHEMATICS", "SCIENCE", "SOCIAL_STUDIES")
CRCT_2011_2012_INSTRUCTOR$CONTENT_AREA <- as.character(CRCT_2011_2012_INSTRUCTOR$CONTENT_AREA)
my.tmp <- CRCT_2011_2012_INSTRUCTOR[CONTENT_AREA=="ELA"]
my.tmp[,CONTENT_AREA:="READING"]
CRCT_2011_2012_INSTRUCTOR <- rbind(CRCT_2011_2012_INSTRUCTOR, my.tmp)
CRCT_2011_2012_INSTRUCTOR$CONTENT_AREA <- as.character(CRCT_2011_2012_INSTRUCTOR$CONTENT_AREA)
save(CRCT_2011_2012_INSTRUCTOR, file="CRCT_2011_2012_INSTRUCTOR.Rdata")

EOCT_2011_2012_INSTRUCTOR$CONTENT_AREA <- as.factor(EOCT_2011_2012_INSTRUCTOR$CONTENT_AREA)
levels(EOCT_2011_2012_INSTRUCTOR$CONTENT_AREA) <- c("AMERICAN_LIT", "AMERICAN_LIT", "GRADE_9_LIT", "AMERICAN_LIT", rep("BIOLOGY", 3), "ALGEBRA", "GEOMETRY", 
	"MATHEMATICS_I", "MATHEMATICS_II", "MATHEMATICS_I", "MATHEMATICS_II", "ALGEBRA", "GEOMETRY", "PHYSICAL_SCIENCE", rep("ECONOMICS", 4), rep("US_HISTORY", 3))
EOCT_2011_2012_INSTRUCTOR$CONTENT_AREA <- as.character(EOCT_2011_2012_INSTRUCTOR$CONTENT_AREA)
save(EOCT_2011_2012_INSTRUCTOR, file="EOCT_2011_2012_INSTRUCTOR.Rdata")


### Create YEAR_WITHIN Varaible

CRCT_2011_2012_INSTRUCTOR$YEAR_WITHIN_INSTRUCTOR <- "2"

setnames(EOCT_2011_2012_INSTRUCTOR, "MARKING_PERIOD_DESCRIPTION", "YEAR_WITHIN_INSTRUCTOR")
EOCT_2011_2012_INSTRUCTOR$YEAR_WITHIN_INSTRUCTOR <- as.factor(EOCT_2011_2012_INSTRUCTOR$YEAR_WITHIN_INSTRUCTOR)
levels(EOCT_2011_2012_INSTRUCTOR$YEAR_WITHIN_INSTRUCTOR) <- c("1", "1", "1", "1", "2", "1", "2", "2", "2", "2", "2", "2")
EOCT_2011_2012_INSTRUCTOR$MARKING_PERIOD <- NULL


### Identify CRCT duplicates




### Merge together 2011 and 2012 CRCT/EOCT files

INSTRUCTOR_NUMBER <- as.data.table(rbind.fill(CRCT_2011_2012_INSTRUCTOR, EOCT_2011_2012_INSTRUCTOR))
setcolorder(INSTRUCTOR_NUMBER, c(7,1,11,8,2:6,9:10))
INSTRUCTOR_NUMBER[,INSTRUCTOR_ENROLLMENT_STATUS:=factor(1, levels=0:1, labels=c("Enrolled Instructor: No", "Enrolled Instructor: Yes"))]


### Remove duplicates

setkey(INSTRUCTOR_NUMBER, CONTENT_AREA, YEAR, YEAR_WITHIN_INSTRUCTOR, INSTRUCTOR_NUMBER, ID)
INSTRUCTOR_NUMBER <- unique(INSTRUCTOR_NUMBER)
setkey(INSTRUCTOR_NUMBER, ID, CONTENT_AREA, YEAR)


### Save results

save(INSTRUCTOR_NUMBER, file="INSTRUCTOR_NUMBER.Rdata")
