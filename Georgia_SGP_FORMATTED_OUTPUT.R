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

variables.to.output <- c("VALID_CASE", "GTID", "SCHOOL_YEAR", "SUBJECT_CODE", "YEAR_WITHIN", "GRADE", "GRADE_REPORTED", "SCALE_SCORE", 
"FIRST_OBSERVATION", "LAST_OBSERVATION", "PERFORMANCE_LEVEL", "SR_SYSTEM_ID", "SCHOOL_NUMBER", "ADMIN_INVALIDATION", "ADMIN_TYPE", "MATCH_STATUS",
"RACE_CODE", "GENDER_CODE", "ED", "SWD", "LEP", "BIRTH_DATE", "LAST_NAME", "FIRST_NAME", "MIDDLE_NAME",
"SGP_NORM_GROUP", "SGP", "SGP_SIMEX", "SGP_LEVEL", "SGP_STANDARD_ERROR", "SGP_NORM_GROUP_SCALE_SCORES", 
"SGP_NORM_GROUP_BASELINE", "SGP_BASELINE", "SGP_SIMEX_BASELINE", "SGP_LEVEL_BASELINE", "SGP_NORM_GROUP_BASELINE_SCALE_SCORES",
"SCHOOL_YEAR_PRIOR_1", "SUBJECT_CODE_PRIOR_1", "SCALE_SCORE_PRIOR_1", "SCHOOL_YEAR_PRIOR_2", "SUBJECT_CODE_PRIOR_2", "SCALE_SCORE_PRIOR_2",
"SCHOOL_YEAR_PRIOR_3", "SUBJECT_CODE_PRIOR_3", "SCALE_SCORE_PRIOR_3", "SCHOOL_YEAR_PRIOR_4", "SUBJECT_CODE_PRIOR_4", "SCALE_SCORE_PRIOR_4",
"SGP_PROJECTION_GROUP_PRIOR", "SGP_PROJECTION_GROUP_CURRENT", "LEVEL_1_SGP_TARGET_YEAR_1_PRIOR", "LEVEL_2_SGP_TARGET_YEAR_1_PRIOR", 
"LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT", "P1_PROJ_YEAR_1_PRIOR", "P35_PROJ_YEAR_1_PRIOR", "P66_PROJ_YEAR_1_PRIOR", 
"P99_PROJ_YEAR_1_PRIOR", "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT")

### Subset out relevant variables
# setnames(Georgia_SGP_LONG_Data_2013, "DISTRICT_NUMBER", "SR_SYSTEM_ID") # AVI Fixed bug in SGPstateData variable names lookup for this.
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


### Get PRIOR Projections
### 2012 contains duplicates in math and reading, so remove those from Georgia_SGP@SGP$SGProjections first.

###  No longer need to run this.  Problem has been corrected and saved in the SGP object.

# dup.subjects <- c("READING", "MATHEMATICS", "SCIENCE")
# dup.var.names <- c("ID", "LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT")
# valid.var.names <- c("ID", "LEVEL_1_SGP_TARGET_YEAR_1", "LEVEL_2_SGP_TARGET_YEAR_1")

# for (n in dup.subjects) {
	# ### Find ALL duplicates
	# tmp.dups <- data.table(Georgia_SGP@SGP$SGProjections[[paste(n, ".2012.BASELINE", sep="")]][, dup.var.names], key="ID")
	# tmp.dups <- data.table(tmp.dups[c(which(duplicated(tmp.dups))-1, which(duplicated(tmp.dups)))], key="ID")
	
	# ### Narrow down dups to find which one is
	# tmp.valid <- data.table(Georgia_SGP@SGP$SGProjections[[paste(n, ".2013.LAGGED.BASELINE", sep="")]][, valid.var.names], key="ID")
	# tmp.valid <- tmp.dups[tmp.valid, allow.cartesian=TRUE]
	# tmp.valid <- data.table(tmp.valid[LEVEL_1_SGP_TARGET_YEAR_1_CURRENT==LEVEL_1_SGP_TARGET_YEAR_1 & LEVEL_2_SGP_TARGET_YEAR_1_CURRENT==LEVEL_2_SGP_TARGET_YEAR_1][, 
		# list(ID, LEVEL_1_SGP_TARGET_YEAR_1, LEVEL_2_SGP_TARGET_YEAR_1)], key="ID")
	
	# tmp.dups <- tmp.valid[data.table(Georgia_SGP@SGP$SGProjections[[paste(n, ".2012.BASELINE", sep="")]], key="ID")]
	# tmp.dups <- tmp.dups[is.na(LEVEL_1_SGP_TARGET_YEAR_1) | LEVEL_1_SGP_TARGET_YEAR_1_CURRENT == LEVEL_1_SGP_TARGET_YEAR_1]
	# Georgia_SGP@SGP$SGProjections[[paste(n, ".2012.BASELINE", sep="")]] <- data.frame(
		# tmp.dups[-c(which(duplicated(tmp.dups))-1, which(duplicated(tmp.dups)))])[, -(2:3)]
