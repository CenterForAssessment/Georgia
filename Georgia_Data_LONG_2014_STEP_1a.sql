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


/**Generate 2014 data**/
select VALID_CASE, SCHOOL_YEAR, SR_SYSTEM_ID, SR_SCHOOL_ID as SCHOOL_NUMBER, GTID, FIRST_NAME, MIDDLE_NAME, LAST_NAME,BIRTH_DATE,GRADE, GRADE_REPORTED, SCALE_SCORE, MATCH_STATUS, SUBJECT_CODE, ADMIN_INVALIDATION, 
ADMINISTRATION_PERIOD, RACE_CODE, GENDER_CODE, ED, SWD, Performance_level, LEP, YEAR_WITHIN, SCHOOL_ENROLLMENT_STATUS, DISTRICT_ENROLLMENT_STATUS, 
STATE_ENROLLMENT_STATUS, GIFT
INTO [2014 SGP w SIMEX]..[2014_AllData_Final]
from [2014 CRCT and EOCT Data]..[2014_AllMatchedData_clean2]
where SCHOOL_YEAR='2014'





/**Export "[2014 SGP w SIMEX]..[2014_AllData_Final]" to pipe delimited text file**/
