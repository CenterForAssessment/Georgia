#####################################################################################
###                                                                               ###
###        Prepare and format the 2021 EOG and EOC Georgia Milestones data        ###
###                                                                               ###
#####################################################################################

### Load required packages
require(data.table)

#####
###		Load 2021 Raw Data
#####

###   EOG Full Enrollment Data
GA_EOG_All_Enroll <- fread("./Data/Base_Files/2021_Final_Data/ElemetantaryMiddle_Student_Extract_Final_v2.txt",  header = TRUE, sep = "|", colClasses=rep("character", 17))
#  EOG: Test Window Enrollee = Y & Part-time SWD Flag = N & GAA status/GAA flag = N (per Adrienne W email 9/8/21)
GA_EOG_All_Enroll <- GA_EOG_All_Enroll[STUDENT_GRADE_LEVEL %in% paste0("0", 3:8) & GAA_FLAG == "N"] # Remove all kids that should take the Alternate Assessment (and irrelevant GRADE levels)
GA_EOG_All_Enroll[, ENROLLED := ifelse(TEST_WINDOW_ENROLLEE == "Y" & SWD_PART_TIME == "N", 1, 0)] # All SWD_PART_TIME = "N"

GA_EOG_All_Enroll[, c("TEST_WINDOW_ENROLLEE", "ACCESS_TEST_WINDOW_ENROLLEE", "GAA_FLAG", "SWD_PART_TIME") := NULL]
GA_EOG_All_Enroll[, GRADE := gsub("0", "", STUDENT_GRADE_LEVEL)]

###   EOC Full Enrollment Data
GA_EOC_All_Enroll <- fread("./Data/Base_Files/2021_Final_Data/MiddleHigh_Student_CourseEnroll_Extract_Final.txt",  header = TRUE, sep = "|", colClasses=rep("character", 18))
setnames(GA_EOC_All_Enroll, "ASSESSMENT_SUBJECT_CODE", "SUBJECT_CODE")
#  EOC: Course Enrolled = Y & Part-time SWD Flag = N & GAA status/GAA flag = N (per Adrienne W email 9/8/21)
GA_EOC_All_Enroll <- GA_EOC_All_Enroll[SUBJECT_CODE %in% c("Alg", "Ame") & GAA_FLAG == "N"] # Remove all kids that should take the Alternate Assessment (and irrelevant GRADE levels)
GA_EOC_All_Enroll[, ENROLLED := ifelse(COURSE_ENROLLED == "Y" & SWD_PART_TIME == "N", 1, 0)] # All ENROLLED = 1 after filter above
GA_EOC_All_Enroll[SUBJECT_CODE == "Alg", SUBJECT_CODE := "ALGEBRA_I"]
GA_EOC_All_Enroll[SUBJECT_CODE == "Ame", SUBJECT_CODE := "AMERICAN_LIT"]

GA_EOC_All_Enroll[, c("COURSE_GRADE", "COURSE_ENROLLED", "GAA_FLAG", "SWD_PART_TIME") := NULL]
GA_EOC_All_Enroll[, GRADE := "EOCT"]

GA_All_Enroll_2021 <- rbindlist(list(
    copy(GA_EOG_All_Enroll)[, SUBJECT_CODE := "ELA"],
    copy(GA_EOG_All_Enroll)[, SUBJECT_CODE := "MATHEMATICS"],
    GA_EOC_All_Enroll), fill=TRUE, use.names=TRUE)

