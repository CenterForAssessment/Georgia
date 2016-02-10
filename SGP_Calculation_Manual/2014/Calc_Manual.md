# SGP Calculation Manual
February 3, 2015  


<!-- 
output:
  html_document:
    number_sections: yes
    theme: default
    toc: no
    toc_depth: 2
    highlight: pygments
    self_contained: true
-->

# Introduction

This report supplies technical details associated with the [Georgia Student Growth Model](http://www.gadoe.org/School-Improvement/Teacher-and-Leader-Effectiveness/Pages/Student-Growth-Percentiles.aspx), including the calculation of student growth percentiles and percentile growth trajectories from Georgia state assessment data using the [R Software Environment](http://www.r-project.org/) in conjunction with the [SGP Package](http://www.sgp.io).

Broadly, the SGP analysis of the Georgia longitudinal student assessment data takes place in two steps:

1. [Data Preparation](#data-preparation)
2. [Data Analysis](#data-analysis)

Those familiar with data analysis know that the bulk of the effort in the above two step process lies with Step 1: [Data Preparation](#data-preparation). Following thorough data cleaning and preparation, data analysis using the SGP Package takes clean data and makes it as easy as possible to calculate, output, and visualize the results from SGP analyses.

# Data Preparation

Data preparation involves taking data provided by the Georgia Department of Education (GADOE) and producing a .Rdata file that will be subsequently analyzed in Step 2. This process is carried out annually as new data becomes available from the state assessment program.  In the following sections we first detail the data preparation business rules used and steps taken in 2014, and then provide information about additional steps that have been required in past years for data preparation.

## Initial SQL Data Pull and Cleaning of 2014 CRCT & EOCT Student-Level Data

In the source code below, data is supplied by the Georgia DOE Information Technology and subsequently clean and processed using a two step process:

***1a.*** In the first step the data is clean using the .sql script below wherein student records are selected are invalidated based upon business rules specified in the sql code itself. The result is an exportable pipe delimited file where `VALID_CASES` are unique by `CONTENT_AREA`, `YEAR`, `ID`, and `YEAR_WITHIN`.

***1b.*** In the second step the clean data from step 1 is read into [R](http://www.r-project.org/) and modified slightly with regard to variable types/classes. The result is an Rdata file that is suitable for analysis with the [SGP Package](http://www.sgp.io).


#### Step 1a: Cleaning data with SQL

```sql
/**Delete the retest data from the unmatched files**/
DELETE FROM [2014 CRCT and EOCT Final Matched Data]..[eoct2014_unmatched_sys777-89x_pipe]
WHERE retest_indicator='Y'

/**Recode and Merge all 4 files  4763841 **/

DROP TABLE [2014 CRCT and EOCT Data]..[2014_AllMatchedData]
select SCHOOL_YEAR, SR_SYSTEM_ID, SR_SCHOOL_ID, GTID, LAST_NAME,  MIDDLE_NAME, FIRST_NAME,BIRTH_DATE, AYP_GRADE AS GRADE, AYP_GRADE AS GRADE_REPORTED, ASSESSMENT_TYPE_CODE, ADMINISTRATION_PERIOD, 
case
when SUBJECT_CODE='REA' then 'READING'
when SUBJECT_CODE='ELA' then 'ELA'
when SUBJECT_CODE='MAT' then 'MATHEMATICS'
when SUBJECT_CODE='SCI' then 'SCIENCE'
when SUBJECT_CODE='SOC' then 'SOCIAL_STUDIES'
else 'NULL'
end 
as SUBJECT_CODE, AYP_SCALE_SCORE as SCALE_SCORE,
case
when AYP_PERF_LEVEL='1' then 'Does Not Meet Expectations'
when AYP_PERF_LEVEL='2' then 'Meets Expectations'
when AYP_PERF_LEVEL='3' then 'Exceeds Expectations'
Else AYP_PERF_LEVEL
end
as Performance_level,
case
when RACE_CODE='H' then 'Hispanic' 
when RACE_CODE='B' then 'African-American/Black'
when RACE_CODE='I' then 'American Indian/Alaskan Native'
when RACE_CODE='P' then 'Pacific Islander'
when RACE_CODE='A' then 'Asian'
when RACE_CODE='S' then 'Asian'
when RACE_CODE='W' then 'White'
when RACE_CODE='M' then 'Two or More Races'
Else ''
end 
as RACE_CODE,
case
when gender_code='F' then 'Female'
when gender_code='M' then 'Male'
Else gender_code
end
as GENDER_CODE,
case
when ED='Y' then 'Economically Disadvantaged: Yes'
when ED='N' then 'Economically Disadvantaged: No'
Else ED
end
as ED,
case
when SWD='Y' then 'Student with Disability: Yes'
when SWD='N' then 'Student with Disability: No'
Else SWD
end
as SWD,
case
when LEP='Y' then 'LEP: Yes'
when LEP='N' then 'LEP: No'
else LEP
end
as LEP,
case
when GIFT='Y' then 'Gifted: Yes'
when GIFT='N' then 'Gifted: No'
else GIFT
end
as GIFT, 
case
when TAR in ('2','3') then 'TAR'
when PTNA='1' then 'PTNA'
when DNA='1' then 'DNA'
else ''
end
as ADMIN_INVALIDATION, '' AS TEST_OUT_ADMINISTRATION, MATCH_STATUS,
case
when ADMINISTRATION_PERIOD='Winter' then 1
when ADMINISTRATION_PERIOD='Spring' then 2
when ADMINISTRATION_PERIOD='Summer' then 3
else 'NULL'
end
as YEAR_WITHIN,
'Enrolled School: Yes' as SCHOOL_ENROLLMENT_STATUS,
'Enrolled District: Yes' as DISTRICT_ENROLLMENT_STATUS,
'Enrolled State: Yes' AS STATE_ENROLLMENT_STATUS
into [2014 CRCT and EOCT Data]..[2014_AllMatchedData]
FROM (SELECT *,'M' as MATCH_STATUS FROM [2014 CRCT and EOCT Final Matched Data]..[fy2014_crct-matched_20140904_pipe]
UNION ALL
select SCHOOL_YEAR, TEST_SYSTEM_ID AS SR_SYSTEM_ID, TEST_SCHOOL_ID AS SR_SCHOOL_ID, TEST_STUDENT_ID AS SR_STUDENT_ID,GTID,STUDENT_FIRST_NAME AS FIRST_NAME, STUDENT_MI AS MIDDLE_NAME, STUDENT_LAST_NAME AS LAST_NAME,
BIRTH_DATE, GRADE AS STUDENT_GRADE_LEVEL ,AYP_GRADE, ASSESSMENT_TYPE_CODE, ADMINISTRATION_PERIOD, SUBJECT_CODE, RACE_CODE, GENDER AS GENDER_CODE,'' AS ED,'' AS SWD, '' AS LEP, '' AS GIFT, AYP_SCALE_SCORE, AYP_PERF_LEVEL, TAR,AYP_CTBRC, PTNA,DNA, 'U' MATCH_STATUS
from [2014 CRCT and EOCT Final Matched Data]..[crct2014_unmatched_sys89x_pipe]
)  G
UNION ALL
select SCHOOL_YEAR, SR_SYSTEM_ID, SR_SCHOOL_ID, GTID, LAST_NAME,  MIDDLE_NAME, FIRST_NAME,BIRTH_DATE ,'EOCT' AS GRADE ,STUDENT_GRADE_LEVEL as GRADE_REPORTED, 'EOCT' as ASSESSMENT_TYPE_CODE, ADMINISTRATION_PERIOD,
case
when ASSESSMENT_SUBJECT_CODE='02GEO' then 'GEOMETRY'
when ASSESSMENT_SUBJECT_CODE='039TH' then 'GRADE_9_LIT'
when ASSESSMENT_SUBJECT_CODE='04AME' then 'AMERICAN_LIT'
when ASSESSMENT_SUBJECT_CODE='05BIO' then 'BIOLOGY'
when ASSESSMENT_SUBJECT_CODE='06PHY' then 'PHYSICAL_SCIENCE'
when ASSESSMENT_SUBJECT_CODE='07USH' then 'US_HISTORY'
when ASSESSMENT_SUBJECT_CODE='08ECO' then 'ECONOMICS'
when ASSESSMENT_SUBJECT_CODE='09MA1' then 'MATHEMATICS_I'
when ASSESSMENT_SUBJECT_CODE='10MA2' then 'MATHEMATICS_II'
when ASSESSMENT_SUBJECT_CODE='11CAL' then 'COORDINATE_ALGEBRA'
when ASSESSMENT_SUBJECT_CODE='12AGE' then 'ANALYTIC_GEOMETRY'
else 'NULL'
end 
as Subject_code, SCALE_SCORE,
case
when Performance_level='1' then 'Does Not Meet Expectations'
when Performance_level='2' then 'Meets Expectations'
when Performance_level='3' then 'Exceeds Expectations'
Else Performance_level
end
as Performance_level,
case
when RACE_CODE='H' then 'Hispanic' 
when RACE_CODE='B' then 'African-American/Black'
when RACE_CODE='I' then 'American Indian/Alaskan Native'
when RACE_CODE='P' then 'Pacific Islander'
when RACE_CODE='A' then 'Asian'
when RACE_CODE='S' then 'Asian'
when RACE_CODE='W' then 'White'
when RACE_CODE='M' then 'Two or More Races'
Else ''
end 
as RACE_CODE,
case
when gender_code='F' then 'Female'
when gender_code='M' then 'Male'
Else gender_code
end
as GENDER_CODE,
case
when ED='Y' then 'Economically Disadvantaged: Yes'
when ED='N' then 'Economically Disadvantaged: No'
Else ED
end
as ED,
case
when SWD='Y' then 'Student with Disability: Yes'
when SWD='N' then 'Student with Disability: No'
Else SWD
end
as SWD,
case
when LEP='Y' then 'LEP: Yes'
when LEP='N' then 'LEP: No'
else LEP
end
as LEP,
case
when GIFT='Y' then 'Gifted: Yes'
when GIFT='N' then 'Gifted: No'
else GIFT
end
as GIFT, 
case
when PTNA_INDICATOR='Y' then 'PTNA'
when DNA_INDICATOR='Y' then 'DNA'
else ''
end
as ADMIN_INVALIDATION, TEST_OUT_ADMINISTRATION, MATCH_STATUS,
case
when ADMINISTRATION_PERIOD='Winter' then 1
when ADMINISTRATION_PERIOD='Spring' then 2
when ADMINISTRATION_PERIOD='Summer' then 3
else 'NULL'
end
as YEAR_WITHIN,
'Enrolled School: Yes' as SCHOOL_ENROLLMENT_STATUS,
'Enrolled District: Yes' as DISTRICT_ENROLLMENT_STATUS,
'Enrolled State: Yes' AS STATE_ENROLLMENT_STATUS
from (
SELECT *, 'M' AS MATCH_STATUS FROM [2014 CRCT and EOCT Final Matched Data]..[fy2014_eoct-matched_20140904_pipe]
UNION ALL
SELECT SCHOOL_YEAR, TEST_SYSTEM_ID AS SR_SYSTEM_ID, TEST_SCHOOL_ID AS SR_SCHOOL_ID, STUDENT_FIRST_NAME AS FIRST_NAME, STUDENT_MI AS MIDDLE_NAME,STUDENT_LAST_NAME AS LAST_NAME, TEST_STUDENT_ID AS STUDENT_ID, TEST_RECORD_GRADE_FIELD AS STUDENT_GRADE_LEVEL,TEST_RECORD_GRADE_FIELD, GTID,  BIRTH_DATE,SUBJ_CODE AS ASSESSMENT_SUBJECT_CODE ,  SCALE_SCORE, PERFORMANCE_LEVEL, RACE_CODE, GENDER_CODE, '' AS ED, '' AS SWD, '' AS LEP, '' AS GIFT,
PTNA_INDICATOR, DNA_INDICATOR,  IRREGULAR_ADMIN_INDICATOR, GRADE_CONVERSION, ADMINISTRATION_PERIOD, PIV_INDICATOR, '' AS TEST_OUT_ADMINISTRATION , 'U' AS MATCH_STATUS
FROM [2014 CRCT and EOCT Final Matched Data]..[eoct2014_unmatched_sys777-89x_pipe]
) I


/**Clean the data**/


/**step 1: invalidate test-out students and bad GTIDs**/

ALTER TABLE [2014 CRCT and EOCT Data]..[2014_AllMatchedData]
ADD VALID_CASE varchar(50)

/**4607 rows affected**/
update [2014 CRCT and EOCT Data]..[2014_AllMatchedData]
set VALID_CASE='INVALID_CASE'
where TEST_OUT_ADMINISTRATION='Y' or  SCALE_SCORE=''

select * from [2014 CRCT and EOCT Data]..[2014_AllMatchedData]
where TEST_OUT_ADMINISTRATION='Y' or SCALE_SCORE=''

/**108 rows affected**/
update [2014 CRCT and EOCT Data]..[2014_AllMatchedData]
set VALID_CASE='INVALID_CASE'
where GTID='' or GTID='..........'


/**step 2: Invalidate the duplicate scores that are in the same admin period: 4763841**/

drop table [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean1]
select *, ROW_NUMBER() over(partition by VALID_CASE,SCHOOL_YEAR, GRADE, SUBJECT_CODE, GTID, MATCH_STATUS, ADMINISTRATION_PERIOD order by Scale_Score Desc) as Rownumber_dup1
into [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean1]
from [2014 CRCT and EOCT Data]..[2014_AllMatchedData]


/**1781 row(s) affected**/
update [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean1]
set VALID_CASE='INVALID_CASE'
where  Rownumber_dup1<> 1 

/**4757431 row(s) affected**/
update [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean1]
set VALID_CASE='VALID_CASE'
where  VALID_CASE is null

/**step 3: Invalidate students who have two difference grades**/


drop table [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean2]
select *, ROW_NUMBER() over(partition by VALID_CASE,SCHOOL_YEAR, SUBJECT_CODE, GTID, administration_period order by grade Desc) as Rownumber_dup2
into [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean2]
from [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean1]


/**348 row(s) affected**/
update [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean2]
set VALID_CASE='INVALID_CASE'
where  Rownumber_dup2<> 1 


/** create first and last observation indicators for the same year repeater and block scheduler: 4763841**/

drop table [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean3]
select * 
into [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean3]
from (
select *,
case 
when Rownumber_AdminType_Asc=1 then '1' 
else ''
end 
as First_observation,
case
when Rownumber_AdminType_Desc=1 then '1'
else ''
end
as Last_observation
from (
select *, ROW_NUMBER() over(partition by valid_case,Subject_code,GTID order by YEAR_WITHIN Asc) as Rownumber_AdminType_Asc,ROW_NUMBER() over(partition by valid_case,Subject_code,GTID order by YEAR_WITHIN Desc) as Rownumber_AdminType_Desc
from [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean2]
) h
) g


/**Combine data with previous years 23504724**/

drop table [All Data 2009_2014]..[2010_2014AllData]
select VALID_CASE, SCHOOL_YEAR, SR_SYSTEM_ID, SCHOOL_NUMBER, GTID, GRADE, GRADE_REPORTED, SCALE_SCORE, MATCH_STATUS, SUBJECT_CODE, ADMIN_INVALIDATION, 
ADMINISTRATION_PERIOD, RACE_CODE, gender_code, ED, SWD, Performance_level AS ACHIVEMENT_LEVEL, LEP, YEAR_WITHIN, SCHOOL_ENROLLMENT_STATUS, DISTRICT_ENROLLMENT_STATUS, 
STATE_ENROLLMENT_STATUS, FIRST_OBSERVATION, LAST_OBSERVATION,'' as GIFT 
into [All Data 2009_2014]..[2010_2014AllData]
from [2009_2013LongData]..Georgia_Data_LONG
where valid_case='VALID_CASE' 
union all
select VALID_CASE, SCHOOL_YEAR, SR_SYSTEM_ID, SR_SCHOOL_ID as SCHOOL_NUMBER, GTID, GRADE, GRADE_REPORTED, SCALE_SCORE, MATCH_STATUS, SUBJECT_CODE, ADMIN_INVALIDATION, 
ADMINISTRATION_PERIOD, RACE_CODE, gender_code, ED, SWD, Performance_level AS ACHIVEMENT_LEVEL, LEP, YEAR_WITHIN, SCHOOL_ENROLLMENT_STATUS, DISTRICT_ENROLLMENT_STATUS, 
STATE_ENROLLMENT_STATUS, FIRST_OBSERVATION, LAST_OBSERVATION  , GIFT
from [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean3]
where SCHOOL_YEAR='2014'


/**Export "[All Data 2009_2014]..[2010_2014AllData]" to pipe delimited text file**/
```


#### Step 1b: Creating an R version of the cleaned data

After text data from the Information Technology department has been cleaned using the above SQL script, a pipe delimited text file is output and needs to be read into [R](http://www.r-project.org/) in order to create an [R](http://www.r-project.org/) based data set to be used for SGP calculations. The [R](http://www.r-project.org/) script below reads pipe delimited data into `R` and variable by variable tidies up the data for subsequent analysis in the SGP package.


```R
###################################################################################
###
### Script to read in data and create LONG data in R for 2014 Georgia CRCT/EOCT
###
###################################################################################

### Load packages

require(data.table)


### Load data

Georgia_Data_LONG_2014 <- fread(
   "Data/Base_Files/Georgia_Data_LONG_2014_Step_1a.txt", colClasses=rep("character", 27))


### Tidy up date

Georgia_Data_LONG_2014[,SCHOOL_YEAR:=as.character(SCHOOL_YEAR)]

Georgia_Data_LONG_2014$SCHOOL_NUMBER <- 
   Georgia_Data_LONG_2014$SR_SYSTEM_ID*10000 + Georgia_Data_LONG_2014$SCHOOL_NUMBER
Georgia_Data_LONG_2014[which(SR_SYSTEM_ID >1000), SCHOOL_NUMBER:=SR_SYSTEM_ID]
Georgia_Data_LONG_2014[, SCHOOL_NUMBER:=as.integer(SCHOOL_NUMBER)]

Georgia_Data_LONG_2014[, FIRST_NAME:=as.factor(FIRST_NAME)]
Georgia_Data_LONG_2014[, MIDDLE_NAME:=as.factor(MIDDLE_NAME)]
Georgia_Data_LONG_2014[, LAST_NAME:=as.factor(LAST_NAME)]

Georgia_Data_LONG_2014[GRADE=="03", GRADE:="3"]
Georgia_Data_LONG_2014[GRADE=="04", GRADE:="4"]
Georgia_Data_LONG_2014[GRADE=="05", GRADE:="5"]
Georgia_Data_LONG_2014[GRADE=="06", GRADE:="6"]
Georgia_Data_LONG_2014[GRADE=="07", GRADE:="7"]
Georgia_Data_LONG_2014[GRADE=="08", GRADE:="8"]

Georgia_Data_LONG_2014[, GRADE_REPORTED:=as.integer(GRADE_REPORTED)]

Georgia_Data_LONG_2014[,SCALE_SCORE:=as.numeric(SCALE_SCORE)]

Georgia_Data_LONG_2014[ADMIN_INVALIDATION=="",ADMIN_INVALIDATION:=as.character(NA)]

Georgia_Data_LONG_2014[, ADMINISTRATION_PERIOD:=toupper(ADMINISTRATION_PERIOD)]

Georgia_Data_LONG_2014[,RACE_CODE:=as.factor(RACE_CODE)]
levels(Georgia_Data_LONG_2014$RACE_CODE)[1] <- NA

Georgia_Data_LONG_2014[,GENDER_CODE:=as.factor(GENDER_CODE)]
levels(Georgia_Data_LONG_2014$GENDER_CODE)[1] <- NA

Georgia_Data_LONG_2014[,ED:=as.factor(ED)]
levels(Georgia_Data_LONG_2014$ED)[1] <- NA

Georgia_Data_LONG_2014[,SWD:=as.factor(SWD)]
levels(Georgia_Data_LONG_2014$SWD)[1] <- NA

Georgia_Data_LONG_2014[,LEP:=as.factor(LEP)]
levels(Georgia_Data_LONG_2014$LEP)[1] <- NA

Georgia_Data_LONG_2014[,PERFORMANCE_LEVEL:=factor(PERFORMANCE_LEVEL, 
   levels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"), ordered=TRUE)]

Georgia_Data_LONG_2014[,SCHOOL_ENROLLMENT_STATUS:=factor(SCHOOL_ENROLLMENT_STATUS, 
   levels=c("Enrolled School: No", "Enrolled School: Yes"), 
   labels=c("Enrolled School: No", "Enrolled School: Yes"))]

Georgia_Data_LONG_2014[,DISTRICT_ENROLLMENT_STATUS:=factor(DISTRICT_ENROLLMENT_STATUS, 
   levels=c("Enrolled District: No", "Enrolled District: Yes"), 
   labels=c("Enrolled District: No", "Enrolled District: Yes"))]

Georgia_Data_LONG_2014[,STATE_ENROLLMENT_STATUS:=factor(STATE_ENROLLMENT_STATUS, 
   levels=c("Enrolled State: No", "Enrolled State: Yes"), 
   labels=c("Enrolled State: No", "Enrolled State: Yes"))]

Georgia_Data_LONG_2014[,GIFT:=as.factor(GIFT)]
levels(Georgia_Data_LONG_2014$GIFT)[1] <- NA

### Save results

save(Georgia_Data_LONG_2014, file="Data/Georgia_Data_LONG_2014.Rdata")
```

##  Data Preperation Issues and Requirements from Previous Years

* *Administration Invalidation* - Invalidate student records with test administration flags including PTNA, PIV, DNA, TAR, AYP_CTBRC, etc.
* *Malformed Student IDs* - Student GTID values with fewer than 10 digits or including a decimal point.
* *Missing and '0' Scores* - Students with NA values or even 0 for missing (which is far outside the range of observable scale scores).
* *Multiple Test Scores* - Duplicate student recores from the same test administration period, or multiple records from the "matched" and "unmatched" data files.
* *Retest Scores* - Students have been allowed to re-take an exam.
* *Schools Involved in Cheating* - Student records from schools caught cheating on exams were all removed.


## Variable naming conventions

Note that the naming conventions associated with Georgia CRCT and EOCT data provided by the DOE and the naming conventions used by the SGP Package are different. The [SGP Package](http://www.sgp.io) accommodates different state data naming conventions through the use of a meta-data lookup table embedded within the [SGPstateData](https://github.com/CenterForAssessment/SGPstateData) Rdata object in the package. The variable name lookup table for Georgia is shown below with **names.provided** giving the state specific names, **names.sgp** the SGP Package specific names, **names.type** giving the type associated with the variable which is used within [`summarizeSGP`](https://github.com/CenterForAssessment/SGP/blob/master/R/summarizeSGP.R) to construct group summaries, **names.info** providing meta-data associated with the variable, and **names.output** a Boolean indicator of whether variable should be used with [`summarizeSGP`](https://github.com/CenterForAssessment/SGP/blob/master/R/summarizeSGP.R).

<pre>
|names.provided|names.sgp|names.type|names.info|names.output|
|--------------|---------|----------|----------|------------|
VALID_CASE|VALID_CASE|individual_inclusion|Valid Case Identifier||
SUBJECT_CODE|CONTENT_AREA|content|Content area of assessment||
SCHOOL_YEAR|YEAR|time|Year (testing year) associated with record||
SR_SYSTEM_ID|DISTRICT_NUMBER|institution|District Number||
SCHOOL_NUMBER|SCHOOL_NUMBER|institution|Unique School Identifier created from SR_SCHOOL_ID and SR_SYSTEM_ID||
GRADE|GRADE|institution_level|Grade level of test taken except EOCT||
GRADE_REPORTED|GRADE_REPORTED|institution_level|Grade level of test taken or reported||
SCALE_SCORE|SCALE_SCORE|measure|Scale score||
PERFORMANCE_LEVEL|ACHIEVEMENT_LEVEL|measure|Achievement level associated with student score||
GTID|ID|individual|Unique student identifier||
LAST_NAME|LAST_NAME|other|LAST_NAME||
FIRST_NAME|FIRST_NAME|other|FIRST_NAME||
MIDDLE_NAME|MIDDLE_NAME|other|MIDDLE_NAME||
BIRTH_DATE|BIRTH_DATE|other|BIRTH_DATE||
RACE_CODE|RACE_CODE|demographic|Ethnicity/Race code|TRUE|
GENDER_CODE|GENDER_CODE|demographic|GENDER|TRUE|
ED|ED|demographic|Economically Disadvantaged indicator|TRUE|
SWD|SWD|demographic|Students with disabilities|TRUE|
LEP|LEP|demographic|LEP/ELL Students|TRUE|
MATCH_STATUS|MATCH_STATUS|other|Match Status||
ADMIN_INVALIDATION|ADMIN_INVALIDATION|other|Combination of TAR PTNA DNA and other invalidation indicators||
ADMINISTRATION_PERIOD|ADMINISTRATION_PERIOD|other|Administration time for EOC assessments||
YEAR_WITHIN|YEAR_WITHIN|other - time|Administrative time associated with record (integer)||
RETEST_INDICATOR|RETEST_INDICATOR|other|Indicator||
FIRST_OBSERVATION|FIRST_OBSERVATION|other - time|Indicator whether record is first observed for YEAR_WITHIN||
LAST_OBSERVATION|LAST_OBSERVATION|other - time|Indicator whether record is last observed for YEAR_WITHIN||
SCHOOL_ENROLLMENT_STATUS|SCHOOL_ENROLLMENT_STATUS|institution_inclusion|School inclusion/accountability indicator||
DISTRICT_ENROLLMENT_STATUS|DISTRICT_ENROLLMENT_STATUS|institution_inclusion|District inclusion/accountability indicator||
STATE_ENROLLMENT_STATUS|STATE_ENROLLMENT_STATUS|institution_inclusion|State inclusion/accountability indicator||
</pre>

## The `prepareSGP` Step - Combining New Data with Existing SGP Object

Once we have the cleaned and prepared data for the latest annual SGP analysis, we must now combine the new data into the existing SGP object.  This is accomplished using the `prepareSGP` function (or `prepareSGP` step of a higher-level wrapper function such as `updateSGP` or `abcSGP`).  In 2014 we accomplished this by first "preparing" a new, temporary SGP object from the 2014 data and then using the `rbind.fill` function from the `plyr` package to combine the two longitudinal data sets.

```R
###############################################################################################
###
###   Update the SGP object with the 2014 data
###
###############################################################################################

## Load the SGP object including up to 2013 Analyses
load('../Georgia_SGP.Rdata')

##  Run prepareSGP on the new data to format and rename the data appropriately
GA_2014 <- prepareSGP(Georgia_Data_LONG_2014)
sgp.key <- key(Georgia_SGP@Data)

##  Combine the two longitudinal data sets in @Data slots
Georgia_SGP@Data <- data.table(rbind.fill(Georgia_SGP@Data, GA_2014@Data), key=sgp.key)

##  Run prepareSGP one more time to ensure data readiness
Georgia_SGP <- prepareSGP(Georgia_SGP)

save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")

```

# Data Analysis

Data analysis is conducted using the [R Software Environment](http://www.r-project.org/) in conjunction with the [SGP Package](http://www.sgp.io).  The 2014 annual analysis scripts are provided below and describe the steps required to run the annual SGP analyses for the [Georgia Student Growth Model](http://www.gadoe.org/School-Improvement/Teacher-and-Leader-Effectiveness/Pages/Student-Growth-Percentiles.aspx).  Information about additional steps that will be required in future years given the changes in assessment programs as expected at present are also provided.

## 2014 SGP Analyses

For the 2014 Georgia SGP analyses, we are following an analyses work flow established in previous years that includes the following 6 steps:

1. Create annual SGP configurations for EOCT analyses as well as the associated norm group preferences included in `SGPstateData`.
2. Create any baseline matrices and simex baseline coefficient matrices needed for new content areas sequences.
3. Conduct CRCT SGP Analyses.
4. Conduct EOCT SGP Analyses.
5. Combine results into longitudinal data set, summarize results and output unformatted data.
6. Export formatted data from Georgia_SGP object.


#### 1. Create annual SGP configurations.

Unlike CRCT analyses, EOCT analyses are specialized enough so that it is necessary to specify the analyses to be performed via a configuration.  For several years, configurations have been employed to conduct EOCT SGP analyses for Georgia. The configurations associated with the 2014 annual EOCT SGP analyses are located in the Georgia Github repository folder named [SGP_CONFIG](https://github.com/CenterForAssessment/Georgia/tree/master/SGP_CONFIG/EOCT/2014).  The configurations are broken up into four separate R scripts: [ELA](https://github.com/CenterForAssessment/Georgia/blob/master/SGP_CONFIG/EOCT/2014/ELA.R), [MATHEMATICS](https://github.com/CenterForAssessment/Georgia/blob/master/SGP_CONFIG/EOCT/2014/MATHEMATICS.R), [SCIENCE](https://github.com/CenterForAssessment/Georgia/blob/master/SGP_CONFIG/EOCT/2014/SCIENCE.R), and [SOCIAL_STUDIES](https://github.com/CenterForAssessment/Georgia/blob/master/SGP_CONFIG/EOCT/2014/SOCIAL_STUDIES.R).

Each configuration specifies a set of parameters that defines the norm group of students to be examined.  Every potential norm group is defined by, at a minimum, the progressions of content area, academic year and grade-level.  Other parameters may also be defined.  Each configuration used for the Georgia EOCT analyses contain these elements:

* **`sgp.content.areas`:** A progression of values that specifies the content areas to be looked at and the order in which the courses were taken.
* **`sgp.panel.years`:** The progression of the years associated with the content area progression (`sgp.content.areas`) provided in the configuration, potentially allowing for skipped years, block schedules, etc.
* **`sgp.grade.sequences`:** The grade progression associated with the content area and year progressions provided in the configuration. *'EOCT'* stands for 'End Of Course Test'.
* **`sgp.panel.years.within`:** A vector of same length as the year progression (sgp.panel.years) indicating what observation is to be used for the individual student (when multiple observations exist within a single year)
* **`sgp.exact.grade.progression`:** A Boolean argument (set to TRUE) indicating whether to run the EXACT configuration as written (rather than taking progressively restricted nested subsets of the configuration if FALSE).
* **`sgp.calculate.simex`:** A Boolean argument indicating whether cohort referenced SIMEX adjustment analyses should be run as part of the analysis for this configuration.  Excluding the argument (or explicitly setting to NULL) has the same effect as setting it to FALSE. 
* **`sgp.calculate.simex.baseline`:** A Boolean argument indicating whether baseline referenced SIMEX adjustment analyses should be run as part of the analysis for this configuration.  Excluding the argument (or explicitly setting to NULL) has the same effect as setting it to FALSE. 
* **`sgp.norm.group.preference`:** Because a student can be potentially analyzed by more than one configuration, this argument provides a ranking specifying which SGP is preferable for being matched with the student in the [`combineSGP`](https://github.com/CenterForAssessment/SGP/blob/master/R/combineSGP.R) step.  *Lower numbers correspond with higher preference.*

Note that `sgp.content.areas`, `sgp.panel.years`, and `sgp.grade.sequences` elements are all character strings, and their values correspond to levels found in the `CONTENT_AREA`, `YEAR`, and `GRADE` variables in the `Georgia_SGP@Data` slot respectively.  As an example, here is the [Mathematics II configuration script](https://github.com/CenterForAssessment/Georgia/blob/master/SGP_CONFIG/EOCT/2014/MATHEMATICS.R#L128) used to defined the 2014 SGP analyses:


```R
### Mathematics II

MATHEMATICS_II_2014.config <- list(
	MATHEMATICS_II.2014 = list( #32
		sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
		sgp.panel.years=c('2012', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=4),
	MATHEMATICS_II.2014 = list( #33
		sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS_I', 'MATHEMATICS_II'),
		sgp.panel.years=c('2011', '2012', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=3),
	MATHEMATICS_II.2014 = list( #34
		sgp.content.areas=c('MATHEMATICS_I', 'MATHEMATICS_II'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=2),
	MATHEMATICS_II.2014 = list( #35
		sgp.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
		sgp.panel.years=c('2013', '2014'),
		sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.norm.group.preference=1)#,
	# MATHEMATICS_II.2014 = list( #36  - Too few kids ( ~ 400 )
		# sgp.content.areas=c('MATHEMATICS_II', 'MATHEMATICS_II'),
		# sgp.panel.years=c('2014', '2014'),
		# sgp.grade.sequences=list(c('EOCT', 'EOCT')),
		# sgp.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION'),
		# sgp.exact.grade.progression=TRUE,
		# sgp.norm.group.preference=0)
) ### END MATHEMATICS_II_2014.config
```

Configurations are R scripts that are sourced as part of the larger SGP analysis to be discussed later.  In addition, the `SGPstateData` needs to be updated with the norm group preference embedded within the configurations.  To do this, an Rdata object needs to be constructed that is embedded within `SGPstateData` (either manually or included in the package build itself). To create the Rdata object with the norm groups preferences utilize/source the R script [configToSGPNormGroup.R](https://github.com/CenterForAssessment/Georgia/blob/master/SGP_CONFIG/configToSGPNormGroup.R) in the [SGP_CONFIG](https://github.com/CenterForAssessment/Georgia/tree/master/SGP_CONFIG/EOCT/2014) folder as follows:

```R
source("configToSGPNormGroup.R")
```

This creates the Rdata object [GA_SGP_Norm_Group_Preference.Rdata)](https://github.com/CenterForAssessment/Georgia/blob/master/SGP_CONFIG/GA_SGP_Norm_Group_Preference.Rdata) containing the norm group preferences (the `GA_SGP_Norm_Group_Preference` object is just a data.frame/data.table containing information about what the rank ordering of the configurations are in terms of preference). 

The `GA_SGP_Norm_Group_Preference` can either be embedded into `SGPstateData` manually (see Step 4 below) or submitted to the [SGP Package maintainers](https://github.com/CenterForAssessment/SGP#contributors) for inclusion in the package so that it is contained in `SGPstateData` when the package is loaded.


#### 2. Create baseline and SIMEX baseline coefficient matrices.

For the 2014 CRCT & EOCT Georgia will employ baseline referenced and SIMEX adjusted baseline referenced SGPs. For most grade and content area analyses the coefficient matrices required to produce these results were produced prior to 2014. The following script creates baseline matrices for content areas and cohorts with adequate data as well as baseline matrices for SIMEX adjusted SGPs. 


```R
####################################################################
###
### R Script to create Baseline and Simex Adjusted Baseline Matrices
### for 2014 Georgia Analyses
###
####################################################################

### Load SGP Package

require(SGP)


### Load Data

load("Data/Georgia_SGP.Rdata")

# Extract/save the existing Baseline Matrices from the object first in order to create additional matrices.  
# Then remove all baseline matrices from the object.
Georgia_Baseline_Matrices <- 
   Georgia_SGP@SGP$Coefficient_Matrices[grep("BASELINE", names(Georgia_SGP@SGP$Coefficient_Matrices))]
Georgia_SGP@SGP$Coefficient_Matrices <- 
   Georgia_SGP@SGP$Coefficient_Matrices[-grep("BASELINE", names(Georgia_SGP@SGP$Coefficient_Matrices))]

###  Construct baseline analysis configuration lists for each content area and 

### GRADE_9_LIT

my.baseline.config <- list(
	list(  # 7,584 students #1
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(8,8, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 3)),
	list(  # 4,399 students #2
		sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(7,7, 8,8, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 0, 3)),

	list(  # 4,882 students #7
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(7,7, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1)),
	list(  # 3,813 students #8
		sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(6,6, 7,7, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 0, 1))) # Continuous NO 8th grade ELA/Reading

GA_GRADE_9_LIT_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=4,  ## NOTE Change here
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=20)))

## Loop to investigate the N size and other info
for (i in 1:length(GA_GRADE_9_LIT_Baseline_Matrices[[1]])) {
	print(paste(GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Version$Matrix_Information$N,
	GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Version$Date_Prepared,
	GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Grade_Progression,
	GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Content_Areas,
	GA_GRADE_9_LIT_Baseline_Matrices[[1]][[i]]@Time_Lags[[1]], "\n", sep=", "))
}


### AMERICAN_LIT 

my.baseline.config <- list(
	list(  # 19,722 students #11
		sgp.baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=3), # skip 2 years

	list(  # 11,293 students #12
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(8,8, 'EOCT', 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 3))) # skip 2 years
				
				
GA_AMERICAN_LIT_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=3,  ## NOTE Change here
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=20)))

for (i in 1:length(GA_AMERICAN_LIT_Baseline_Matrices[[1]])) {
	print(paste(GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Version$Matrix_Information$N,
	GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Version$Date_Prepared,
	GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Grade_Progression,
	GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Content_Areas,
	GA_AMERICAN_LIT_Baseline_Matrices[[1]][[i]]@Time_Lags[[1]], "\n", sep=", "))
}


###  US History

my.baseline.config <- list(
	list(  # 11,507 students #62
		sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('8', 'EOCT'),
		sgp.baseline.grade.sequences.lags=4,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	list(  # 15,155 students #67
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
	# list(  # 924 students #68  TOO FEW STUDENTS - NOT RUN / MATRICES NOT KEPT
		# sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'ECONOMICS', 'US_HISTORY'),
		# sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		# sgp.baseline.grade.sequences=c('8', 'EOCT', 'EOCT'),
		# sgp.baseline.grade.sequences.lags=c(1,1),
		# sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION')),
	list(  # 5,938 students #69
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	list(  # 12,060 students #73
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=0,
		sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))

GA_USHIST_Baseline_Matrices <- baselineSGP(
	Georgia_SGP,
	sgp.baseline.config=my.baseline.config,
	sgp.percentiles.baseline.max.order=1,
	return.matrices.only=TRUE,
	calculate.baseline.sgps=FALSE,
	goodness.of.fit.print=FALSE,
	parallel.config=list(
		BACKEND="PARALLEL",
		WORKERS=list(TAUS=20)))


for (i in 1:length(GA_USHIST_Baseline_Matrices[[1]])) {
	print(paste(GA_USHIST_Baseline_Matrices[[1]][[i]]@Version$Matrix_Information$N,
	GA_USHIST_Baseline_Matrices[[1]][[i]]@Version$Date_Prepared,
	GA_USHIST_Baseline_Matrices[[1]][[i]]@Grade_Progression,
	GA_USHIST_Baseline_Matrices[[1]][[i]]@Content_Areas,
	GA_USHIST_Baseline_Matrices[[1]][[i]]@Time_Lags[[1]], "\n", sep=", "))
}


##  Now combine the newly computed coefficient matrices with the previously existing ones.  
##  Save and add into SGP object before running analyses AND needed to produce SIMEX coeffient matrices below.

Georgia_Baseline_Matrices[["AMERICAN_LIT.BASELINE"]] <- 
   c(Georgia_Baseline_Matrices[["AMERICAN_LIT.BASELINE"]], GA_AMERICAN_LIT_Baseline_Matrices[["AMERICAN_LIT.BASELINE"]])
Georgia_Baseline_Matrices[["GRADE_9_LIT.BASELINE"]] <- 
   c(Georgia_Baseline_Matrices[["GRADE_9_LIT.BASELINE"]], GA_GRADE_9_LIT_Baseline_Matrices[["GRADE_9_LIT.BASELINE"]])
Georgia_Baseline_Matrices[["US_HISTORY.BASELINE"]] <- 
   c(Georgia_Baseline_Matrices[["US_HISTORY.BASELINE"]], GA_USHIST_Baseline_Matrices[["US_HISTORY.BASELINE"]])

save(Georgia_Baseline_Matrices, file="Georgia_Baseline_Matrices.Rdata")


###################################################################################################
###
###   Georgia Baseline SIMEX matrix calculation
###
###################################################################################################

SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- 
  SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]][
  -grep("BASELINE.SIMEX", names(SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]]))]

### GRADE_9_LIT

my.baseline.config <- list(
	list(  # 7,584 students #1
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(8,8, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 3)),
	list(  # 4,399 students #2
		sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(7,7, 8,8, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 0, 3)),

	list(  # 4,882 students #7
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(7,7, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1)),
	list(  # 3,813 students #8
		sgp.baseline.content.areas=c('ELA', 'READING', 'ELA', 'READING', 'GRADE_9_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(6,6, 7,7, 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 0, 1))) # Continuous NO 8th grade ELA/Reading


	GA_GRADE_9_LIT_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=4,  ## NOTE Change here
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=25)))
	

### AMERICAN_LIT 

my.baseline.config <- list(
	list(  # 19,722 students #11
		sgp.baseline.content.areas=c('GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=3), # skip 2 years

	list(  # 11,293 students #12
		sgp.baseline.content.areas=c('ELA', 'READING', 'GRADE_9_LIT', 'AMERICAN_LIT'),
		sgp.baseline.panel.years=c('2007', '2008', '2009', '2010', '2011', '2012'),
		sgp.baseline.grade.sequences=c(8,8, 'EOCT', 'EOCT'),
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.baseline.grade.sequences.lags=c(0, 1, 3))) # skip 2 years
						
	GA_AMERICAN_LIT_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=3,  ## NOTE Change here
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=25))) #16


###  US History

my.baseline.config <- list(
	list(  # 11,507 students #62
		sgp.baseline.content.areas=c('SOCIAL_STUDIES', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('8', 'EOCT'),
		sgp.baseline.grade.sequences.lags=4,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	list(  # 15,155 students #67
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=1,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),
	list(  # 5,938 students #69
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=2,
		sgp.baseline.panel.years.within=c('LAST_OBSERVATION', 'FIRST_OBSERVATION')),

	list(  # 12,060 students #73
		sgp.baseline.content.areas=c('ECONOMICS', 'US_HISTORY'),
		sgp.baseline.panel.years=c('2008', '2009', '2010', '2011', '2012', '2013'),
		sgp.baseline.grade.sequences=c('EOCT', 'EOCT'),
		sgp.baseline.grade.sequences.lags=0,
		sgp.baseline.panel.years.within=c('FIRST_OBSERVATION', 'LAST_OBSERVATION')))

	GA_USHIST_SIMEX_Baseline_Matrices <- baselineSGP(
		Georgia_SGP,
		sgp.baseline.config=my.baseline.config,
		sgp.percentiles.baseline.max.order=1,
		return.matrices.only=TRUE,
		calculate.baseline.sgps=FALSE,
		calculate.baseline.simex=TRUE,
		goodness.of.fit.print=FALSE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SIMEX=25)))

Georgia_SIMEX_Baseline_Matrices <- Georgia_Baseline_Matrices[grep("BASELINE.SIMEX", names(Georgia_Baseline_Matrices))]
Georgia_Baseline_Matrices <- Georgia_Baseline_Matrices[-grep("BASELINE.SIMEX", names(Georgia_Baseline_Matrices))]

Tmp_SIMEX_Baseline_Matrices <- 
   c(GA_GRADE_9_LIT_SIMEX_Baseline_Matrices, GA_AMERICAN_LIT_SIMEX_Baseline_Matrices, GA_USHIST_SIMEX_Baseline_Matrices)
SIMEX_Baseline_Matrices <- 
   SGP:::mergeSGP(list(Coefficient_Matrices= Georgia_SIMEX_Baseline_Matrices), list(Coefficient_Matrices= Tmp_SIMEX_Baseline_Matrices))

SIMEX_Baseline_Matrices$Coefficient_Matrices$GRADE_9_LIT.BASELINE.SIMEX[[2]][[1]][[101]]@Version

Georgia_Baseline_Matrices <- c(Georgia_Baseline_Matrices, SIMEX_Baseline_Matrices$Coefficient_Matrices)

save(Georgia_Baseline_Matrices, file="Georgia_Baseline_Matrices.Rdata")
```


#### 3. Conduct CRCT SGP Analyses.

```R
#########################################################
###
### Calculate SGPs for Georgia - 2014
###
##########################################################

### Load SGP Package

require(SGP)

### Load Georgia SGP object

load("Data/Georgia_SGP.Rdata")
load('Data/Georgia_Baseline_Matrices.Rdata' )


### AnalyzeSGP : Grade level CRCT tests

SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- Georgia_Baseline_Matrices

Georgia_SGP <- analyzeSGP(
			Georgia_SGP,
			years='2014',
			content_areas=c("ELA", "READING", "MATHEMATICS", "SOCIAL_STUDIES"), # "SCIENCE" is produced in SGP_Config
			sgp.percentiles=TRUE,
			sgp.projections=TRUE,
			sgp.projections.lagged=TRUE,
			sgp.percentiles.baseline=TRUE,
			sgp.projections.baseline=TRUE,
			sgp.projections.lagged.baseline=TRUE,
			simulate.sgps=TRUE,
			calculate.simex=NULL, # TRUE or NULL - NULL now to avoid creating (unnecessary) Cohort referenced SIMEX
			calculate.simex.baseline=TRUE, # TRUE or NULL
			goodness.of.fit.print="GROB", # Print all out once after running EOCTs
			parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=12, BASELINE_PERCENTILES=12, PROJECTIONS=6, LAGGED_PROJECTIONS=6)))

### Save Results

#save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")
```

#### 4. Conduct EOCT SGP Analyses.

```R
#########################################################
###
### Calculate EOCT SGPs for Georgia for 2014
###
##########################################################

### Load SGP Package

require(SGP)


### Load Georgia SGP object

load("Data/Georgia_SGP.Rdata")

### Load EOCT configurations
require(SGP)
setwd('Github_Repos/Projects/Georgia')

source("SGP_CONFIG/EOCT/2014/ELA.R")
source("SGP_CONFIG/EOCT/2014/SCIENCE.R")
source("SGP_CONFIG/EOCT/2014/SOCIAL_STUDIES.R")

source("SGP_CONFIG/EOCT/2014/MATHEMATICS.R")

####################################################################################
###
### EOCT Analyses
###
####################################################################################

###
###		Cohort referenced EOCT content areas - run seperate to keep SIMEX production limited to "official" version
###

GA_EOCT.config <- c(
		ANALYTIC_GEOMETRY_2014.config,
		COORDINATE_ALGEBRA_2014.config,
		MATHEMATICS_II_2014.config)

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config=GA_EOCT.config,
		sgp.percentiles=TRUE,
		sgp.projections= TRUE,
		sgp.projections.lagged= TRUE,
		sgp.percentiles.baseline= FALSE,
		sgp.projections.baseline= FALSE,
		sgp.projections.lagged.baseline=FALSE,
		simulate.sgps = FALSE,
		calculate.simex = TRUE,
		parallel.config=list(BACKEND='PARALLEL', WORKERS=list(SIMEX=15, TAUS=15)))


###
###		BASELINE SGPs
###

GA_EOCT.config <- c(
		AMERICAN_LIT_2014.config,
		BIOLOGY_2014.config,
		ECONOMICS_2014.config,
		GRADE_9_LIT_2014.config,
		PHYSICAL_SCIENCE_2014.config,
		US_HISTORY_2014.config)

# load('Georgia_Baseline_Matrices.Rdata' )
SGPstateData[["GA"]][["Baseline_splineMatrix"]][["Coefficient_Matrices"]] <- Georgia_Baseline_Matrices

### Replace original baseline matrices with updated matrices (original + additional US Hist and ELA progressions)
Georgia_SGP@SGP$Coefficient_Matrices <- Georgia_SGP@SGP$Coefficient_Matrices[-grep("BASELINE", names(Georgia_SGP@SGP$Coefficient_Matrices))]
# Georgia_SGP@SGP$Coefficient_Matrices <- c(Georgia_SGP@SGP$Coefficient_Matrices, Georgia_Baseline_Matrices)

### analyzeSGP

Georgia_SGP <- analyzeSGP(
		Georgia_SGP,
		sgp.config=GA_EOCT.config,
		sgp.percentiles= FALSE,
		sgp.projections=FALSE,
		sgp.projections.lagged=FALSE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline= TRUE,
		sgp.projections.lagged.baseline= TRUE,
		simulate.sgps = FALSE,
		calculate.simex.baseline = TRUE,
		goodness.of.fit.print=FALSE,
		# parallel.config=list(BACKEND='PARALLEL', WORKERS=list(SIMEX=12)))
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(BASELINE_PERCENTILES=6, PROJECTIONS=3, LAGGED_PROJECTIONS=2)))

save(Georgia_SGP, file="Georgia_SGP.Rdata")
```

#### 5. Combine 2014 Results into the Longitudinal data in the Georgia_SGP object.

```R
### combineSGP

#  Add Norm Group Preferences if they have not been submitted to SGPstateData: 
SGPstateData[["GA"]][["SGP_Norm_Group_Preference"]] <- GA_SGP_Norm_Group_Preference

Georgia_SGP <- combineSGP(Georgia_SGP, years='2014')

### Save results
save(Georgia_SGP, file="Data/Georgia_SGP.Rdata")


### summarizeSGP (Produces aggregate tables)

Georgia_SGP <- summarizeSGP(Georgia_SGP, parallel.config=list(BACKEND="PARALLEL", WORKERS=list(SUMMARY=20)))
#  Extract and save the summary tables seperately

Georgia_Summary <- Georgia_SGP@Summary
save(Georgia_Summary, file="Data/Georgia_Summary_2014.Rdata")

Georgia_SGP@Summary <- NULL

### outputSGP

outputSGP(Georgia_SGP, output.type=c("LONG_Data", "LONG_FINAL_YEAR_Data"))

```


#### 6. Export formatted data from Georgia_SGP object.

```R
######################################################################################
###
### Script to produce formatted text output for Georgia from annual long data
###
######################################################################################

### Load packages

require(SGP)
require(data.table)

### Load data
setwd('Georgia')

load("Data/Georgia_SGP.Rdata")
load("Data/Georgia_SGP_LONG_Data_2014.Rdata")

### Variables to output
variables.to.output <- c("VALID_CASE", "GTID", "SCHOOL_YEAR", "SUBJECT_CODE", "YEAR_WITHIN", "GRADE", "GRADE_REPORTED", "SCALE_SCORE", "SCALE_SCORE_PRIOR_STANDARDIZED",
"ADMINISTRATION_PERIOD", "FIRST_OBSERVATION", "LAST_OBSERVATION", "PERFORMANCE_LEVEL", "SR_SYSTEM_ID", "SCHOOL_NUMBER", "ADMIN_INVALIDATION", "ADMIN_TYPE", "MATCH_STATUS",
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

tmp.long.data[, SGP_SIMEX_LEVEL_FINAL := ordered(
   findInterval(SGP_SIMEX_FINAL, SGPstateData[["GA"]][["Growth"]][["Cutscores"]][["Cuts"]]), labels=c("Low", "Typical", "High"))]

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
tmp.long.data$SUBJECT_CODE_PRIOR_1 <- sapply(sapply(strsplit(sapply(strsplit(
   sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")
tmp.long.data$SUBJECT_CODE_PRIOR_2 <- sapply(sapply(strsplit(sapply(strsplit(
   sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")
tmp.long.data$SUBJECT_CODE_PRIOR_3 <- sapply(sapply(strsplit(sapply(strsplit(
   sapply(my.tmp.split, function(x) rev(x)[4]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")
tmp.long.data$SUBJECT_CODE_PRIOR_4 <- sapply(sapply(strsplit(sapply(strsplit(
   sapply(my.tmp.split, function(x) rev(x)[5]), "/"), '[', 2), "_"), head, -1), paste, collapse="_")

### GRADE Prior
tmp.long.data$GRADE_PRIOR_1 <- sapply(strsplit(sapply(strsplit(
   sapply(my.tmp.split, function(x) rev(x)[2]), "/"), '[', 2), "_"), tail, 1)
tmp.long.data$GRADE_PRIOR_2 <- sapply(strsplit(sapply(strsplit(
   sapply(my.tmp.split, function(x) rev(x)[3]), "/"), '[', 2), "_"), tail, 1)
tmp.long.data$GRADE_PRIOR_3 <- sapply(strsplit(sapply(strsplit(
   sapply(my.tmp.split, function(x) rev(x)[4]), "/"), '[', 2), "_"), tail, 1)
tmp.long.data$GRADE_PRIOR_4 <- sapply(strsplit(sapply(strsplit(
   sapply(my.tmp.split, function(x) rev(x)[5]), "/"), '[', 2), "_"), tail, 1)

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
	ordered(findInterval(as.numeric(SCALE_SCORE_PRIOR_1), c(800, 850)), 
	labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]
tmp.long.data[which(GRADE_PRIOR_1 == "EOCT"), PERFORMANCE_LEVEL_PRIOR_1 := 
	ordered(findInterval(SCALE_SCORE_PRIOR_1, c(400, 450)), 
	labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]

tmp.long.data[which(GRADE_PRIOR_2 != "EOCT"), PERFORMANCE_LEVEL_PRIOR_2 := 
	ordered(findInterval(as.numeric(SCALE_SCORE_PRIOR_2), c(800, 850)), 
	labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]
## 2nd -> 4th Priors will all be CRCT
# tmp.long.data[which(GRADE == "EOCT"), PERFORMANCE_LEVEL_PRIOR_2 := 
	# ordered(findInterval(SCALE_SCORE_PRIOR_2, c(400, 450)), 
	# labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]

tmp.long.data[which(GRADE_PRIOR_3 != "EOCT"), PERFORMANCE_LEVEL_PRIOR_3 := 
	ordered(findInterval(as.numeric(SCALE_SCORE_PRIOR_3), c(800, 850)), 
	labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]

tmp.long.data[which(GRADE_PRIOR_4 != "EOCT"), PERFORMANCE_LEVEL_PRIOR_4 := 
	ordered(findInterval(as.numeric(SCALE_SCORE_PRIOR_4), c(800, 850)), 
	labels=c("Does Not Meet Expectations", "Meets Expectations", "Exceeds Expectations"))]


### ADMINISTRATION_PERIOD_PRIOR_* Prior

tmp.admin.period <- Georgia_SGP@Data[, 
   c(key(Georgia_SGP@Data)[1:4], "GRADE", "ADMINISTRATION_PERIOD", "SCALE_SCORE"), with=FALSE][VALID_CASE=="VALID_CASE" & GRADE=="EOCT"]
setnames(tmp.admin.period, c("CONTENT_AREA", "YEAR", "GRADE", "ID", "ADMINISTRATION_PERIOD", "SCALE_SCORE"), 
	c("SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", "GTID", "ADMINISTRATION_PERIOD_PRIOR_1", "SCALE_SCORE_PRIOR_1"))

tmp.admin.period[, SCALE_SCORE_PRIOR_1 := as.character(SCALE_SCORE_PRIOR_1)]

## Remove the "LAST_OBSERVATION" for within year repeaters that had the exact same score in both Admin Periods
setkeyv(tmp.admin.period, c("GTID", "SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", 
   "SCALE_SCORE_PRIOR_1", "ADMINISTRATION_PERIOD_PRIOR_1", "VALID_CASE"))
setkeyv(tmp.admin.period, c("GTID", "SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", 
   "SCALE_SCORE_PRIOR_1", "VALID_CASE"))
tmp.admin.period <- tmp.admin.period[which(!duplicated(tmp.admin.period))]

setkeyv(tmp.long.data, c("GTID", "SUBJECT_CODE_PRIOR_1", "SCHOOL_YEAR_PRIOR_1", "GRADE_PRIOR_1", 
   "SCALE_SCORE_PRIOR_1", "VALID_CASE"))

tmp.long.data <- merge(tmp.long.data, tmp.admin.period, all.x=TRUE)

tmp.long.data[which(!is.na(GRADE_PRIOR_1) & is.na(ADMINISTRATION_PERIOD_PRIOR_1)), 
   ADMINISTRATION_PERIOD_PRIOR_1 := "2: SPRING"]
   
table(tmp.long.data$ADMINISTRATION_PERIOD_PRIOR_1, tmp.long.data$ADMINISTRATION_PERIOD, tmp.long.data$SCHOOL_YEAR_PRIOR_1)

tmp.long.data[, paste("ADMINISTRATION_PERIOD_PRIOR", 2:4, sep="_") := as.character(NA)]

tmp.long.data[which(!is.na(GRADE_PRIOR_2)), ADMINISTRATION_PERIOD_PRIOR_2 := "2: SPRING"]
tmp.long.data[which(!is.na(GRADE_PRIOR_3)), ADMINISTRATION_PERIOD_PRIOR_3 := "2: SPRING"]
tmp.long.data[which(!is.na(GRADE_PRIOR_4)), ADMINISTRATION_PERIOD_PRIOR_4 := "2: SPRING"]

Georgia_SGP_Data_LONG_2014_FORMATTED <- tmp.long.data[, variables.to.output, with=FALSE]
setkeyv(Georgia_SGP_Data_LONG_2014_FORMATTED, c("VALID_CASE", "SUBJECT_CODE", "SCHOOL_YEAR", "GTID", "YEAR_WITHIN"))


### Save results

save(Georgia_SGP_Data_LONG_2014_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2014_FORMATTED.Rdata")
write.table(Georgia_SGP_Data_LONG_2014_FORMATTED, file="Data/Georgia_SGP_Data_LONG_2014_FORMATTED.txt", 
   sep="|", row.names=FALSE, na="", quote=FALSE)

```

##  Additional Steps for Future Ananlyses

* Knots bounds
* Update `SGPstateData` entry
* baseline matrices
* Misc code adjustments to switch to cohort ref'd & chrt SIMEX