# }

tmp.list.prior <- list()
my.projection.table.names <- c("ELA.2012.BASELINE", "READING.2012.BASELINE", "GRADE_9_LIT.2012.BASELINE", "MATHEMATICS.2012.BASELINE", "SCIENCE.2012.BASELINE", "BIOLOGY.2012.BASELINE", "PHYSICAL_SCIENCE.2012.BASELINE")
##  No SOCIAL_STUDIES.2012.BASELINE - baselines came online in 2013.  Don't use cohort prior targets though (don't mix 2013 Baseline and 2012 cohort in same visualization - per weekly conversation 1/23/14)

my.variable.names <- c("ID", "YEAR_WITHIN", "SGP_PROJECTION_GROUP", "LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT", "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT")
for (i in my.projection.table.names) {
	tmp.list.prior[[i]] <- data.table(
			VALID_CASE="VALID_CASE",
			SUBJECT_CODE=unlist(strsplit(i, "\\."))[1],
			SCHOOL_YEAR="2013",
			# YEAR_WITHIN="2",
			Georgia_SGP@SGP$SGProjections[[i]][,my.variable.names])

	setnames(tmp.list.prior[[i]], c("LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT", "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT"), c("LEVEL_1_SGP_TARGET_YEAR_1_PRIOR", "LEVEL_2_SGP_TARGET_YEAR_1_PRIOR", "P1_PROJ_YEAR_1_PRIOR", "P35_PROJ_YEAR_1_PRIOR", "P66_PROJ_YEAR_1_PRIOR", "P99_PROJ_YEAR_1_PRIOR"))
}

### Add in CURRENT Projections

tmp.list.current <- list()
my.projection.table.names <- c("ELA.2013.BASELINE", "READING.2013.BASELINE", "GRADE_9_LIT.2013.BASELINE", "MATHEMATICS.2013.BASELINE", "SCIENCE.2013.BASELINE", "BIOLOGY.2013.BASELINE", "PHYSICAL_SCIENCE.2012.BASELINE", "SOCIAL_STUDIES.2013.BASELINE", "US_HISTORY.2013.BASELINE")
for (i in my.projection.table.names) {
	tmp.list.current[[i]] <- data.table(
			VALID_CASE="VALID_CASE",
			SUBJECT_CODE=unlist(strsplit(i, "\\."))[1],
			SCHOOL_YEAR=unlist(strsplit(i, "\\."))[2],
			# YEAR_WITHIN="2",
			Georgia_SGP@SGP$SGProjections[[i]][,my.variable.names])
}

###  Merge projection/target data in.  Do this seperately so that 8th grade students get their prior merged in (no current target).
tmp.projections.p <- data.table(rbindlist(tmp.list.prior), FIRST_OBSERVATION = 1L, key=c("ID", "SUBJECT_CODE"))
tmp.projections.c <- data.table(rbindlist(tmp.list.current), FIRST_OBSERVATION = 1L, key=c("ID", "SUBJECT_CODE"))

