---
title: The Georgia Student Growth Model
subtitle: A Technical Overview of the 2013-2014 Student Growth Percentile Calculations
author: [Damian W. Betebenner, Adam R. VanIwaarden, <em>National Center for the Improvement <br></br> of Educational Assessment (NCIEA)</em>]
date:  April 2015
language: en-US
rights:  Creative Commons Non-Commercial Share Alike 3.0
---
<div class='lead' id='document_lead'><p style='text-align:center;'> DRAFT REPORT - DO NOT CITE! <br></br> This report provides details about the Georgia Student Growth Model methodology and presents a descriptive analysis of the 2014 SGP calculation process and results. </p></div>
<!--SGPreport-->

<!-- 
This document was written by Damian Betebenner & Adam VanIwaarden for the State of Georgia Department of Education (DOE).

	Original Draft:  February 20, 2015
	Second Draft:    March 18, 2015
  Third Draft:     April 6, 2015
	...
-->




# Introduction

This report contains details on the 2013-2014 implementation of the student growth percentiles (SGP) model for the state of Georgia.  The National Center for the Improvement of Educational Assessment (NCIEA) contracted with the Georgia Department of Education (DOE) to implement the SGP methodology using data derived from the Georgia Student Assessment Program to create the [Georgia Student Growth Model](http://www.gadoe.org/Curriculum-Instruction-and-Assessment/Assessment/Pages/Georgia-Student-Growth-Model.aspx).  The goal of the engagement with DOE is to create a set of open source analytics techniques and conduct a set of initial analyses that will eventually be conducted by DOE in following years.

The SGP methodology is an open source norm- and criterion-referenced student growth analysis that produces student growth percentiles and student growth projections/targets for each student with longitudinal data in the state.  The methodology is currently used for many purposes.  States and districts have used the results in various ways including parent/student diagnostic reporting, institutional improvement, and school and educator accountability.  Specifics about the manner in which growth is included in school and educator accountability can be found in documents related to those accountability systems.  

The report includes four sections covering Data, Analytics, SGP Results, and Goodness of Fit:

- *Data* includes details on the decision rules used in the raw data preparation and student record validation.
- *Analytics* introduces some of the basic computational process and statistical methods implemented in 2013-2014.^[More in depth treatment of the SGP Methodology can be found [here](https://github.com/CenterForAssessment/SGP_Resources/tree/master/articles).]
- *SGP Results* provides basic descriptive statistics from the 2014 analyses.
- *Goodness of Fit* describes how well the statistical models used to produce SGPs fit Georgia students' data.  This includes discussion of goodness of fit plots and the student- and school-level correlations between SGP and prior achievement.

Additionally, multiple appendices are included.  Appendix A includes Goodness of Fit plots for all content areas and grades.  Appendix B provides a technical description of the SIMEX correction for measurement error with specific applications to Georgia.

# Data

Data for the Georgia Criterion-Referenced Competency Tests (CRCT) and End of Course Tests (EOCT) used in the SGP analyses were supplied by the Georgia DOE to the NCIEA for analysis in the fall of 2014.  The current longitudinal data set includes academic years 2006-2007 through 2013-2014.  Subsequent years' analyses will augment this multi-year data set allowing DOE to maintain a comprehensive longitudinal data set for all students taking the CRCT and EOCT assessments and transitioning to the [Georgia Milestones Assessment System.](http://www.gadoe.org/Curriculum-Instruction-and-Assessment/Assessment/Pages/Georgia-Milestones-Assessment-System.aspx)

Student Growth Percentiles have been produced for students that have a current score and at least one prior score in the same subject or a related content area.  SGPs were produced for grade-level (CRCT) Reading, English Language Arts (ELA), Social Studies, Science and Mathematics.  For the 2014 academic year SGPs were produced for EOCT courses including 9<sup>th</sup> Grade Literature, American Literature, U.S. History, Economics, Biology, Physical Science, Mathematics II, Coordinate Algebra and Analytic Geometry.

## Longitudinal Data
Growth analyses on assessment data require data that are linked to individual students over time.  Student growth percentile analyses require, at a minimum two, and preferably three years of assessment data for analysis of student progress.  To this end it is necessary that a unique student identifier be available so that student data records across years can be merged with one another and subsequently examined.  Because some records in the assessment data set contain students with more than one test score in a content area in a given year, a process to create unique student records in each content area by year combination was required in order to carry out subsequent growth analyses.  Furthermore, student records may be invalidated for other reasons.  The following business rules were used to either invalidate particular student records or select the appropriate record for use in the analyses.

### General business rules

1.  Student records are invalidated if the student identifier is not exactly 10 digits long.
2.  Student records with missing ("NA") scores or scale scores outside of the possible range (usually 0) are invalidated.
3.  Duplicate records that originated from the "unmatched" data files are invalidated.^[Both "Matched" (where student to school/district links have been verified) and "Unmatched" data files are available.  Unmatched data is added to the initial data file in hopes that it will possibly fill holes in students' score histories, but any current year SGPs produced will not be linked to any school, district or teacher.]
4.  If a student has a main and a retest score^[Retests were available in 2011-12 but retest data are no longer used in SGP calculations as of the 2012-13 school year.], the record with the lower score is invalidated.
5.  Student records with any administrative invalidation flag (for example, identifying test irregularities, students that did not attempt the test, or other issues) are invalidated.
6.  School years for which CRCT tests were aligned to QCC curriculum are invalidated (SGPs were not produced in previous years and have not been used as prior scores subsequently).

Beginning in 2014 the majority of the selection and invalidation of student records was performed by GaDOE.  Whereas in previous years NCIEA staff conducted the data cleaning using `R` prior to running the data analytics, GaDOE incorporated these business rules into the `SQL` code used to pull data from GaDOE's data warehouse.

### CRCT specific business rules

1.  If a student has multiple records (duplicate from the same subject, grade and administration period), their highest score was selected.
2.  Student records from schools identified by the Governor’s Office of Student Achievement (GOSA) as having artificially inflated student test scores from the 2008-2010 are invalidated.
3.  If a student took more than one assessment in the same subject and school year but was identified as being in two different grades, the record with the highest grade level was selected.

Table 1 shows the number of valid CRCT student records available for analysis after applying the general and CRCT specific business rules.^[This number does not represent the number of SGPs produced, however, because students are required to have at least one prior score available as well.]



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<thead>
<tr><td colspan='8' style='text-align: left;'>
**Table 1:** Number of Valid CRCT Student Records by Grade and Subject for 2014</td></tr>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='6' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Grades</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>3</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>4</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>5</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>6</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>7</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>8</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Reading</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>126,691</td>
<td style='text-align: right;'>124,832</td>
<td style='text-align: right;'>123,619</td>
<td style='text-align: right;'>124,700</td>
<td style='text-align: right;'>127,197</td>
<td style='text-align: right;'>126,158</td>
</tr>
<tr>
<td style='text-align: right;'>ELA</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>126,977</td>
<td style='text-align: right;'>124,679</td>
<td style='text-align: right;'>123,542</td>
<td style='text-align: right;'>124,571</td>
<td style='text-align: right;'>126,921</td>
<td style='text-align: right;'>125,945</td>
</tr>
<tr>
<td style='text-align: right;'>Social Studies</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>129,083</td>
<td style='text-align: right;'>127,135</td>
<td style='text-align: right;'>126,770</td>
<td style='text-align: right;'>127,152</td>
<td style='text-align: right;'>129,329</td>
<td style='text-align: right;'>128,298</td>
</tr>
<tr>
<td style='text-align: right;'>Science</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>129,604</td>
<td style='text-align: right;'>127,612</td>
<td style='text-align: right;'>127,219</td>
<td style='text-align: right;'>127,540</td>
<td style='text-align: right;'>129,772</td>
<td style='text-align: right;'>128,864</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>127,463</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>124,665</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>122,976</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>124,027</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>126,346</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>125,192</td>
</tr>
</tbody>
</table>

### EOCT specific business rules

1.  If a student has multiple records (duplicate from the same subject and administration period), their highest score was selected.
2.  For students who participate in two main administrations (i.e., students who failed and retook an EOCT course), the first attempt is used as a prior to produce an SGP for the final attempt.  In subsequent years, their final attempt may be used as a prior for other EOCT analyses.
3.  Students who have tested out of EOCT courses are invalidated.^[Beginning in the 2013-2014 school year, students had the opportunity to test out of an EOCT course by taking the test early and scoring at the Exceeds level. SGPs were not calculated for any test out attempt. Successful attempts, however, may be used as prior scores in subsequent years' analyses.]

Table 2 shows the total number of valid EOCT student records available for analysis after applying the general and EOCT specific business rules.



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<thead>
<tr><td colspan='2' style='text-align: left;'>
**Table 2:** Total Number of Valid EOCT Student Records by Subject for 2014</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Valid Records</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Grade 9 Lit</td>
<td style='text-align: right;'>134,863</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit</td>
<td style='text-align: right;'>114,511</td>
</tr>
<tr>
<td style='text-align: right;'>Economics</td>
<td style='text-align: right;'>107,313</td>
</tr>
<tr>
<td style='text-align: right;'>US History</td>
<td style='text-align: right;'>113,037</td>
</tr>
<tr>
<td style='text-align: right;'>Biology</td>
<td style='text-align: right;'>131,978</td>
</tr>
<tr>
<td style='text-align: right;'>Physical Science</td>
<td style='text-align: right;'>85,290</td>
</tr>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='text-align: right;'>143,211</td>
</tr>
<tr>
<td style='text-align: right;'>Analytic Geometry</td>
<td style='text-align: right;'>120,224</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics II</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>10,432</td>
</tr>
</tbody>
</table>

# Analytics

This section provides basic details about the calculation of student growth percentiles from Georgia state assessment data using the [R Software Environment](http://www.r-project.org/) in conjunction with the [SGP Package](https://github.com/CenterForAssessment/SGP).  More in depth treatment of the data analysis process, including code examples, has been provided to GaDOE staff in the 2014 Calculation Manual.

Broadly, the SGP analysis of the Georgia longitudinal student assessment data takes place in two steps:

1. Data Preparation
2. Data Analysis

Those familiar with data analysis know that the bulk of the effort in the above two step process lies with Step 1: Data Preparation.  Following thorough data cleaning and preparation, data analysis using the SGP Package takes clean data and makes it as easy as possible to calculate, summarize, output and visualize the results from SGP analyses.

## Data Preparation

The data preparation step involves taking data provided by the GaDOE and producing a `.Rdata` file that will subsequently be analyzed in Step 2. This process is carried out annually as new data becomes available from the state assessment program.  The data supplied by the GaDOE Information Technology department and subsequently cleaned and processed using a two step process:

<div class='caption'>**Step 1a.** Initial data extraction and cleaning</div>

In this first step a clean data set is extracted from the Georgia student data warehouse using an internal `SQL` connection and command script. Through this process, student records are selected and invalidated based upon the [business rules discussed above](#general-business-rules). The end result is an exported, pipe-delimited file where a each valid student record is unique by content area, school year, student identifier (GTID), and test administration period.

<div class='caption'>**Step 1b.** Final data cleaning and preparation in `R`</div>

In this step the clean data from step 1a is read into [`R`](http://www.r-project.org/) and modified slightly with regard to variable types/classes. The result is an `.Rdata` file that is suitable for analysis with the [SGP Package](https://github.com/CenterForAssessment/SGP).  In previous years' analyses the bulk of the data cleaning and implementation of business rule validation from step 1a was also performed in `R` by NCIEA staff.  However, the division of the cleaning and validation tasks used in 2014 is an important step in moving towards GaDOE self-sufficiency in calculating growth percentiles in subsequent years.

The cleaned and formatted data is finally combined with the existing data housed in the Georgia [SGP class object](http://cran.r-project.org/web/packages/SGP/SGP.pdf), which was created through the 2013 analyses.  With an appropriate longitudinal data prepared, we move to the calculation and estimation of student-level SGPs.

## 2014 Data Analysis

The objective of the student growth percentile (SGP) analysis is to describe how (a)typical a student's growth is by examining his/her current achievement relative to students with a similar achievement history; i.e his/her *academic peers* (see [Section 2 of the GSGM FAQ](https://docs.google.com/viewer?url=http%3A%2F%2Fwww.gadoe.org%2FCurriculum-Instruction-and-Assessment%2FAssessment%2FDocuments%2FSGP%2520FAQ%2520072214.pdf)). The estimation of this norm-referenced growth quantity is conducted using quantile regression [@Koenker:2005] to model curvilinear functional relationships between student's prior and current scores.  One hundred such regression calculations are run for each separate analysis (defined as a unique year by content area by grade by prior order combination).  The end product of these 100 separate regression models is a single coefficient matrix, which serves as a look-up table to relate prior student achievement to current achievement for each percentile. This process ultimately leads to the calculation of tens of thousands of calculations per year (and many more when SIMEX measurement error corrections are performed) during each of Georgia's annual batch of analyses.  For a more in-depth discussion of the calculation and estimation of SGPs, see Betebenner ([-@Betebenner:2009]), and see Shang, VanIwaarden and Betebenner ([@ShangVanIBet:2015]) and Appendix B of this report for further information on the SIMEX measurement error correction methodology.

The 2014 Georgia SGP analyses follow a work flow established in previous years that includes the following 6 steps:

1. Update the Georgia assessment meta-data required for SGP calculations using the `SGP` Package.
2. Create annual SGP configurations for EOCT analyses.
3. Create any baseline matrices and SIMEX baseline coefficient matrices needed for new content areas sequences.
4. Conduct CRCT SGP Analyses.
5. Conduct EOCT SGP Analyses.
6. Combine results into the master longitudinal data set, summarize results and output data.

### Update Georgia meta-data in `SGP` Package

The use of higher-level functions included in the SGP package (e.g. `analyzeSGP`) requires the availability of state specific assessment information.  This meta-data is compiled in a `R` object named `SGPstateData` that is housed in the package.  The required updates for the 2014 analyses included a) the additions of knots and boundaries, proficiency level cutscores, and conditional standard errors of measurement (CSEMs) for Analytic Geometry, b) adding a new variable to the Variable Name Lookup table, and c) updating the norm group preferences object.

<div class='caption'>**Calculation and addition of knots and boundaries**</div>
Calculation of SGPs includes the use of cubic B-spline basis functions to more adequately model the heteroscedasticity and non-linearity found in assessment data.^[It should be noted that the independent estimation of the regression functions can potentially result in the crossing of the quantile functions.  This occurs near the extremes of the distributions and is potentially more likely to occur given the use of non-linear functions.  A potential result of allowing the quantile functions to cross would be *lower* percentile estimations of growth for *higher* observed scale scores at the extremes (give all else equal in prior scores) and vice versa.  In order to deal with these contradictory estimates, quantile regression results are isotonized to prevent quantile crossing following the methods derived by Chernozhukov, Fernandez-Val and Glichon [-@chernozhukov2010quantile].]  These functions require the selection of boundary and interior knots.  Boundary knots are end-points outside of the scale score distribution that anchor the B-spline basis.  These are generally selected by extending the entire range of scale scores by 10%.  That is, they are defined as lying 10% below the lowest obtainable (or observed) scale score (LOSS) and 10% above the highest obtainable scale score (HOSS).  The interior knots are the *internal* breakpoints that define the spline.  The default choice in the `SGP` package [@sgp2015] is to select the 20<sup>th</sup>, 40<sup>th</sup>, 60<sup>th</sup> and 80<sup>th</sup> quantiles of the observed scale score distribution.

In general the knots and boundaries are computed from a distribution comprised of several years of test data (i.e. multiple cohorts) so that any irregularities in a single year are smoothed out.  This is important because subsequent annual analyses use these same knots and boundaries as well.  All defaults were used to compile the knots and boundaries for Georgia from the CRCT and EOCT tests in previous years, and were also used in 2014 to compute the Analytic Geometry knots and boundaries.  New knots and boundaries will be required for Georgia Milestones assessments beginning in 2016 at which point they will be used as the dependent variables in the quantile regressions.

<div class='caption'>**Proficiency level cutscores**</div>
Cutscores, which are set externally by the GaDOE through standard-setting processes, are mainly required for student growth projections, which were not computed as part of the 2014 analyses.^[Projections were not included in the 2014 analyses due to the switch to Georgia Milestones Assessments in 2015.  Student Growth Projections assume consistency in assessment programs.  It would therefore would be nonsensical to project progress toward tests that will never be taken.]  However, they may likely be used in future years and so were added at this point. 

<div class='caption'>**Conditional standard errors of measurement (CSEMs)**</div>
The calculation of SIMEX adjusted student growth percentiles requires the availability of each assessments' standard errors of measurement.  The CSEM data for all other content areas had been compiled and added in previous years, but were required for Analytic Geometry in this initial year of testing.  Raw CSEM data was provided by GaDOE in spreadsheets and the NCIEA compiled this into an appropriate `R` data object for inclusion in the `SGPstateData` file.

<div class='caption'>**The "Variable Name Lookup" table**</div>
The `SGPstateData` file also includes a lookup table that allows various functions in the SGP package to translate between the naming conventions used within them and the variable names that the GaDOE uses.  The 2014 data included a gifted and talented student identifier, which was used in result summarizations.

<div class='caption'>**Norm group preferences**</div>
The process through which EOCT analyses are run can produce multiple SGPs for some students.  In order to identify which quantity will be used as the students' "official" SGP and subsequently merged into the master longitudinal data set, a system of norm group preferencing is established and is encoded into a lookup table and included in the `SGPstateData`.  In general, the preference is given to:

- Progressions with the greatest number of prior scale scores.
- Progressions in which a student has repeated a course.
- Progressions that do not include a skipped year (i.e. a gap in the scale score history).
- Progressions for block-schedule course taking patterns.

The next section describes the process by which the individual course progression analyses are established and how the preferencing system is included within their configuration code.

### Create annual SGP configurations.

Unlike CRCT analyses, EOCT analyses are specialized enough so that it is necessary to specify the analyses to be performed via explicit configuration code.  For several years, configurations have been employed to conduct EOCT SGP analyses for Georgia. The configurations are broken up into four separate R scripts based on content domain (literature, mathematics, science and social studies).  Each configuration specifies a set of parameters that defines the norm group of students to be examined.  Every potential norm group is defined by, at a minimum, the progressions of content area, academic year and grade-level.  Each configuration used for the Georgia EOCT analyses contain these elements:

- **`sgp.content.areas`:** A progression of values that specifies the content areas to be looked at and the order in which the courses were taken.
- **`sgp.panel.years`:** The progression of the years associated with the content area progression (`sgp.content.areas`) provided in the configuration, potentially allowing for skipped years, block schedules, etc.
- **`sgp.grade.sequences`:** The grade progression associated with the content area and year progressions provided in the configuration. *'EOCT'* stands for 'End Of Course Test'.  The use of the generic *'EOCT'* allows for secondary students to be compared based on the pattern of course taking rather than being dependent upon grade-level/class-designation.
- **`sgp.panel.years.within`:** A vector of same length as the year progression (sgp.panel.years) indicating what observation is to be used for the individual student (when multiple observations exist within a single year).  Typically the "Last" observation is used as the prior score (covariate) and the "First" observation is used as the current year score (outcome).
- **`sgp.exact.grade.progression`:** A Boolean argument (set to TRUE) indicating whether to run the EXACT configuration as written (rather than taking progressively restricted nested subsets of the configuration if FALSE).
- **`sgp.calculate.simex`:** A Boolean argument indicating whether cohort-referenced SIMEX adjustment analyses should be run as part of the analysis for this configuration.  Excluding the argument (or explicitly setting to NULL) has the same effect as setting it to FALSE. 
- **`sgp.calculate.simex.baseline`:** A Boolean argument indicating whether baseline-referenced SIMEX adjustment analyses should be run as part of the analysis for this configuration.  Excluding the argument (or explicitly setting to NULL) has the same effect as setting it to FALSE. 
- **`sgp.norm.group.preference`:** Because a student can potentially be included in more than one analysis/configuration, this argument provides a ranking specifying which SGP is preferable for being matched with the student in the [`combineSGP`](https://github.com/CenterForAssessment/SGP/blob/master/R/combineSGP.R) step.  *Lower numbers correspond with higher preference.*

As an example, here is one of the Biology configurations used to defined the 2014 SGP analyses:

```R
...

  BIOLOGY.2014 = list(
		sgp.content.areas=c('SCIENCE', 'PHYSICAL_SCIENCE', 'BIOLOGY'),
		sgp.panel.years=c('2012', '2013', '2014'),
		sgp.grade.sequences=list(c('8', 'EOCT', 'EOCT')),
		sgp.panel.years.within=c('LAST_OBSERVATION', 'LAST_OBSERVATION', 'FIRST_OBSERVATION'),
		sgp.exact.grade.progression=TRUE,
		sgp.calculate.simex=TRUE,
		sgp.calculate.simex.baseline=TRUE,
		sgp.norm.group.preference=4), 
...

```

Configurations are `R` scripts that are sourced as part of the larger SGP analysis to be discussed later and to construct the norm group preference object discussed previously.

### Create baseline and SIMEX baseline coefficient matrices.

The 2014 CRCT & EOCT analyses Georgia employed baseline-referenced and SIMEX adjusted baseline-referenced SGPs. For most grade and content area analyses the coefficient matrices required to produce these results were produced prior to 2014. However, baseline matrices for several EOCT course progressions were found to have adequate data for baseline matrix construction. 

Baseline coefficient matrices differ form traditional cohort-referenced matrices in that they are produced using a "super-cohort" of students rather than a single year cohort.  For example, the baseline super-cohort for the Biology course sequence shown above consisted of three combined cohorts using GPS Science and EOCT Physical Science and Biology test scores from 2008 to 2012.  Every student who took Biology in the 2010, 2011 and 2012 academic years with consecutive Physical Science and 8<sup>th</sup> grade Science prior scale scores would have been included in the calculations of the Growth Percentile regression equations.  Because most baseline coefficient matrices were produced using previous years' data, the 2014 cohort data does not contribute to the calculation of the models used to produce their SGPs.  Additional general information about baseline analyses can be found in the discussion of [Median SGP results below](#baseline-referenced-median-sgps).

The baseline matrices produced in 2014 were created using the same years of data as those previously produced in those content areas.  American Literature and 9<sup>th</sup> Grade Literature matrices (adding in skipped year patterns not previously modeled) were produced using data from 2007 to 2012 and US History matrices were produced using data from 2008 to 2013.  These matrices were then added to the existing collection and their course progressions added in the 2014 configuration scripts.

The baseline-referenced, SIMEX-corrected versions of these matrices were then produced using the uncorrected versions as the "naive" model.  Details of the SIMEX procedure can be found in Appendix B of this report.  In all 200 - 400 matrices were produced for each course progression depending on the number of priors used.

### Conduct CRCT SGP Analyses

The CRCT grade level ELA, Reading, Math, Science and Social Studies analyses were conducted separately from the EOCT course analyses.  Mainly this is done because the CRCT analyses do not require custom configuration scripts like EOCT does.  Given the simplistic use of only the same test as prior test scores in these analyses, the SGP package's functions can identify the analyses to be conducted internally.  This also allows the analyses to be completed and checked, and interim results saved which is sometimes necessary due to the computationally intensive nature of the analysis, particularly with a state the size of Georgia.

The `analyzeSGP` function was used to calculate all SGPs.  Initial 2014 analyses included the baseline and SIMEX corrected baseline SGP production (the "official" SGPs), as well as annual cohort-referenced SGPs.^[Cohort referenced SGPs are not used in a official capacity, but are calculated as an additional resource for GaDOE.  Note that CRCT cohort-referenced SGPs have used all available prior information, whereas Baseline referenced SGPs use only 2 prior years of data.]  SIMEX corrected cohort-referenced SGPs were produced subsequent to requests made by the Georgia Educator Effectiveness Technical Advisory Committee.

### Conduct EOCT SGP Analyses

The EOCT content area progression specific analyses were then calculated using the configuration scripts described above.  The baseline-referenced content areas were analyzed separately from the cohort-referenced subjects (mathematics domain).  This was done due to the computationally intensive nature of the calculations rather than necessity, as all relevant argument controls are specified in the configuration scripts.  As with the CRCT analyses, cohort-referenced SIMEX corrected versions of all SGPs were eventually produced.^[Unlike the CRCT, EOCT cohort-referenced SGPs use only 2 prior years of data as specified in the configuration scripts.]

### Merge 2014 results into the longitudinal data, summarize and output.

Once all analyses are completed the results are merged into the master longitudinal data set in the `@Data` slot of the SGP class object using the `combineSGP` function.  The data is then summarized using the `summarizeSGP` function, which produced many tables of descriptive statistics that are disaggregated at the state, district, school and instructor levels.  These basic summary tables are also further disaggregated by the demographic groups available in the data set and listed in [Georgia's Variable Name Lookup table](https://github.com/CenterForAssessment/SGPstateData/blob/master/Variable_Name_Lookup/GA_Variable_Name_Lookup.csv).  Finally, a pipe delimited version of the complete long data is output.  Additionally for Georgia, the NCIEA produces a formatted version of the 2014 results, which contains fields needed for rendering data in the state's [visualization tool](http://gastudentgrowth.gadoe.org/) such as students' entire prior score and course progression history.


# SGP Results

In the following sections basic descriptive statistics from the 2014 analyses are provided, including the state-level mean and median growth percentiles.  Currently Georgia uses either cohort or baseline-referenced SGPs as the official student-level growth metric, depending upon the content area.  The goal is to eventually use only baseline-referenced SGPs, however this requires an assessment program to have been established for several years.  Given that EOCT math courses have undergone changes in recent years, only cohort-referenced SGPs are currently available for them.  Similarly, the upcoming transition from the CRCT and EOCT to [Georgia Milestones](http://www.gadoe.org/Curriculum-Instruction-and-Assessment/Assessment/Pages/Georgia-Milestones-Assessment-System.aspx) assessments will require the exclusive use of cohort-referenced analyses for several years until baseline referencing is again feasible.  

Georgia DOE has also recently decided to implement the SIMEX measurement error correction method in the calculation of student-level SGPs.  This correction has been applied to both cohort and baseline-referenced SGPs and the descriptive statistics from these analyses are also presented here.  The interested reader can find more in depth discussions of the cohort and baseline-referenced SGP methodology in the [available literature](https://github.com/CenterForAssessment/SGP_Resources/tree/master/articles), and information about the SIMEX measurement error correction methodology is available in Appendix B of this report as well as in recent academic articles [@ShangVanIBet:2015].

## Cohort Referenced Median SGPs
Growth percentiles, being quantities associated with each individual student, can be easily summarized across numerous grouping indicators to provide summary results regarding growth.  The median and mean of a collection of growth percentiles are used as measures of central tendency that summarize the distribution as a single number.  With perfect data fit, we expect the state median of all student growth percentiles in any grade to be 50 because the data are norm-referenced across all students in the state.  Median (and mean) growth percentiles well below 50 represent growth less than the state "average" and median growth percentiles well above 50 represent growth in excess of the state "average".

To demonstrate the norm-referenced nature of the growth percentiles viewed at the state level, Table 3 presents the cohort-referenced growth percentile medians and means for the EOCT mathematics based content areas.  



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<thead>
<tr><td colspan='3' style='text-align: left;'>
**Table 3:** EOCT Median and Mean <em>Cohort</em> Referenced Student Growth Percentile by Content Area for 2014</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median SGP</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean SGP</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>49.7</td>
</tr>
<tr>
<td style='text-align: right;'>Analytic Geometry</td>
<td style='text-align: center;'>49</td>
<td style='text-align: center;'>49.4</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics II</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>50</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>49.8</td>
</tr>
</tbody>
</table>

Based upon perfect model fit to the data, the median of all state growth percentiles in each grade by year by subject combination should be 50.  That is, in the conditional distributions, 50 percent of growth percentiles should be less than 50 and 50 percent should be greater than 50.  Deviations from 50 indicate imperfect model fit to the data.  Imperfect model fit can occur for a number of reasons, some due to issues with the data (e.g., floor and ceiling effects leading to a "bunching" up of the data) as well as issues due to the way that the SGP function fits the data.  The results in Table 3 are close to perfect, with almost all values equal to 50.

The results are coarse in that they are aggregated across tens of thousands of students.  More refined fit analyses are presented in the [Goodness-of-Fit section that follows](#goodness-of-fit).  Depending upon feedback from Georgia DOE, it may be desirable to tweak with some operational parameters and attempt to improve fit even further.  The impact upon the operational results based on better fit is expected to be extremely minor.

It is important to note how, at the entire state level, the *norm-referenced* growth information returns little information on annual trends due to its norm-reference nature.  What the results indicate is that a typical (or average) student in the state demonstrates 50<sup>th</sup> percentile growth.  That is, "typical students" demonstrate "typical growth".  One benefit of the norm-referenced results follows when subgroups are examined (e.g., schools, district, demographic groups, etc.) Examining subgroups in terms of the median of their student growth percentiles, it is then possible to investigate why some subgroups display lower/higher student growth than others.  Moreover, because the subgroup summary statistic (i.e., the median) is composed of many individual student growth percentiles, one can break out the result and further examine the distribution of individual results.  

## Baseline Referenced Median SGPs
Baseline SGPs allow one to look at norm-referenced growth through another lens.  Rather than considering a single year's cohort, baseline SGPs are referenced against a "super-cohort" consisting of several years of students linked by common course/grade progressions.  This super-cohort serves as a baseline against which future annual cohorts can be compared, which allows for the examination of whether or not the system as a whole might be improving (or declining) in terms of growth over time relative to the baseline group.  If the system is improving over time, we would see those higher levels of effectiveness in the form of median SGPs that are greater than 50 (what *was* a higher rate of growth in the past is now typical growth).  An assumption required for the use of baseline-referenced SGPs is that the scale scores are well anchored.  If this assumption is violated, then any deviation from "typical" growth may be purely an artifact of the test scaling procedure.  States transitioning from old test to new tests, for example, must reset their baseline growth because a new scale is in effect.  Table 4 provides the median and mean baseline-referenced results from Georgia's CRCT assessments and Table 5 provides the EOCT results.



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<thead>
<tr><td colspan='7' style='text-align: left;'>
**Table 4:** CRCT Median (Mean) <em>Baseline</em> Student Growth Percentile by Grade and Content Area for 2014</td></tr>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='5' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Grades</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>4</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>5</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>6</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>7</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>8</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Reading</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>59 (56.6)</td>
<td style='text-align: right;'>48 (48.7)</td>
<td style='text-align: right;'>61 (58)</td>
<td style='text-align: right;'>58 (55.7)</td>
<td style='text-align: right;'>60 (55.9)</td>
</tr>
<tr>
<td style='text-align: right;'>ELA</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>48 (48.3)</td>
<td style='text-align: right;'>46 (47.1)</td>
<td style='text-align: right;'>43 (45.2)</td>
<td style='text-align: right;'>57 (54.8)</td>
<td style='text-align: right;'>45 (46.1)</td>
</tr>
<tr>
<td style='text-align: right;'>Social Studies</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>50 (49.5)</td>
<td style='text-align: right;'>48 (48.3)</td>
<td style='text-align: right;'>52 (51.5)</td>
<td style='text-align: right;'>48 (48.5)</td>
<td style='text-align: right;'>47 (47.8)</td>
</tr>
<tr>
<td style='text-align: right;'>Science</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>55 (53.2)</td>
<td style='text-align: right;'>50 (49.7)</td>
<td style='text-align: right;'>46 (47.5)</td>
<td style='text-align: right;'>54 (52.8)</td>
<td style='text-align: right;'>54 (52.4)</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>49 (49.6)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>44 (45.1)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>56 (54.1)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>37 (40.6)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>52 (50.4)</td>
</tr>
</tbody>
</table>




<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<thead>
<tr><td colspan='3' style='text-align: left;'>
**Table 5:** EOCT Median and Mean <em>Baseline</em> Referenced Student Growth Percentile by Content Area for 2014</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median SGP</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean SGP</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Grade 9 Lit</td>
<td style='text-align: center;'>51</td>
<td style='text-align: center;'>50.7</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit</td>
<td style='text-align: center;'>48</td>
<td style='text-align: center;'>48.7</td>
</tr>
<tr>
<td style='text-align: right;'>Economics</td>
<td style='text-align: center;'>52</td>
<td style='text-align: center;'>51.0</td>
</tr>
<tr>
<td style='text-align: right;'>US History</td>
<td style='text-align: center;'>45</td>
<td style='text-align: center;'>46.5</td>
</tr>
<tr>
<td style='text-align: right;'>Biology</td>
<td style='text-align: center;'>43</td>
<td style='text-align: center;'>45.0</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Physical Science</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>48</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>48.3</td>
</tr>
</tbody>
</table>


## SIMEX Adjusted Student Growth Percentiles
The use of error-prone standardized test scores in statistical models can lead to numerous problems.  Understanding the effects of measurement error and correcting it is particularly difficult in the SGP model given that it is based on non-parametric quantile regression.  Preliminary investigations suggest that the use of error-prone measures may lead SGP estimates to be inflated for students with high prior achievement and underestimated for students with lower prior achievement.  This bias at the individual student-level can translate to bias in aggregate measures (such as median and mean SGPs) when student sorting based on prior achievement exists at the level of aggregation (e.g.  classrooms or schools).  As a result, growth and prior achievement are (positively) correlated, giving schools and teachers with higher achieving students an undue advantage and disadvantaging those with a preponderance of low achieving students.  

Simulation-extrapolation (SIMEX) methods of correcting for measurement error induced bias in the SGP estimation has been proposed and recently tested in Georgia.  Descriptive statistics from these analyses are provided here and in the [Goodness-of-Fit](#goodness-of-fit) section.  Additional technical information about the SIMEX procedure in general and its use in the calculation of cohort and baseline-referenced SGPs is provided in Appendix B of this report.



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<thead>
<tr><td colspan='3' style='text-align: left;'>
**Table 6:** SIMEX Corrected EOCT Median and Mean <em>Cohort</em> Referenced Student Growth Percentile by Content Area for 2014</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median SGP</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean SGP</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>50.1</td>
</tr>
<tr>
<td style='text-align: right;'>Analytic Geometry</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>49.7</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics II</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>50</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>50.1</td>
</tr>
</tbody>
</table>




<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<thead>
<tr><td colspan='7' style='text-align: left;'>
**Table 7:** SIMEX Corrected CRCT Median (Mean) <em>Baseline</em> Student Growth Percentile by Grade and Content Area for 2014</td></tr>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='5' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Grades</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>4</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>5</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>6</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>7</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>8</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Reading</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>57 (55.9)</td>
<td style='text-align: right;'>47 (47.9)</td>
<td style='text-align: right;'>60 (57.5)</td>
<td style='text-align: right;'>58 (54.7)</td>
<td style='text-align: right;'>60 (55.2)</td>
</tr>
<tr>
<td style='text-align: right;'>ELA</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>46 (48)</td>
<td style='text-align: right;'>46 (46.6)</td>
<td style='text-align: right;'>42 (44.6)</td>
<td style='text-align: right;'>57 (54.8)</td>
<td style='text-align: right;'>44 (45.7)</td>
</tr>
<tr>
<td style='text-align: right;'>Social Studies</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>48 (49.2)</td>
<td style='text-align: right;'>47 (48.2)</td>
<td style='text-align: right;'>52 (51.7)</td>
<td style='text-align: right;'>48 (48.2)</td>
<td style='text-align: right;'>47 (47.7)</td>
</tr>
<tr>
<td style='text-align: right;'>Science</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>54 (53)</td>
<td style='text-align: right;'>50 (49.4)</td>
<td style='text-align: right;'>46 (47.3)</td>
<td style='text-align: right;'>54 (52.8)</td>
<td style='text-align: right;'>53 (52.1)</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (49.3)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>43 (44.7)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>56 (54.1)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>36 (39.9)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>51 (50.3)</td>
</tr>
</tbody>
</table>




<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<thead>
<tr><td colspan='3' style='text-align: left;'>
**Table 8:** SIMEX Corrected EOCT Median and Mean <em>Baseline</em> Referenced Student Growth Percentile by Content Area for 2014</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median SGP</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean SGP</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Grade 9 Lit</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>50.2</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit</td>
<td style='text-align: center;'>47</td>
<td style='text-align: center;'>47.9</td>
</tr>
<tr>
<td style='text-align: right;'>Economics</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>50.5</td>
</tr>
<tr>
<td style='text-align: right;'>US History</td>
<td style='text-align: center;'>43</td>
<td style='text-align: center;'>45.9</td>
</tr>
<tr>
<td style='text-align: right;'>Biology</td>
<td style='text-align: center;'>42</td>
<td style='text-align: center;'>44.5</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Physical Science</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>47</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>47.9</td>
</tr>
</tbody>
</table>


A comparison of the unadjusted (Tables 3 to 5) and SIMEX corrected (Tables 6 through 8) shows very little difference in the medians and means.  This is not surprising as the majority of the growth percentiles for students in the middle of the prior score distributions change very little, and the larger changes that occur for students in the extremes of the prior score distributions tend to even out.  

# Goodness of Fit
Examination of goodness-of-fit was conducted by comparing the estimated conditional density with the theoretical uniform density of the SGPs.  Despite the use of B-splines to accommodate heteroscedasticity and skewness of the conditional density, assumptions are made concerning the number and position of spline knots that impact the percentile curves that are fit.  With an infinite population of test takers, at each prior scaled score, with perfect model fit, the expectation is to have 10 percent of the estimated growth percentiles between 1 and 9, 10 and 19, 20 and 29, ..., and 90 and 99.  Deviations from 10 percent would be indicative of lack of model fit.  

## Model Fit Plots
Using all available CRCT and EOCT scores as the variables, estimation of student growth percentiles was conducted for each possible student (those with a current score and at least one prior score).  Percentages of student growth percentiles between the 10<sup>th</sup>, 20<sup>th</sup>, 30<sup>th</sup>, 40<sup>th</sup>, 50<sup>th</sup>, 60<sup>th</sup>, 70<sup>th</sup>, 80<sup>th</sup>, and 90<sup>th</sup> percentiles were calculated based upon the decile of the prior year's scaled score (the total students in each for the analyses varies depending on grade and subject).  Results for the B-spline parameterizations for all CRCT and EOCT analyses are given in Appendix A.  



###  Cohort referenced model fit
The results in all subjects are excellent with a few exceptions.  Deviations from perfect fit are indicated by red and blue shading.  The further *above* 10 the darker the red, and the further *below* 10 the darker the blue.  In instances where large deviations from 10 occur, the likely cause is that there is a mass point associated with certain scale scores that makes it impossible to "split" the score at a dividing point forcing a majority of the scores into an adjacent cell.  This is the case with all large deviations observed in the Georgia data.  

Figure 1 shows the results for 8<sup>th</sup> grade ELA.  Although this CRCT subject is officially a baseline-referenced subject, we provide the plot here as an exemplar of cohort-referenced model fit with which to compare with baseline and SIMEX model fit using the same student data in subsequent sections.

<div class='caption'> **Figure 1:**   Goodness of Fit Plot for 2014 ***Cohort*** Referenced 8<sup>th</sup> Grade ELA. </div>
![](./img/Examples/Goodness_of_Fit/ELA.2014/gofSGP_Grade_8.png)


###  Baseline referenced model fit

Assumptions regarding model fit are much different for baseline-referenced models.  Perfect model fit is not expected, or even desired, in these analyses because the data from the 2014 cohort was not used to produce the baseline model parameter estimates.  As discussed above, these models may allow us to see whether or not the system as a whole might be improving (or declining) over time.  These changes would be indicated by model *misfit* in the goodness of fit plots.  A greater number of students with high growth (red cells on the right hand side of the first plots) would suggest system improvement.  Ideally we would see this for students in the entire range prior achievement.

Figure 2 shows how the baseline model fits the 2014 8<sup>th</sup> grade ELA student data.  Here we see that the model suggests student performance has declined relative to the established baseline.  This appears to be generally true for students from all prior achievement levels with the exception of students in the lowest decile of prior scores.

<p></p>

<div class='caption'> **Figure 2:**   Goodness of Fit Plot for 2014 ***Baseline*** Referenced 8<sup>th</sup> Grade ELA. </div>
![](./img/Examples/Goodness_of_Fit/ELA.2014.BASELINE/gofSGP_Grade_8.png)

###  SIMEX model fit

SIMEX model fit is also not expected to be perfect.  In this case we expect model misfit in the form of increased high SGPs for students with lower prior performance (and a complementary decrease in low SGPs for those students), and the reverse expectation for high achieving students.  This is visible in the goodness of fit plot in Figure 3 where the SIMEX correction method has been applied to the 8<sup>th</sup> grade ELA baseline model.

<p></p>

<div class='caption'> **Figure 3:**   Goodness of Fit Plot for 2014 ***SIMEX Corrected,*** Baseline Referenced 8<sup>th</sup> Grade ELA. </div>
![](./img/Examples/Goodness_of_Fit/ELA.2014.BASELINE.SIMEX/gofSGP_Grade_8.png)


## Student Level Results
To investigate the possibility that individual level misfit might impact summary level results, student growth percentile analyses were run on all students and the results were examined relative to prior achievement.  With perfect fit to data, the correlation between students' most recent prior achievement scores and their student growth percentiles is zero (i.e., the goodness of fit tables would have a uniform distribution of percentiles across all previous scale score levels).  To investigate in another way, correlations between prior student scale scores and student growth percentiles were calculated.^[In addition to providing information about model fit, these student-level correlations can assess potential impact of test ceiling effects.]

Student-level correlations between the various SGP versions (uncorrected and SIMEX corrected cohort and baseline-referenced estimates) and prior achievement are presented here.  The results are generally as expected.  With cohort-referenced percentiles, when the model is perfectly fit to the data, the correlation between students' most recent prior achievement scores and their student growth percentiles is zero (i.e., there is a uniform distribution of percentiles across all previous scale score levels).  Correlations for Georgia cohort-referenced SGPs are all essentially zero.  This provides assurance that the models have fit the data well, and indicate that students can demonstrate high (or low) growth regardless of prior achievement using cohort-referenced SGPs.

Baseline referenced growth percentiles relax assumptions about correlations and the aspiration for a uniform distribution of percentiles.  Rather than considering a single year's cohort, baseline SGPs are referenced against a "super-cohort" of several years of students linked by common course/grade progressions.  This allows us to examine whether or not the system as a whole might be improving (or declining) over time relative to the established baseline.  That is, if the system is improving over time, we would see that improvement in median SGPs that are greater than 50 (more than half of students would have growth greater than what *was* typical growth in the past).  Furthermore, if students at different levels of prior achievement experience differential growth a correlation greater or less than zero may be observed.^[A major assumption required in producing baseline-referenced SGPs is that the scale scores are well anchored.  If this assumption does not hold, then any deviation from "typical" growth may be purely and artifact of the test scaling procedure.  However, it would seem that this type of "scale drift" would be consistent across scale score levels.  Therefore it isn't clear that this would cause a differential impact on growth, and thereby a positive or negative correlation at the student level between growth and prior achievement.]  For example, if lower achieving students had consistently higher growth relative to the baseline cohort and higher achieving students had consistently lower growth, then a negative correlation would be expected at the student-level.  Although small, many correlations between baseline SGPs and prior achievement deviate from zero.

SIMEX corrected SGPs induce a negative correlation between growth and prior achievement (regardless of reference type) as shown in Table 9 below.  Rather than a uniform distribution, SIMEX produces a distribution in which growth for lower prior achieving students' growth is weighted upward and higher prior achieving students' growth is weighted down.  In theory this produces biased student-level SGPs but may decrease the bias in aggregate growth measures as has been documented previous SIMEX reports.  This in turn decreases the observed correlations between "uncorrected" SGPs and prior achievement^[Note that aggregate-level correlations that are initially negative also become increasingly negative rather than return to zero.  This has been noted in test results from other states not presented here.].


<p></p>

### CRCT


<!-- HTML_Start -->
<table class='gmisc_table' style='border-collapse: collapse;' >
<caption style='caption-side: top'>
CRCT Correlations between Student-Level Prior Standardized Scale Score and SGP Versions</caption>
<thead>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='4' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Aggregate Group Type</th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Grade</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Cohort SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Cohort SIMEX</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Baseline SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Baseline SIMEX</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>N Size</th>
</tr>
</thead>
<tbody> 
<tr><td colspan='8' style='font-weight: 900;'>Reading</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.04</td>
<td style='text-align: right;'>-0.14</td>
<td style='text-align: right;'>-0.05</td>
<td style='text-align: right;'>-0.17</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>116,555</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.01</td>
<td style='text-align: right;'>-0.11</td>
<td style='text-align: right;'> 0.04</td>
<td style='text-align: right;'>-0.06</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>116,011</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'>-0.15</td>
<td style='text-align: right;'>-0.25</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>115,579</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'> 0.05</td>
<td style='text-align: right;'>-0.06</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>118,100</td>
</tr>
<tr>
<td style='text-align: right;'>8</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'> 0.23</td>
<td style='text-align: right;'> 0.15</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>117,649</td>
</tr> 
<tr><td colspan='8' style='font-weight: 900;'>ELA</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.02</td>
<td style='text-align: right;'>-0.12</td>
<td style='text-align: right;'>-0.05</td>
<td style='text-align: right;'>-0.17</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>116,512</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>-0.16</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>115,884</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'> 0.10</td>
<td style='text-align: right;'> 0.01</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>115,387</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>-0.05</td>
<td style='text-align: right;'>-0.16</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>117,865</td>
</tr>
<tr>
<td style='text-align: right;'>8</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>-0.05</td>
<td style='text-align: right;'>-0.14</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>117,354</td>
</tr> 
<tr><td colspan='8' style='font-weight: 900;'>Mathematics</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.02</td>
<td style='text-align: right;'>-0.11</td>
<td style='text-align: right;'>-0.04</td>
<td style='text-align: right;'>-0.13</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>116,432</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'> 0.04</td>
<td style='text-align: right;'>-0.03</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>115,154</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>-0.06</td>
<td style='text-align: right;'>-0.14</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>114,434</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'> 0.09</td>
<td style='text-align: right;'> 0.01</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>116,981</td>
</tr>
<tr>
<td style='text-align: right;'>8</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.05</td>
<td style='text-align: right;'> 0.21</td>
<td style='text-align: right;'> 0.16</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>116,387</td>
</tr> 
<tr><td colspan='8' style='font-weight: 900;'>Science</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.01</td>
<td style='text-align: right;'>-0.10</td>
<td style='text-align: right;'>-0.05</td>
<td style='text-align: right;'>-0.16</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>119,841</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'>-0.10</td>
<td style='text-align: right;'>-0.17</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>119,799</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.06</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.07</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>119,473</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.05</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>121,273</td>
</tr>
<tr>
<td style='text-align: right;'>8</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.06</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'>-0.15</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>120,518</td>
</tr> 
<tr><td colspan='8' style='font-weight: 900;'>Social Studies</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.01</td>
<td style='text-align: right;'>-0.10</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.08</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>119,417</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'> 0.02</td>
<td style='text-align: right;'>-0.06</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>119,367</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.06</td>
<td style='text-align: right;'> 0.04</td>
<td style='text-align: right;'>-0.02</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>119,045</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.06</td>
<td style='text-align: right;'>-0.01</td>
<td style='text-align: right;'>-0.08</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>120,844</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>8</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'> 0.00</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.06</td>
<td style='border-bottom: 2px solid grey; text-align: right;'> 0.01</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.06</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>119,989</td>
</tr>
</tbody>
</table>
<p></p>


### EOCT Baseline Referenced Subjects


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<caption style='caption-side: top'>
**Table 10:** Correlations between Student-Level Prior Standardized Scale Score and EOCT Baseline Referenced SGP Versions</caption>
<thead>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='4' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Aggregate Group Type</th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Cohort SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Cohort SIMEX</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Baseline SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Baseline SIMEX</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>N Size</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Grade 9 Lit     </td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'>-0.19</td>
<td style='text-align: right;'>-0.27</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>121,063</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit    </td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'>-0.02</td>
<td style='text-align: right;'>-0.10</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>106,673</td>
</tr>
<tr>
<td style='text-align: right;'>US History      </td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.01</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>-0.02</td>
<td style='text-align: right;'>-0.10</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>101,613</td>
</tr>
<tr>
<td style='text-align: right;'>Economics       </td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>-0.03</td>
<td style='text-align: right;'>-0.09</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>95,447</td>
</tr>
<tr>
<td style='text-align: right;'>Biology         </td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'>-0.03</td>
<td style='text-align: right;'>-0.10</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>119,521</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Physical Science</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'> 0.00</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.07</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.02</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.09</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>78,867</td>
</tr>
</tbody>
</table>
<p></p>


### EOCT Cohort Referenced Subjects


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<caption style='caption-side: top'>
**Table 11:** Correlations between Student-Level Prior Standardized Scale Score and EOCT Cohort Referenced SGP Versions</caption>
<thead>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='2' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Aggregate Group Type</th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Cohort SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Cohort SIMEX</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>N Size</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>129,534</td>
</tr>
<tr>
<td style='text-align: right;'>Analytic Geometry </td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.02</td>
<td style='text-align: right;'>-0.08</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>110,958</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics II    </td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.00</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.08</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'> 7,805</td>
</tr>
</tbody>
</table>


## Group Level Results
Unlike when reporting SGPs at the individual level, when aggregating to the group level (e.g., school) the correlation between aggregate prior student achievement and aggregate growth is rarely zero.  The correlation between prior student achievement and growth at the school level is a compelling descriptive statistic because it indicates whether students attending schools serving higher achieving students grow faster (on average) than those students attending schools serving lower achieving students.  Results from previous state analyses show a correlation between prior achievement of students associated with a current school (quantified as percent at/above proficient) and the median SGP to be between 0.1 and 0.3.  That is, these results indicate that on average, students attending schools serving lower achieving students tend to demonstrate less exemplary growth than those attending schools serving higher achieving students.  Equivalently, based upon ordinary least squares (OLS) regression assumptions, the prior achievement level of students attending a school accounts for between 1 and 10 percent of the variability observed in student growth.  There are no definitive numbers on what this correlation should be, but studies on value-added models show similar results [@MccaLock:2008].

### School Level Results

To illustrate these relationships visually, the bubble charts in Figures 4 through 8 depict growth as quantified by the median SGP of students at the school against  achievement/status, quantified by percentage of student at/above proficient (advanced) at the school.  The charts have been successful in helping to motivate the discussion of the two qualities: student achievement and student growth.  Though the figures are not detailed enough to indicate strength of relationship between growth and achievement, they are suggestive and valuable for discussions with stakeholders who are being introduced to the growth model for the first time.



<div class='caption'> **Figure 4:**   School-level Bubble Plots for Georgia:  ELA, 2013-2014. </div>
![](./img/Bubble_Plots/2014/State/Style_1/Georgia_2014_ELA_State_Bubble_Plot_(Prior_Achievement).png)

<p></p>
<p></p>

<div class='caption'> **Figure 5:**   School-level Bubble Plots for Georgia:  Reading, 2013-2014. </div>
![](./img/Bubble_Plots/2014/State/Style_1/Georgia_2014_Reading_State_Bubble_Plot_(Prior_Achievement).png)

<p></p>
<p></p>

<div class='caption'> **Figure 6:**   School-level Bubble Plots for Georgia:  Mathematics, 2013-2014. </div>
![](./img/Bubble_Plots/2014/State/Style_1/Georgia_2014_Mathematics_State_Bubble_Plot_(Prior_Achievement).png)

<p></p>
<p></p>

<div class='caption'> **Figure 7:**   School-level Bubble Plots for Georgia:  Science, 2013-2014. </div>
![](./img/Bubble_Plots/2014/State/Style_1/Georgia_2014_Science_State_Bubble_Plot_(Prior_Achievement).png)

<p></p>
<p></p>

<div class='caption'> **Figure 8:**   School-level Bubble Plots for Georgia:  Social Studies, 2013-2014. </div>
![](./img/Bubble_Plots/2014/State/Style_1/Georgia_2014_Social Studies_State_Bubble_Plot_(Prior_Achievement).png)

The relationship between average prior student achievement and median SGP observed for Georgia is relatively strong compared to some other states for which the Center has done SGP analyses.  Table 12 shows correlations between prior achievement (measured as the mean prior standardized scale score as well as the percent at/above proficient at the school^[Percent Prior Proficient in this case is determined by the percent of student's that scored in the Proficient or Advanced range of all student's that received a score.  This measure does not reflect student's that did not receive a score but are included in the denominator of Percent Meeting Standard as displayed in the DOE Georgia Report Card.]).  All results shown here are for schools with 15 or more students.

<p></p>




<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<caption style='caption-side: top'>
**Table 12:** Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs - (Combined Subjects)</caption>
<thead>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='4' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>SGP Aggregate Type</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Year</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SIMEX</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SIMEX</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.60</td>
<td style='text-align: right;'>0.61</td>
<td style='text-align: right;'>0.45</td>
<td style='text-align: right;'>0.47</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.58</td>
<td style='text-align: right;'>0.58</td>
<td style='text-align: right;'>0.41</td>
<td style='text-align: right;'>0.42</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>2014</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.54</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.55</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.38</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.38</td>
</tr>
</tbody>
</table>

<p></p>

Correlation tables describing the relationship between prior achievement (defined here as mean prior standardized scale score) and aggregate growth percentiles are presented below in separate subsections for CRCT and EOCT subjects.  The first correlation table in the each subsection provides these overall SGP aggregates' relationships with mean prior standardized scale scores.  The additional correlation tables are dis-aggregated by content area, and content area and grade to provide more detail.

<p></p>

***CRCT***


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<caption style='caption-side: top'>
**Table 13:** CRCT Correlations between School-Level Mean Prior Standardized Scale Score and (Baseline) SGP Aggregations.</caption>
<thead>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='4' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Aggregate SGP Type</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Year</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SIMEX</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SIMEX</th>
</tr>
</thead>
<tbody> 
<tr><td colspan='6' style='font-weight: 900;'>Reading</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.58</td>
<td style='text-align: right;'>0.60</td>
<td style='text-align: right;'>0.34</td>
<td style='text-align: right;'>0.37</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.58</td>
<td style='text-align: right;'>0.60</td>
<td style='text-align: right;'>0.33</td>
<td style='text-align: right;'>0.34</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.58</td>
<td style='text-align: right;'>0.61</td>
<td style='text-align: right;'>0.38</td>
<td style='text-align: right;'>0.39</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Ela</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.48</td>
<td style='text-align: right;'>0.50</td>
<td style='text-align: right;'>0.3</td>
<td style='text-align: right;'>0.32</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.48</td>
<td style='text-align: right;'>0.49</td>
<td style='text-align: right;'>0.28</td>
<td style='text-align: right;'>0.28</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.45</td>
<td style='text-align: right;'>0.46</td>
<td style='text-align: right;'>0.21</td>
<td style='text-align: right;'>0.22</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Mathematics</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.45</td>
<td style='text-align: right;'>0.46</td>
<td style='text-align: right;'>0.34</td>
<td style='text-align: right;'>0.35</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.46</td>
<td style='text-align: right;'>0.48</td>
<td style='text-align: right;'>0.34</td>
<td style='text-align: right;'>0.36</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.47</td>
<td style='text-align: right;'>0.48</td>
<td style='text-align: right;'>0.37</td>
<td style='text-align: right;'>0.37</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Science</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.46</td>
<td style='text-align: right;'>0.47</td>
<td style='text-align: right;'>0.33</td>
<td style='text-align: right;'>0.34</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.31</td>
<td style='text-align: right;'>0.32</td>
<td style='text-align: right;'>0.12</td>
<td style='text-align: right;'>0.14</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.30</td>
<td style='text-align: right;'>0.31</td>
<td style='text-align: right;'>0.12</td>
<td style='text-align: right;'>0.13</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Social Studies</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.37</td>
<td style='text-align: right;'>0.39</td>
<td style='text-align: right;'></td>
<td style='text-align: right;'></td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.29</td>
<td style='text-align: right;'>0.30</td>
<td style='text-align: right;'>0.15</td>
<td style='text-align: right;'>0.17</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>2014</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.37</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.37</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.24</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.25</td>
</tr>
</tbody>
</table>
<p></p>


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<caption style='caption-side: top'>
**Table 14:** 2014 CRCT Correlations between School-Level prior standardized scale score and Aggregate (Baseline) SGPs by Grade.</caption>
<thead>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='4' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Aggregate Group Type</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Grade</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SIMEX</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SIMEX</th>
</tr>
</thead>
<tbody> 
<tr><td colspan='6' style='font-weight: 900;'>Reading</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.31</td>
<td style='text-align: right;'> 0.05</td>
<td style='text-align: right;'>0.34</td>
<td style='text-align: right;'> 0.05</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.51</td>
<td style='text-align: right;'> 0.35</td>
<td style='text-align: right;'>0.54</td>
<td style='text-align: right;'> 0.37</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.15</td>
<td style='text-align: right;'>-0.15</td>
<td style='text-align: right;'>0.14</td>
<td style='text-align: right;'>-0.14</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.54</td>
<td style='text-align: right;'> 0.35</td>
<td style='text-align: right;'>0.56</td>
<td style='text-align: right;'> 0.38</td>
</tr>
<tr>
<td style='text-align: right;'>8</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.76</td>
<td style='text-align: right;'> 0.69</td>
<td style='text-align: right;'>0.78</td>
<td style='text-align: right;'> 0.72</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Ela</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.32</td>
<td style='text-align: right;'> 0.10</td>
<td style='text-align: right;'>0.33</td>
<td style='text-align: right;'> 0.10</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.16</td>
<td style='text-align: right;'>-0.02</td>
<td style='text-align: right;'>0.15</td>
<td style='text-align: right;'>-0.04</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.54</td>
<td style='text-align: right;'> 0.42</td>
<td style='text-align: right;'>0.55</td>
<td style='text-align: right;'> 0.41</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.27</td>
<td style='text-align: right;'> 0.03</td>
<td style='text-align: right;'>0.30</td>
<td style='text-align: right;'> 0.08</td>
</tr>
<tr>
<td style='text-align: right;'>8</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.38</td>
<td style='text-align: right;'> 0.20</td>
<td style='text-align: right;'>0.41</td>
<td style='text-align: right;'> 0.21</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Mathematics</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.26</td>
<td style='text-align: right;'> 0.15</td>
<td style='text-align: right;'>0.26</td>
<td style='text-align: right;'> 0.15</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.23</td>
<td style='text-align: right;'> 0.15</td>
<td style='text-align: right;'>0.25</td>
<td style='text-align: right;'> 0.17</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.23</td>
<td style='text-align: right;'> 0.14</td>
<td style='text-align: right;'>0.24</td>
<td style='text-align: right;'> 0.14</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.53</td>
<td style='text-align: right;'> 0.44</td>
<td style='text-align: right;'>0.55</td>
<td style='text-align: right;'> 0.45</td>
</tr>
<tr>
<td style='text-align: right;'>8</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.54</td>
<td style='text-align: right;'> 0.48</td>
<td style='text-align: right;'>0.55</td>
<td style='text-align: right;'> 0.50</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Science</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.25</td>
<td style='text-align: right;'> 0.07</td>
<td style='text-align: right;'>0.27</td>
<td style='text-align: right;'> 0.09</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.01</td>
<td style='text-align: right;'>-0.11</td>
<td style='text-align: right;'>0.03</td>
<td style='text-align: right;'>-0.10</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.24</td>
<td style='text-align: right;'> 0.14</td>
<td style='text-align: right;'>0.25</td>
<td style='text-align: right;'> 0.15</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.14</td>
<td style='text-align: right;'> 0.03</td>
<td style='text-align: right;'>0.15</td>
<td style='text-align: right;'> 0.03</td>
</tr>
<tr>
<td style='text-align: right;'>8</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.11</td>
<td style='text-align: right;'>0.03</td>
<td style='text-align: right;'>-0.09</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Social Studies</td></tr>
<tr>
<td style='text-align: right;'>4</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.22</td>
<td style='text-align: right;'> 0.11</td>
<td style='text-align: right;'>0.23</td>
<td style='text-align: right;'> 0.12</td>
</tr>
<tr>
<td style='text-align: right;'>5</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.05</td>
<td style='text-align: right;'>-0.04</td>
<td style='text-align: right;'>0.06</td>
<td style='text-align: right;'>-0.03</td>
</tr>
<tr>
<td style='text-align: right;'>6</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.16</td>
<td style='text-align: right;'> 0.11</td>
<td style='text-align: right;'>0.18</td>
<td style='text-align: right;'> 0.12</td>
</tr>
<tr>
<td style='text-align: right;'>7</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.17</td>
<td style='text-align: right;'> 0.07</td>
<td style='text-align: right;'>0.18</td>
<td style='text-align: right;'> 0.09</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>8</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.04</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.05</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.06</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.03</td>
</tr>
</tbody>
</table>
<p></p>

***EOCT***


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<caption style='caption-side: top'>
**Table 15:** 2011 to 2014 Correlations between Mean Prior Standardized Scale Score and Aggregate Baseline SGPs.</caption>
<thead>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='4' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Aggregate SGP Type</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Year</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SIMEX</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SIMEX</th>
</tr>
</thead>
<tbody> 
<tr><td colspan='6' style='font-weight: 900;'>Grade 9 Lit</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.50</td>
<td style='text-align: right;'>0.53</td>
<td style='text-align: right;'>0.37</td>
<td style='text-align: right;'>0.4</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.36</td>
<td style='text-align: right;'>0.37</td>
<td style='text-align: right;'>0.2</td>
<td style='text-align: right;'>0.2</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.02</td>
<td style='text-align: right;'>0.04</td>
<td style='text-align: right;'>-0.15</td>
<td style='text-align: right;'>-0.16</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>American Lit</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.48</td>
<td style='text-align: right;'>0.50</td>
<td style='text-align: right;'>0.32</td>
<td style='text-align: right;'>0.35</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.22</td>
<td style='text-align: right;'>0.21</td>
<td style='text-align: right;'>0.01</td>
<td style='text-align: right;'>-0.01</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.37</td>
<td style='text-align: right;'>0.41</td>
<td style='text-align: right;'>0.21</td>
<td style='text-align: right;'>0.23</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>US History</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.14</td>
<td style='text-align: right;'>0.17</td>
<td style='text-align: right;'></td>
<td style='text-align: right;'></td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.07</td>
<td style='text-align: right;'>0.08</td>
<td style='text-align: right;'>-0.02</td>
<td style='text-align: right;'>-0.01</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.07</td>
<td style='text-align: right;'>0.09</td>
<td style='text-align: right;'>-0.03</td>
<td style='text-align: right;'>-0.02</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Economics</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.06</td>
<td style='text-align: right;'>0.07</td>
<td style='text-align: right;'>-0.04</td>
<td style='text-align: right;'>-0.03</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.19</td>
<td style='text-align: right;'>0.21</td>
<td style='text-align: right;'>0.11</td>
<td style='text-align: right;'>0.12</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.07</td>
<td style='text-align: right;'>0.09</td>
<td style='text-align: right;'>-0.01</td>
<td style='text-align: right;'>0</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Biology</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.16</td>
<td style='text-align: right;'>0.17</td>
<td style='text-align: right;'>0.03</td>
<td style='text-align: right;'>0.05</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.17</td>
<td style='text-align: right;'>0.18</td>
<td style='text-align: right;'>0.05</td>
<td style='text-align: right;'>0.07</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.13</td>
<td style='text-align: right;'>0.14</td>
<td style='text-align: right;'>0.02</td>
<td style='text-align: right;'>0.03</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Physical Science</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.23</td>
<td style='text-align: right;'>0.24</td>
<td style='text-align: right;'>0.13</td>
<td style='text-align: right;'>0.14</td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.34</td>
<td style='text-align: right;'>0.36</td>
<td style='text-align: right;'>0.26</td>
<td style='text-align: right;'>0.27</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>2014</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.29</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.29</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.19</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.21</td>
</tr>
</tbody>
</table>
<p></p>


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse;' >
<caption style='caption-side: top'>
**Table 16:** 2011 to 2014 Correlations between Mean Prior Standardized Scale Score and Cohort SGPs.</caption>
<thead>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='4' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Aggregate SGP Type</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Year</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SGP</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median SIMEX</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean SIMEX</th>
</tr>
</thead>
<tbody> 
<tr><td colspan='6' style='font-weight: 900;'>Coordinate Algebra</td></tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.38</td>
<td style='text-align: right;'>0.37</td>
<td style='text-align: right;'>0.24</td>
<td style='text-align: right;'>0.24</td>
</tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.40</td>
<td style='text-align: right;'>0.40</td>
<td style='text-align: right;'>0.25</td>
<td style='text-align: right;'>0.24</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Analytic Geometry</td></tr>
<tr>
<td style='text-align: right;'>2014</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.47</td>
<td style='text-align: right;'>0.48</td>
<td style='text-align: right;'>0.32</td>
<td style='text-align: right;'>0.33</td>
</tr> 
<tr><td colspan='6' style='font-weight: 900;'>Mathematics II</td></tr>
<tr>
<td style='text-align: right;'>2012</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.39</td>
<td style='text-align: right;'>0.40</td>
<td style='text-align: right;'></td>
<td style='text-align: right;'></td>
</tr>
<tr>
<td style='text-align: right;'>2013</td>
<td style=';' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>0.41</td>
<td style='text-align: right;'>0.41</td>
<td style='text-align: right;'>0.3</td>
<td style='text-align: right;'>0.3</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>2014</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.36</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.38</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.27</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.3</td>
</tr>
</tbody>
</table>
<p></p>

# References
