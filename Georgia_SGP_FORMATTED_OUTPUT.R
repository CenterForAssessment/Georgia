######################################################################################
###
### Script to produce formatted text output for Georgia from annual long data
###
######################################################################################

### Load packages

require(SGP)
require(data.table)


### Load data

load("Data/Georgia_SGP.Rdata")
load("Data/Georgia_SGP_LONG_Data_2013.Rdata")


### Variables to output

variables.to.output <- c("VALID_CASE", "SCHOOL_YEAR", "SR_SYSTEM_ID", "SCHOOL_NUMBER", 
"SUBJECT_CODE", "GTID", "GRADE", "GRADE_REPORTED", "SCALE_SCORE", "PERFORMANCE_LEVEL", 
"SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "SCALE_SCORE_PRIOR_STANDARDIZED_1", "ACHIEVEMENT_LEVEL_PRIOR_1", 
"SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "SCALE_SCORE_PRIOR_2", "SCALE_SCORE_PRIOR_STANDARDIZED_2", "ACHIEVEMENT_LEVEL_PRIOR_2",
"SCHOOL_YEAR_PRIOR_3", "SUBJECT_CODE_PRIOR_3", "SCALE_SCORE_PRIOR_3", "SCALE_SCORE_PRIOR_STANDARDIZED_3", "ACHIEVEMENT_LEVEL_PRIOR_3",
"SCHOOL_YEAR_PRIOR_4", "SUBJECT_CODE_PRIOR_4", "SCALE_SCORE_PRIOR_4", "SCALE_SCORE_PRIOR_STANDARDIZED_4", "ACHIEVEMENT_LEVEL_PRIOR_4",
"RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", 
"SGP_NORM_GROUP", "SGP", "SGP_LEVEL", "SGP_STANDARD_ERROR", "SGP_NORM_GROUP_SCALE_SCORES", "SGP_NORM_GROUP_BASELINE", "SGP_BASELINE", "SGP_LEVEL_BASELINE", "SGP_NORM_GROUP_BASELINE_SCALE_SCORES",
"LEVEL_1_SGP_TARGET_YEAR_1", "LEVEL_2_SGP_TARGET_YEAR_1",
"P1_PROJ_YEAR_1", "P35_PROJ_YEAR_1", "P66_PROJ_YEAR_1", "P99_PROJ_YEAR_1", "ADMIN_INVALIDATION", "ADMIN_TYPE", "YEAR_WITHIN", "FIRST_OBSERVATION", "LAST_OBSERVATION", "MATCH_STATUS")


### Subset out relevant variables

tmp.long.data <- subset(Georgia_SGP_LONG_Data_2013, select=intersect(variables.to.output, names(Georgia_SGP_LONG_Data_2013)))


### Split SGP_NORM_GROUP_BASELINE
my.tmp.split <- strsplit(as.character(tmp.long.data$SGP_NORM_GROUP_BASELINE), "; ")


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


### SCALE_SCORE Prior
my.tmp.split.scale_score <- strsplit(tmp.long.data$SGP_NORM_GROUP_BASELINE_SCALE_SCORES, "; ")
tmp.long.data$SCALE_SCORE_PRIOR_1 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[2])
tmp.long.data$SCALE_SCORE_PRIOR_2 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[3])
tmp.long.data$SCALE_SCORE_PRIOR_3 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[4])
tmp.long.data$SCALE_SCORE_PRIOR_4 <- sapply(my.tmp.split.scale_score, function(x) rev(x)[5])


### Add in Projections

tmp.list <- list()
my.projection.table.names <- c("ELA.2013.BASELINE", "READING.2013.BASELINE", "MATHEMATICS.2013.BASELINE", "SCIENCE.2013.BASELINE", "SOCIAL_STUDIES.2013.BASELINE")
my.variable.names <- c("ID", "LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT", "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT")
for (i in my.projection.table.names) {
	tmp.list[[i]] <- data.table(
			VALID_CASE="VALID_CASE",
			SUBJECT_CODE=unlist(strsplit(i, "\\."))[1],
			SCHOOL_YEAR=unlist(strsplit(i, "\\."))[2],
			YEAR_WITHIN="2",
			Georgia_SGP@SGP$SGProjections[[i]][,my.variable.names])

}

tmp.projections <- rbindlist(tmp.list)
setnames(tmp.projections, "ID", "GTID")
setkeyv(tmp.projections, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))
setkeyv(tmp.long.data, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))

tmp.long.data.merged <- tmp.projections[tmp.long.data]


### Save results

Georgia_SGP_Data_LONG_2013_FORMATTED <- tmp.long.data.merged
save(Georgia_SGP_Data_LONG_2013_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2013_FORMATTED.Rdata")
write.table(Georgia_SGP_Data_LONG_2013_FORMATTED, file="Georgia_SGP_Data_LONG_2013_FORMATTED.txt", sep="|", row.names=FALSE, na="", quote=FALSE)
