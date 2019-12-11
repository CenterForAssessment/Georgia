#####################################################################################
###                                                                               ###
###    Script to produce formatted text output for Georgia from 2018 long data    ###
###                                                                               ###
#####################################################################################

require(data.table)

###   GA DOE
load("U:/DATA/SGP/Data/2018 SGPs/2018 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP_LONG_Data_2018.Rdata")
load("U:/DATA/SGP/Data/2018 SGPs/2018 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP.Rdata")

###   CFA/AVI
setwd('~/SGP_Projects/Georgia')
load("Data/Georgia_SGP.Rdata")
load("Data/Georgia_SGP_LONG_Data_2018.Rdata")

###   For EOC Analyses/Data:
# Georgia_SGP_LONG_Data_2018 <- Georgia_SGP_LONG_Data_2018[!SUBJECT_CODE %in% c("ELA", "MATHEMATICS")]
###


### Variables to output
variables.to.output <- c("VALID_CASE", "GTID", "SCHOOL_YEAR", "SUBJECT_CODE", "YEAR_WITHIN", "GRADE", "GRADE_REPORTED", "SCALE_SCORE", "SCALE_SCORE_PRIOR_STANDARDIZED",
                         "ADMINISTRATION_PERIOD", "FIRST_OBSERVATION", "LAST_OBSERVATION", "PERFORMANCE_LEVEL", "SR_SYSTEM_ID", "SYSTEM_NAME", "SR_SCHOOL_ID", "SCHOOL_NUMBER", "SCHOOL_NAME","ADMIN_INVALIDATION", "ADMIN_TYPE", "MATCH_STATUS",
                         "RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "GIFT", "BIRTH_DATE", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME",
                         "SGP_NORM_GROUP", "SGP", "SGP_SIMEX", "SGP_SIMEX_RANKED", "SGP_LEVEL", "SGP_STANDARD_ERROR", "SGP_NORM_GROUP_SCALE_SCORES", "SGP_NOTE",
                         "SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "PERFORMANCE_LEVEL_PRIOR_1", "GRADE_PRIOR_1", "ADMINISTRATION_PERIOD_PRIOR_1", "ASSESSMENT_TYPE_PRIOR_1",
                         "SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "SCALE_SCORE_PRIOR_2", "PERFORMANCE_LEVEL_PRIOR_2", "GRADE_PRIOR_2", "ADMINISTRATION_PERIOD_PRIOR_2", "ASSESSMENT_TYPE_PRIOR_2",
                         "SGP_PROJECTION_GROUP_CURRENT", "LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_3_SGP_TARGET_YEAR_1_CURRENT",
                         "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT")

### Subset out relevant variables
tmp.long.data <- subset(Georgia_SGP_LONG_Data_2018, select=intersect(variables.to.output, names(Georgia_SGP_LONG_Data_2018)))

### Split SGP_NORM_GROUP
my.tmp.split <- strsplit(as.character(tmp.long.data$SGP_NORM_GROUP), "; ")

### YEAR Prior
tmp.long.data$SCHOOL_YEAR_PRIOR_1 <- sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 1)
tmp.long.data$SCHOOL_YEAR_PRIOR_2 <- sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 1)

### SUBJECT_CODE Prior
tmp.long.data$SUBJECT_CODE_PRIOR_1 <- sapply(sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")
tmp.long.data$SUBJECT_CODE_PRIOR_2 <- sapply(sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")

### GRADE Prior
tmp.long.data$GRADE_PRIOR_1 <- sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 2), "_"), tail, 1)
tmp.long.data$GRADE_PRIOR_2 <- sapply(strsplit(sapply(strsplit(sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 2), "_"), tail, 1)

### SCALE_SCORE Prior
my.tmp.split.scale_score <- strsplit(tmp.long.data$SGP_NORM_GROUP_SCALE_SCORES, "; ")
tmp.long.data$SCALE_SCORE_PRIOR_1 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[2])
tmp.long.data$SCALE_SCORE_PRIOR_2 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[3])

###  PERFORMANCE_LEVEL Prior

## Set name of GRADE to GRADE_CURRENT for both prior var creations
setnames(tmp.long.data, "GRADE", "GRADE_CURRENT")

