#####################################################################################
###                                                                               ###
###        Prepare and format the 2022 EOG and EOC Georgia Milestones data        ###
###                                                                               ###
#####################################################################################

### Load required packages
require(data.table)

#####
###		Load 2022 Raw Data
#####

###   EOG Full Enrollment Data
GA_EOG_All_Enroll <-
  fread(file = "./Data/Base_Files/2022_Final_Data/ElemetantaryMiddle_Student_Extract_Final_v2.txt",
        header = TRUE, sep = "|", colClasses = rep("character", 17))

#  EOG: Test Window Enrollee = Y & Part-time SWD Flag = N & GAA status/GAA flag = N (per Adrienne W email 9/8/21)
# Remove all kids that should take the Alternate Assessment (and irrelevant GRADE levels)
GA_EOG_All_Enroll <-
  GA_EOG_All_Enroll[STUDENT_GRADE_LEVEL %in% paste0("0", 3:8) & GAA_FLAG == "N"]
GA_EOG_All_Enroll[, ENROLLED := ifelse(TEST_WINDOW_ENROLLEE == "Y" & SWD_PART_TIME == "N", 1, 0)] # All SWD_PART_TIME = "N"

GA_EOG_All_Enroll[, c("TEST_WINDOW_ENROLLEE", "ACCESS_TEST_WINDOW_ENROLLEE", "GAA_FLAG", "SWD_PART_TIME") := NULL]
GA_EOG_All_Enroll[, GRADE := gsub("0", "", STUDENT_GRADE_LEVEL)]

###   EOC Full Enrollment Data
GA_EOC_All_Enroll <-
  fread(file = "./Data/Base_Files/2022_Final_Data/MiddleHigh_Student_CourseEnroll_Extract_Final.txt",
        header = TRUE, sep = "|", colClasses = rep("character", 18))
setnames(GA_EOC_All_Enroll, "ASSESSMENT_SUBJECT_CODE", "SUBJECT_CODE")

#  EOC: Course Enrolled = Y & Part-time SWD Flag = N & GAA status/GAA flag = N (per Adrienne W email 9/8/21)
# Remove all kids that should take the Alternate Assessment (and irrelevant GRADE levels)
GA_EOC_All_Enroll <-
  GA_EOC_All_Enroll[SUBJECT_CODE %in% c("Alg", "Ame") & GAA_FLAG == "N"]
GA_EOC_All_Enroll[, ENROLLED :=
                      ifelse(COURSE_ENROLLED == "Y" & SWD_PART_TIME == "N", 1, 0)]
GA_EOC_All_Enroll[SUBJECT_CODE == "Alg", SUBJECT_CODE := "ALGEBRA_I"]
GA_EOC_All_Enroll[SUBJECT_CODE == "Ame", SUBJECT_CODE := "AMERICAN_LIT"]

GA_EOC_All_Enroll[, c("COURSE_GRADE", "COURSE_ENROLLED", "GAA_FLAG", "SWD_PART_TIME") := NULL]
GA_EOC_All_Enroll[, GRADE := "EOCT"]

GA_All_Enroll_2022 <- rbindlist(list(
    copy(GA_EOG_All_Enroll)[, SUBJECT_CODE := "ELA"],
    copy(GA_EOG_All_Enroll)[, SUBJECT_CODE := "MATHEMATICS"],
    GA_EOC_All_Enroll), fill = TRUE, use.names = TRUE)

GA_All_Enroll_2022[, SCHOOL_ENROLLMENT_STATUS :=
                       factor(ENROLLED, levels = 0:1,
                              labels = c("Enrolled School: No", "Enrolled School: Yes"))]
GA_All_Enroll_2022[, DISTRICT_ENROLLMENT_STATUS :=
                       factor(ENROLLED, levels = 0:1,
                              labels = c("Enrolled District: No", "Enrolled District: Yes"))]
GA_All_Enroll_2022[, STATE_ENROLLMENT_STATUS :=
                       factor(1, levels = 0:1,
                              labels = c("Enrolled District: No", "Enrolled District: Yes"))]
GA_All_Enroll_2022[, ENROLLED := NULL]

table(GA_All_Enroll_2022[, RACE_CODE])
GA_All_Enroll_2022[, RACE_CODE := factor(RACE_CODE)]
setattr(GA_All_Enroll_2022$RACE_CODE, "levels", c("African-American/Black", "Hispanic",
  "American Indian/Alaskan Native", "Two or More Races", "Pacific Islander", "Asian", "White"))
GA_All_Enroll_2022[, RACE_CODE := as.character(RACE_CODE)]

table(GA_All_Enroll_2022[, GENDER_CODE])
GA_All_Enroll_2022[, GENDER_CODE := ifelse(GENDER_CODE == "M", "Male", "Female")]

table(GA_All_Enroll_2022[, ED])
GA_All_Enroll_2022[, ED := ifelse(ED == "N",
                                  "Economically Disadvantaged: No", "Economically Disadvantaged: Yes")]

table(GA_All_Enroll_2022[, LEP])
GA_All_Enroll_2022[, LEP := ifelse(LEP == "N", "LEP: No", "LEP: Yes")]

table(GA_All_Enroll_2022[, SWD])
GA_All_Enroll_2022[, SWD := ifelse(SWD == "N", "Student with Disability: No", "Student with Disability: Yes")]

setnames(GA_All_Enroll_2022, gsub("STUDENT_", "", names(GA_All_Enroll_2022)))
setnames(GA_All_Enroll_2022,
         c("GRADE_LEVEL", "SYSTEM_ID", "SCHOOL_ID"),
         c("GRADE_REPORTED", "SR_SYSTEM_ID", "SR_SCHOOL_ID"))

