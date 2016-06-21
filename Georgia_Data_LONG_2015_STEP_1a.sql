/**Merge all EOG data files together**/
select SCHOOL_YEAR, SR_SYSTEM_ID,SYSTEM_NAME,SR_SCHOOL_ID,SCHOOL_NAME,FIRST_NAME,MIDDLE_NAME,LAST_NAME,BIRTH_DATE,STUDENT_ID,GRADE_LEVEL,TEST_GRADE_LEVEL,GTID,ASSESSMENT_SUBJECT_CODE,
SCALE_SCORE_ELA as SCALE_SCORE,CONDSEM_ELA as CONDSEM,PERFORMANCE_LEVEL_ELA as PERFORMANCE_LEVEL ,LEXILE_SCALE_SCORE, MASTERYCATEGORYDOM1_ELA as MASTERYCATEGORYDOM1,NRT_NP_ELA as NRT_NP,NRT_NPRANGE_ELA as NRT_NPRANGE,NRT_NCE_ELA as NRT_NCE,
RACE,GENDER_CODE,ED,SWD,LEP,GIFTED_SERVICE_CODE,
PTNA_INDICATOR_ELA as PTNA_INDICATOR, DNA_INDICATOR_ELA as DNA_INDICATOR,IR_INDICATOR_ELA as IR_INDICATOR,PIV_INDICATOR_ELA as PIV_INDICATOR,ADMINISTRATION_PERIOD 
INTO [2015 Georgia Milestones Final Matched]..[EOG_Extract_for_SGP]
from [2015 Georgia Milestones Final Matched]..[EOG_Extract_for_SGP_12222015_English]
UNION ALL
select SCHOOL_YEAR, SR_SYSTEM_ID,SYSTEM_NAME,SR_SCHOOL_ID,SCHOOL_NAME,FIRST_NAME,MIDDLE_NAME,LAST_NAME,BIRTH_DATE,STUDENT_ID,GRADE_LEVEL,TEST_GRADE_LEVEL,GTID,ASSESSMENT_SUBJECT_CODE,
SCALE_SCORE_MATH as SCALE_SCORE,CONDSEM_MATH as CONDSEM,PERFORMANCE_LEVEL_MATH as PERFORMANCE_LEVEL ,LEXILE_SCALE_SCORE, MASTERYCATEGORYDOM1_MATH as MASTERYCATEGORYDOM1,NRT_NP_MATH as NRT_NP,NRT_NPRANGE_MATH as NRT_NPRANGE,NRT_NCE_MATH as NRT_NCE,
RACE,GENDER_CODE,ED,SWD,LEP,GIFTED_SERVICE_CODE,
PTNA_INDICATOR_MATH as PTNA_INDICATOR, DNA_INDICATOR_MATH as DNA_INDICATOR,IR_INDICATOR_MATH as IR_INDICATOR,PIV_INDICATOR_MATH as PIV_INDICATOR,ADMINISTRATION_PERIOD 
from [2015 Georgia Milestones Final Matched]..[EOG_Extract_for_SGP_12222015_Math]
UNION ALL
select SCHOOL_YEAR, SR_SYSTEM_ID,SYSTEM_NAME,SR_SCHOOL_ID,SCHOOL_NAME,FIRST_NAME,MIDDLE_NAME,LAST_NAME,BIRTH_DATE,STUDENT_ID,GRADE_LEVEL,TEST_GRADE_LEVEL,GTID,ASSESSMENT_SUBJECT_CODE,
SCALE_SCORE_SCI as SCALE_SCORE,CONDSEM_SCI as CONDSEM,PERFORMANCE_LEVEL_SCI as PERFORMANCE_LEVEL ,LEXILE_SCALE_SCORE, MASTERYCATEGORYDOM1_SCI as MASTERYCATEGORYDOM1,NRT_NP_SCI as NRT_NP,NRT_NPRANGE_SCI as NRT_NPRANGE,NRT_NCE_SCI as NRT_NCE,
RACE,GENDER_CODE,ED,SWD,LEP,GIFTED_SERVICE_CODE,
PTNA_INDICATOR_SCI as PTNA_INDICATOR, DNA_INDICATOR_SCI as DNA_INDICATOR,IR_INDICATOR_SCI as IR_INDICATOR,PIV_INDICATOR_SCI as PIV_INDICATOR,ADMINISTRATION_PERIOD 
from [2015 Georgia Milestones Final Matched]..[EOG_Extract_for_SGP_12222015_Science]
UNION ALL
select SCHOOL_YEAR, SR_SYSTEM_ID,SYSTEM_NAME,SR_SCHOOL_ID,SCHOOL_NAME,FIRST_NAME,MIDDLE_NAME,LAST_NAME,BIRTH_DATE,STUDENT_ID,GRADE_LEVEL,TEST_GRADE_LEVEL,GTID,ASSESSMENT_SUBJECT_CODE,
SCALE_SCORE_SOC as SCALE_SCORE,CONDSEM_SOC as CONDSEM,PERFORMANCE_LEVEL_SOC as PERFORMANCE_LEVEL ,LEXILE_SCALE_SCORE, MASTERYCATEGORYDOM1_SOC as MASTERYCATEGORYDOM1,NRT_NP_SOC as NRT_NP,NRT_NPRANGE_SOC as NRT_NPRANGE,NRT_NCE_SOC as NRT_NCE,
RACE,GENDER_CODE,ED,SWD,LEP,GIFTED_SERVICE_CODE,
PTNA_INDICATOR_SOC as PTNA_INDICATOR, DNA_INDICATOR_SOC as DNA_INDICATOR,IR_INDICATOR_SOC as IR_INDICATOR,PIV_INDICATOR_SOC as PIV_INDICATOR,ADMINISTRATION_PERIOD 
from [2015 Georgia Milestones Final Matched]..[EOG_Extract_for_SGP_12222015_Social_Studies]

