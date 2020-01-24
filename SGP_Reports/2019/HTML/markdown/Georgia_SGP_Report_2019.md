---
title: "The Georgia Student Growth Model"
subtitle: "A Technical Overview of the 2018-2019 Student Growth Percentile Calculations"
author:
  - name: Adam R. VanIwaarden
  - name: Damian W. Betebenner
  - name: <em>National Center for the Improvement<br></br> of Educational Assessment (NCIEA)</em>
date: January 2020
abstract: "DRAFT REPORT - DO NOT CITE! <br></br> This report provides details about the Georgia Student Growth Model methodology and presents a descriptive analysis of the 2019 SGP calculation process and results."
---

<!--SGPreport-->

<!-- 
This document was written by Damian Betebenner & Adam VanIwaarden for the State of Georgia Department of Education (DOE).

	Original Draft:  October 13, 2019
	Final Draft:     September 5, 2019
-->




# Introduction

This report contains details on the 2018-2019 implementation of the student growth percentile (SGP) model for the state of Georgia.  The National Center for the Improvement of Educational Assessment (NCIEA) contracted with the Georgia Department of Education (DOE) to implement the SGP methodology using data derived from the [Georgia Milestones Assessment System](http://www.gadoe.org/Curriculum-Instruction-and-Assessment/Assessment/Pages/Georgia-Milestones-Assessment-System.aspx) to create the [Georgia Student Growth Model (GSGM)](http://www.gadoe.org/Curriculum-Instruction-and-Assessment/Assessment/Pages/Georgia-Student-Growth-Model.aspx).  The goal of the engagement with DOE is to create a set of open source analytics techniques and conduct analyses that will eventually be conducted exclusively by DOE in following years.

The SGP methodology is an open source norm- and criterion-referenced student growth analysis that produces student growth percentiles and student growth projections/targets for each student in the state with adequate longitudinal data.  The methodology is currently used for many purposes.  States and districts have used the results in various ways including parent/student diagnostic reporting, institutional improvement, and school and educator accountability.  Specifics about the manner in which growth is included in accountability frameworks, such as the [College and Career Ready Performance Index (CCRPI), ](https://www.gadoe.org/CCRPI/Pages/default.aspx)) can be found in documents related to those accountability systems.

This report includes four sections:

- ***Data - *** includes details on the decision rules used in the raw data preparation and student record validation.
- ***Analytics - *** introduces some of the basic statistical methods and the computational process implemented in the 2019 analyses.^[More in-depth treatment of the SGP Methodology can be found [here](https://github.com/CenterForAssessment/SGP_Resources/tree/master/articles).]
- ***Goodness of Fit - *** investigates how well the statistical models used to produce SGPs fit Georgia students' data.  This includes discussion of goodness of fit plots and the student-level correlations between SGP and prior achievement.
- ***SGP Results - *** provides basic descriptive statistics from the 2019 analyses at both the state and school levels.

This report also includes multiple appendices.  Appendix A displays Goodness of Fit plots for each analysis conducted in 2019.  Appendix B provides a technical description of the SIMEX correction for measurement error with specific applications to Georgia.  Appendix C is an investigation of potential ceiling and/or floor effects present in the Georgia assessment data and growth analyses.


<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


# Data

The Georgia DOE supplied Milestones end-of-grade (EOG) and end-of-course (EOC) test data used in the 2019 SGP analyses to the NCIEA in late summer of 2019.  These test records were added to existing Georgia assessment data^[2019 Prior assessment data includes Milestones data from 2014-2015 through 2017-2018.  Data from the  Criterion-Referenced Competency Tests (CRCT) and EOCT assessment program are no longer used in SGP calculations.] to create the longitudinal data set from which the 2019 SGPs were calculated.  Subsequent years' analyses will augment this multi-year data set allowing DOE to maintain comprehensive longitudinal data for all students taking the EOG and EOC Milestones assessments.

Student Growth Percentiles have been produced for students that have a current score and at least one prior score in either the same subject or a related content area.  For the 2019 academic year SGPs were produced for grade-level English Language Arts (ELA) and Mathematics, as well as for EOC test subjects including 9<sup>th</sup> Grade Literature, American Literature, Algebra I, Geometry, Coordinate Algebra and Analytic Geometry.

## Longitudinal Data
Growth analyses on assessment data require data that are linked to individual students over time.  Student growth percentile analyses require, at a minimum two, and preferably three years of assessment data for analysis of student progress.  To this end it is necessary that a unique student identifier be available so that student data records across years can be merged with one another and subsequently examined.  Because some records in the assessment data set contain students with more than one test score in a content area in a given year, a process to create unique student records in each content area by year combination was required in order to carry out subsequent growth analyses.  Furthermore, student records may be invalidated for other reasons.  The following business rules were used to either invalidate particular student records or select the appropriate record for use in the analyses.

### General business rules

1.  Student records are invalidated if the student identifier is not exactly 10 digits long.
2.  Student records with missing ("NA") scores or scale scores outside of the possible range (usually 0) are invalidated.
3.  Student records with an administrative flag that resulted in a non-score code (e.g., student cheating, provision of inappropriate accommodations, or students that did not attempt the test) are invalidated.

Beginning in 2014 Georgia DOE has performed the majority of the selection and invalidation of student records, incorporating these and other business rules into the `SQL` code used to pull student records from their data warehouse.


<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


### EOG specific business rules

1.  If a student has multiple records (duplicate from the same subject and grade), the record with the highest score was selected.


Table 1 shows the number of valid EOG student records available for analysis after applying the general and EOG specific business rules.^[This does not represent the number of SGPs produced, however, because students are required to have at least one prior score available as well.]



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='8' style='text-align: left;'>
**Table 1:** Number of Valid EOG Student Records by Grade and Subject for 2019</td></tr>
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
<td style='text-align: right;'>ELA</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>129,217</td>
<td style='text-align: right;'>133,538</td>
<td style='text-align: right;'>136,497</td>
<td style='text-align: right;'>136,651</td>
<td style='text-align: right;'>133,189</td>
<td style='text-align: right;'>124,638</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>129,142</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>133,477</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>136,445</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>136,602</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>132,728</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>103,282</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 1:** Number of Valid EOG Student Records by Grade and Subject for 2019\label{my}} 
\begin{center}
\begin{tabular}{rcrrrrrr}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{6}{c}{\bfseries Grades}\tabularnewline
\cline{3-8}
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{3}&\multicolumn{1}{c}{4}&\multicolumn{1}{c}{5}&\multicolumn{1}{c}{6}&\multicolumn{1}{c}{7}&\multicolumn{1}{c}{8}\tabularnewline
\hline
ELA&&129,217&133,538&136,497&136,651&133,189&124,638\tabularnewline
Mathematics&&129,142&133,477&136,445&136,602&132,728&103,282\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->


### EOC specific business rules

1.  If a student has multiple records from the same subject and administration period, the record with the highest score was selected.
2.  For students who participated in two main administrations in 2019 (i.e., students who failed and retook an EOC course in the same year), the first attempt is used as a prior to produce an SGP for the final attempt.  In subsequent years, their final attempt may be used as a prior for other EOC analyses.
3.  Students who have tested out of EOC courses are invalidated.^[Beginning in 2013-2014, students had the opportunity to test out of an EOC course by taking the test early and scoring at highest performance level ("Distinguished Learner"). SGPs are not calculated for any current year test out attempt. Successful attempts, however, are used as prior scores in subsequent years' analyses.]

Table 2 shows the total number of valid EOC student records available for analysis after applying the general and EOC specific business rules.



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='2' style='text-align: left;'>
**Table 2:** Total Number of Valid EOC Student Records by Subject for 2019</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Valid Records</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Grade 9 Lit</td>
<td style='text-align: right;'>138,822</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit</td>
<td style='text-align: right;'>124,786</td>
</tr>
<tr>
<td style='text-align: right;'>Algebra I</td>
<td style='text-align: right;'>124,818</td>
</tr>
<tr>
<td style='text-align: right;'>Geometry</td>
<td style='text-align: right;'>113,342</td>
</tr>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='text-align: right;'>20,989</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Analytic Geometry</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>19,505</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 2:** Total Number of Valid EOC Student Records by Subject for 2019\label{my}} 
\begin{center}
\begin{tabular}{rr}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Valid Records}\tabularnewline
\hline
Grade 9 Lit&138,822\tabularnewline
American Lit&124,786\tabularnewline
Algebra I&124,818\tabularnewline
Geometry&113,342\tabularnewline
Coordinate Algebra&20,989\tabularnewline
Analytic Geometry&19,505\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->

<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


# Analytics

This section provides basic details about the calculation of student growth percentiles from Georgia state assessment data using the [`R` Software Environment](http://www.r-project.org/) [@Rsoftware] in conjunction with the [`SGP` package](https://github.com/CenterForAssessment/SGP) [@sgp2019].  More in depth treatment of the data analysis process with code examples is provided to Georgia DOE staff in the Calculation Manual.

Broadly, the SGP analysis of the Georgia longitudinal student assessment data takes place in two steps:

1. Data Preparation
2. Data Analysis

The majority of the effort in the above two step process lies with Step 1: Data Preparation.  Following thorough data cleaning and preparation, data analysis using the `SGP` package takes clean data and makes it as easy as possible to calculate, summarize, output and visualize the results from SGP analyses.

## Data Preparation

The data preparation step involves taking data provided by the Georgia DOE and producing a `.Rdata` file that will subsequently be analyzed in Step 2. This process is carried out annually as new data becomes available from the state assessment program.  The data housed by the Georgia DOE Information Technology department is extracted, cleaned and processed using a two step process:

<div class='caption'>**Step 1a.** *Initial data extraction and cleaning*</div>

In this first step a formatted data set is extracted from the Georgia student data warehouse using an internal `SQL` connection and command script. Through this process, student records are selected and invalidated based upon the business rules discussed above. The end result is a pipe-delimited file where each valid student record is unique by content area, school year, student identifier (GTID), and test administration period.

<div class='caption'>**Step 1b.** *Final data cleaning and preparation in* `R`</div>

In this step the data from step 1a is read into [`R`](http://www.r-project.org/) and modified slightly. The result is a `.Rdata` file containing data in the format suitable for analysis with the [`SGP` package](https://github.com/CenterForAssessment/SGP).  This data is combined with prior years' Milestones data to complete the 2019 analyses and is stored in a updated [`SGP` class object](http://cran.r-project.org/web/packages/SGP/SGP.pdf).  With an appropriate longitudinal data set prepared, we move to the calculation of student-level SGPs.

## 2019 Data Analysis

The objective of the student growth percentile (SGP) analysis is to describe how (a)typical a student's growth is by examining his/her current achievement relative to students with a similar achievement history; i.e his/her *academic peers* (see [Section 2 of the GSGM FAQ](https://docs.google.com/viewer?url=http%3A%2F%2Fwww.gadoe.org%2FCurriculum-Instruction-and-Assessment%2FAssessment%2FDocuments%2FSGP%2520FAQ%2520072214.pdf)). This norm-referenced growth quantity is estimated using quantile regression [@Koenker:2005] to model curvilinear functional relationships between students' prior and current scores.  One hundred such regression models are calculated for each separate analysis (defined as a unique ***year** by **content area** by **grade** by **prior order*** combination, with student grade-level ignored in EOC subjects).  The end product of these 100 separate regression models is a single coefficient matrix, which serves as a look-up table to relate prior student achievement to current achievement for each percentile. This process ultimately leads to tens of thousands of model calculations (and many more when SIMEX measurement error corrections are performed) during each of Georgia's annual batch of analyses.  For a more in-depth discussion of SGP calculation, see Betebenner [-@Betebenner:2009], and see Shang, VanIwaarden and Betebenner [-@ShangVanIBet:2015] and Appendix B of this report for further information on the SIMEX measurement error correction methodology.

The 2019 Georgia SGP analyses follow a work flow established in previous years that includes the following 4 steps:

1. Update the Georgia assessment meta-data required for SGP calculations using the `SGP` package.
2. Create annual SGP configurations for analyses.
3. Conduct all EOG and EOC SGP analyses.
4. Combine results into the master longitudinal data set, summarize results and output data.

### Update Georgia meta-data

The use of higher-level functions included in the `SGP` package (e.g. `analyzeSGP`) requires the availability of state specific assessment information.  This meta-data is compiled in a `R` object named `SGPstateData` that is housed in the package.  No updates to Georgia's metadata were required for the 2019 analyses.


### Create SGP configurations

Unlike most EOG analyses, EOC analyses are specialized enough so that it is necessary to specify the analyses to be performed via explicit configuration code.  For several years, configurations have been employed to conduct EOC SGP analyses for Georgia.  Beginning in 2015 configurations were used for EOG SGP analyses as well, which allows for consistency between the EOC subjects and for all analyses (particularly student growth projections) to be run concurrently.

Configurations are `R` code scripts that are used as part of the larger SGP analysis to be discussed later.  They are broken up into separate R scripts based on content area (ELA and Mathematics).  Each configuration code chunk specifies a set of parameters that defines the norm group of students to be examined.  Every potential norm group is defined by, at a minimum, the progressions of content area and academic year, as well as grade-level for the EOG analyses.  Because Georgia allows for repeated test administrations within each year, the sequence in which score observations occur must also be included.  Therefore, every configuration used contains the first four elements listed below.  The EOC analyses also contain the fifth through eighth elements:

1. **`sgp.content.areas`:** The progression of content areas to be looked at and their order.
2. **`sgp.panel.years`:** The progression of the years associated with the content area progression (`sgp.content.areas`), potentially allowing for skipped or repeated years, etc.
3. **`sgp.panel.years.within`:** The progression of the observation sequence associated with each year.  Required when multiple test scores are present within a given year.  Values may be set to `LAST_OBSERVATION` or `FIRST_OBSERVATION`.
4. **`sgp.grade.sequences`:** The grade progression associated with the configuration content areas and years. The value **'EOCT'** stands for 'End Of Course Test'.^[This abbreviation differs from Georgia's use of "EOC", but is a required convention in the `SGP` package.]  The use of the generic 'EOCT' allows for secondary students to be compared based on the pattern of course taking rather than being dependent upon grade-level designation.
5. **`sgp.exact.grade.progression`:** When set to `TRUE`, this element will force the lower level functions to analyze *only* the progression as specified in its entirety.  Otherwise these functions will analyze subsets of the progression for every possible order (i.e. each number of prior time periods of data available). When set to `TRUE`, a norm group preference system is usually required as well.
6. **`sgp.norm.group.preference`:** Because a student can potentially be included in more than one analysis/configuration, multiple SGPs will be produced for some students and a system is required to identify the preferred SGP that will be matched with the student in the `combineSGP` step.  This argument provides a ranking that specifies how preferable SGPs produced from the analysis in question is relative to other possible SGPs.  ***Lower numbers correspond with higher preference.***  Higher preference is given to:
    * Progressions with the greatest number of prior scale scores.
    * Progressions in which a student has repeated a course.
    * Progressions that do not include a skipped year (i.e. a gap in the scale score history).
    * Progressions for block-schedule course taking patterns.
7. **`sgp.projection.grade.sequences`:** This element is used to identify the grade sequence that will be used to produce straight and/or lagged student growth projections.  It can either be left out or set explicitly to `NULL` to produce projections based on the values provided in the `sgp.content.areas` and `sgp.grade.sequences` elements.  Alternatively, when set to "`NO_PROJECTIONS`", no projections will be produced.  For EOC analyses, only configurations that correspond to the canonical course progressions can produce student growth projections.  The canonical progressions are codified in the `SGP` package here: [`SGPstateData[["GA"]][["SGP_Configuration"]][["content_area.projection.sequence"]]`](https://github.com/CenterForAssessment/SGPstateData/blob/fda10b20d92f5c9dcba3fa6eaf98844bab5bb05b/SGPstateData.R#L2614).
8. **`sgp.exclude.sequences`:** Lookup table containing the grade, subject, and year combinations of students that should be excluded from a cohort.  This element is used in progressions in which a year or similar time period is skipped (i.e. a gap in time exists).  For example, in a progression that goes from 8<sup>th</sup> grade Mathematics to EOC Algebra I with a skipped year in between one may want to exclude kids that repeated either 8<sup>th</sup> grade Mathematics or Algebra I, or took other math related subjects (e.g. Geometry) in the skipped year.  Students with different course progressions may be inappropriate to include with the cohort of students who truly had no mathematics related course in the intervening year.

As an example, here is one Algebra I configuration used to define a 2019 SGP analysis that includes a skipped year and requires all eight configuration elements:

```R
...

  ALGEBRA_I.2019 = list(
    sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'ALGEBRA_I'),
    sgp.panel.years=c('2016', '2017', '2019'),
    sgp.panel.years.within=c("LAST_OBSERVATION", 
        "LAST_OBSERVATION", "FIRST_OBSERVATION"),
    sgp.grade.sequences=list(c('7', '8', 'EOCT')),
    sgp.exact.grade.progression=TRUE,
    sgp.norm.group.preference=6,
    sgp.projection.grade.sequences="NO_PROJECTIONS",
    sgp.exclude.sequences = data.table(
        VALID_CASE = 'VALID_CASE',
        CONTENT_AREA=c('MATHEMATICS', 'ALGEBRA_I', 'GEOMETRY'),
        YEAR=c('2018', '2018', '2018'), 
        GRADE=c('8', 'EOCT', 'EOCT')))
...

```


### Conduct SGP analyses

Due to differences in the time-frames in which the EOG and EOC were validated and made available, EOG and EOC SGPs were calculated at separate times.  Cohort-referenced (uncorrected) and SIMEX corrected SGPs were calculated for each individual analysis.  We use the [`updateSGP`](https://www.rdocumentation.org/packages/SGP/versions/1.9-0.0/topics/updateSGP) function to ***a)*** do the final preparation and addition of the 2019 cleaned and formatted data to a `SGP` class object ([`prepareSGP`](https://www.rdocumentation.org/packages/SGP/versions/1.9-0.0/topics/prepareSGP) step) and ***b)*** calculate SGP estimates ([`analyzeSGP`](https://www.rdocumentation.org/packages/SGP/versions/1.9-0.0/topics/analyzeSGP) step).  

Student growth projections were also computed for both EOG and EOC student growth analyses in the `analyzeSGP` step.  Due to the data delivery timeline, EOG growth projections/targets extending beyond the 8<sup>th</sup> grade are calculated using preliminary EOC results using student data from the winter and spring assessment periods only (excluding summer).  Growth projections are discussed in more detail in the "Student Growth Targets" section of this report.

### Merge, output, summarize and visualize results

Once all analyses were completed the results were merged into the master longitudinal data set ([`combineSGP`](https://www.rdocumentation.org/packages/SGP/versions/1.9-0.0/topics/combineSGP) step).  A pipe delimited version of the complete long data is output ([`outputSGP`](https://www.rdocumentation.org/packages/SGP/versions/1.9-0.0/topics/outputSGP) step) and submitted to the Georgia DOE after some additional formatting to add fields such as students' entire prior score and course progression history needed for rendering data in the state's [visualization tool](http://gastudentgrowth.gadoe.org/).  In this stage an additional check is also performed in which SGP results are removed when the absolute value of the difference between the uncorrected SGP and Ranked SIMEX SGP is equal to 20 or more ($|SGP_ {Uncorrected} - SGP_ {Ranked SIMEX}| \geq 20$).

Finally, the SGP results are summarized using the [`summarizeSGP` function](https://www.rdocumentation.org/packages/SGP/versions/1.9-0.0/topics/summarizeSGP), which produces many tables of descriptive statistics that are disaggregated at the state, district and school levels, as well as other factors of interest.  Visualizations (such as the bubble charts used in this report and "growth and achievement" charts) are produced from the SGP results and summary tables using the [`visualizeSGP`](https://www.rdocumentation.org/packages/SGP/versions/1.9-0.0/topics/visualizeSGP) function.


<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


# Goodness of Fit

Assessment data are generally imperfect and require sophisticated statistical methods to deal with the various issues they present.  Cubic B-spline basis functions are used in the calculation of SGPs to more adequately model the heteroscedasticity, non-linearity and skewness.  Despite this, assumptions that are made in the statistical modeling process can impact how well the percentile curves fit the data.^[It should be noted that the independent estimation of the regression functions can potentially result in the crossing of the quantile functions.  This occurs near the extremes of the distributions and is potentially more likely to occur given the use of non-linear functions.  A potential result of allowing the quantile functions to cross would be *lower* estimated growth percentiles for *higher* observed scale scores at the extremes (give all else equal in prior scores) and vice versa.  In order to deal with these contradictory estimates, quantile regression results are isotonized to prevent quantile crossing following the methods derived by Chernozhukov, Fernandez-Val and Glichon [-@chernozhukov2010quantile].]  Accordingly a thorough evaluation of the models' fit is always required.

Examination of the Georgia Student Growth Model goodness-of-fit was conducted by first inspecting model fit plots the `SGP` software package produced for each analysis, and subsequently inspecting student level correlations between growth and achievement.  Discussion of the model fit plots in general and examples of them are provided below, as are tables of the correlation results.  The complete portfolio of model fit plots is provided in Appendix A.

## Model Fit Plots

Using all available EOG and EOC scores as the variables, estimation of student growth percentiles was conducted for each possible student (those with a current score and at least one prior score).  Each analysis is defined by the grade and content area for the grade-level analyses and exact content area (and grade when relevant) sequences for the EOC subjects.  Georgia has added an additional requirement that an analysis cohort must have at least 1,500 students in order to calculate SGPs.  A goodness of fit plot is produced for each unique analysis run in 2019 and are all provided in Appendix A to this report.

As an example, Figure 1 shows the results for 8<sup>th</sup> grade ELA as an example of good model fit.  Figure 2 is an example of minor model misfit from the Geometry "same-year" course repeater analysis (i.e. students have two Geometry scores in 2019).

The two panels compare the observed conditional density of the SGP estimates with the theoretical (uniform) density.  The bottom left panel shows the empirical distribution of SGPs given prior scale score deciles in the form of a 10 by 10 cell grid.  Percentages of student growth percentiles between the 10<sup>th</sup>, 20<sup>th</sup>, 30<sup>th</sup>, 40<sup>th</sup>, 50<sup>th</sup>, 60<sup>th</sup>, 70<sup>th</sup>, 80<sup>th</sup>, and 90<sup>th</sup> percentiles were calculated based upon the empirical decile of the cohort's prior year scaled score distribution^[The total students in each analysis varies depending on grade and subject, and prior score deciles are based only on scores for students used in the SGP calculations.].  With an infinite population of test takers, at each prior scaled score, with perfect model fit, the expectation is to have 10 percent of the estimated growth percentiles between 1 and 9, 10 and 19, 20 and 29, ..., and 90 and 99.  Deviations from 10 percent, indicated by red and blue shading, suggests lack of model fit.  The further *above* 10 the darker the red, and the further *below* 10 the darker the blue.  

When large deviations occur, one likely cause is a clustering of scale scores that makes it impossible to "split" the score at a dividing point forcing a majority of the scores into an adjacent cell.  This occurs more often in lowest grade levels where fewer prior scores are available (particularly in the lowest grade when only a single prior is available).  Another common cause of this is small cohort size (e.g. fewer than 5,000 students).  Smaller cohorts generally have less variability in most cases, which makes differentiating between students more difficult.  Further compounding this issue in Georgia's case, these small cohorts tend to be atypical groups with more homogeneous academic performance (e.g. course repeaters or accelerated students).

The bottom right panel of each plot is a Q-Q plot which compares the observed distribution of SGPs with the theoretical (uniform) distribution.  An ideal plot here will show black step function lines that do not deviate greatly from the ideal, red line which traces the 45 degree angle of perfect fit.





<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->

###  Uncorrected model fit

Although the *official* SGPs used in Georgia's accountability system incorporate SIMEX measurement error correction, we provide uncorrected SGP plots here as exemplars of cohort-referenced model fit, and to compare with SIMEX corrected and Ranked SIMEX models that use the same student data in the subsequent sections.  The results in all subjects are excellent with few exceptions (see Appendix A).


<!-- HTML_Start -->

<div class='caption'> <strong>Figure 1:</strong>   Goodness of Fit Plot for 2019 <strong><em>Uncorrected</em></strong> 8<sup>th</sup> Grade ELA:  Example of good model fit. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Goodness_of_Fit/ELA.2019/gofSGP_Grade_8.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 1:}}   } Goodness of Fit Plot for 2019 {\bf{{\textit{Uncorrected}}}} 8$^{th}$ Grade ELA:  Example of good model fit.}
  \begin{subfigure}[b]{0.875\textwidth}
    \includegraphics[width=\textwidth]{../img/Goodness_of_Fit/ELA.2019/gofSGP_Grade_8.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->

Minor misfit in the Geometry model is likely due to several factors, such as the relatively small cohort size and the use of a single prior in the model.  These two factors often result in clustering of SGPs in some conditional distribution grid cells (dark red cells adjacent to dark blue cells) because the norm group data does not provide sufficient information to differentiate between students.  Another factor in this analysis is that course repeater norm groups are typically homogeneous cohorts of low academic achievers.  This presents a "restriction of range" issue, making growth trends more difficult to model.



<!-- HTML_Start -->

<div class='caption'> <strong>Figure 2:</strong>   Goodness of Fit Plot for a 2019 <strong><em>Uncorrected</em></strong> Geometry Repeater Progression: Example of slight model misfit. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Goodness_of_Fit/GEOMETRY.2019/2019_GEOMETRY_EOCT;2019_GEOMETRY_EOCT.png' style='width: 640px;'/>
</div>
</div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 2:}}   } Goodness of Fit Plot for a 2019 {\bf{{\textit{Uncorrected}}}} Geometry Repeater Progression: Example of slight model misfit.}
  \begin{subfigure}[b]{1\textwidth}
    \includegraphics[width=\textwidth]{../img/Goodness_of_Fit/GEOMETRY.2019/2019_GEOMETRY_EOCT;2019_GEOMETRY_EOCT.png}
  \end{subfigure}
\end{figure}

LaTeX_End -->


###  SIMEX Corrected model fit

The basic SIMEX model fit ***is not*** expected to be uniformly distributed regardless of prior achievement.  In these models we expect misfit in the form of increased high SGPs for students with lower prior performance (and a complementary decrease in low SGPs for those students), and the reverse expectation for high achieving students.  The model changes are visible in the goodness of fit plots in Figure 3 where the basic SIMEX correction method has been applied to the 8<sup>th</sup> grade ELA model, and Figure 4 for the same Geometry progression as presented above.



<!-- HTML_Start -->

<div class='caption'> <strong>Figure 3:</strong>   Goodness of Fit Plot for 2019 <strong><em>Basic SIMEX Corrected</em></strong> 8<sup>th</sup> Grade ELA:  Example of good model fit. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Goodness_of_Fit/ELA.2019.SIMEX/gofSGP_Grade_8.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 3:}}   } Goodness of Fit Plot for 2019 {\bf{{\textit{Basic SIMEX Corrected}}}} 8$^{th}$ Grade ELA:  Example of good model fit.}
  \begin{subfigure}[b]{1\textwidth}
    \includegraphics[width=\textwidth]{../img/Goodness_of_Fit/ELA.2019.SIMEX/gofSGP_Grade_8.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->

In these plots we see a shift in the "Student Growth Percentile Range" panel cells from blue to red in the top half, and red to blue in the bottom half.  The Q-Q plots suggest that the observed distributions of SIMEX corrected SGPs deviates from a perfect uniform distribution, particularly in the middle ranges.


<!-- HTML_Start -->

<div class='caption'> <strong>Figure 4:</strong>   Goodness of Fit Plot for a 2019 <strong><em>Basic SIMEX Corrected</em></strong> Geometry Progression: Example of slight model misfit. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Goodness_of_Fit/GEOMETRY.2019.SIMEX/2019_GEOMETRY_EOCT;2019_GEOMETRY_EOCT.png' style='width: 640px;'/>
</div>
</div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 4:}}   } Goodness of Fit Plot for a 2019 {\bf{{\textit{Basic SIMEX Corrected}}}} Geometry Progression: Example of slight model misfit.}
  \begin{subfigure}[b]{1\textwidth}
    \includegraphics[width=\textwidth]{../img/Goodness_of_Fit/GEOMETRY.2019.SIMEX/2019_GEOMETRY_EOCT;2019_GEOMETRY_EOCT.png}
  \end{subfigure}