## Create the 1st Prior PERFORMANCE_LEVEL
setnames(tmp.long.data, c("SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "GRADE_PRIOR_1"), c("YEAR", "CONTENT_AREA", "GRADE"))
tmp.long.data <- SGP:::getAchievementLevel(tmp.long.data, state="GA", achievement.level.name="PERFORMANCE_LEVEL_PRIOR_1", scale.score.name="SCALE_SCORE_PRIOR_1")
setnames(tmp.long.data, c("YEAR", "CONTENT_AREA", "GRADE"), c("SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "GRADE_PRIOR_1"))

## Create the 2nd Prior PERFORMANCE_LEVEL
setnames(tmp.long.data, c("SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "GRADE_PRIOR_2"), c("YEAR", "CONTENT_AREA", "GRADE"))
tmp.long.data <- SGP:::getAchievementLevel(tmp.long.data, state="GA", achievement.level.name="PERFORMANCE_LEVEL_PRIOR_2", scale.score.name="SCALE_SCORE_PRIOR_2")
setnames(tmp.long.data, c("YEAR", "CONTENT_AREA", "GRADE"), c("SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "GRADE_PRIOR_2"))

## Set name of GRADE_CURRENT back to GRADE
setnames(tmp.long.data, "GRADE_CURRENT", "GRADE")


### ADMINISTRATION_PERIOD_PRIOR_* Prior
tmp.admin.period <- Georgia_SGP@Data[, c(key(Georgia_SGP@Data), "SCALE_SCORE"), with=FALSE][VALID_CASE=="VALID_CASE"]
setnames(tmp.admin.period, c("CONTENT_AREA", "YEAR", "GRADE", "ID", "YEAR_WITHIN", "SCALE_SCORE"),
         c("SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "GTID", "YEAR_WITHIN_PRIOR_1", "SCALE_SCORE_PRIOR_1"))
tmp.admin.period[, SCALE_SCORE_PRIOR_1 := as.character(SCALE_SCORE_PRIOR_1)]

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

tmp.long.data[, ADMINISTRATION_PERIOD_PRIOR_2 := as.character(NA)]
tmp.long.data[which(!is.na(GRADE_PRIOR_2)), ADMINISTRATION_PERIOD_PRIOR_2 := "2: SPRING"]
tmp.long.data[, YEAR_WITHIN_PRIOR_1 := NULL]


###  ASSESSMENT_TYPE_PRIOR_*

tmp.long.data[, paste("ASSESSMENT_TYPE_PRIOR", 1:2, sep="_") := as.character(NA)]

table(tmp.long.data[, SCHOOL_YEAR_PRIOR_1, GRADE_PRIOR_1], exclude=NULL) #  All Milestones test years
tmp.long.data[which(GRADE_PRIOR_1=='EOCT'), ASSESSMENT_TYPE_PRIOR_1 := "EOC"]
tmp.long.data[which(GRADE_PRIOR_1 %in% c('3','4', '5','6','7','8')), ASSESSMENT_TYPE_PRIOR_1 := "EOG"]
table(tmp.long.data[, ASSESSMENT_TYPE_PRIOR_1, SCHOOL_YEAR_PRIOR_1], exclude=NULL) # All priors from current year (block/repeaters) should be EOC
table(tmp.long.data[, ASSESSMENT_TYPE_PRIOR_1, SUBJECT_CODE_PRIOR_1], exclude=NULL) # Subjects should line up as expected

table(tmp.long.data[, SCHOOL_YEAR_PRIOR_2, GRADE_PRIOR_2], exclude=NULL) #  All Milestones test years (CRCT has now sunset)
# tmp.long.data[which(GRADE_PRIOR_2=='EOCT'), ASSESSMENT_TYPE_PRIOR_2 := "EOC"] # None -- all EOGs
tmp.long.data[which(GRADE_PRIOR_2 %in% c('3','4', '5','6','7','8')), ASSESSMENT_TYPE_PRIOR_2 := "EOG"]
table(tmp.long.data[, ASSESSMENT_TYPE_PRIOR_2, SCHOOL_YEAR_PRIOR_2], exclude=NULL) # All priors should be EOG Math/ELA
table(tmp.long.data[, ASSESSMENT_TYPE_PRIOR_2, SUBJECT_CODE_PRIOR_2], exclude=NULL)


####
###  Add in CURRENT Projections
####

my.variable.names <- c("ID", "YEAR_WITHIN", "GRADE", "SGP_PROJECTION_GROUP",
                       "LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_3_SGP_TARGET_YEAR_1_CURRENT",
                       "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT")

tmp.list.current <- list()

my.projection.table.names <- c(
          "ELA.2018", "MATHEMATICS.2018", #  EOG
          "GRADE_9_LIT.2018", "COORDINATE_ALGEBRA.2018", "ALGEBRA_I.2018")  #  EOC
for (i in my.projection.table.names) {
  setnames(Georgia_SGP@SGP$SGProjections[[i]], gsub("_CURRENT_CURRENT", "_CURRENT", names(Georgia_SGP@SGP$SGProjections[[i]])))
  if ("YEAR_WITHIN_CURRENT" %in% names(Georgia_SGP@SGP$SGProjections[[i]])) setnames(Georgia_SGP@SGP$SGProjections[[i]], "YEAR_WITHIN_CURRENT", "YEAR_WITHIN")
	tmp.list.current[[i]] <- data.table(
			VALID_CASE="VALID_CASE",
			SUBJECT_CODE=unlist(strsplit(i, "\\."))[1],
			SCHOOL_YEAR=unlist(strsplit(i, "\\."))[2],
			Georgia_SGP@SGP$SGProjections[[i]][, my.variable.names, with=FALSE])
}

###  Merge projection/target data in.  Do this seperately so that 8th grade students get their prior merged in (no current target).
tmp.projections.c <- data.table(rbindlist(tmp.list.current), key=c("ID", "SUBJECT_CODE")) ## Remove the "FIRST_OBSERVATION" for within year repeaters

setnames(tmp.projections.c, "ID", "GTID")
setkeyv(tmp.projections.c, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN", "GRADE")) ## Remove the "FIRST_OBSERVATION" for within year repeaters
setkeyv(tmp.long.data, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN", "GRADE"))

###   Need to keep multiple projections for MATHEMATICS (allow.cartesian=TRUE)
Georgia_SGP_Data_LONG_2018_FORMATTED <- tmp.projections.c[tmp.long.data, allow.cartesian=TRUE]
setnames(Georgia_SGP_Data_LONG_2018_FORMATTED, "SGP_PROJECTION_GROUP", "SGP_PROJECTION_GROUP_CURRENT")


###  Final arrangement of variables
Georgia_SGP_Data_LONG_2018_FORMATTED <- Georgia_SGP_Data_LONG_2018_FORMATTED[, variables.to.output, with=FALSE]

setnames(Georgia_SGP_Data_LONG_2018_FORMATTED, c("LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_3_SGP_TARGET_YEAR_1_CURRENT"),
    c("DEVELOPING_SGP_TARGET_YEAR_1_CURRENT",  "PROFICIENT_SGP_TARGET_YEAR_1_CURRENT", "DISTINGUISHED_SGP_TARGET_YEAR_1_CURRENT")) # Developing, Proficient and Distinguished instead of Level 1-3 -- Qi, 8/13/18

setkeyv(Georgia_SGP_Data_LONG_2018_FORMATTED, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))


###   Add a SGP_Final to accommondate bussiness rule to eliminate (SGP - SGP_SIMEX_RANKED) greater than 20
###   99 assigned to HOSS scores automatically now through SGPstateData `sgp.loss.hoss.adjustment` element.

dim(Georgia_SGP_Data_LONG_2018_FORMATTED[which(abs(SGP-SGP_SIMEX_RANKED) > 20), ]) #  9 EOG / 137 EOC students in prelim 2018
Georgia_SGP_Data_LONG_2018_FORMATTED[which(abs(SGP-SGP_SIMEX_RANKED) <= 20), SGP_Final := SGP_SIMEX_RANKED]


###   Save results

##    GADOE
save(Georgia_SGP_Data_LONG_2018_FORMATTED, file="U:/DATA/SGP/Data/2018 SGPs/2018 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP_Data_LONG_2018_FORMATTED.Rdata")
fwrite(Georgia_SGP_Data_LONG_2018_FORMATTED, file="U:/DATA/SGP/Data/2018 SGPs/2018 SGP Calculation/Working Directory_QQ/Data/Georgia_SGP_Data_LONG_2018_FORMATTED.txt", sep="|")

##    CFA

#   Change the file name appendix to -EOG or -EOC depending on what is being formatted (Removed when EOC/EOG combined with updated SGP_STANDARD_ERROR)
save(Georgia_SGP_Data_LONG_2018_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2018_FORMATTED.Rdata")
fwrite(Georgia_SGP_Data_LONG_2018_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2018_FORMATTED.txt", sep="|")
zip(zipfile="Data/Georgia_SGP_Data_LONG_2018_FORMATTED.txt.zip", files="Data/Georgia_SGP_Data_LONG_2018_FORMATTED.txt")
unlink("Data/Georgia_SGP_Data_LONG_2018_FORMATTED.txt")