/**Recode and Merge all files   **/

select SCHOOL_YEAR, SR_SYSTEM_ID, SYSTEM_NAME, SR_SCHOOL_ID, SCHOOL_NAME, GTID, LAST_NAME,  MIDDLE_NAME, FIRST_NAME,BIRTH_DATE, TEST_GRADE_LEVEL AS GRADE, TEST_GRADE_LEVEL AS GRADE_REPORTED, 'EOG' as ASSESSMENT_TYPE_CODE, ADMINISTRATION_PERIOD, 
CASE
WHEN ASSESSMENT_SUBJECT_CODE='ELA' THEN 'ELA'
WHEN ASSESSMENT_SUBJECT_CODE='M' THEN 'MATHEMATICS'
WHEN ASSESSMENT_SUBJECT_CODE='Sci' THEN 'SCIENCE'
WHEN ASSESSMENT_SUBJECT_CODE='Soc' THEN 'SOCIAL_STUDIES'
ELSE ''
END
AS SUBJECT_CODE, SCALE_SCORE, CONDSEM,
case
when PERFORMANCE_LEVEL='1' then 'Beginning Learner'
when PERFORMANCE_LEVEL='2' then 'Developing Learner'
when PERFORMANCE_LEVEL='3' then 'Proficient Learner'
when PERFORMANCE_LEVEL='4' then 'Distinguished Learner'
Else PERFORMANCE_LEVEL
end
as PERFORMANCE_LEVEL,
case
when RACE='H' then 'Hispanic' 
when RACE='B' then 'African-American/Black'
when RACE='I' then 'American Indian/Alaskan Native'
when RACE='P' then 'Pacific Islander'
when RACE='A' then 'Asian'
when RACE='S' then 'Asian'
when RACE='W' then 'White'
when RACE='M' then 'Two or More Races'
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
as LEP, GIFTED_SERVICE_CODE as GIFT, 
case
when PTNA_INDICATOR='Y' then 'PTNA'
when DNA_INDICATOR='Y' then 'DNA'
when PIV_INDICATOR='Y' then 'PIV'
else ''
end
as ADMIN_INVALIDATION, '' AS TEST_OUT_ADMINISTRATION, 'M' as MATCH_STATUS,
case
when ADMINISTRATION_PERIOD='Winter' then 1
when ADMINISTRATION_PERIOD='Spring' then 2
when ADMINISTRATION_PERIOD='Summer' then 3
else 'NULL'
end
as YEAR_WITHIN
into [2015 Georgia Milestones Final Matched]..[2015 Final Mached Data]
FROM [2015 Georgia Milestones Final Matched]..EOG_Extract_for_SGP
union all
select SCHOOL_YEAR, SR_SYSTEM_ID, SYSTEM_NAME,SR_SCHOOL_ID,SCHOOL_NAME, GTID, LAST_NAME,  MIDDLE_NAME, FIRST_NAME,BIRTH_DATE ,'EOCT' AS GRADE , GRADE_LEVEL as GRADE_REPORTED, 'EOCT' as ASSESSMENT_TYPE_CODE, ADMINISTRATION_PERIOD,
case
WHEN ASSESSMENT_SUBJECT_CODE='9TH' THEN 'GRADE_9_LIT'
WHEN ASSESSMENT_SUBJECT_CODE='AGE' THEN 'ANALYTIC_GEOMETRY'
WHEN ASSESSMENT_SUBJECT_CODE='AME' THEN 'AMERICAN_LIT'
WHEN ASSESSMENT_SUBJECT_CODE='BIO' THEN 'BIOLOGY'
WHEN ASSESSMENT_SUBJECT_CODE='CAL' THEN 'COORDINATE_ALGEBRA'
WHEN ASSESSMENT_SUBJECT_CODE='ECO' THEN 'ECONOMICS'
WHEN ASSESSMENT_SUBJECT_CODE='PHY' THEN 'PHYSICAL_SCIENCE'
WHEN ASSESSMENT_SUBJECT_CODE='USH' THEN 'US_HISTORY'
else 'NULL'
end 
as Subject_code, SCALE_SCORE, CONDSEM,
case
when PERFORMANCE_LEVEL='1' then 'Beginning Learner'
when PERFORMANCE_LEVEL='2' then 'Developing Learner'
when PERFORMANCE_LEVEL='3' then 'Proficient Learner'
when PERFORMANCE_LEVEL='4' then 'Distinguished Learner'
Else Performance_level
end
as Performance_level,
case
when RACE='H' then 'Hispanic' 
when RACE='B' then 'African-American/Black'
when RACE='I' then 'American Indian/Alaskan Native'
when RACE='P' then 'Pacific Islander'
when RACE='A' then 'Asian'
when RACE='S' then 'Asian'
when RACE='W' then 'White'
when RACE='M' then 'Two or More Races'
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
GIFTED_SERVICE_CODE as GIFT, 
case
when PTNA_INDICATOR='Y' then 'PTNA'
when DNA_INDICATOR='Y' then 'DNA'
when PIV_INDICATOR='Y' then 'PIV'
else ''
end
as ADMIN_INVALIDATION, TEST_OUT_ADMINISTRATION, 'M' as MATCH_STATUS,
case
when ADMINISTRATION_PERIOD='Winter' then 1
when ADMINISTRATION_PERIOD='Spring' then 2
when ADMINISTRATION_PERIOD='Summer' then 3
else 'NULL'
end
as YEAR_WITHIN
from [2015 Georgia Milestones Final Matched]..EOC_Extract_for_SGP_12222015
union all
select * from [2015 Georgia Milestones Final Matched]..[2015_Georgia_Unmatched_all]