\end{figure}

LaTeX_End -->



<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->

###  Ranked SIMEX model fit

Although basic SIMEX corrected SGPs are useful in reducing measurement error induced bias, they are not without technical and practical limitations.  As shown in the figures above, the SIMEX correction disrupts the uniform distribution of the individual SGP values, which is one of the desirable characteristics of the SGP model in general because it suggests that the full range of SGP growth values (1-99) is equally likely to be attained regardless of prior achievement.

McCaffrey, et al. [-@McCaLo:2015] first suggested that ranking the SIMEX SGP values may present a possible alternative that would have the beneficial properties of both SGP estimate types, and Castellano and McCaffrey [-@CastMcCaf:2017] investigated the properties of the ranked SIMEX SGP.  Among other positive results, they found that taking the percentile ranks of the SIMEX corrected values resulted in a more uniform distribution than typical U-shaped distribution of the basic SIMEX SGP model results.  

Georgia has used ranked SIMEX SGPs as the *official* growth metric in their accountability system as of 2017.  Both basic and ranked SIMEX model properties and their application to Georgia assessment data are discussed in greater detail in Appendix B of this report.

Figures 5 and 6 are fit plots with the ranked SIMEX correction method applied to the same 8<sup>th</sup> grade ELA and Geometry repeater analyses as presented above.  A more uniform distribution is visible in these plots, although not as uniform as the uncorrected model.  Note that the shifts (from blue to red in the top half and red to blue in the bottom half) in the "Student Growth Percentile Range" panel are still present, but have been substantially decreased.  The Q-Q plots also suggest some improvement in making the distributions more uniform.