##    Fill in a few other variables that will be needed at some point
GA_All_Enroll_2022[, YEAR_WITHIN := "2"]
GA_All_Enroll_2022[, VALID_CASE := "VALID_CASE"] # Mark all as VALID_CASE for now

GA_All_Enroll_2022[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
GA_All_Enroll_2022[which(as.numeric(SR_SYSTEM_ID) > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
GA_All_Enroll_2022[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]


###   EOG Data
Georgia_Data_LONG_2022_EOG <-
  fread(file = "./Data/Base_Files/2022_Final_Data/EOG_ELA_MATH_Combined_2022_NCIEA.csv",
        colClasses = rep("character", 29))

###   EOC Data
Georgia_Data_LONG_2022_EOC <-
  fread(file = "./Data/Base_Files/2022_Final_Data/EOC_2022_NCIEA.csv", colClasses = rep("character", 28))

Georgia_Data_LONG_2022 <-
  rbindlist(list(Georgia_Data_LONG_2022_EOG, Georgia_Data_LONG_2022_EOC),
            fill = TRUE, use.names = TRUE)
setnames(Georgia_Data_LONG_2022, toupper(names(Georgia_Data_LONG_2022)))

#####
###   Tidy up data
#####

Georgia_Data_LONG_2022[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
Georgia_Data_LONG_2022[which(as.numeric(SR_SYSTEM_ID) > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2022[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2022[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2022[, CONDSEM := as.numeric(CONDSEM)]

Georgia_Data_LONG_2022[, GRADE := gsub("0", "", GRADE)]

Georgia_Data_LONG_2022[PERFORMANCE_LEVEL == "", PERFORMANCE_LEVEL := NA] # Avoid NOTE in prepareSGP / checkSGP ##  PRELIM CODE  ##
Georgia_Data_LONG_2022[, PERFORMANCE_LEVEL := as.factor(PERFORMANCE_LEVEL)]
setattr(Georgia_Data_LONG_2022$PERFORMANCE_LEVEL, "levels",
       c("Beginning Learner", "Developing Learner", "Distinguished Learner", "Proficient Learner"))
Georgia_Data_LONG_2022[, PERFORMANCE_LEVEL := as.character(PERFORMANCE_LEVEL)]

table(Georgia_Data_LONG_2022[, PERFORMANCE_LEVEL, is.na(SCALE_SCORE)], exclude = NULL)  #  All NA scores are NA PERFORMANCE_LEVEL
table(Georgia_Data_LONG_2022[, VALID_CASE, is.na(SCALE_SCORE)], exclude = NULL)  #  All NA scores are INVALID_CASEs

Georgia_Data_LONG_2022[, ADMINISTRATION_PERIOD :=
                           paste(YEAR_WITHIN, toupper(ADMINISTRATION_PERIOD), sep = ": ")]
Georgia_Data_LONG_2022[ADMINISTRATION_PERIOD == "2: NA", ADMINISTRATION_PERIOD := NA]

Georgia_Data_LONG_2022[, SCHOOL_ENROLLMENT_STATUS :=
                           factor(1, levels = 0:1,
                                  labels = c("Enrolled School: No", "Enrolled School: Yes"))]
Georgia_Data_LONG_2022[, DISTRICT_ENROLLMENT_STATUS :=
                           factor(1, levels = 0:1,
                                  labels = c("Enrolled District: No", "Enrolled District: Yes"))]
Georgia_Data_LONG_2022[, STATE_ENROLLMENT_STATUS :=
                           factor(1, levels = 0:1,
                                  labels = c("Enrolled State: No", "Enrolled State: Yes"))]

###   Invalidate duplicates (Usually no duplicate cases in Georgia data --  Only INVALID_CASE dups)
setkey(Georgia_Data_LONG_2022, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID, SCALE_SCORE)
setkey(Georgia_Data_LONG_2022, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
dupl <- duplicated(Georgia_Data_LONG_2022, by = key(Georgia_Data_LONG_2022))
sum(dupl) # XXX duplicates with valid GTIDs - (((take the highest score if any exist)))
dups <- data.table(Georgia_Data_LONG_2022[unique(c(which(dupl) - 1, which(dupl))), ],
                   key = key(Georgia_Data_LONG_2022))
Georgia_Data_LONG_2022[which(dupl) - 1, VALID_CASE := "INVALID_CASE"]


###   Merge in the missing data (from above) and sort out students that were ACTUALLY missing
setkey(Georgia_Data_LONG_2022, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
setkey(GA_All_Enroll_2022, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)

GA_MISSING_2022 <- GA_All_Enroll_2022[!Georgia_Data_LONG_2022]
GA_MISSING_2022[, VALID_CASE := "MISSING"]

Georgia_Data_LONG_2022[is.na(SCALE_SCORE), VALID_CASE := "MISSING"]

setkey(Georgia_Data_LONG_2022, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
setkey(GA_MISSING_2022, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)

GA_MISSING_2022 <- GA_MISSING_2022[!Georgia_Data_LONG_2022]
GA_MISSING_2022[, VALID_CASE := "INVALID_CASE"]
Georgia_Data_LONG_2022[is.na(SCALE_SCORE), VALID_CASE := "INVALID_CASE"]

Georgia_Data_LONG_2022 <-
  rbindlist(list(Georgia_Data_LONG_2022, GA_MISSING_2022),
            fill = TRUE, use.names = TRUE)
setkey(Georgia_Data_LONG_2022, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)


### Save results
save(Georgia_Data_LONG_2022, file = "./Data/Georgia_Data_LONG_2022.Rdata")
