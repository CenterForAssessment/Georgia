######################################################################################
###
###   Script to produce formatted text output for Georgia from 2016 long data
###
######################################################################################

###   GA DOE
load("U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP_LONG_Data_2016.Rdata")
load("U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP.Rdata")

###   CFA/AVI
setwd('~/SGP_Projects/Georgia')
load("Data/Georgia_SGP.Rdata")
load("Data/Georgia_SGP_LONG_Data_2016.Rdata")

### Variables to output
variables.to.output <- c("VALID_CASE", "GTID", "SCHOOL_YEAR", "SUBJECT_CODE", "YEAR_WITHIN", "GRADE", "GRADE_REPORTED", "SCALE_SCORE", "SCALE_SCORE_PRIOR_STANDARDIZED",
                         "ADMINISTRATION_PERIOD", "FIRST_OBSERVATION", "LAST_OBSERVATION", "PERFORMANCE_LEVEL", "SR_SYSTEM_ID", "SYSTEM_NAME","SCHOOL_NUMBER", "SCHOOL_NAME","ADMIN_INVALIDATION", "ADMIN_TYPE", "MATCH_STATUS",
                         "RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "GIFT", "BIRTH_DATE", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME",
                         "SGP_NORM_GROUP", "SGP", "SGP_SIMEX", "SGP_LEVEL", "SGP_STANDARD_ERROR", "SGP_NORM_GROUP_SCALE_SCORES",
                         "SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "PERFORMANCE_LEVEL_PRIOR_1", "GRADE_PRIOR_1", "ADMINISTRATION_PERIOD_PRIOR_1", "ASSESSMENT_TYPE_PRIOR_1",
                         "SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "SCALE_SCORE_PRIOR_2", "PERFORMANCE_LEVEL_PRIOR_2", "GRADE_PRIOR_2", "ADMINISTRATION_PERIOD_PRIOR_2", "ASSESSMENT_TYPE_PRIOR_2",
                         "SCHOOL_YEAR_PRIOR_3", "SUBJECT_CODE_PRIOR_3", "SCALE_SCORE_PRIOR_3", "PERFORMANCE_LEVEL_PRIOR_3", "GRADE_PRIOR_3", "ADMINISTRATION_PERIOD_PRIOR_3", "ASSESSMENT_TYPE_PRIOR_3",
                        #  "SGP_PROJECTION_GROUP_PRIOR", "LEVEL_1_SGP_TARGET_YEAR_1_PRIOR", "LEVEL_2_SGP_TARGET_YEAR_1_PRIOR",
                        #  "P1_PROJ_YEAR_1_PRIOR", "P35_PROJ_YEAR_1_PRIOR", "P66_PROJ_YEAR_1_PRIOR", "P99_PROJ_YEAR_1_PRIOR",
                         "SGP_PROJECTION_GROUP_CURRENT", "LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT",
                         "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT")

### Subset out relevant variables
tmp.long.data <- subset(Georgia_SGP_LONG_Data_2016, select=intersect(variables.to.output, names(Georgia_SGP_LONG_Data_2016)))

### Split SGP_NORM_GROUP_BASELINE
my.tmp.split <- strsplit(as.character(tmp.long.data$SGP_NORM_GROUP), "; ")

### YEAR Prior
tmp.long.data$SCHOOL_YEAR_PRIOR_1 <- sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 1)
tmp.long.data$SCHOOL_YEAR_PRIOR_2 <- sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 1)
tmp.long.data$SCHOOL_YEAR_PRIOR_3 <- sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[4]), "/"), '[', 1)

### SUBJECT_CODE Prior
tmp.long.data$SUBJECT_CODE_PRIOR_1 <- sapply(sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")
tmp.long.data$SUBJECT_CODE_PRIOR_2 <- sapply(sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")
tmp.long.data$SUBJECT_CODE_PRIOR_3 <- sapply(sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[4]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")

### GRADE Prior
tmp.long.data$GRADE_PRIOR_1 <- sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 2), "_"), tail, 1)
tmp.long.data$GRADE_PRIOR_2 <- sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 2), "_"), tail, 1)
tmp.long.data$GRADE_PRIOR_3 <- sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[4]), "/"), '[', 2), "_"), tail, 1)