/**Data cleaning**/


/**Step 1: invalidate test-out students and bad GTIDs**/

ALTER TABLE [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data]
ADD VALID_CASE varchar(50)

update [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data]
set VALID_CASE='INVALID_CASE'
where TEST_OUT_ADMINISTRATION='Y' or  SCALE_SCORE=''

update [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data]
set VALID_CASE='INVALID_CASE'
where GTID='' or GTID='..........'


/**Step 2: Invalidate duplicate scores that are in the same admin period**/

select *, ROW_NUMBER() over(partition by VALID_CASE,SCHOOL_YEAR, GRADE, SUBJECT_CODE, GTID, MATCH_STATUS, ADMINISTRATION_PERIOD order by Scale_Score Desc) as Rownumber_dup1
into [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data_clean1]
from [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data]

update [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data_clean1]
set VALID_CASE='INVALID_CASE'
where  Rownumber_dup1<> 1 

update [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data_clean1]
set VALID_CASE='VALID_CASE'
where  VALID_CASE is null

/**Step 3: Invalidate students who have two difference grades**/

select *, ROW_NUMBER() over(partition by VALID_CASE,SCHOOL_YEAR, SUBJECT_CODE, GTID, administration_period order by grade Desc) as Rownumber_dup2
into [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data_clean2]
from [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data_clean1]


update [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data_clean2]
set VALID_CASE='INVALID_CASE'
where  Rownumber_dup2<> 1 



/**format current year's data **/

select VALID_CASE, SCHOOL_YEAR, SR_SYSTEM_ID, SR_SCHOOL_ID as SCHOOL_NUMBER, GTID, GRADE, GRADE_REPORTED, SCALE_SCORE, CONDSEM, MATCH_STATUS, SUBJECT_CODE, ADMIN_INVALIDATION, 
ADMINISTRATION_PERIOD, RACE_CODE, gender_code, ED, SWD, PERFORMANCE_LEVEL, LEP, YEAR_WITHIN, GIFT, TEST_OUT_ADMINISTRATION
INTO [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data_FINAL]
from [2015 Georgia Milestones Computer Matched]..[2015_Preliminary_Matched_Data_clean2]