<p></p>


<!-- HTML_Start -->

<div class='caption'> <strong>Figure 5:</strong>   Goodness of Fit Plot for 2019 <strong><em>Ranked SIMEX Corrected</em></strong> 8<sup>th</sup> Grade ELA:  Example of good model fit. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Goodness_of_Fit/ELA.2019.RANKED_SIMEX/gofSGP_Grade_8.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 5:}}   } Goodness of Fit Plot for 2019 {\bf{{\textit{Ranked SIMEX Corrected}}}} 8$^{th}$ Grade ELA:  Example of good model fit.}
  \begin{subfigure}[b]{0.9\textwidth}
    \includegraphics[width=\textwidth]{../img/Goodness_of_Fit/ELA.2019.RANKED_SIMEX/gofSGP_Grade_8.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->


<!-- HTML_Start -->

<div class='caption'> <strong>Figure 6:</strong>   Goodness of Fit Plot for a 2019 <strong><em>Ranked SIMEX Corrected</em></strong> Geometry Repeater Progression: Example of slight model misfit. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Goodness_of_Fit/GEOMETRY.2019.RANKED_SIMEX/2019_GEOMETRY_EOCT;2019_GEOMETRY_EOCT.png' style='width: 640px;'/>
</div>
</div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 6:}}   } Goodness of Fit Plot for a 2019 {\bf{{\textit{Ranked SIMEX Corrected}}}} Geometry Repeater Progression: Example of slight model misfit.}
  \begin{subfigure}[b]{1\textwidth}
    \includegraphics[width=\textwidth]{../img/Goodness_of_Fit/GEOMETRY.2019.RANKED_SIMEX/2019_GEOMETRY_EOCT;2019_GEOMETRY_EOCT.png}
  \end{subfigure}
\end{figure}

LaTeX_End -->



<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


## Growth and Prior Achievement at the Student Level

To investigate the possibility that individual level misfit might impact summary level results, student level SGP results were examined relative to prior achievement.  With perfect fit to data, the correlation between students' most recent prior achievement scores and their student growth percentiles is zero (i.e., the goodness of fit tables would have a uniform distribution of percentiles across all previous scale score levels).  To investigate in another way, correlations between **a)** prior and current scale scores (achievement) and **b)** prior score and student growth percentiles were calculated.  Evidence of good model fit begins with a strong positive relationship between prior and current achievement, which suggests that growth is detectable and modeling it is reasonable to begin with.  A lack of relationship (zero correlation) between prior achievement and growth confirms that the model has fit the data well and produced a uniform distribution of percentiles across the past year's scale score range.

Student-level correlations for EOG subjects are presented in Table 3, and the results are generally as expected.  Strong relationships exist between prior and current scale scores for the grade level analyses (column 3).  This also indicates that students can demonstrate high (or low) growth regardless of prior achievement.  Column 4 shows that correlations for Georgia's cohort-referenced (uncorrected) SGPs are all zero, which indicates the models are perfectly fit to the data.

SIMEX corrected SGPs induce a negative correlation between growth and prior achievement.  Rather than a uniform distribution, SIMEX produces a distribution in which growth for lower prior achieving students' is weighted upward and higher achieving students' growth is weighted down.  This correction is necessary because measurement error has been found to create bias that can disadvantage students with lower prior achievement and vice versa.  Without correction, this bias is transferred to aggregate measures of educator or school effectiveness when a disproportionate number of students with relatively low/high prior achievement are concentrated in a classroom or school [@ShangVanIBet:2015; @LockCast:2015].  

SIMEX corrected SGPs, although biased at the student-level, may then decrease the bias in aggregate growth measures (as documented in Appendix B and Shang et al., 2015).  This is borne out in column 5 of the correlation tables below, where the student-level relationship between SIMEX corrected SGPs and prior achievement are stronger (showing a negative bias), and the strength of the aggregate-level relationships between growth and prior achievement have been reduced (see the "Group Level Results" section for aggregate-level correlations).


### EOG Subjects


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='6' style='text-align: left;'>
**Table 3:** EOG Student Level Correlations between Prior Standardized Scale Score and 1) Current Scale Score, 2) SGP and 3) Ranked SIMEX SGP.</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Grade</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>$\r_ { Test Scores}$</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>$\r_ { SGP}$</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>$\r_ { Ranked SIMEX}$</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>N Size</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>ELA</td>
<td style='text-align: right;'>4</td>
<td style='text-align: right;'>0.83</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.12</td>
<td style='text-align: right;'>125,474</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>5</td>
<td style='text-align: right;'>0.84</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'>128,855</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>6</td>
<td style='text-align: right;'>0.85</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>128,247</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>7</td>
<td style='text-align: right;'>0.85</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>125,122</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>8</td>
<td style='text-align: right;'>0.85</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>116,984</td>
</tr>
<tr>
<td style='text-align: right;'>Mathematics</td>
<td style='text-align: right;'>4</td>
<td style='text-align: right;'>0.85</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.10</td>
<td style='text-align: right;'>125,364</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>5</td>
<td style='text-align: right;'>0.85</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>128,757</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>6</td>
<td style='text-align: right;'>0.85</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.06</td>
<td style='text-align: right;'>128,178</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>7</td>
<td style='text-align: right;'>0.87</td>
<td style='text-align: right;'>0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>124,594</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'></td>
<td style='border-bottom: 2px solid grey; text-align: right;'>8</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.82</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.00</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.07</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>96,323</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 3:** EOG Student Level Correlations between Prior Standardized Scale Score and 1) Current Scale Score, 2) SGP and 3) Ranked SIMEX SGP.\label{my}} 
\begin{center}
\begin{tabular}{rrrrrr}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Grade}&\multicolumn{1}{c}{$\r_ { Test Scores}$}&\multicolumn{1}{c}{$\r_ { SGP}$}&\multicolumn{1}{c}{$\r_ { Ranked SIMEX}$}&\multicolumn{1}{c}{N Size}\tabularnewline
\hline
&&&&&\tabularnewline
ELA&4&0.83&0.00&-0.12&125,474\tabularnewline
&5&0.84&0.00&-0.08&128,855\tabularnewline
&6&0.85&0.00&-0.09&128,247\tabularnewline
&7&0.85&0.00&-0.09&125,122\tabularnewline
&8&0.85&0.00&-0.09&116,984\tabularnewline
\hline
&&&&&\tabularnewline
Mathematics&4&0.85&0.00&-0.10&125,364\tabularnewline
&5&0.85&0.00&-0.07&128,757\tabularnewline
&6&0.85&0.00&-0.06&128,178\tabularnewline
&7&0.87&0.00&-0.07&124,594\tabularnewline
&8&0.82&0.00&-0.07&96,323\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->

### EOC Subjects

