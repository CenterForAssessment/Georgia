#####################################################################################
###                                                                               ###
###           Prepare and format the 2019 EOG and EOC Georgia Milestones data     ###
###                                                                               ###
#####################################################################################

### Load required packages
require(data.table)

#####
###		Load 2019 Raw Data
#####

#   Function to load base data
readZIP <- function(file, ...) {
  if(!file.exists(file)) stop("File requested does not exist in path provided.")
  my.file <- gsub(".zip",  "", file)
  tmp.dir <- getwd()
  setwd(tempdir())
  system(paste0("unzip '", file.path(tmp.dir, paste0(my.file, ".zip")), "'"))

  TMP <- try(data.table::fread(file = grep(basename(my.file), list.files(), value=TRUE), ...), silent=TRUE)
  if(any(class(TMP) == "try-error")) {
    message(paste("\n\t\tError reported from data.table::fread!\n\n", attributes(TMP)$condition))
  }
  unlink(grep(basename(my.file), list.files(all.files = TRUE, recursive = TRUE), value=TRUE))
  setwd(tmp.dir)
  if(!any(class(TMP) == "try-error")) return(TMP)
}

###   GADOE data loading process
setwd('U:/DATA/SGP/Data/2019 SGPs/SGP Calculation/Working Directory_QQ/')

####  Load 2019 Milestones Data ####