setnames(tmp.projections.p, "ID", "GTID")
setkeyv(tmp.projections.p, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN", "FIRST_OBSERVATION"))
setnames(tmp.projections.c, "ID", "GTID")
setkeyv(tmp.projections.c, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN", "FIRST_OBSERVATION"))
setkeyv(tmp.long.data, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN", "FIRST_OBSERVATION"))

###  Now need to keep SCIENCE's multiple projections
Georgia_SGP_Data_LONG_2013_FORMATTED <- tmp.projections.p[tmp.long.data, allow.cartesian=TRUE] #keep all CURRENT students (allow.cartesian=TRUE)
setnames(Georgia_SGP_Data_LONG_2013_FORMATTED, "SGP_PROJECTION_GROUP", "SGP_PROJECTION_GROUP_PRIOR")
setkeyv(Georgia_SGP_Data_LONG_2013_FORMATTED, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN", "FIRST_OBSERVATION"))
Georgia_SGP_Data_LONG_2013_FORMATTED <- tmp.projections.c[Georgia_SGP_Data_LONG_2013_FORMATTED, allow.cartesian=TRUE]
setnames(Georgia_SGP_Data_LONG_2013_FORMATTED, "SGP_PROJECTION_GROUP", "SGP_PROJECTION_GROUP_CURRENT")

###  Remove true duplicates from SCIENCE
setkeyv(Georgia_SGP_Data_LONG_2013_FORMATTED, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN", "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT"))

Georgia_SGP_Data_LONG_2013_FORMATTED <- Georgia_SGP_Data_LONG_2013_FORMATTED[!duplicated(Georgia_SGP_Data_LONG_2013_FORMATTED)][, variables.to.output, with=FALSE]
setkeyv(Georgia_SGP_Data_LONG_2013_FORMATTED, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))
# ##  Keep prior for 8th grade projections (projecting to Coordinate Algebra) cohort referenced because projection to coordinate Algebra is cohort referenced.
# Georgia_SGP@SGP$SGProjections[["MATHEMATICS.2012"]][["YEAR_WITHIN"]] <- "2"
# Georgia_SGP@SGP$SGProjections[["MATHEMATICS.2012"]][["SGP_PROJECTION_GROUP"]] <- "MATHEMATICS"

# tmp.projections.p.math <- data.table(
			# VALID_CASE="VALID_CASE",
			# SUBJECT_CODE="MATHEMATICS",
			# SCHOOL_YEAR="2013",
			# # YEAR_WITHIN="2",
			# Georgia_SGP@SGP$SGProjections[["MATHEMATICS.2012"]][,my.variable.names], key=c("ID", "SUBJECT_CODE"))

# setnames(tmp.projections.p.math, c("LEVEL_1_SGP_TARGET_YEAR_1_CURRENT", "LEVEL_2_SGP_TARGET_YEAR_1_CURRENT", "P1_PROJ_YEAR_1_CURRENT", "P35_PROJ_YEAR_1_CURRENT", "P66_PROJ_YEAR_1_CURRENT", "P99_PROJ_YEAR_1_CURRENT"), c("LEVEL_1_SGP_TARGET_YEAR_1_PRIOR", "LEVEL_2_SGP_TARGET_YEAR_1_PRIOR", "P1_PROJ_YEAR_1_PRIOR", "P35_PROJ_YEAR_1_PRIOR", "P66_PROJ_YEAR_1_PRIOR", "P99_PROJ_YEAR_1_PRIOR"))

# ### Add in CURRENT Projections
# tmp.projections.c.math <- data.table(
			# VALID_CASE="VALID_CASE",
			# SUBJECT_CODE="MATHEMATICS",
			# SCHOOL_YEAR="2013",
			# # YEAR_WITHIN="2",
			# Georgia_SGP@SGP$SGProjections[["MATHEMATICS.2013"]][,my.variable.names], key=c("ID", "SUBJECT_CODE"))

# setnames(tmp.projections.p.math, "ID", "GTID")
# setkeyv(tmp.projections.p.math, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))
# setnames(tmp.projections.c.math, "ID", "GTID")
# setkeyv(tmp.projections.c.math, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))

# Math_2013_FORMATTED <- tmp.projections.p.math[Georgia_SGP_Data_LONG_2013_FORMATTED[is.na(LEVEL_2_SGP_TARGET_YEAR_1_CURRENT) & SUBJECT_CODE == "MATHEMATICS"][, 
	# c(key(tmp.projections.p.math), setdiff(names(Georgia_SGP_Data_LONG_2013_FORMATTED),c(names(tmp.projections.p.math), my.variable.names))), with=FALSE]]
# Math_2013_FORMATTED <- tmp.projections.c.math[Math_2013_FORMATTED]

# Georgia_SGP_Data_LONG_2013_FORMATTED <- data.table(rbind(Math_2013_FORMATTED,
	# Georgia_SGP_Data_LONG_2013_FORMATTED[!(is.na(LEVEL_2_SGP_TARGET_YEAR_1_CURRENT) & SUBJECT_CODE == "MATHEMATICS")]), key = c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))

### Save results

save(Georgia_SGP_Data_LONG_2013_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2013_FORMATTED.Rdata")
write.table(Georgia_SGP_Data_LONG_2013_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2013_FORMATTED.txt", sep="|", row.names=FALSE, na="", quote=FALSE)