Each EOC test subject is analyzed using more than one sequence of prior subjects, grades and years, and these unique progressions are disaggregated in Table 4 using the most recent prior available for each norm group (although more prior years' scores are used in SGP calculations when available).  These correlations between current and prior scale score are notably lower than in the EOG grade level norm groups, and overall lower correlations may be expected in EOC subjects due to the change in specific subject from one course to the next.  

Additionally, there are three types of norm groups in which the correlations are markedly lower: skipped year groups, course repeaters and high prior-achievers.  The use of skipped-year sequences will likely decrease correlations due simply to weakening of students' skills and knowledge during these time gaps (e.g. see the first row for Grade 9 Literature, $r = 0.70$).  In the repeated course norm groups, decrease (attenuation) in the correlations is likely due to "self-selection bias" in the cohort.  That is, mainly lower attaining students will repeat a course, which results in a restriction of range in the prior scores, as well as the expected range of current scores.  As an example, see the Grade 9 Literature repeaters (second, fifth and sixth rows) with correlations of $r = 0.59$, $r = 0.69$ and $r = 0.61$.  Self-selection bias is also likely at play in the norm groups in which the most recent prior is a 7<sup>th</sup> grade subject.  Here higher attaining students have enrolled in advanced classes, and we expect a restriction of range in the scores at the upper end of the score distributions.

The relationships between growth and prior achievement reported in Table 4 are nearly non-existent for cohort referenced SGPs and slightly negative after SIMEX correction.  These results are as expected for appropriate fit to the respective models as discussed in the EOG section above.



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='6' style='text-align: left;'>
**Table 4:** EOC Student Level Correlations between Prior Standardized Scale Score and 1) Current Scale Score, 2) SGP and 3) Ranked SIMEX SGP - Disaggregated by Norm Group.</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Most Recent Prior</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>$\r_ {  Test Scores}$</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>$\r_ {  SGP}$</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>$\r_ { Ranked SIMEX}$</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>N Size</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Grade 9 Lit</td>
<td style='text-align: right;'>2017 ELA Grade 8</td>
<td style='text-align: right;'>0.70</td>
<td style='text-align: right;'>-0.01</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'>2,881</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2017 Grade 9 Lit</td>
<td style='text-align: right;'>0.59</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>1,832</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 ELA Grade 7</td>
<td style='text-align: right;'>0.71</td>
<td style='text-align: right;'> 0.02</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>6,052</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 ELA Grade 8</td>
<td style='text-align: right;'>0.83</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.08</td>
<td style='text-align: right;'>109,528</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 Grade 9 Lit</td>
<td style='text-align: right;'>0.69</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>5,067</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019 Grade 9 Lit</td>
<td style='text-align: right;'>0.61</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>1,768</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit</td>
<td style='text-align: right;'>2016 Grade 9 Lit</td>
<td style='text-align: right;'>0.77</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.10</td>
<td style='text-align: right;'>2,574</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2017 Grade 9 Lit</td>
<td style='text-align: right;'>0.79</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>96,430</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 American Lit</td>
<td style='text-align: right;'>0.66</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>4,755</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 Grade 9 Lit</td>
<td style='text-align: right;'>0.79</td>
<td style='text-align: right;'>-0.02</td>
<td style='text-align: right;'>-0.11</td>
<td style='text-align: right;'>10,665</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019 American Lit</td>
<td style='text-align: right;'>0.59</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>1,937</td>
</tr>
<tr>
<td style='text-align: right;'>Algebra I</td>
<td style='text-align: right;'>2017 Math Grade 8</td>
<td style='text-align: right;'>0.55</td>
<td style='text-align: right;'>-0.01</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>7,149</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 Algebra I</td>
<td style='text-align: right;'>0.80</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.11</td>
<td style='text-align: right;'>8,223</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 Math Grade 7</td>
<td style='text-align: right;'>0.74</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>23,621</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 Math Grade 8</td>
<td style='text-align: right;'>0.79</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.06</td>
<td style='text-align: right;'>71,673</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019 Algebra I</td>
<td style='text-align: right;'>0.58</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.11</td>
<td style='text-align: right;'>2,651</td>
</tr>
<tr>
<td style='text-align: right;'>Geometry</td>
<td style='text-align: right;'>2017 Algebra I</td>
<td style='text-align: right;'>0.71</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.11</td>
<td style='text-align: right;'>2,278</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 Algebra I</td>
<td style='text-align: right;'>0.73</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>92,589</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 Geometry</td>
<td style='text-align: right;'>0.69</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.10</td>
<td style='text-align: right;'>4,667</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019 Algebra I</td>
<td style='text-align: right;'>0.88</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.09</td>
<td style='text-align: right;'>3,251</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019 Geometry</td>
<td style='text-align: right;'>0.74</td>
<td style='text-align: right;'>-0.01</td>
<td style='text-align: right;'>-0.12</td>
<td style='text-align: right;'>2,274</td>
</tr>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='text-align: right;'>2018 Math Grade 7</td>
<td style='text-align: right;'>0.72</td>
<td style='text-align: right;'> 0.01</td>
<td style='text-align: right;'>-0.10</td>
<td style='text-align: right;'>2,439</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018 Math Grade 8</td>
<td style='text-align: right;'>0.81</td>
<td style='text-align: right;'> 0.00</td>
<td style='text-align: right;'>-0.07</td>
<td style='text-align: right;'>13,115</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Analytic Geometry</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>2018 Coordinate Algebra</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>0.74</td>
<td style='border-bottom: 2px solid grey; text-align: right;'> 0.01</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.08</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>15,604</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 4:** EOC Student Level Correlations between Prior Standardized Scale Score and 1) Current Scale Score, 2) SGP and 3) Ranked SIMEX SGP - Disaggregated by Norm Group.\label{my}} 
\begin{center}
\begin{tabular}{rrrrrr}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Most Recent Prior}&\multicolumn{1}{c}{$\r_ {  Test Scores}$}&\multicolumn{1}{c}{$\r_ {  SGP}$}&\multicolumn{1}{c}{$\r_ { Ranked SIMEX}$}&\multicolumn{1}{c}{N Size}\tabularnewline
\hline
&&&&&\tabularnewline
Grade 9 Lit&2017 ELA Grade 8&0.70&-0.01&-0.08&2,881\tabularnewline
&2017 Grade 9 Lit&0.59& 0.01&-0.07&1,832\tabularnewline
&2018 ELA Grade 7&0.71& 0.02&-0.09&6,052\tabularnewline
&2018 ELA Grade 8&0.83& 0.00&-0.08&109,528\tabularnewline
&2018 Grade 9 Lit&0.69& 0.00&-0.09&5,067\tabularnewline
&2019 Grade 9 Lit&0.61& 0.00&-0.09&1,768\tabularnewline
\hline
&&&&&\tabularnewline
American Lit&2016 Grade 9 Lit&0.77& 0.00&-0.10&2,574\tabularnewline
&2017 Grade 9 Lit&0.79& 0.00&-0.09&96,430\tabularnewline
&2018 American Lit&0.66& 0.00&-0.09&4,755\tabularnewline
&2018 Grade 9 Lit&0.79&-0.02&-0.11&10,665\tabularnewline
&2019 American Lit&0.59& 0.00&-0.09&1,937\tabularnewline
\hline
&&&&&\tabularnewline
Algebra I&2017 Math Grade 8&0.55&-0.01&-0.07&7,149\tabularnewline
&2018 Algebra I&0.80& 0.00&-0.11&8,223\tabularnewline
&2018 Math Grade 7&0.74& 0.00&-0.07&23,621\tabularnewline
&2018 Math Grade 8&0.79& 0.00&-0.06&71,673\tabularnewline
&2019 Algebra I&0.58& 0.00&-0.11&2,651\tabularnewline
\hline
&&&&&\tabularnewline
Geometry&2017 Algebra I&0.71& 0.00&-0.11&2,278\tabularnewline
&2018 Algebra I&0.73& 0.01&-0.07&92,589\tabularnewline
&2018 Geometry&0.69& 0.00&-0.10&4,667\tabularnewline
&2019 Algebra I&0.88& 0.00&-0.09&3,251\tabularnewline
&2019 Geometry&0.74&-0.01&-0.12&2,274\tabularnewline
\hline
&&&&&\tabularnewline
Coordinate Algebra&2018 Math Grade 7&0.72& 0.01&-0.10&2,439\tabularnewline
&2018 Math Grade 8&0.81& 0.00&-0.07&13,115\tabularnewline
\hline
&&&&&\tabularnewline
Analytic Geometry&2018 Coordinate Algebra&0.74& 0.01&-0.08&15,604\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->

<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


# SGP Results

In the following sections basic descriptive statistics from the 2019 analyses are provided, including the state-level mean and median growth percentiles.  Beginning in 2014 the Georgia DOE has used the SIMEX measurement error correction method in the calculation of student-level SGPs.  A system of ranking the SIMEX SGPs in order to improve some student level properties of the growth measure [@CastMcCaf:2017] was added as well in 2017.  Descriptive statistics from the uncorrected and ranked SIMEX corrected SGP results are both presented here.  The interested reader can find more in depth discussions of the SGP methodology in the [available literature](https://github.com/CenterForAssessment/SGP_Resources/tree/master/articles), and information about the SIMEX measurement error correction methodology is available in Appendix B of this report and academic articles [@ShangVanIBet:2015; @CastMcCaf:2017].

## Uncorrected SGPs

Growth percentiles, being quantities associated with each individual student, can be easily summarized across numerous grouping indicators to provide summary results regarding growth.  The median and mean of a collection of growth percentiles are used as measures of central tendency that summarize the distribution as a single number.  With perfect data fit, we expect the state median of all student growth percentiles in any grade to be 50 because the data are norm-referenced across all students in the state.  Median (and mean) growth percentiles well below 50 represent growth less than the state "average" and median growth percentiles well above 50 represent growth in excess of the state "average".

To demonstrate the norm-referenced nature of the growth percentiles viewed at the state level, Tables 5 and  6 present the cohort-referenced growth percentile medians and means for the EOG and EOC content areas respectively.


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='7' style='text-align: left;'>
**Table 5:** 2019 EOG Median (Mean) Student Growth Percentile by Grade and Content Area.</td></tr>
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
<td style='text-align: right;'>ELA</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>50 (49.9)</td>
<td style='text-align: right;'>50 (50.1)</td>
<td style='text-align: right;'>50 (50)</td>
<td style='text-align: right;'>50 (50)</td>
<td style='text-align: right;'>50 (49.9)</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (49.9)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (50.1)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (50)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (50)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (50)</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 5:** 2019 EOG Median (Mean) Student Growth Percentile by Grade and Content Area.\label{}} 
\begin{center}
\begin{tabular}{rcrrrrr}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{5}{c}{\bfseries Grades}\tabularnewline
\cline{3-7}
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{4}&\multicolumn{1}{c}{5}&\multicolumn{1}{c}{6}&\multicolumn{1}{c}{7}&\multicolumn{1}{c}{8}\tabularnewline
\hline
ELA&&50 (49.9)&50 (50.1)&50 (50)&50 (50)&50 (49.9)\tabularnewline
Mathematics&&50 (49.9)&50 (50.1)&50 (50)&50 (50)&50 (50)\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='3' style='text-align: left;'>
**Table 6:** 2019 EOC Median and Mean Student Growth Percentile by Content Area.</td></tr>
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
<td style='text-align: center;'>49.9</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>50.1</td>
</tr>
<tr>
<td style='text-align: right;'>Algebra I</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>49.9</td>
</tr>
<tr>
<td style='text-align: right;'>Geometry</td>
<td style='text-align: center;'>49</td>
<td style='text-align: center;'>49.1</td>
</tr>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>50.0</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Analytic Geometry</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>49</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>49.2</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 6:** 2019 EOC Median and Mean Student Growth Percentile by Content Area.\label{my}} 
\begin{center}
\begin{tabular}{rcc}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}\tabularnewline
\hline
Grade 9 Lit&50&49.9\tabularnewline
American Lit&50&50.1\tabularnewline
Algebra I&50&49.9\tabularnewline
Geometry&49&49.1\tabularnewline
Coordinate Algebra&50&50.0\tabularnewline
Analytic Geometry&49&49.2\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->

Based upon perfect model fit to the data, the median of all state growth percentiles in each grade by year by subject combination should be 50.  That is, in the conditional distributions, 50 percent of growth percentiles should be less than 50 and 50 percent should be greater than 50.  Deviations from 50 indicate imperfect model fit to the data.  Imperfect model fit can occur for a number of reasons, some due to issues with the data (e.g., floor and ceiling effects leading to a "bunching" up of the data) as well as issues due to the way that the SGP function fits the data.  The results in Tables 5 and  6 are close to perfect, with almost all values equal to 50.  The slight deviations in the EOC results are due to collapsing these aggregations across the numerous course progression analyses. 

The results are coarse in that they are aggregated across tens of thousands of students.  More refined fit analyses were presented in the "Goodness of Fit" section.  Depending upon feedback from Georgia DOE, it may be desirable to tweak some operational parameters and attempt to improve fit even further.  The impact upon the operational results based on better fit is expected to be extremely minor.


## Ranked SIMEX Adjusted SGPs

The use of standardized test scores in statistical models may lead to problems due to measurement error. Understanding the effects of measurement error in test scores and correcting for it is particularly difficult in the SGP model given that it is based on non-parametric quantile regression. Preliminary investigations suggest that the use of test scores uncorrected for measurement error may lead to SGP estimates that are overestimated for students with high prior achievement and underestimated for students with lower prior achievement. This bias at the individual student-level may translate to bias in aggregate measures (such as median and mean SGPs) when student sorting into classrooms or schools based on prior achievement exists at the level of aggregation. As a result of this student sorting, growth and prior achievement are (positively) correlated at aggregate levels, giving schools and teachers with higher achieving students an undue advantage and disadvantaging those with lower achieving students.  