Georgia_Data_LONG_2018_Testout <- fread("U:/DATA/SGP/Data/2019 SGPs/Computer Matched Data/2018_Georgia_Milestones_EOC_TestOut.txt",  header = TRUE, sep = "|", colClasses=rep("character", 28))
Georgia_Data_LONG_2019 <- fread("U:/DATA/SGP/Data/2019 SGPs/Computer Matched Data/EOG_EOC_Final_Data_2019.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))
###   END GA DOE   ###


###   NCIEA data loading process
###   Start EOG
Georgia_Data_LONG_2019 <- readZIP("./Data/Base_Files/2019 SGP Preliminary Data/EOG_Prelim_data_2019.txt.zip",  header = TRUE, sep = "|", colClasses=rep("character", 29))
###   End EOG


###   Start EOC
###
Georgia_Data_LONG_2019 <- rbindlist(list(
          fread("./Data/Base_Files/EOC_Final_Spring_Winter_Data_2019.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31)),
          fread("./Data/Base_Files/EOC_Final_Summer_Data_2019.txt",  header = TRUE, sep = "|", colClasses=rep("character", 31))))
###   End EOC

###   Start Testout
Georgia_Data_LONG_2019 <- fread("./Data/Base_Files/2018_EOC_Final_Testout.txt",  header = TRUE, sep = "|", colClasses=rep("character", 35))

Georgia_Data_LONG_2019[, SUBJECT_CODE := as.factor(ASSESSMENT_SUBJECT_CODE)]
levels(Georgia_Data_LONG_2019$SUBJECT_CODE) <- c("GRADE_9_LIT", "ANALYTIC_GEOMETRY", "ALGEBRA_I", "AMERICAN_LIT", "BIO", "COORDINATE_ALGEBRA", "ECO", "GEOMETRY", "PHY", "USH")
Georgia_Data_LONG_2019[, SUBJECT_CODE := as.character(SUBJECT_CODE)]
Georgia_Data_LONG_2019 <- Georgia_Data_LONG_2019[SUBJECT_CODE %in% c("GRADE_9_LIT", "ANALYTIC_GEOMETRY", "ALGEBRA_I", "AMERICAN_LIT", "COORDINATE_ALGEBRA", "GEOMETRY"),]

Georgia_Data_LONG_2019[, GRADE := "EOCT"]

Georgia_Data_LONG_2019[, PERFORMANCE_LEVEL := as.factor(PERFORMANCE_LEVEL)]
levels(Georgia_Data_LONG_2019$PERFORMANCE_LEVEL) <- c("Beginning Learner", "Developing Learner", "Distinguished Learner", "Proficient Learner")
Georgia_Data_LONG_2019[, PERFORMANCE_LEVEL := as.character(PERFORMANCE_LEVEL)]

Georgia_Data_LONG_2019[, VALID_CASE := "VALID_CASE"]

Georgia_Data_LONG_2019[, YEAR_WITHIN := as.numeric(NA)]
Georgia_Data_LONG_2019[ADMINISTRATION_PERIOD=="Fall", YEAR_WITHIN := 1]
Georgia_Data_LONG_2019[ADMINISTRATION_PERIOD=="Spring", YEAR_WITHIN := 2]
Georgia_Data_LONG_2019[ADMINISTRATION_PERIOD=="Summer", YEAR_WITHIN := 3]
###   End Testout
###   NCIEA data loading


#####
###   Tidy up data
#####

Georgia_Data_LONG_2019[, SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)*10000 + as.numeric(SR_SCHOOL_ID)]
Georgia_Data_LONG_2019[which(as.numeric(SR_SYSTEM_ID) > 1000), SCHOOL_NUMBER := as.numeric(SR_SYSTEM_ID)]
Georgia_Data_LONG_2019[, SCHOOL_NUMBER := as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2019[, SCALE_SCORE := as.numeric(SCALE_SCORE)]
Georgia_Data_LONG_2019[, CONDSEM := as.numeric(CONDSEM)]

Georgia_Data_LONG_2019[, GRADE := gsub("0", "", GRADE)]

Georgia_Data_LONG_2019[PERFORMANCE_LEVEL=="", PERFORMANCE_LEVEL := NA] # Avoid NOTE in prepareSGP / checkSGP ##  PRELIM CODE  ##
table(Georgia_Data_LONG_2019[,PERFORMANCE_LEVEL, is.na(SCALE_SCORE)], exclude=NULL)  #  All NA scores are NA PERFORMANCE_LEVEL
table(Georgia_Data_LONG_2019[, VALID_CASE, is.na(SCALE_SCORE)], exclude=NULL)  #  All NA scores are INVALID_CASEs

Georgia_Data_LONG_2019[, ADMINISTRATION_PERIOD := paste(YEAR_WITHIN, toupper(ADMINISTRATION_PERIOD), sep=": ")]

Georgia_Data_LONG_2019[, SCHOOL_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled School: No", "Enrolled School: Yes"))]
Georgia_Data_LONG_2019[, DISTRICT_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled District: No", "Enrolled District: Yes"))]
Georgia_Data_LONG_2019[, STATE_ENROLLMENT_STATUS := factor(1, levels=0:1, labels=c("Enrolled State: No", "Enrolled State: Yes"))]

# Georgia_Data_LONG_2019[, c("Rownumber_dup1", "Rownumber_dup2") := NULL]

###  Invalidate duplicates (No duplicate cases in 2019 prelim data)

setkey(Georgia_Data_LONG_2019, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID, SCALE_SCORE)
setkey(Georgia_Data_LONG_2019, VALID_CASE, SUBJECT_CODE, GRADE, SCHOOL_YEAR, YEAR_WITHIN, GTID)
# sum(duplicated(Georgia_Data_LONG_2019[VALID_CASE != "INVALID_CASE"], by=key(Georgia_Data_LONG_2019))) # 285 EOC duplicates with valid GTIDs - (((take the highest score if any exist)))
# dups <- data.table(Georgia_Data_LONG_2019[unique(c(which(duplicated(Georgia_Data_LONG_2019, by=key(Georgia_Data_LONG_2019)))-1, which(duplicated(Georgia_Data_LONG_2019, by=key(Georgia_Data_LONG_2019))))), ], key=key(Georgia_Data_LONG_2019))
Georgia_Data_LONG_2019[which(duplicated(Georgia_Data_LONG_2019, by=key(Georgia_Data_LONG_2019)))-1, VALID_CASE := "INVALID_CASE"]


### Save results

###  EOG
assign("Georgia_Data_LONG_2018_EOG", Georgia_Data_LONG_2019)
save(Georgia_Data_LONG_2018_EOG, file="./Data/Georgia_Data_LONG_2019_EOG.Rdata")

###  EOC
assign("Georgia_Data_LONG_2018_EOC", Georgia_Data_LONG_2019)
save(Georgia_Data_LONG_2018_EOC, file="./Data/Georgia_Data_LONG_2019_EOC.Rdata")

###  Test Out data
assign("Georgia_Data_LONG_2018_Testout", Georgia_Data_LONG_2019)
save(Georgia_Data_LONG_2018_Testout, file="./Data/Georgia_Data_LONG_2018_Testout.Rdata")
