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
load("Data/Georgia_SGP_LONG_Data_2014.Rdata")

### Variables to output
variables.to.output <- c("VALID_CASE", "GTID", "SCHOOL_YEAR", "SUBJECT_CODE", "YEAR_WITHIN", "GRADE", "GRADE_REPORTED", "SCALE_SCORE", "ADMINISTRATION_PERIOD",
"FIRST_OBSERVATION", "LAST_OBSERVATION", "PERFORMANCE_LEVEL", "SR_SYSTEM_ID", "SCHOOL_NUMBER", "ADMIN_INVALIDATION", "ADMIN_TYPE", "MATCH_STATUS",
"RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "GIFT", "BIRTH_DATE", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME",
"SGP_NORM_GROUP", "SGP", "SGP_SIMEX", "SGP_LEVEL", "SGP_STANDARD_ERROR", "SGP_NORM_GROUP_SCALE_SCORES", 
"SGP_NORM_GROUP_BASELINE", "SGP_BASELINE", "SGP_SIMEX_BASELINE", "SGP_LEVEL_BASELINE", "SGP_NORM_GROUP_BASELINE_SCALE_SCORES", 
"SGP_NORM_GROUP_FINAL", "SGP_FINAL", "SGP_SIMEX_FINAL", "SGP_LEVEL_FINAL", "SGP_SIMEX_LEVEL_FINAL", "SGP_NORM_GROUP_FINAL_SCALE_SCORES",
"SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "PERFORMANCE_LEVEL_PRIOR_1", "GRADE_PRIOR_1", "ADMINISTRATION_PERIOD_PRIOR_1",
"SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "SCALE_SCORE_PRIOR_2", "PERFORMANCE_LEVEL_PRIOR_2", "GRADE_PRIOR_2", "ADMINISTRATION_PERIOD_PRIOR_2", 
"SCHOOL_YEAR_PRIOR_3", "SUBJECT_CODE_PRIOR_3", "SCALE_SCORE_PRIOR_3", "PERFORMANCE_LEVEL_PRIOR_3", "GRADE_PRIOR_3", "ADMINISTRATION_PERIOD_PRIOR_3",
"SCHOOL_YEAR_PRIOR_4", "SUBJECT_CODE_PRIOR_4", "SCALE_SCORE_PRIOR_4", "PERFORMANCE_LEVEL_PRIOR_4", "GRADE_PRIOR_4", "ADMINISTRATION_PERIOD_PRIOR_4")

### Subset out relevant variables

tmp.long.data <- subset(Georgia_SGP_LONG_Data_2014, select=intersect(variables.to.output, names(Georgia_SGP_LONG_Data_2014)))

# ### Clean up ADMINISTRATION_PERIOD - Changed in Georgia_SGP@Data and Georgia_SGP_LONG_Data_2014 output, so not needed anymore
# tmp.long.data[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, ADMINISTRATION_PERIOD, sep=": ")]

###		Create SGP_*_FINAL Variables
###		Start with baseline SGPs and then fill in missings (EOCT Math subjects) with cohort referenced SGPs

tmp.long.data[, SGP_FINAL := SGP_BASELINE]
tmp.long.data[which(is.na(SGP_FINAL)), SGP_FINAL := SGP]

tmp.long.data[, SGP_SIMEX_FINAL := SGP_SIMEX_BASELINE]
tmp.long.data[which(is.na(SGP_FINAL)), SGP_FINAL := SGP_SIMEX]

tmp.long.data[, SGP_LEVEL_FINAL := SGP_LEVEL_BASELINE]
tmp.long.data[which(is.na(SGP_LEVEL_FINAL)), SGP_LEVEL_FINAL := SGP_LEVEL]

tmp.long.data[, SGP_SIMEX_LEVEL_FINAL := ordered(findInterval(SGP_SIMEX_FINAL, SGPstateData[["GA"]][["Growth"]][["Cutscores"]][["Cuts"]]), labels=c("Low", "Typical", "High"))]

tmp.long.data[, SGP_NORM_GROUP_FINAL := SGP_NORM_GROUP_BASELINE]
tmp.long.data[which(is.na(SGP_NORM_GROUP_FINAL)), SGP_NORM_GROUP_FINAL := SGP_NORM_GROUP]