Using ranked simulation-extrapolation (SIMEX) methods in the SGP estimation for correcting bias caused by assessment measurement error has been proposed and tested in Georgia.  Descriptive statistics from these analyses are provided here and in the "Goodness of Fit" section.  Additional technical information about the SIMEX procedure in general and its use in the calculation of cohort-referenced SGPs is provided in Appendix B of this report.


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='7' style='text-align: left;'>
**Table 7:** Ranked SIMEX Corrected EOG Median (Mean) Student Growth Percentile by Grade and Content Area for 2019</td></tr>
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
<td style='text-align: right;'>ELA</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>50 (50)</td>
<td style='text-align: right;'>50 (50.2)</td>
<td style='text-align: right;'>50 (50.1)</td>
<td style='text-align: right;'>50 (50.1)</td>
<td style='text-align: right;'>50 (50)</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Mathematics</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (50)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (50.1)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (50.1)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (50.1)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>50 (50)</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 7:** Ranked SIMEX Corrected EOG Median (Mean) Student Growth Percentile by Grade and Content Area for 2019\label{}} 
\begin{center}
\begin{tabular}{rcrrrrr}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{5}{c}{\bfseries Grades}\tabularnewline
\cline{3-7}
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{4}&\multicolumn{1}{c}{5}&\multicolumn{1}{c}{6}&\multicolumn{1}{c}{7}&\multicolumn{1}{c}{8}\tabularnewline
\hline
ELA&&50 (50)&50 (50.2)&50 (50.1)&50 (50.1)&50 (50)\tabularnewline
Mathematics&&50 (50)&50 (50.1)&50 (50.1)&50 (50.1)&50 (50)\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='3' style='text-align: left;'>
**Table 8:** Ranked SIMEX Corrected EOC Median (Mean) Student Growth Percentile by Content Area for 2019</td></tr>
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
<td style='text-align: center;'>50.0</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>50.2</td>
</tr>
<tr>
<td style='text-align: right;'>Algebra I</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>50.0</td>
</tr>
<tr>
<td style='text-align: right;'>Geometry</td>
<td style='text-align: center;'>49</td>
<td style='text-align: center;'>49.4</td>
</tr>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='text-align: center;'>50</td>
<td style='text-align: center;'>50.1</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Analytic Geometry</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>49</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>49.5</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 8:** Ranked SIMEX Corrected EOC Median (Mean) Student Growth Percentile by Content Area for 2019\label{my}} 
\begin{center}
\begin{tabular}{rcc}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}\tabularnewline
\hline
Grade 9 Lit&50&50.0\tabularnewline
American Lit&50&50.2\tabularnewline
Algebra I&50&50.0\tabularnewline
Geometry&49&49.4\tabularnewline
Coordinate Algebra&50&50.1\tabularnewline
Analytic Geometry&49&49.5\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->

A comparison of the unadjusted (Tables 5 and 6) and SIMEX corrected (Tables 7 and 8) shows very little difference in the medians and means.  This is not surprising as the majority of the growth percentiles for students in the middle of the prior score distributions change very little after SIMEX correction, and the larger changes that occur for students in the extremes of the prior score distributions tend to even out.  

It is important to note how, at the entire state level, the *norm-referenced* growth information returns little information on annual trends due to its norm-reference nature.  What the results indicate is that a typical (or average) student in the state demonstrates 50<sup>th</sup> percentile growth.  That is, "typical students" demonstrate "typical growth".  One benefit of the norm-referenced results follows when subgroups are examined (e.g., schools, district, demographic groups, etc.) Examining subgroups in terms of the mean or median of their student growth percentiles, it is then possible to investigate why some subgroups display lower/higher student growth than others.  Moreover, because the subgroup summary statistic (i.e., the median) is composed of many individual student growth percentiles, one can break out the result and further examine the distribution of individual results.  


<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


## Group Level Results

Unlike when reporting SGPs at the individual level, when aggregating to the group level (e.g., school) the correlation between aggregate prior student achievement and aggregate growth is rarely zero. The correlation between prior student achievement and growth at the school level is a compelling descriptive statistic because it indicates whether students attending schools serving higher achieving students grow faster (on average) than those students attending schools serving lower achieving students. Results from previous state analyses show a correlation between prior achievement of students associated with a current school (quantified as percent at/above proficient) and the median SGP are typically between 0.1 and 0.3 (although higher numbers have been observed in some states as well). That is, these results indicate that on average, students attending schools serving lower achieving students tend to demonstrate less exemplary growth than those attending schools serving higher achieving students. Equivalently, based upon ordinary least squares (OLS) regression assumptions, the prior achievement level of students attending a school accounts for between 1 and 10 percent of the variability observed in student growth. There are no definitive numbers on what this correlation should be, but studies on value-added models show similar results [@MccaLock:2008].

### School Level Results

To illustrate these relationships visually, the bubble charts in Figures 7 and 8 depict growth as quantified by the median SGP of students at the school against prior achievement status, quantified by percentage of student at/above proficient at the school.  "Prior Percent at/above Proficient" in this case is determined by the percent of students that scored in the "Proficient Learner" or "Distinguished Learner" range of the prior year's Milestones test out of all students that received a score.  The charts have been successful in helping to motivate the discussion of the two qualities: student achievement and student growth.  Though the figures are not detailed enough to indicate strength of relationship between growth and achievement, they are suggestive and valuable for discussions with stakeholders who are being introduced to the growth model for the first time.  Only charts for the EOG subjects are shown here.




<!-- HTML_Start -->

<div class='caption'> <strong>Figure 7:</strong>   School-level Bubble Plots for Georgia: ELA, 2018-2019 (\(N \geq 15\)). </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Bubble_Plots/2019/State/Style_1/Georgia_2019_ELA_State_Bubble_Plot_(Prior_Achievement).png' style='width: 640px;'/>
</div>
</div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 7:}}   } School-level Bubble Plots for Georgia: ELA, 2018-2019 (\(N \geq 15\)).}
  \begin{subfigure}[b]{0.925\textwidth}
    \includegraphics[width=\textwidth]{../img/Bubble_Plots/2019/State/Style_1/Georgia_2019_ELA_State_Bubble_Plot_(Prior_Achievement).png}
  \end{subfigure}
\end{figure}

LaTeX_End -->

<p></p>
<p></p>



<!-- HTML_Start -->

<div class='caption'> <strong>Figure 8:</strong>   School-level Bubble Plots for Georgia: Mathematics, 2018-2019 (\(N \geq 15\)). </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Bubble_Plots/2019/State/Style_1/Georgia_2019_Mathematics_State_Bubble_Plot_(Prior_Achievement).png' style='width: 640px;'/>
</div>
</div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 8:}}   } School-level Bubble Plots for Georgia: Mathematics, 2018-2019 (\(N \geq 15\)).}
  \begin{subfigure}[b]{0.925\textwidth}
    \includegraphics[width=\textwidth]{../img/Bubble_Plots/2019/State/Style_1/Georgia_2019_Mathematics_State_Bubble_Plot_(Prior_Achievement).png}
  \end{subfigure}
\end{figure}

LaTeX_End -->

<p></p>
<p></p>


The school-level relationship between average prior student achievement and median SGP observed for Georgia is relatively strong compared to some other states for which the NCIEA has done SGP analyses.  Table 9 shows overall correlation between prior achievement (measured here as the mean prior standardized scale score) for the previous three years.  All results shown here are for schools with 15 or more students.





<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<caption style='caption-side: top'>
**Table 9:** 2017 to 2019 Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs - (Combined Subjects)</caption>
<thead>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='4' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>SGP Aggregate Type</th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Year</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median
Uncorrected</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean
Uncorrected</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Median
Ranked SIMEX</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Mean
Ranked SIMEX</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>N</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: center;'>2017</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: center;'>0.54</td>
<td style='text-align: center;'>0.55</td>
<td style='text-align: center;'>0.40</td>
<td style='text-align: center;'>0.41</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: center;'>2,170</td>
</tr>
<tr>
<td style='text-align: center;'>2018</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: center;'>0.52</td>
<td style='text-align: center;'>0.53</td>
<td style='text-align: center;'>0.37</td>
<td style='text-align: center;'>0.38</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: center;'>2,177</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: center;'>2019</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.52</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.53</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.36</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.38</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>2,182</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 9:** 2017 to 2019 Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs - (Combined Subjects)\label{my}} 
\begin{center}
\begin{tabular}{cccccccc}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{4}{c}{\bfseries SGP Aggregate Type}&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }\tabularnewline
\cline{3-6}
\multicolumn{1}{c}{Year}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Median}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{Median}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{N}\tabularnewline
&&\multicolumn{1}{c}{{\scriptsize Uncorrected}}&\multicolumn{1}{c}{{\scriptsize Uncorrected}}&\multicolumn{1}{c}{{\scriptsize Ranked SIMEX}}&\multicolumn{1}{c}{{\scriptsize Ranked SIMEX}}&&\tabularnewline
\hline
2017&&0.54&0.55&0.40&0.41&&2,170\tabularnewline
2018&&0.52&0.53&0.37&0.38&&2,177\tabularnewline
2019&&0.52&0.53&0.36&0.38&&2,182\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->

