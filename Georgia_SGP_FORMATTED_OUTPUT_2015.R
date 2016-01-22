######################################################################################
###
### Script to produce formatted text output for Georgia from annual long data
###
######################################################################################

### Load packages

require(SGP)
require(data.table)

### Load data
setwd('/media/Data/Dropbox/SGP/Georgia')

load("Data/Georgia_SGP.Rdata")
load("Data/Georgia_SGP_LONG_Data_2015.Rdata")

### Variables to output
variables.to.output <- c("VALID_CASE", "GTID", "SCHOOL_YEAR", "SUBJECT_CODE", "YEAR_WITHIN", "GRADE", "GRADE_REPORTED", "SCALE_SCORE", "SCALE_SCORE_PRIOR_STANDARDIZED",
"ADMINISTRATION_PERIOD", "FIRST_OBSERVATION", "LAST_OBSERVATION", "PERFORMANCE_LEVEL", "SR_SYSTEM_ID", "SCHOOL_NUMBER", "ADMIN_INVALIDATION", "ADMIN_TYPE", "MATCH_STATUS",
"RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "GIFT", "BIRTH_DATE", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME",
"SGP_NORM_GROUP", "SGP", "SGP_SIMEX", "SGP_LEVEL", "SGP_STANDARD_ERROR", "SGP_NORM_GROUP_SCALE_SCORES", 
"SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "PERFORMANCE_LEVEL_PRIOR_1", "GRADE_PRIOR_1", "ADMINISTRATION_PERIOD_PRIOR_1", "ASSESSMENT_TYPE_PRIOR_1",
"SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "SCALE_SCORE_PRIOR_2", "PERFORMANCE_LEVEL_PRIOR_2", "GRADE_PRIOR_2", "ADMINISTRATION_PERIOD_PRIOR_2", "ASSESSMENT_TYPE_PRIOR_2", 
"SCHOOL_YEAR_PRIOR_3", "SUBJECT_CODE_PRIOR_3", "SCALE_SCORE_PRIOR_3", "PERFORMANCE_LEVEL_PRIOR_3", "GRADE_PRIOR_3", "ADMINISTRATION_PERIOD_PRIOR_3", "ASSESSMENT_TYPE_PRIOR_3",
"SCHOOL_YEAR_PRIOR_4", "SUBJECT_CODE_PRIOR_4", "SCALE_SCORE_PRIOR_4", "PERFORMANCE_LEVEL_PRIOR_4", "GRADE_PRIOR_4", "ADMINISTRATION_PERIOD_PRIOR_4", "ASSESSMENT_TYPE_PRIOR_4")

### Subset out relevant variables

tmp.long.data <- subset(Georgia_SGP_LONG_Data_2015, select=intersect(variables.to.output, names(Georgia_SGP_LONG_Data_2015)))

# ### Clean up ADMINISTRATION_PERIOD - Changed in Georgia_SGP@Data and Georgia_SGP_LONG_Data_2015 output, so not needed anymore
# tmp.long.data[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, ADMINISTRATION_PERIOD, sep=": ")]

### Split SGP_NORM_GROUP
my.tmp.split <- strsplit(as.character(tmp.long.data$SGP_NORM_GROUP), "; ")


### YEAR Prior
tmp.long.data$SCHOOL_YEAR_PRIOR_1 <- sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 1)
tmp.long.data$SCHOOL_YEAR_PRIOR_2 <- sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 1)
tmp.long.data$SCHOOL_YEAR_PRIOR_3 <- sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[4]), "/"), '[', 1)
tmp.long.data$SCHOOL_YEAR_PRIOR_4 <- sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[5]), "/"), '[', 1)