tmp.long.data[, SGP_NORM_GROUP_FINAL_SCALE_SCORES := SGP_NORM_GROUP_BASELINE_SCALE_SCORES]
tmp.long.data[which(is.na(SGP_NORM_GROUP_FINAL_SCALE_SCORES)), SGP_NORM_GROUP_FINAL_SCALE_SCORES := SGP_NORM_GROUP_SCALE_SCORES]


### Split SGP_NORM_GROUP_FINAL
my.tmp.split <- strsplit(as.character(tmp.long.data$SGP_NORM_GROUP_FINAL), "; ")


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
my.tmp.split.scale_score <- strsplit(tmp.long.data$SGP_NORM_GROUP_FINAL_SCALE_SCORES, "; ")
tmp.long.data$SCALE_SCORE_PRIOR_1 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[2])
tmp.long.data$SCALE_SCORE_PRIOR_2 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[3])
tmp.long.data$SCALE_SCORE_PRIOR_3 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[4])
tmp.long.data$SCALE_SCORE_PRIOR_4 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[5])


###  PERFORMANCE_LEVEL Prior

## Create all 4 PERFORMANCE_LEVEL PRIOR vars as NA vectors
tmp.long.data[, paste("PERFORMANCE_LEVEL_PRIOR", 1:4, sep="_") := factor(NA)]

## Fill in the 1st Prior PERFORMANCE_LEVEL info for CRCT and EOCT.  2nd - 4th Priors will all be CRCT
tmp.long.data[which(GRADE_PRIOR_1 != "EOCT"), PERFORMANCE_LEVEL_PRIOR_1 := 
	ordered(findInterval(as.numeric(SCALE_SCORE_PRIOR_1), c(800, 850)), labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]
tmp.long.data[which(GRADE_PRIOR_1 == "EOCT"), PERFORMANCE_LEVEL_PRIOR_1 := 
	ordered(findInterval(SCALE_SCORE_PRIOR_1, c(400, 450)), labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]

tmp.long.data[which(GRADE_PRIOR_2 != "EOCT"), PERFORMANCE_LEVEL_PRIOR_2 := 
	ordered(findInterval(as.numeric(SCALE_SCORE_PRIOR_2), c(800, 850)), labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]
## 2nd -> 4th Priors will all be CRCT
# tmp.long.data[which(GRADE == "EOCT"), PERFORMANCE_LEVEL_PRIOR_2 := 
	# ordered(findInterval(SCALE_SCORE_PRIOR_2, c(400, 450)), labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]

tmp.long.data[which(GRADE_PRIOR_3 != "EOCT"), PERFORMANCE_LEVEL_PRIOR_3 := 
	ordered(findInterval(as.numeric(SCALE_SCORE_PRIOR_3), c(800, 850)), labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]

tmp.long.data[which(GRADE_PRIOR_4 != "EOCT"), PERFORMANCE_LEVEL_PRIOR_4 := 
	ordered(findInterval(as.numeric(SCALE_SCORE_PRIOR_4), c(800, 850)), labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]


### ADMINISTRATION_PERIOD_PRIOR_* Prior

tmp.admin.period <- Georgia_SGP@Data[, c(key(Georgia_SGP@Data)[1:4], "GRADE", "ADMINISTRATION_PERIOD", "SCALE_SCORE"), with=FALSE][VALID_CASE=="VALID_CASE" & GRADE=="EOCT"]
setnames(tmp.admin.period, c("CONTENT_AREA", "YEAR", "GRADE", "ID", "ADMINISTRATION_PERIOD", "SCALE_SCORE"), 
	c("SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "GTID", "ADMINISTRATION_PERIOD_PRIOR_1", "SCALE_SCORE_PRIOR_1"))
### Clean up ADMINISTRATION_PERIOD
# tmp.admin.period[which(SCHOOL_YEAR_PRIOR_1 =='2014'), ADMINISTRATION_PERIOD_PRIOR_1 := paste(YEAR_WITHIN, ADMINISTRATION_PERIOD_PRIOR_1, sep=": ")]
# tmp.admin.period[, YEAR_WITHIN := NULL]

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

Georgia_SGP_Data_LONG_2014_FORMATTED <- tmp.long.data[, variables.to.output, with=FALSE]
setkeyv(Georgia_SGP_Data_LONG_2014_FORMATTED, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))


### Save results

save(Georgia_SGP_Data_LONG_2014_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2014_FORMATTED.Rdata")
write.table(Georgia_SGP_Data_LONG_2014_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2014_FORMATTED.txt", sep="|", row.names=FALSE, na="", quote=FALSE)