The correlations shown in Table 9 provide important context for the relationship between total school-level combined growth and achievement because school accountability measures typically combine growth and status measures across grades and content areas to produce a single school accountability metric.  However, using these high-level aggregates in correlations can create an ["ecological fallacy"](https://en.wikipedia.org/wiki/Ecological_fallacy).  That is, the school-level correlations are inflated by aggregating across the lower-level groups upon which the SGP analyses are based.

In order to provide a more detailed look at the relationship between school-level growth and prior achievement, additional correlation tables are presented below in separate subsections for EOG and EOC subjects.  The first correlation table in the EOG subsection disaggregates the school-level correlation between mean/median SGP and mean prior standardized scale scores by content area.  The second table is disaggregated by content area and grade to provide detail at the level at which the SGP analyses is actually occurring.  Note that the correlations gradually decrease as the aggregation level approaches the level at which the analyses are performed.  The EOC subsection includes correlations disaggregated by content area only.



<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->

<div class='caption'>**End-of-Grade Content Areas**</div>



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='7' style='text-align: left;'>
**Table 10:** 2017 to 2019 School Level EOG Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs by Content Area.</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Year</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median
Uncorrected</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean
Uncorrected</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median
Ranked SIMEX</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean
Ranked SIMEX</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>N</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>ELA</td>
<td style='text-align: right;'>2017</td>
<td style='text-align: center;'>0.50</td>
<td style='text-align: center;'>0.52</td>
<td style='text-align: center;'>0.31</td>
<td style='text-align: center;'>0.33</td>
<td style='text-align: center;'>1,748</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018</td>
<td style='text-align: center;'>0.47</td>
<td style='text-align: center;'>0.48</td>
<td style='text-align: center;'>0.28</td>
<td style='text-align: center;'>0.29</td>
<td style='text-align: center;'>1,756</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019</td>
<td style='text-align: center;'>0.46</td>
<td style='text-align: center;'>0.47</td>
<td style='text-align: center;'>0.27</td>
<td style='text-align: center;'>0.29</td>
<td style='text-align: center;'>1,763</td>
</tr>
<tr>
<td style='text-align: right;'>Mathematics</td>
<td style='text-align: right;'>2017</td>
<td style='text-align: center;'>0.40</td>
<td style='text-align: center;'>0.42</td>
<td style='text-align: center;'>0.29</td>
<td style='text-align: center;'>0.30</td>
<td style='text-align: center;'>1,748</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018</td>
<td style='text-align: center;'>0.39</td>
<td style='text-align: center;'>0.40</td>
<td style='text-align: center;'>0.28</td>
<td style='text-align: center;'>0.29</td>
<td style='text-align: center;'>1,757</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'></td>
<td style='border-bottom: 2px solid grey; text-align: right;'>2019</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.40</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.41</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.28</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.29</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>1,762</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 10:** 2017 to 2019 School Level EOG Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs by Content Area.\label{my}} 
\begin{center}
\begin{tabular}{rrccccc}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Year}&\multicolumn{1}{c}{Median}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{Median}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{N}\tabularnewline
&&\multicolumn{1}{c}{{\scriptsize Uncorrected}}&\multicolumn{1}{c}{{\scriptsize Uncorrected}}&\multicolumn{1}{c}{{\scriptsize Ranked SIMEX}}&\multicolumn{1}{c}{{\scriptsize Ranked SIMEX}}&\tabularnewline
\hline
&&&&&&\tabularnewline
ELA&2017&0.50&0.52&0.31&0.33&1,748\tabularnewline
&2018&0.47&0.48&0.28&0.29&1,756\tabularnewline
&2019&0.46&0.47&0.27&0.29&1,763\tabularnewline
\hline
&&&&&&\tabularnewline
Mathematics&2017&0.40&0.42&0.29&0.30&1,748\tabularnewline
&2018&0.39&0.40&0.28&0.29&1,757\tabularnewline
&2019&0.40&0.41&0.28&0.29&1,762\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->
<p></p>


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='7' style='text-align: left;'>
**Table 11:** 2019 School Level EOG Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs by Content Area and Grade.</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Year</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median
uncorrected</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean
uncorrected</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median
ranked SIMEX</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean
ranked SIMEX</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>N</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>ELA</td>
<td style='text-align: right;'>4</td>
<td style='text-align: center;'>0.32</td>
<td style='text-align: center;'>0.34</td>
<td style='text-align: center;'>0.12</td>
<td style='text-align: center;'>0.14</td>
<td style='text-align: center;'>1,240</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>5</td>
<td style='text-align: center;'>0.28</td>
<td style='text-align: center;'>0.29</td>
<td style='text-align: center;'>0.13</td>
<td style='text-align: center;'>0.14</td>
<td style='text-align: center;'>1,232</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>6</td>
<td style='text-align: center;'>0.23</td>
<td style='text-align: center;'>0.26</td>
<td style='text-align: center;'>0.09</td>
<td style='text-align: center;'>0.10</td>
<td style='text-align: center;'>565</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>7</td>
<td style='text-align: center;'>0.37</td>
<td style='text-align: center;'>0.37</td>
<td style='text-align: center;'>0.22</td>
<td style='text-align: center;'>0.21</td>
<td style='text-align: center;'>553</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>8</td>
<td style='text-align: center;'>0.36</td>
<td style='text-align: center;'>0.38</td>
<td style='text-align: center;'>0.22</td>
<td style='text-align: center;'>0.23</td>
<td style='text-align: center;'>545</td>
</tr>
<tr>
<td style='text-align: right;'>Mathematics</td>
<td style='text-align: right;'>4</td>
<td style='text-align: center;'>0.24</td>
<td style='text-align: center;'>0.26</td>
<td style='text-align: center;'>0.11</td>
<td style='text-align: center;'>0.13</td>
<td style='text-align: center;'>1,240</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>5</td>
<td style='text-align: center;'>0.18</td>
<td style='text-align: center;'>0.20</td>
<td style='text-align: center;'>0.09</td>
<td style='text-align: center;'>0.10</td>
<td style='text-align: center;'>1,232</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>6</td>
<td style='text-align: center;'>0.25</td>
<td style='text-align: center;'>0.26</td>
<td style='text-align: center;'>0.18</td>
<td style='text-align: center;'>0.19</td>
<td style='text-align: center;'>565</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>7</td>
<td style='text-align: center;'>0.25</td>
<td style='text-align: center;'>0.25</td>
<td style='text-align: center;'>0.13</td>
<td style='text-align: center;'>0.13</td>
<td style='text-align: center;'>553</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'></td>
<td style='border-bottom: 2px solid grey; text-align: right;'>8</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.24</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.24</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.14</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.15</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>542</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 11:** 2019 School Level EOG Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs by Content Area and Grade.\label{my}} 
\begin{center}
\begin{tabular}{rrccccc}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Year}&\multicolumn{1}{c}{Median}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{Median}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{N}\tabularnewline
&&\multicolumn{1}{c}{{\scriptsize uncorrected}}&\multicolumn{1}{c}{{\scriptsize uncorrected}}&\multicolumn{1}{c}{{\scriptsize ranked SIMEX}}&\multicolumn{1}{c}{{\scriptsize ranked SIMEX}}&\tabularnewline
\hline
&&&&&&\tabularnewline
ELA&4&0.32&0.34&0.12&0.14&1,240\tabularnewline
&5&0.28&0.29&0.13&0.14&1,232\tabularnewline
&6&0.23&0.26&0.09&0.10&565\tabularnewline
&7&0.37&0.37&0.22&0.21&553\tabularnewline
&8&0.36&0.38&0.22&0.23&545\tabularnewline
\hline
&&&&&&\tabularnewline
Mathematics&4&0.24&0.26&0.11&0.13&1,240\tabularnewline
&5&0.18&0.20&0.09&0.10&1,232\tabularnewline
&6&0.25&0.26&0.18&0.19&565\tabularnewline
&7&0.25&0.25&0.13&0.13&553\tabularnewline
&8&0.24&0.24&0.14&0.15&542\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->

<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->

<div class='caption'>**End-of-Course Subjects**</div>



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='7' style='text-align: left;'>
**Table 12:** 2017 to 2019 School Level EOC Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs by Content Area.</td></tr>
<tr>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Year</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median
Uncorrected</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean
Uncorrected</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Median
Ranked SIMEX</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Mean
Ranked SIMEX</th>
<th style='border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>N</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Grade 9 Lit</td>
<td style='text-align: right;'>2017</td>
<td style='text-align: center;'>0.38</td>
<td style='text-align: center;'>0.40</td>
<td style='text-align: center;'>0.22</td>
<td style='text-align: center;'>0.23</td>
<td style='text-align: center;'>522</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018</td>
<td style='text-align: center;'>0.43</td>
<td style='text-align: center;'>0.44</td>
<td style='text-align: center;'>0.25</td>
<td style='text-align: center;'>0.26</td>
<td style='text-align: center;'>527</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019</td>
<td style='text-align: center;'>0.40</td>
<td style='text-align: center;'>0.43</td>
<td style='text-align: center;'>0.23</td>
<td style='text-align: center;'>0.26</td>
<td style='text-align: center;'>547</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit</td>
<td style='text-align: right;'>2017</td>
<td style='text-align: center;'>0.56</td>
<td style='text-align: center;'>0.59</td>
<td style='text-align: center;'>0.46</td>
<td style='text-align: center;'>0.49</td>
<td style='text-align: center;'>429</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018</td>
<td style='text-align: center;'>0.56</td>
<td style='text-align: center;'>0.57</td>
<td style='text-align: center;'>0.43</td>
<td style='text-align: center;'>0.43</td>
<td style='text-align: center;'>434</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019</td>
<td style='text-align: center;'>0.43</td>
<td style='text-align: center;'>0.45</td>
<td style='text-align: center;'>0.27</td>
<td style='text-align: center;'>0.29</td>
<td style='text-align: center;'>437</td>
</tr>
<tr>
<td style='text-align: right;'>Algebra I</td>
<td style='text-align: right;'>2017</td>
<td style='text-align: center;'>0.36</td>
<td style='text-align: center;'>0.37</td>
<td style='text-align: center;'>0.26</td>
<td style='text-align: center;'>0.28</td>
<td style='text-align: center;'>597</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018</td>
<td style='text-align: center;'>0.35</td>
<td style='text-align: center;'>0.37</td>
<td style='text-align: center;'>0.25</td>
<td style='text-align: center;'>0.27</td>
<td style='text-align: center;'>646</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019</td>
<td style='text-align: center;'>0.30</td>
<td style='text-align: center;'>0.31</td>
<td style='text-align: center;'>0.22</td>
<td style='text-align: center;'>0.23</td>
<td style='text-align: center;'>675</td>
</tr>
<tr>
<td style='text-align: right;'>Geometry</td>
<td style='text-align: right;'>2017</td>
<td style='text-align: center;'>0.45</td>
<td style='text-align: center;'>0.48</td>
<td style='text-align: center;'>0.34</td>
<td style='text-align: center;'>0.36</td>
<td style='text-align: center;'>331</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018</td>
<td style='text-align: center;'>0.39</td>
<td style='text-align: center;'>0.41</td>
<td style='text-align: center;'>0.24</td>
<td style='text-align: center;'>0.26</td>
<td style='text-align: center;'>348</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019</td>
<td style='text-align: center;'>0.41</td>
<td style='text-align: center;'>0.45</td>
<td style='text-align: center;'>0.27</td>
<td style='text-align: center;'>0.30</td>
<td style='text-align: center;'>374</td>
</tr>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='text-align: right;'>2017</td>
<td style='text-align: center;'>0.31</td>
<td style='text-align: center;'>0.33</td>
<td style='text-align: center;'>0.20</td>
<td style='text-align: center;'>0.20</td>
<td style='text-align: center;'>160</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018</td>
<td style='text-align: center;'>0.18</td>
<td style='text-align: center;'>0.18</td>
<td style='text-align: center;'>0.10</td>
<td style='text-align: center;'>0.07</td>
<td style='text-align: center;'>114</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2019</td>
<td style='text-align: center;'>0.20</td>
<td style='text-align: center;'>0.24</td>
<td style='text-align: center;'>0.11</td>
<td style='text-align: center;'>0.13</td>
<td style='text-align: center;'>109</td>
</tr>
<tr>
<td style='text-align: right;'>Analytic Geometry</td>
<td style='text-align: right;'>2017</td>
<td style='text-align: center;'>0.25</td>
<td style='text-align: center;'>0.30</td>
<td style='text-align: center;'>0.13</td>
<td style='text-align: center;'>0.16</td>
<td style='text-align: center;'>122</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>2018</td>
<td style='text-align: center;'>0.35</td>
<td style='text-align: center;'>0.38</td>
<td style='text-align: center;'>0.22</td>
<td style='text-align: center;'>0.23</td>
<td style='text-align: center;'>89</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'></td>
<td style='border-bottom: 2px solid grey; text-align: right;'>2019</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.32</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.34</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.19</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>0.20</td>
<td style='border-bottom: 2px solid grey; text-align: center;'>67</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 12:** 2017 to 2019 School Level EOC Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs by Content Area.\label{my}} 
\begin{center}
\begin{tabular}{rrccccc}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Year}&\multicolumn{1}{c}{Median}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{Median}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{N}\tabularnewline
&&\multicolumn{1}{c}{{\scriptsize Uncorrected}}&\multicolumn{1}{c}{{\scriptsize Uncorrected}}&\multicolumn{1}{c}{{\scriptsize Ranked SIMEX}}&\multicolumn{1}{c}{{\scriptsize Ranked SIMEX}}&\tabularnewline
\hline
&&&&&&\tabularnewline
Grade 9 Lit&2017&0.38&0.40&0.22&0.23&522\tabularnewline
&2018&0.43&0.44&0.25&0.26&527\tabularnewline
&2019&0.40&0.43&0.23&0.26&547\tabularnewline
\hline
&&&&&&\tabularnewline
American Lit&2017&0.56&0.59&0.46&0.49&429\tabularnewline
&2018&0.56&0.57&0.43&0.43&434\tabularnewline
&2019&0.43&0.45&0.27&0.29&437\tabularnewline
\hline
&&&&&&\tabularnewline
Algebra I&2017&0.36&0.37&0.26&0.28&597\tabularnewline
&2018&0.35&0.37&0.25&0.27&646\tabularnewline
&2019&0.30&0.31&0.22&0.23&675\tabularnewline
\hline
&&&&&&\tabularnewline
Geometry&2017&0.45&0.48&0.34&0.36&331\tabularnewline
&2018&0.39&0.41&0.24&0.26&348\tabularnewline
&2019&0.41&0.45&0.27&0.30&374\tabularnewline
\hline
&&&&&&\tabularnewline
Coordinate Algebra&2017&0.31&0.33&0.20&0.20&160\tabularnewline
&2018&0.18&0.18&0.10&0.07&114\tabularnewline
&2019&0.20&0.24&0.11&0.13&109\tabularnewline
\hline
&&&&&&\tabularnewline
Analytic Geometry&2017&0.25&0.30&0.13&0.16&122\tabularnewline
&2018&0.35&0.38&0.22&0.23&89\tabularnewline
&2019&0.32&0.34&0.19&0.20&67\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->

<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


#  Student Growth Targets

To fully understand the rates of student growth in the state, it is necessary to complement the normative growth results with a standard based interpretation (i.e. a growth-to-standard measure).  Whereas normative growth answers the question "What is?", growth-to-standard analyses attempt to establish a threshold answering "What should be?".  For example, if universal proficiency is the goal of the education system, then growth adequacy can be anchored to that achievement target.

Student growth targets describe how much growth a student will likely need to be on track to reach a desired achievement level within a specific time frame. By defining a future achievement target for each student, growth percentile analyses can be used to quantify what level of growth, expressed as a per/year growth percentile, is required by the student to reach their achievement target (identified by the proficiency level cutscores, e.g. a scale score of 525 for "Proficient Learner"). Unique to the SGP Methodology is the ability to stipulate *both* what the growth standard is as well as how much the student actually grew in a metric that is informative to stakeholders.

Establishing thresholds for growth for each student that can be used to make adequacy judgments requires pre-established achievement targets and a time-frame to reach the target for each student against which growth can be assessed.  Georgia uses a single year from the establishment of the target for describing students' growth-to-standard and has established three growth target levels based on the state's performance levels:

- **Developing Learner Target:** The Developing Learner Target describes the amount of growth a student needs to become or remain a Developing Learner.
- **Proficient Learner Target:** The Proficient Learner Target describes the amount of growth a student needs to become or remain a Proficient Learner.
- **Distinguished Learner Target:** The Distinguished Learner Target describes the amount of growth a student needs to become or remain a Distinguished Learner.