### SUBJECT_CODE Prior
tmp.long.data$SUBJECT_CODE_PRIOR_1 <- sapply(sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")
tmp.long.data$SUBJECT_CODE_PRIOR_2 <- sapply(sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")
tmp.long.data$SUBJECT_CODE_PRIOR_3 <- sapply(sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[4]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")
tmp.long.data$SUBJECT_CODE_PRIOR_4 <- sapply(sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[5]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")

### GRADE Prior
tmp.long.data$GRADE_PRIOR_1 <- sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 2), "_"), tail, 1)
tmp.long.data$GRADE_PRIOR_2 <- sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 2), "_"), tail, 1)
tmp.long.data$GRADE_PRIOR_3 <- sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[4]), "/"), '[', 2), "_"), tail, 1)
tmp.long.data$GRADE_PRIOR_4 <- sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[5]), "/"), '[', 2), "_"), tail, 1)

### SCALE_SCORE Prior
my.tmp.split.scale_score <- strsplit(tmp.long.data$SGP_NORM_GROUP_SCALE_SCORES, "; ")
tmp.long.data$SCALE_SCORE_PRIOR_1 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[2])
tmp.long.data$SCALE_SCORE_PRIOR_2 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[3])
tmp.long.data$SCALE_SCORE_PRIOR_3 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[4])
tmp.long.data$SCALE_SCORE_PRIOR_4 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[5])


###  PERFORMANCE_LEVEL Prior

## Set name of GRADE to GRADE_CURRENT for all 4 prior var creations
setnames(tmp.long.data, "GRADE", "GRADE_CURRENT")

## Create the 1st Prior PERFORMANCE_LEVEL info for Milestones & CRCT (EOGT & EOCT).  2nd - 4th Priors will all be CRCT EOGT only in 2015