GA_All_Enroll_2021[, SCHOOL_ENROLLMENT_STATUS := factor(ENROLLED, levels=0:1, labels=c("Enrolled School: No", "Enrolled School: Yes"))]
GA_All_Enroll_2021[, DISTRICT_ENROLLMENT_STATUS := factor(ENROLLED, levels=0:1, labels=c("Enrolled District: No", "Enrolled District: Yes"))]
GA_All_Enroll_2021[, STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled District: No", "Enrolled District: Yes"))]
GA_All_Enroll_2021[, ENROLLED := NULL]

table(GA_All_Enroll_2021[, RACE_CODE])
GA_All_Enroll_2021[, RACE_CODE := factor(RACE_CODE)]
setattr(GA_All_Enroll_2021$RACE_CODE, "levels", c("African-American/Black", "Hispanic",
  "American Indian/Alaskan Native", "Two or More Races", "Pacific Islander", "Asian", "White"))
GA_All_Enroll_2021[, RACE_CODE := as.character(RACE_CODE)]

table(GA_All_Enroll_2021[, GENDER_CODE])
GA_All_Enroll_2021[, GENDER_CODE := ifelse(GENDER_CODE == "M", "Male", "Female")]

table(GA_All_Enroll_2021[, ED])
GA_All_Enroll_2021[, ED := ifelse(ED == "N", "Economically Disadvantaged: No", "Economically Disadvantaged: Yes")]

table(GA_All_Enroll_2021[, LEP])
GA_All_Enroll_2021[, LEP := ifelse(LEP == "N", "LEP: No", "LEP: Yes")]

table(GA_All_Enroll_2021[, SWD])
GA_All_Enroll_2021[, SWD := ifelse(SWD == "N", "Student with Disability: No", "Student with Disability: Yes")]

setnames(GA_All_Enroll_2021, gsub("STUDENT_", "", names(GA_All_Enroll_2021)))
setnames(GA_All_Enroll_2021, c("GRADE_LEVEL", "SYSTEM_ID", "SCHOOL_ID"), c("GRADE_REPORTED", "SR_SYSTEM_ID", "SR_SCHOOL_ID"))

##    Fill in a few other variables that will be needed at some point
GA_All_Enroll_2021[, YEAR_WITHIN := "2"]
GA_All_Enroll_2021[, VALID_CASE := "VALID_CASE"] # Mark all as VALID_CASE for now

GA_All_Enroll_2021[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
GA_All_Enroll_2021[which(as.numeric(SR_SYSTEM_ID) > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
GA_All_Enroll_2021[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]


###   EOG Data
Georgia_Data_LONG_2021_EOG <- fread("./Data/Base_Files/2021_Final_Data/EOG_ELA_MATH_Combined_2021_NCIEA.csv", colClasses=rep("character", 29))

###   EOC Data
Georgia_Data_LONG_2021_EOC <- fread("./Data/Base_Files/2021_Final_Data/EOC_2021_NCIEA.csv",  colClasses=rep("character", 28))

Georgia_Data_LONG_2021 <- rbindlist(list(Georgia_Data_LONG_2021_EOG, Georgia_Data_LONG_2021_EOC), fill=TRUE, use.names = TRUE)
setnames(Georgia_Data_LONG_2021, toupper(names(Georgia_Data_LONG_2021)))

#####
###   Tidy up data
#####

Georgia_Data_LONG_2021[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
Georgia_Data_LONG_2021[which(as.numeric(SR_SYSTEM_ID) > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2021[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2021[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2021[, CONDSEM := as.numeric(CONDSEM)]

Georgia_Data_LONG_2021[, GRADE := gsub("0", "", GRADE)]

Georgia_Data_LONG_2021[PERFORMANCE_LEVEL=="", PERFORMANCE_LEVEL := NA] # Avoid NOTE in prepareSGP / checkSGP ##  PRELIM CODE  ##
Georgia_Data_LONG_2021[, PERFORMANCE_LEVEL := as.factor(PERFORMANCE_LEVEL)]
setattr(Georgia_Data_LONG_2021$PERFORMANCE_LEVEL, "levels", c("Beginning Learner", "Developing Learner", "Distinguished Learner", "Proficient Learner"))
Georgia_Data_LONG_2021[, PERFORMANCE_LEVEL := as.character(PERFORMANCE_LEVEL)]

table(Georgia_Data_LONG_2021[, PERFORMANCE_LEVEL, is.na(SCALE_SCORE)], exclude=NULL)  #  All NA scores are NA PERFORMANCE_LEVEL
table(Georgia_Data_LONG_2021[, VALID_CASE, is.na(SCALE_SCORE)], exclude=NULL)  #  All NA scores are INVALID_CASEs

Georgia_Data_LONG_2021[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, toupper(ADMINISTRATION_PERIOD), sep=": ")]
Georgia_Data_LONG_2021[ADMINISTRATION_PERIOD=="2: NA", ADMINISTRATION_PERIOD := NA]

Georgia_Data_LONG_2021[, SCHOOL_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled School: No", "Enrolled School: Yes"))]
Georgia_Data_LONG_2021[, DISTRICT_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled District: No", "Enrolled District: Yes"))]
Georgia_Data_LONG_2021[, STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled State: No", "Enrolled State: Yes"))]

###   Invalidate duplicates (No duplicate cases in 2021 prelim data --  Only INVALID_CASE dups)
# setkey(Georgia_Data_LONG_2021, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID, SCALE_SCORE)
# setkey(Georgia_Data_LONG_2021, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
# sum(duplicated(Georgia_Data_LONG_2021[VALID_CASE != "INVALID_CASE"], by=key(Georgia_Data_LONG_2021))) # XXX duplicates with valid GTIDs - (((take the highest score if any exist)))
# dups <- data.table(Georgia_Data_LONG_2021[unique(c(which(duplicated(Georgia_Data_LONG_2021, by=key(Georgia_Data_LONG_2021)))-1, which(duplicated(Georgia_Data_LONG_2021, by=key(Georgia_Data_LONG_2021))))), ], key=key(Georgia_Data_LONG_2021))
# Georgia_Data_LONG_2021[which(duplicated(Georgia_Data_LONG_2021, by=key(Georgia_Data_LONG_2021)))-1, VALID_CASE := "INVALID_CASE"]

setkey(Georgia_Data_LONG_2021, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
setkey(GA_All_Enroll_2021, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)

GA_MISSING_2021 <- GA_All_Enroll_2021[!Georgia_Data_LONG_2021]
GA_MISSING_2021[, VALID_CASE := "MISSING"]

Georgia_Data_LONG_2021[is.na(SCALE_SCORE), VALID_CASE := "MISSING"]

setkey(Georgia_Data_LONG_2021, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
setkey(GA_MISSING_2021, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)

GA_MISSING_2021 <- GA_MISSING_2021[!Georgia_Data_LONG_2021]
GA_MISSING_2021[, VALID_CASE := "INVALID_CASE"]
Georgia_Data_LONG_2021[is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"]

Georgia_Data_LONG_2021 <- rbindlist(list(Georgia_Data_LONG_2021, GA_MISSING_2021), fill=TRUE, use.names = TRUE)
setkey(Georgia_Data_LONG_2021, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)

### Save results
save(Georgia_Data_LONG_2021, file="./Data/Georgia_Data_LONG_2021.Rdata")