Targets are initially established in the prior academic year, so that students' growth towards specific targets in the current year are considered relative to growth norms from the previous years' cohort.  That is, Georgia "banks" growth targets for use in the subsequent academic year.  As an example, a 6<sup>th</sup> grade student's 2019 ELA SGP would be compared to the 6<sup>th</sup> grade ELA targets calculated in 2018, and that student's cohort would form the growth targets on which 2020 ELA 6<sup>th</sup> graders will be compared.

The growth target analyses done in 2019 will be used in the [Georgia visualization tool](http://gastudentgrowth.gadoe.org/) to provide stakeholders with prospective information about student growth needs in the upcoming year.  These targets will also be used to compare with 2020 SGPs to determine growth adequacy.  The following sections provide descriptive statistics of the growth target results for 2019.


<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->

##  Growth Target Summary Statistics

The following tables and figures summarize the distributions of the 2019 Developing, Proficient and Distinguished Growth Targets that describe how much growth a student will need to reach a desired achievement level in 2020. They are disaggregated by test (EOG/EOC), content area, and current achievement level to illustrate how students' academic starting points impact their one-year growth targets. 

As would be expected, students with lower current achievement levels need to demonstrate more growth than students with higher current achievement to reach the same target proficiency level. For example, Table 13 shows that for ELA the median SGP needed for all students in the Beginning Learner achievement level (currently) to move to the Developing Learner achievement level next year is 74 (some student's targets are higher, some lower). The median SGP for those students to move to the Proficient Learner achievement level next year is 99. 

These tables and figures help us better understand the variability of growth targets for achievement levels and the extent to which some students must grow in the next year in order to meet certain achievement levels.






###  End of Grade Growth Targets

The EOG summaries include targets that project from one grade level to the next.  This includes ELA and Mathematics targets for grades 4 through 8 in 2020 (i.e. 3<sup>rd</sup> to 7<sup>th</sup> graders in 2019).


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='7' style='text-align: left;'>
**Table 13:** Median (Mean) 2019 EOG Growth Targets by Target Content Area and Current Achievement Level</td></tr>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='3' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Growth Target Levels</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Target Content Area</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Current Achievement Level</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Developing</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Proficient</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Distinguished</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>ELA</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Beginning Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>74 (70.5)</td>
<td style='text-align: right;'>99 (97.7)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Developing Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>12 (16.3)</td>
<td style='text-align: right;'>75 (71.3)</td>
<td style='text-align: right;'>99 (98.7)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Proficient Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>1 (1.9)</td>
<td style='text-align: right;'>16 (20.4)</td>
<td style='text-align: right;'>90 (84.4)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Distinguished Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>1 (1.0)</td>
<td style='text-align: right;'>1 (2.1)</td>
<td style='text-align: right;'>37 (37.3)</td>
</tr>
<tr>
<td style='text-align: right;'>Mathematics</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Beginning Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>75 (71.6)</td>
<td style='text-align: right;'>99 (98.7)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Developing Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>13 (18.3)</td>
<td style='text-align: right;'>84 (79.8)</td>
<td style='text-align: right;'>99 (98.9)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Proficient Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>1 (1.7)</td>
<td style='text-align: right;'>19 (23.3)</td>
<td style='text-align: right;'>90 (84.3)</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'></td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>Distinguished Learner</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>1 (1.0)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>1 (1.9)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>28 (29.4)</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 13:** Median (Mean) 2019 EOG Growth Targets by Target Content Area and Current Achievement Level\label{}} 
\begin{center}
\begin{tabular}{rcrcrrr}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{3}{c}{\bfseries Growth Target Levels}\tabularnewline
\cline{5-7}
\multicolumn{1}{c}{Target Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Current Achievement Level}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Developing}&\multicolumn{1}{c}{Proficient}&\multicolumn{1}{c}{Distinguished}\tabularnewline
\hline
&&&&&&\tabularnewline
ELA&&Beginning Learner&&74 (70.5)&99 (97.7)&99 (99.0)\tabularnewline
&&Developing Learner&&12 (16.3)&75 (71.3)&99 (98.7)\tabularnewline
&&Proficient Learner&&1 (1.9)&16 (20.4)&90 (84.4)\tabularnewline
&&Distinguished Learner&&1 (1.0)&1 (2.1)&37 (37.3)\tabularnewline
\hline
&&&&&&\tabularnewline
Mathematics&&Beginning Learner&&75 (71.6)&99 (98.7)&99 (99.0)\tabularnewline
&&Developing Learner&&13 (18.3)&84 (79.8)&99 (98.9)\tabularnewline
&&Proficient Learner&&1 (1.7)&19 (23.3)&90 (84.3)\tabularnewline
&&Distinguished Learner&&1 (1.0)&1 (1.9)&28 (29.4)\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->


<!-- HTML_Start -->

<div class='caption'> <strong>Figure 9:</strong>   2019 EOG growth target box plots by current achievement level. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Box_Plots-1.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 9:}}   } 2019 EOG growth target box plots by current achievement level.}
  \begin{subfigure}[b]{1\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Box_Plots-1.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->

###  End of Course Growth Targets

The EOC summaries include targets that project from one subject to the next related subject that represents the most typical course progression in Georgia: 

- 8<sup>th</sup> Grade ELA $\rightarrow$ 9<sup>th</sup> Grade Literature
- 8<sup>th</sup> Grade Mathematics $\rightarrow$ Algebra I
- 9<sup>th</sup> Grade Literature $\rightarrow$ American Literature
- Algebra I $\rightarrow$ Geometry
- Coordinate Algebra $\rightarrow$ Analytic Geometry

A less typical, but important, course progression target is also calculated for grade 8 students:

-	8<sup>th</sup> Grade Mathematics $\rightarrow$ Coordinate Algebra

For mathematics, it is unknown which high school math course sequence will be taken in 2020 by current 8<sup>th</sup> grade students in 2019.  Therefore, each 8<sup>th</sup> grade student receives both a Grade 8 Math to Algebra I target (typical progression) and Grade 8 Math to Coordinate Algebra target (less typical progression). 



<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='7' style='text-align: left;'>
**Table 14:** 2019 EOC Median (Mean) Growth Targets by Subject and Current Achievement.</td></tr>
<tr>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='3' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Growth Target Levels</th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Target Content Area</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Current Achievement Level</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Developing</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Proficient</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Distinguished</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>Grade 9 Lit</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Beginning Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>62 (60.9)</td>
<td style='text-align: right;'>99 (96.7)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Developing Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>5 (8.1)</td>
<td style='text-align: right;'>59 (57.2)</td>
<td style='text-align: right;'>99 (98.6)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Proficient Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>1 (1.2)</td>
<td style='text-align: right;'>6 (9.9)</td>
<td style='text-align: right;'>85 (79.7)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Distinguished Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>1 (1.0)</td>
<td style='text-align: right;'>1 (1.2)</td>
<td style='text-align: right;'>28 (30.5)</td>
</tr>
<tr>
<td style='text-align: right;'>American Lit</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Beginning Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>90 (85.4)</td>
<td style='text-align: right;'>99 (98.8)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Developing Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>26 (31.2)</td>
<td style='text-align: right;'>92 (88.1)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Proficient Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>2 (3.7)</td>
<td style='text-align: right;'>33 (36.7)</td>
<td style='text-align: right;'>97 (92.3)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Distinguished Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>1 (1.0)</td>
<td style='text-align: right;'>3 (3.9)</td>
<td style='text-align: right;'>53 (51.6)</td>
</tr>
<tr>
<td style='text-align: right;'>Algebra I</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Beginning Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>80 (78.1)</td>
<td style='text-align: right;'>99 (98.5)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Developing Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>29 (31.7)</td>
<td style='text-align: right;'>89 (85.6)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Proficient Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>3 (4.7)</td>
<td style='text-align: right;'>40 (40.7)</td>
<td style='text-align: right;'>98 (94.9)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Distinguished Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>1 (1.0)</td>
<td style='text-align: right;'>4 (5.6)</td>
<td style='text-align: right;'>61 (57.8)</td>
</tr>
<tr>
<td style='text-align: right;'>Geometry</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Beginning Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>76 (73.3)</td>
<td style='text-align: right;'>99 (97.5)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Developing Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>19 (23.2)</td>
<td style='text-align: right;'>78 (74.4)</td>
<td style='text-align: right;'>99 (98.8)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Proficient Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>2 (2.7)</td>
<td style='text-align: right;'>18 (22.2)</td>
<td style='text-align: right;'>88 (83.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Distinguished Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>1 (1.0)</td>
<td style='text-align: right;'>1 (1.7)</td>
<td style='text-align: right;'>24 (25.4)</td>
</tr>
<tr>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Beginning Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>78 (75.8)</td>
<td style='text-align: right;'>99 (98.9)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Developing Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>23 (27.1)</td>
<td style='text-align: right;'>90 (86.7)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Proficient Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>2 (3.1)</td>
<td style='text-align: right;'>38 (39.0)</td>
<td style='text-align: right;'>99 (95.7)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Distinguished Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>1 (1.0)</td>
<td style='text-align: right;'>4 (5.1)</td>
<td style='text-align: right;'>62 (56.3)</td>
</tr>
<tr>
<td style='text-align: right;'>Analytic Geometry</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Beginning Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>80 (77.5)</td>
<td style='text-align: right;'>99 (98.7)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Developing Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>25 (28.4)</td>
<td style='text-align: right;'>86 (82.4)</td>
<td style='text-align: right;'>99 (99.0)</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>Proficient Learner</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>2 (3.0)</td>
<td style='text-align: right;'>23 (26.4)</td>
<td style='text-align: right;'>94 (88.2)</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'></td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>Distinguished Learner</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>1 (1.0)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>1 (1.5)</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>27 (26.5)</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 14:** 2019 EOC Median (Mean) Growth Targets by Subject and Current Achievement.\label{}} 
\begin{center}
\begin{tabular}{rcrcrrr}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{3}{c}{\bfseries Growth Target Levels}\tabularnewline
\cline{5-7}
\multicolumn{1}{c}{Target Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Current Achievement Level}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Developing}&\multicolumn{1}{c}{Proficient}&\multicolumn{1}{c}{Distinguished}\tabularnewline
\hline
&&&&&&\tabularnewline
Grade 9 Lit&&Beginning Learner&&62 (60.9)&99 (96.7)&99 (99.0)\tabularnewline
&&Developing Learner&&5 (8.1)&59 (57.2)&99 (98.6)\tabularnewline
&&Proficient Learner&&1 (1.2)&6 (9.9)&85 (79.7)\tabularnewline
&&Distinguished Learner&&1 (1.0)&1 (1.2)&28 (30.5)\tabularnewline
\hline
&&&&&&\tabularnewline
American Lit&&Beginning Learner&&90 (85.4)&99 (98.8)&99 (99.0)\tabularnewline
&&Developing Learner&&26 (31.2)&92 (88.1)&99 (99.0)\tabularnewline
&&Proficient Learner&&2 (3.7)&33 (36.7)&97 (92.3)\tabularnewline
&&Distinguished Learner&&1 (1.0)&3 (3.9)&53 (51.6)\tabularnewline
\hline
&&&&&&\tabularnewline
Algebra I&&Beginning Learner&&80 (78.1)&99 (98.5)&99 (99.0)\tabularnewline
&&Developing Learner&&29 (31.7)&89 (85.6)&99 (99.0)\tabularnewline
&&Proficient Learner&&3 (4.7)&40 (40.7)&98 (94.9)\tabularnewline
&&Distinguished Learner&&1 (1.0)&4 (5.6)&61 (57.8)\tabularnewline
\hline
&&&&&&\tabularnewline
Geometry&&Beginning Learner&&76 (73.3)&99 (97.5)&99 (99.0)\tabularnewline
&&Developing Learner&&19 (23.2)&78 (74.4)&99 (98.8)\tabularnewline
&&Proficient Learner&&2 (2.7)&18 (22.2)&88 (83.0)\tabularnewline
&&Distinguished Learner&&1 (1.0)&1 (1.7)&24 (25.4)\tabularnewline
\hline
&&&&&&\tabularnewline
Coordinate Algebra&&Beginning Learner&&78 (75.8)&99 (98.9)&99 (99.0)\tabularnewline
&&Developing Learner&&23 (27.1)&90 (86.7)&99 (99.0)\tabularnewline
&&Proficient Learner&&2 (3.1)&38 (39.0)&99 (95.7)\tabularnewline
&&Distinguished Learner&&1 (1.0)&4 (5.1)&62 (56.3)\tabularnewline
\hline
&&&&&&\tabularnewline
Analytic Geometry&&Beginning Learner&&80 (77.5)&99 (98.7)&99 (99.0)\tabularnewline
&&Developing Learner&&25 (28.4)&86 (82.4)&99 (99.0)\tabularnewline
&&Proficient Learner&&2 (3.0)&23 (26.4)&94 (88.2)\tabularnewline
&&Distinguished Learner&&1 (1.0)&1 (1.5)&27 (26.5)\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->


<!-- HTML_Start -->

<div class='caption'> <strong>Figure 10:</strong>   English Language Arts EOC 2019 growth target box plots by current achievement level. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Box_Plots-2.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 10:}}   } English Language Arts EOC 2019 growth target box plots by current achievement level.}
  \begin{subfigure}[b]{1\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Box_Plots-2.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->

<!-- HTML_Start -->

<div class='caption'> <strong>Figure 11:</strong>   Mathematics EOC 2019 growth target box plots by current achievement level. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Box_Plots-3.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 11:}}   } Mathematics EOC 2019 growth target box plots by current achievement level.}
  \begin{subfigure}[b]{1\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Box_Plots-3.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->


##  Growth Targets and Current Achievement

Examining the relationship between growth targets and current achievement also provides valuable insight into the targets and what they can tell us about expectations for student growth and proficiency attainment on the next assessment.  Correlation tables and scatter plots are provided in the subsequent sections to describe the relationship between Georgia's growth targets and 2019 scale scores.  The correlation tables show negative relationships across the board, suggesting that lower achieving students have higher growth targets and vice versa.  This relationship is as expected - the further below an achievement level a student starts, the higher their target will be.

Scatter plots show that this relationship is not as linear as the Pearson correlation describes due to the ceiling and floor of the growth targets at the lower and higher end of the current scale scores distributions.  The scatter plots also help to show how the targets for the same current scores change relative to the three performance level target cuts.  The points in each scatter plot are color coded by current achievement level and contour lines are provided to show the target distribution density more clearly.



### End of Grade Content Areas


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='8' style='text-align: left;'>
**Table 15:** EOG Student Level Correlations between 2019 Growth Target and Current Scale Score.</td></tr>
<tr>
<th colspan='2' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='3' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Growth Target Levels</th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Target Content Area</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Target Grade</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Developing</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Proficient</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Distinguished</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>N</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>ELA</td>
<td style='text-align: right;'>4</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.87</td>
<td style='text-align: right;'>-0.94</td>
<td style='text-align: right;'>-0.84</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>129,217</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>5</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.85</td>
<td style='text-align: right;'>-0.90</td>
<td style='text-align: right;'>-0.75</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>133,538</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>6</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.85</td>
<td style='text-align: right;'>-0.91</td>
<td style='text-align: right;'>-0.75</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>136,497</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>7</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.85</td>
<td style='text-align: right;'>-0.89</td>
<td style='text-align: right;'>-0.73</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>136,651</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>8</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.79</td>
<td style='text-align: right;'>-0.90</td>
<td style='text-align: right;'>-0.78</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>133,189</td>
</tr>
<tr>
<td style='text-align: right;'>Mathematics</td>
<td style='text-align: right;'>4</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.81</td>
<td style='text-align: right;'>-0.93</td>
<td style='text-align: right;'>-0.82</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>129,142</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>5</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.82</td>
<td style='text-align: right;'>-0.91</td>
<td style='text-align: right;'>-0.82</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>133,477</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>6</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.76</td>
<td style='text-align: right;'>-0.91</td>
<td style='text-align: right;'>-0.82</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>136,445</td>
</tr>
<tr>
<td style='text-align: right;'></td>
<td style='text-align: right;'>7</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.77</td>
<td style='text-align: right;'>-0.90</td>
<td style='text-align: right;'>-0.83</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>136,602</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'></td>
<td style='border-bottom: 2px solid grey; text-align: right;'>8</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.76</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.91</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.85</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>132,728</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 15:** EOG Student Level Correlations between 2019 Growth Target and Current Scale Score.\label{my}} 
\begin{center}
\begin{tabular}{rrcrrrcr}
\hline\hline
\multicolumn{2}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{3}{c}{\bfseries Growth Target Levels}&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }\tabularnewline
\cline{4-6}
\multicolumn{1}{c}{Target Content Area}&\multicolumn{1}{c}{Target Grade}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Developing}&\multicolumn{1}{c}{Proficient}&\multicolumn{1}{c}{Distinguished}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{N}\tabularnewline
\hline
&&&&&&&\tabularnewline
ELA&4&&-0.87&-0.94&-0.84&&129,217\tabularnewline
&5&&-0.85&-0.90&-0.75&&133,538\tabularnewline
&6&&-0.85&-0.91&-0.75&&136,497\tabularnewline
&7&&-0.85&-0.89&-0.73&&136,651\tabularnewline
&8&&-0.79&-0.90&-0.78&&133,189\tabularnewline
\hline
&&&&&&&\tabularnewline
Mathematics&4&&-0.81&-0.93&-0.82&&129,142\tabularnewline
&5&&-0.82&-0.91&-0.82&&133,477\tabularnewline
&6&&-0.76&-0.91&-0.82&&136,445\tabularnewline
&7&&-0.77&-0.90&-0.83&&136,602\tabularnewline
&8&&-0.76&-0.91&-0.85&&132,728\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->