setnames(tmp.long.data, c("SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "GRADE_PRIOR_1"), c("YEAR", "CONTENT_AREA", "GRADE"))
tmp.long.data <- SGP:::getAchievementLevel(tmp.long.data, state="GA", achievement.level.name="PERFORMANCE_LEVEL_PRIOR_1", scale.score.name="SCALE_SCORE_PRIOR_1")
setnames(tmp.long.data, c("YEAR", "CONTENT_AREA", "GRADE"), c("SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "GRADE_PRIOR_1"))

###  Checks on the results:
# tmp.long.data[SCHOOL_YEAR_PRIOR_1 == "2015"][, as.list(summary(as.factor(PERFORMANCE_LEVEL_PRIOR_1))), keyby=list(SUBJECT_CODE_PRIOR_1)]
# tmp.long.data[!is.na(PERFORMANCE_LEVEL_PRIOR_1) & SCHOOL_YEAR_PRIOR_1 != "2015"][, as.list(summary(as.numeric(SCALE_SCORE_PRIOR_1))), keyby=list(PERFORMANCE_LEVEL_PRIOR_1, SUBJECT_CODE_PRIOR_1)]
# tmp.long.data[!is.na(PERFORMANCE_LEVEL_PRIOR_1) & SCHOOL_YEAR_PRIOR_1 == "2015"][, as.list(summary(as.numeric(SCALE_SCORE_PRIOR_1))), keyby=list(SUBJECT_CODE_PRIOR_1, PERFORMANCE_LEVEL_PRIOR_1)]

## Create the 2nd Prior PERFORMANCE_LEVEL info -- CRCT EOGT only in 2015
setnames(tmp.long.data, c("SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "GRADE_PRIOR_2"), c("YEAR", "CONTENT_AREA", "GRADE"))
tmp.long.data <- SGP:::getAchievementLevel(tmp.long.data, state="GA", achievement.level.name="PERFORMANCE_LEVEL_PRIOR_2", scale.score.name="SCALE_SCORE_PRIOR_2")
setnames(tmp.long.data, c("YEAR", "CONTENT_AREA", "GRADE"), c("SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "GRADE_PRIOR_2"))

## Create the 3rd Prior PERFORMANCE_LEVEL info -- CRCT EOGT only in 2015
setnames(tmp.long.data, c("SCHOOL_YEAR_PRIOR_3", "SUBJECT_CODE_PRIOR_3", "GRADE_PRIOR_3"), c("YEAR", "CONTENT_AREA", "GRADE"))
tmp.long.data <- SGP:::getAchievementLevel(tmp.long.data, state="GA", achievement.level.name="PERFORMANCE_LEVEL_PRIOR_3", scale.score.name="SCALE_SCORE_PRIOR_3")
setnames(tmp.long.data, c("YEAR", "CONTENT_AREA", "GRADE"), c("SCHOOL_YEAR_PRIOR_3", "SUBJECT_CODE_PRIOR_3", "GRADE_PRIOR_3"))

## Create the 4th Prior PERFORMANCE_LEVEL info -- CRCT EOGT only in 2015
setnames(tmp.long.data, c("SCHOOL_YEAR_PRIOR_4", "SUBJECT_CODE_PRIOR_4", "GRADE_PRIOR_4"), c("YEAR", "CONTENT_AREA", "GRADE"))
tmp.long.data <- SGP:::getAchievementLevel(tmp.long.data, state="GA", achievement.level.name="PERFORMANCE_LEVEL_PRIOR_4", scale.score.name="SCALE_SCORE_PRIOR_4")
setnames(tmp.long.data, c("YEAR", "CONTENT_AREA", "GRADE"), c("SCHOOL_YEAR_PRIOR_4", "SUBJECT_CODE_PRIOR_4", "GRADE_PRIOR_4"))

## Set name of GRADE_CURRENT back to GRADE
setnames(tmp.long.data, "GRADE_CURRENT", "GRADE")


### ADMINISTRATION_PERIOD_PRIOR_* Prior

tmp.admin.period <- Georgia_SGP@Data[, c(key(Georgia_SGP@Data)[1:4], "GRADE", "ADMINISTRATION_PERIOD", "SCALE_SCORE"), with=FALSE][VALID_CASE=="VALID_CASE" & GRADE=="EOCT"]
setnames(tmp.admin.period, c("CONTENT_AREA", "YEAR", "GRADE", "ID", "ADMINISTRATION_PERIOD", "SCALE_SCORE"), 
	c("SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "GTID", "ADMINISTRATION_PERIOD_PRIOR_1", "SCALE_SCORE_PRIOR_1"))

### Clean up ADMINISTRATION_PERIOD
# tmp.admin.period[which(SCHOOL_YEAR_PRIOR_1 == '2015' & ADMINISTRATION_PERIOD_PRIOR_1 == "1: "), ADMINISTRATION_PERIOD_PRIOR_1 := "1: WINTER"]
# tmp.admin.period[which(SCHOOL_YEAR_PRIOR_1 == '2015' & ADMINISTRATION_PERIOD_PRIOR_1 == "2: "), ADMINISTRATION_PERIOD_PRIOR_1 := "2: SPRING"]
# tmp.admin.period[which(SCHOOL_YEAR_PRIOR_1 == '2015' & ADMINISTRATION_PERIOD_PRIOR_1 == "3: "), ADMINISTRATION_PERIOD_PRIOR_1 := "3: SUMMER"]

tmp.admin.period[, SCALE_SCORE_PRIOR_1 := as.character(SCALE_SCORE_PRIOR_1)]

## Remove the "LAST_OBSERVATION" for within year repeaters that had the exact same score in both Admin Periods
setkeyv(tmp.admin.period, c("GTID", "SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "ADMINISTRATION_PERIOD_PRIOR_1", "VALID_CASE"))
setkeyv(tmp.admin.period, c("GTID", "SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "VALID_CASE"))
tmp.admin.period <- tmp.admin.period[which(!duplicated(tmp.admin.period))]

setkeyv(tmp.long.data, c("GTID", "SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "VALID_CASE"))

tmp.long.data <- merge(tmp.long.data, tmp.admin.period, all.x=TRUE)

tmp.long.data[which(!is.na(GRADE_PRIOR_1) & is.na(ADMINISTRATION_PERIOD_PRIOR_1)), ADMINISTRATION_PERIOD_PRIOR_1 := "2: SPRING"]
table(tmp.long.data$ADMINISTRATION_PERIOD_PRIOR_1, tmp.long.data$ADMINISTRATION_PERIOD, tmp.long.data$SCHOOL_YEAR_PRIOR_1)

tmp.long.data[, paste("ADMINISTRATION_PERIOD_PRIOR", 2:4, sep="_") := as.character(NA)]

tmp.long.data[which(!is.na(GRADE_PRIOR_2)), ADMINISTRATION_PERIOD_PRIOR_2 := "2: SPRING"]
tmp.long.data[which(!is.na(GRADE_PRIOR_3)), ADMINISTRATION_PERIOD_PRIOR_3 := "2: SPRING"]
tmp.long.data[which(!is.na(GRADE_PRIOR_4)), ADMINISTRATION_PERIOD_PRIOR_4 := "2: SPRING"]


###  ASSESSMENT_TYPE_PRIOR_*
tmp.long.data[, paste("ASSESSMENT_TYPE_PRIOR", 1:4, sep="_") := as.character(NA)]

tmp.long.data[which(!is.na(SCALE_SCORE_PRIOR_1)), ASSESSMENT_TYPE_PRIOR_1 := "CRCT"]
tmp.long.data[which(GRADE_PRIOR_1 == "EOCT"), ASSESSMENT_TYPE_PRIOR_1 := "EOCT"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_1 == "2015"), ASSESSMENT_TYPE_PRIOR_1 := "EOC"]

##   CRCT EOGT only in 2015 for priors 2 - 4
tmp.long.data[which(!is.na(SCALE_SCORE_PRIOR_2)), ASSESSMENT_TYPE_PRIOR_2 := "CRCT"]
tmp.long.data[which(!is.na(SCALE_SCORE_PRIOR_3)), ASSESSMENT_TYPE_PRIOR_3 := "CRCT"]
tmp.long.data[which(!is.na(SCALE_SCORE_PRIOR_4)), ASSESSMENT_TYPE_PRIOR_4 := "CRCT"]


###  Final arrangement of variables
Georgia_SGP_Data_LONG_2015_FORMATTED <- tmp.long.data[, variables.to.output, with=FALSE]
setkeyv(Georgia_SGP_Data_LONG_2015_FORMATTED, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))


### Save results

save(Georgia_SGP_Data_LONG_2015_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2015_FORMATTED.Rdata")
write.table(Georgia_SGP_Data_LONG_2015_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2015_FORMATTED.txt", sep="|", row.names=FALSE, na="", quote=FALSE)
zip(zipfile="Data/Georgia_SGP_Data_LONG_2015_FORMATTED.txt.zip", files="Data/Georgia_SGP_Data_LONG_2015_FORMATTED.txt")
unlink("Data/Georgia_SGP_Data_LONG_2015_FORMATTED.txt")


# Georgia_SGP@Data[which(ADMINISTRATION_PERIOD == "1: "), ADMINISTRATION_PERIOD := "1: WINTER"]
# Georgia_SGP@Data[which(ADMINISTRATION_PERIOD == "2: "), ADMINISTRATION_PERIOD := "2: SPRING"]
# Georgia_SGP@Data[which(ADMINISTRATION_PERIOD == "3: "), ADMINISTRATION_PERIOD := "3: SUMMER"]

# table(Georgia_SGP@Data[, ACHIEVEMENT_LEVEL])
# Georgia_SGP@Data[which(!is.na(ACHIVEMENT_LEVEL)), ACHIEVEMENT_LEVEL := ACHIVEMENT_LEVEL]
# Georgia_SGP@Data[, ACHIVEMENT_LEVEL := NULL]