### SCALE_SCORE Prior
my.tmp.split.scale_score <- strsplit(tmp.long.data$SGP_NORM_GROUP_SCALE_SCORES, "; ")
tmp.long.data$SCALE_SCORE_PRIOR_1 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[2])
tmp.long.data$SCALE_SCORE_PRIOR_2 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[3])
tmp.long.data$SCALE_SCORE_PRIOR_3 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[4])

###  PERFORMANCE_LEVEL Prior

## Set name of GRADE to GRADE_CURRENT for all 4 prior var creations
setnames(tmp.long.data, "GRADE", "GRADE_CURRENT")

## Create the 1st Prior PERFORMANCE_LEVEL
setnames(tmp.long.data, c("SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "GRADE_PRIOR_1"), c("YEAR", "CONTENT_AREA", "GRADE"))
tmp.long.data <- SGP:::getAchievementLevel(tmp.long.data, state="GA", achievement.level.name="PERFORMANCE_LEVEL_PRIOR_1", scale.score.name="SCALE_SCORE_PRIOR_1")
setnames(tmp.long.data, c("YEAR", "CONTENT_AREA", "GRADE"), c("SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "GRADE_PRIOR_1"))

## Create the 2nd Prior PERFORMANCE_LEVEL
setnames(tmp.long.data, c("SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "GRADE_PRIOR_2"), c("YEAR", "CONTENT_AREA", "GRADE"))
tmp.long.data <- SGP:::getAchievementLevel(tmp.long.data, state="GA", achievement.level.name="PERFORMANCE_LEVEL_PRIOR_2", scale.score.name="SCALE_SCORE_PRIOR_2")
setnames(tmp.long.data, c("YEAR", "CONTENT_AREA", "GRADE"), c("SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "GRADE_PRIOR_2"))

## Create the 3rd Prior PERFORMANCE_LEVEL
setnames(tmp.long.data, c("SCHOOL_YEAR_PRIOR_3", "SUBJECT_CODE_PRIOR_3", "GRADE_PRIOR_3"), c("YEAR", "CONTENT_AREA", "GRADE"))
tmp.long.data <- SGP:::getAchievementLevel(tmp.long.data, state="GA", achievement.level.name="PERFORMANCE_LEVEL_PRIOR_3", scale.score.name="SCALE_SCORE_PRIOR_3")
setnames(tmp.long.data, c("YEAR", "CONTENT_AREA", "GRADE"), c("SCHOOL_YEAR_PRIOR_3", "SUBJECT_CODE_PRIOR_3", "GRADE_PRIOR_3"))

## Set name of GRADE_CURRENT back to GRADE
setnames(tmp.long.data, "GRADE_CURRENT", "GRADE")


### ADMINISTRATION_PERIOD_PRIOR_* Prior
tmp.admin.period <- Georgia_SGP@Data[, c(key(Georgia_SGP@Data)[1:4], "GRADE", "YEAR_WITHIN", "SCALE_SCORE"), with=FALSE][VALID_CASE=="VALID_CASE"]
setnames(tmp.admin.period, c("CONTENT_AREA", "YEAR", "GRADE", "ID", "YEAR_WITHIN", "SCALE_SCORE"),
         c("SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "GTID", "YEAR_WITHIN_PRIOR_1", "SCALE_SCORE_PRIOR_1"))
tmp.admin.period[, SCALE_SCORE_PRIOR_1 := as.character(SCALE_SCORE_PRIOR_1)]

head(tmp.admin.period)
nrow(tmp.admin.period)
summary(as.factor(tmp.admin.period$GRADE_PRIOR_1))
head(tmp.long.data)
summary(as.factor(tmp.admin.period$YEAR_WITHIN_PRIOR_1))

## Remove the "LAST_OBSERVATION" for within year repeaters that had the exact same score in both Admin Periods
setkeyv(tmp.admin.period, c("GTID", "SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "YEAR_WITHIN_PRIOR_1", "VALID_CASE"))
setkeyv(tmp.admin.period, c("GTID", "SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "VALID_CASE"))
tmp.admin.period <- tmp.admin.period[which(!duplicated(tmp.admin.period, by = key(tmp.admin.period)))]

setkeyv(tmp.long.data, c("GTID", "SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "VALID_CASE"))
tmp.long.data <- merge(tmp.long.data, tmp.admin.period, all.x=TRUE)

tmp.long.data[which(!is.na(GRADE_PRIOR_1) & (YEAR_WITHIN_PRIOR_1== 1)), ADMINISTRATION_PERIOD_PRIOR_1 := "1: WINTER"]
tmp.long.data[which(!is.na(GRADE_PRIOR_1) & (YEAR_WITHIN_PRIOR_1== 2)), ADMINISTRATION_PERIOD_PRIOR_1 := "2: SPRING"]
tmp.long.data[which(!is.na(GRADE_PRIOR_1) & (YEAR_WITHIN_PRIOR_1== 3)), ADMINISTRATION_PERIOD_PRIOR_1 := "3: SUMMER"]

table(tmp.long.data$ADMINISTRATION_PERIOD_PRIOR_1, tmp.long.data$ADMINISTRATION_PERIOD, tmp.long.data$SCHOOL_YEAR_PRIOR_1)

tmp.long.data[, paste("ADMINISTRATION_PERIOD_PRIOR", 2:3, sep="_") := as.character(NA)]

tmp.long.data[which(!is.na(GRADE_PRIOR_2)), ADMINISTRATION_PERIOD_PRIOR_2 := "2: SPRING"]
tmp.long.data[which(!is.na(GRADE_PRIOR_3)), ADMINISTRATION_PERIOD_PRIOR_3 := "2: SPRING"]
tmp.long.data$YEAR_WITHIN_PRIOR_1 <- NULL


###  ASSESSMENT_TYPE_PRIOR_*

tmp.long.data[, paste("ASSESSMENT_TYPE_PRIOR", 1:3, sep="_") := as.character(NA)]

tmp.long.data[which(SCHOOL_YEAR_PRIOR_1 %in% c('2015','2016') & GRADE_PRIOR_1=='EOCT'), ASSESSMENT_TYPE_PRIOR_1 := "EOC"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_1 %in% c('2015','2016') & GRADE_PRIOR_1 %in% c('3','4', '5','6','7','8')), ASSESSMENT_TYPE_PRIOR_1 := "EOG"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_1 %in% c('2012','2013','2014') & GRADE_PRIOR_1=='EOCT'), ASSESSMENT_TYPE_PRIOR_1 := "EOCT"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_1 %in% c('2012','2013','2014') & GRADE_PRIOR_1 %in% c('3','4', '5','6','7','8')), ASSESSMENT_TYPE_PRIOR_1 := "CRCT"]

tmp.long.data[which(SCHOOL_YEAR_PRIOR_2 %in% c('2015','2016') & GRADE_PRIOR_2=='EOCT'), ASSESSMENT_TYPE_PRIOR_2 := "EOC"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_2 %in% c('2015','2016') & GRADE_PRIOR_2 %in% c('3','4', '5','6','7','8')), ASSESSMENT_TYPE_PRIOR_2 := "EOG"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_2 %in% c('2012','2013','2014') & GRADE_PRIOR_2=='EOCT'), ASSESSMENT_TYPE_PRIOR_2 := "EOCT"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_2 %in% c('2012','2013','2014') & GRADE_PRIOR_2 %in% c('3','4', '5','6','7','8')), ASSESSMENT_TYPE_PRIOR_2 := "CRCT"]

tmp.long.data[which(SCHOOL_YEAR_PRIOR_3 %in% c('2015','2016') & GRADE_PRIOR_3=='EOCT'), ASSESSMENT_TYPE_PRIOR_3 := "EOC"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_3 %in% c('2015','2016') & GRADE_PRIOR_3 %in% c('3','4', '5','6','7','8')), ASSESSMENT_TYPE_PRIOR_3 := "EOG"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_3 %in% c('2012','2013','2014') & GRADE_PRIOR_3=='EOCT'), ASSESSMENT_TYPE_PRIOR_3 := "EOCT"]
tmp.long.data[which(SCHOOL_YEAR_PRIOR_3 %in% c('2012','2013','2014') & GRADE_PRIOR_3 %in% c('3','4', '5','6','7','8')), ASSESSMENT_TYPE_PRIOR_3 := "CRCT"]


### Add in CURRENT Projections
my.variable.names <- c("ID", "YEAR_WITHIN", "SGP_PROJECTION_GROUP", "LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT", "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT")
tmp.list.current <- list()

my.projection.table.names <- c(
          "ELA.2016", # "GRADE_9_LIT.2016", # ELA/Lit Projections with Milestones data only, so no Grade 9 Lit projections in 2016
          "MATHEMATICS.2016", "COORDINATE_ALGEBRA.2016",
          "SCIENCE.2016", "BIOLOGY.2016", "PHYSICAL_SCIENCE.2016",
          "SOCIAL_STUDIES.2016", "US_HISTORY.2016")
for (i in my.projection.table.names) {
	tmp.list.current[[i]] <- data.table(
			VALID_CASE="VALID_CASE",
			SUBJECT_CODE=unlist(strsplit(i, "\\."))[1],
			SCHOOL_YEAR=unlist(strsplit(i, "\\."))[2],
			# YEAR_WITHIN="2",
			Georgia_SGP@SGP$SGProjections[[i]][,my.variable.names, with=FALSE])
}

###  Merge projection/target data in.  Do this seperately so that 8th grade students get their prior merged in (no current target).
tmp.projections.c <- data.table(rbindlist(tmp.list.current), FIRST_OBSERVATION = 1L, key=c("ID", "SUBJECT_CODE"))

setnames(tmp.projections.c, "ID", "GTID")
setkeyv(tmp.projections.c, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN", "FIRST_OBSERVATION"))
setkeyv(tmp.long.data, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN", "FIRST_OBSERVATION"))

###   Need to keep multiple projections for SCIENCE and MATHEMATICS
Georgia_SGP_Data_LONG_2016_FORMATTED <- tmp.projections.c[tmp.long.data, allow.cartesian=TRUE]
setnames(Georgia_SGP_Data_LONG_2016_FORMATTED, "SGP_PROJECTION_GROUP", "SGP_PROJECTION_GROUP_CURRENT")

###  Final arrangement of variables
Georgia_SGP_Data_LONG_2016_FORMATTED <- Georgia_SGP_Data_LONG_2016_FORMATTED[, variables.to.output, with=FALSE]
setkeyv(Georgia_SGP_Data_LONG_2016_FORMATTED, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))


### Save results
###  GADOE
save(Georgia_SGP_Data_LONG_2016_FORMATTED, file="U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP_Data_LONG_2016_FORMATTED.Rdata")
fwrite(Georgia_SGP_Data_LONG_2016_FORMATTED, file="U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP_Data_LONG_2016_FORMATTED.txt", sep="|")
#zip(zipfile="U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP_Data_LONG_2016_FORMATTED.txt.zip", files="U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP_Data_LONG_2016_FORMATTED.txt")
#unlink("U:/DATA/SGP/Data/2016 SGPs/2016 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP_Data_LONG_2016_FORMATTED.txt")

###  CFA
save(Georgia_SGP_Data_LONG_2016_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2016_FORMATTED.Rdata")
fwrite(Georgia_SGP_Data_LONG_2016_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2016_FORMATTED.txt", sep="|")
zip(zipfile="Data/Georgia_SGP_Data_LONG_2016_FORMATTED.txt.zip", files="Data/Georgia_SGP_Data_LONG_2016_FORMATTED.txt")
unlink("Data/Georgia_SGP_Data_LONG_2016_FORMATTED.txt")