<!-- HTML_Start -->

<div class='caption'> <strong>Figure 12:</strong>   ELA 2019 growth targets by current scale score. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Scatter_Plot1-1.png' style='width: 640px;'/>
</div>
</div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 12:}}   } ELA 2019 growth targets by current scale score.}
  \begin{subfigure}[b]{0.95\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Scatter_Plot1-1.png}
  \end{subfigure}
\end{figure}

LaTeX_End -->

<!-- HTML_Start -->

<div class='caption'> <strong>Figure 13:</strong>   Mathematics 2019 growth targets by current scale score. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Scatter_Plot2-1.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 13:}}   } Mathematics 2019 growth targets by current scale score.}
  \begin{subfigure}[b]{0.95\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Scatter_Plot2-1.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->

###   End of Course Test Subjects


<!-- HTML_Start -->
<table class='gmisc_table breakboth' style='border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;' >
<thead>
<tr><td colspan='8' style='text-align: left;'>
**Table 16:** EOC Student Level Correlations between 2019 Growth Target and Current Scale Score.</td></tr>
<tr>
<th colspan='2' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='3' style='font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;'>Growth Target Levels</th><th style='border-top: 2px solid grey;; border-bottom: hidden;'>&nbsp;</th>
<th colspan='1' style='font-weight: 900; border-top: 2px solid grey; text-align: center;'></th>
</tr>
<tr>
<th style='border-bottom: 1px solid grey; text-align: center;'>Content Area</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Target Content Area</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Developing</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Proficient</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>Distinguished</th>
<th style='border-bottom: 1px solid grey;' colspan='1'>&nbsp;</th>
<th style='border-bottom: 1px solid grey; text-align: center;'>N</th>
</tr>
</thead>
<tbody>
<tr>
<td style='text-align: right;'>ELA</td>
<td style='text-align: right;'>Grade 9 Lit</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.78</td>
<td style='text-align: right;'>-0.90</td>
<td style='text-align: right;'>-0.78</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>124,638</td>
</tr>
<tr>
<td style='text-align: right;'>Grade 9 Lit</td>
<td style='text-align: right;'>American Lit</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.83</td>
<td style='text-align: right;'>-0.89</td>
<td style='text-align: right;'>-0.73</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>137,035</td>
</tr>
<tr>
<td style='text-align: right;'>Mathematics</td>
<td style='text-align: right;'>Algebra I</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.89</td>
<td style='text-align: right;'>-0.91</td>
<td style='text-align: right;'>-0.67</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>103,282</td>
</tr>
<tr>
<td style='text-align: right;'>Algebra I</td>
<td style='text-align: right;'>Geometry</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.82</td>
<td style='text-align: right;'>-0.90</td>
<td style='text-align: right;'>-0.83</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>122,133</td>
</tr>
<tr>
<td style='text-align: right;'>Mathematics</td>
<td style='text-align: right;'>Coordinate Algebra</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>-0.87</td>
<td style='text-align: right;'>-0.90</td>
<td style='text-align: right;'>-0.64</td>
<td style='' colspan='1'>&nbsp;</td>
<td style='text-align: right;'>103,282</td>
</tr>
<tr>
<td style='border-bottom: 2px solid grey; text-align: right;'>Coordinate Algebra</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>Analytic Geometry</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.85</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.91</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>-0.77</td>
<td style='border-bottom: 2px solid grey;' colspan='1'>&nbsp;</td>
<td style='border-bottom: 2px solid grey; text-align: right;'>20,465</td>
</tr>
</tbody>
</table>
<!-- LaTeX_Start
%latex.default(my_tbl, file = "", where = where, col.just = tex.align,     caption = tmp_caption, ...)%
\begin{table}[H]
\caption{**Table 16:** EOC Student Level Correlations between 2019 Growth Target and Current Scale Score.\label{my}} 
\begin{center}
\begin{tabular}{rrcrrrcr}
\hline\hline
\multicolumn{2}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{3}{c}{\bfseries Growth Target Levels}&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }\tabularnewline
\cline{4-6}
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Target Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Developing}&\multicolumn{1}{c}{Proficient}&\multicolumn{1}{c}{Distinguished}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{N}\tabularnewline
\hline
ELA&Grade 9 Lit&&-0.78&-0.90&-0.78&&124,638\tabularnewline
Grade 9 Lit&American Lit&&-0.83&-0.89&-0.73&&137,035\tabularnewline
Mathematics&Algebra I&&-0.89&-0.91&-0.67&&103,282\tabularnewline
Algebra I&Geometry&&-0.82&-0.90&-0.83&&122,133\tabularnewline
Mathematics&Coordinate Algebra&&-0.87&-0.90&-0.64&&103,282\tabularnewline
Coordinate Algebra&Analytic Geometry&&-0.85&-0.91&-0.77&&20,465\tabularnewline
\hline
\end{tabular}\end{center}
\end{table}

LaTeX_End -->


<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


<!-- HTML_Start -->

<div class='caption'> <strong>Figure 14:</strong>   Grade 9 Lit 2019 growth targets by current scale score. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Scatter_Plot1-2.png' style='width: 640px;'/>
</div>
</div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 14:}}   } Grade 9 Lit 2019 growth targets by current scale score.}
  \begin{subfigure}[b]{0.95\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Scatter_Plot1-2.png}
  \end{subfigure}
\end{figure}

LaTeX_End -->

<!-- HTML_Start -->

<div class='caption'> <strong>Figure 15:</strong>   American Lit 2019 growth targets by current scale score. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Scatter_Plot2-2.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 15:}}   } American Lit 2019 growth targets by current scale score.}
  \begin{subfigure}[b]{0.95\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Scatter_Plot2-2.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->

<!-- HTML_Start -->

<div class='caption'> <strong>Figure 16:</strong>   2019 Algebra I growth targets by current scale score. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Scatter_Plot1-3.png' style='width: 640px;'/>
</div>
</div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 16:}}   } 2019 Algebra I growth targets by current scale score.}
  \begin{subfigure}[b]{0.95\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Scatter_Plot1-3.png}
  \end{subfigure}
\end{figure}

LaTeX_End -->

<!-- HTML_Start -->

<div class='caption'> <strong>Figure 17:</strong>   2019 Geometry growth targets by current scale score. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Scatter_Plot2-3.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 17:}}   } 2019 Geometry growth targets by current scale score.}
  \begin{subfigure}[b]{0.95\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Scatter_Plot2-3.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->

<!-- HTML_Start -->

<div class='caption'> <strong>Figure 18:</strong>   Coordinate Algebra 2019 growth targets by current scale score. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Scatter_Plot1-4.png' style='width: 640px;'/>
</div>
</div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 18:}}   } Coordinate Algebra 2019 growth targets by current scale score.}
  \begin{subfigure}[b]{0.95\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Scatter_Plot1-4.png}
  \end{subfigure}
\end{figure}

LaTeX_End -->

<!-- HTML_Start -->

<div class='caption'> <strong>Figure 19:</strong>   Analytic Geometry 2019 growth targets by current scale score. </div>
<div class='content-node image'>
<div class='image-content'>
<img src='../img/Tech_Reports/2019/Scatter_Plot2-4.png' style='width: 640px;'/>
</div>
</div>
<div class='breakboth' ></div>

<!-- LaTeX_Start
\begin{figure}[H]
\caption*{{{\bf{Figure 19:}}   } Analytic Geometry 2019 growth targets by current scale score.}
  \begin{subfigure}[b]{0.95\textwidth}
    \includegraphics[width=\textwidth]{../img/Tech_Reports/2019/Scatter_Plot2-4.png}
  \end{subfigure}
\end{figure}

\pagebreak

LaTeX_End -->


<!-- HTML_Start -->
<div class='breakboth' ></div>
<!-- LaTeX_Start
\pagebreak
LaTeX_End -->


# References
