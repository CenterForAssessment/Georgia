---
title: "The Georgia Student Growth Model"
subtitle: "A Technical Overview of the 2012-2013 Student Growth Percentile Calculations"
author:
  - name: Damian W. Betebenner
  - name: Adam R. VanIwaarden
  - name: \emph{National Center for the Improvement \ of Educational Assessment (NCIEA)}
date: April 2015
abstract: "DRAFT REPORT - DO NOT CITE! \ This report provides details about the Georgia Student Growth Model methodology and presents a descriptive analysis of the 2013 SGP calculation process and results."
---
<!--SGPreport-->

<!-- 
This document was written by Damian Betebenner & Adam VanIwaarden for the State of Georgia Department of Education (DOE).

	Original Draft:  August 12, 2014
	Second Draft:  November 14, 2014
	...
-->

<!-- load some R packages and functions required for HTML table creation silently.  Load SGP and other packages here to avoid messages. -->



# Introduction

This report contains details on the implementation of the student growth percentiles (SGP) model for the state of Georgia. The National Center for the Improvement of Educational Assessment (NCIEA) contracted with the Georgia Department of Education (DOE) to implement the SGP methodology using data derived from the Georgia Student Assessment Program to create the Georgia Student Growth Model. The goal of the engagement with DOE is to create a set of open source analytics techniques and conduct a set of initial analyses that will eventually be conducted by DOE in following years.

The SGP methodology is an open source norm- and criterion-referenced student growth analysis that produces student growth percentiles and student growth projections/targets for each student with longitudinal data in the state. The methodology is currently used for many purposes. States and districts have used the results in various ways including parent/student diagnostic reporting, institutional improvement, and school and educator accountability. Specifics about the manner in which growth is included in school and educator accountability can be found in documents related to those accountability systems. 

The report includes three sections covering Data, SGP Results, and Goodness of Fit:

- *Data* includes details on the decision rules used in the raw data preparation and student record validation.
- *SGP Results* provides basic descriptive statistics from the 2013 analyses.
- *Goodness of Fit* describes how well the statistical models used to produce SGPs fit Georgia students' data.  This includes discussion of goodness of fit plots and the student- and school-level correlations between SGP and prior achievement.

Additionally, multiple appendices are included.  *Appendix A* includes Goodness of Fit plots for all content areas and grades.  *Appendix B* provides a technical description of the SIMEX correction for measurement error with specific applications to Georgia.

# Data

Data for the Georgia Criterion-Referenced Competency Tests (CRCT) and End of Course Tests (EOCT) used in the SGP analyses were supplied by the Georgia DOE to the NCIEA for analysis in the fall of 2013. The current longitudinal data set includes academic years 2006-2007 through 2012-2013. Subsequent years' analyses will augment this multi-year data set allowing DOE to maintain a comprehensive longitudinal data set for all students taking the CRCT and EOCT assessments and transitioning to the Georgia Milestones assessments.

Student Growth Percentiles have been produced for students that have a current score and at least one prior score in the same subject or a related content area.  SGPs were produced for grade-level (CRCT) Reading, English Language Arts (ELA), Social Studies, Science and Mathematics.  For the 2013 academic year SGPs were produced for EOCT courses including Grade 9 Literature, American Literature,  U.S. History, Economics, Biology, Physical Science, Mathematics I & II, Coordinate Algebra and GPS Geometry.

## Longitudinal Data
Growth analyses on assessment data require data which are linked to individual students over time.  Student growth percentile analyses require, at a minimum two, and preferably three years of assessment data for analysis of student progress. To this end it is necessary that a unique student identifier be available so that student data records across years can be merged with one another and subsequently examined. Because some records in the assessment data set contain students with more than one test score in a content area in a given year, a process to create unique student records in each content area by year combination was required in order to carry out subsequent growth analyses.  Furthermore, student records may be invalidated for other reasons. The following business rules were used to either invalidate particular student records or select the appropriate record for use in the analyses.

### General business rules

1. Student records are invalidated if the student identifier is not exactly 10 digits long.
2. Student records with missing ("NA") scores or scale scores outside of the possible range (usually 0) are invalidated.
3. Duplicate records that originated from the "unmatched" data files are invalidated.^[Both "Matched" (where student to school/district links have been verified) and "Unmatched" data files are available.  Unmatched data is added to the initial data file in hopes that it will possibly fill holes in students' score histories, but any current year SGPs produced will not be linked to any school, district or teacher.]
4. If a student has a main and a retest score,^[Retests were available in 2011-12 but retest data are no longer used in SGP calculations as of the 2012-13 school year.] the record with the lower score is invalidated.
5. Student records with any administrative invalidation flag (for example, identifying test irregularities, students that did not attempt the test, or other issues) are invalidated.
6. School years for which CRCT tests were aligned to QCC curriculum are invalidated (SGPs not produced in previous years and not used as prior scores subsequently).

### CRCT specific business rules

1. If a student has multiple records (duplicate from the same subject, grade and administration period), their highest score was selected.
2. Student records from schools identified by the Governor’s Office of Student Achievement (GOSA) as having artificially inflated student test scores from the 2008-2010 are invalidated.
3. If a student took more than one assessment in the same subject and school year, but was identified as being in two different grades, their highest score was selected.
Table 1 shows the number of valid CRCT student records available for analysis after applying the general and CRCT specific business rules.^[This number does not represent the number of SGPs produced, however, because students are required to have at least one prior score available as well.]



\begin{table}[H]
\caption*{\textbf{Table 1:} Number of Valid CRCT Student Records by Grade and Subject for 2013\label{}} 
\begin{center}
\begin{tabular}{lcllllll}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{6}{c}{\bfseries Grades}\tabularnewline
\cline{1-8}
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{3}&\multicolumn{1}{c}{4}&\multicolumn{1}{c}{5}&\multicolumn{1}{c}{6}&\multicolumn{1}{c}{7}&\multicolumn{1}{c}{8}\tabularnewline
\hline
Reading&&124,819&123,480&123,888&125,475&125,565&123,245\tabularnewline
ELA&&125,078&123,418&123,711&125,360&125,280&123,181\tabularnewline
Social Studies&&127,490&126,143&127,488&128,319&127,839&125,605\tabularnewline
Science&&127,909&126,549&127,879&128,680&128,201&126,028\tabularnewline
Mathematics&&125,485&123,160&122,880&124,754&124,450&122,413\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}



### EOCT specific business rules

1. If a student has multiple records (duplicate from the same subject and administration period), their highest score was selected.
2. For students who participate in two main administrations (i.e., students who failed and retook an EOCT course), the first attempt is used as a prior to produce an SGP for the final attempt. In subsequent years, their final attempt may be used as a prior for other EOCT analyses.

Table 2 shows the total number of valid EOCT student records available for analysis after applying the general and EOCT specific business rules.



\begin{table}[H]
\caption*{\textbf{Table 2:} Total Number of Valid EOCT Student Records by Subject for 2013\label{}} 
\begin{center}
\begin{tabular}{ll}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Valid Records}\tabularnewline
\hline
Grade 9 Lit&131,982\tabularnewline
American Lit&107,828\tabularnewline
Economics&105,085\tabularnewline
Us History&107,075\tabularnewline
Biology&130,813\tabularnewline
Physical Science&83,704\tabularnewline
Mathematics I&9,674\tabularnewline
Mathematics II&103,467\tabularnewline
Coordinate Algebra&134,062\tabularnewline
Geometry&25,012\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}



# SGP Results
The following sections provide basic descriptive statistics from the 2013 analyses, including the state-level mean and median growth percentiles.  Currently Georgia uses either cohort or baseline referenced SGPs as the official student-level growth metric, depending upon the content area.  The goal is to eventually use only baseline referenced SGPs, however this requires an assessment program to have been established for several years.  Given that EOCT math courses have undergone changes in recent years, only cohort referenced SGPs are currently available for them.  Similarly, the upcoming transition from the CRCT and EOCT to Georgia Milestones will require the exclusive use of cohort referenced analyses for at least two years until baseline referencing is again feasible.  

Georgia DOE has also recently decided to implement the SIMEX measurement error correction method in the calculation of student-level SGPs.  This correction has been applied to both cohort and baseline referenced SGPs and the descriptive statistics from these analyses are also presented here.

The interested reader can find more in depth discussions of the cohort- and baseline-referenced SGP methodology in the [available literature](https://github.com/CenterForAssessment/SGP_Resources/tree/master/articles), particularly Betebenner's seminal work [-@Betebenner:2009; -@Betebenner:2008a]. For further information on the SIMEX measurement error correction methodology see Shang, VanIwaarden and Betebenner ([-@ShangVanIBet:2015]) and *Appendix B* of this report.

## Cohort Referenced Median SGPs
Growth percentiles, being quantities associated with each individual student, can be easily summarized across numerous grouping indicators to provide summary results regarding growth. The median and mean of a collection of growth percentiles are used as measures of central tendency that summarize the distribution as a single number. With perfect data fit, we expect the state median of all student growth percentiles in any grade to be 50 because the data are norm-referenced across all students in the state.   Median (and mean) growth percentiles well below 50 represent growth less than the state "average" and median growth percentiles well above 50 represent growth in excess of the state "average".

To demonstrate the norm-referenced nature of the growth percentiles viewed at the state level, Table 3 presents the cohort referenced growth percentile medians and means for the EOCT mathematics based content areas. 



\begin{table}[H]
\caption*{\textbf{Table 3:} EOCT Median and Mean \emph{Cohort} Referenced Student Growth Percentile by Content Area for 2013\label{}} 
\begin{center}
\begin{tabular}{lll}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}\tabularnewline
\hline
Mathematics I&49&49.2\tabularnewline
Mathematics II&49&49.5\tabularnewline
Coordinate Algebra&50&49.8\tabularnewline
Geometry&50&50.1\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}



Based upon perfect model fit to the data, the median of all state growth percentiles in each grade by year by subject combination should be 50. That is, in the conditional distributions, 50 percent of growth percentiles should be less than 50 and 50 percent should be greater than 50. Deviations from 50 indicate imperfect model fit to the data. Imperfect model fit can occur for a number of reasons, some due to issues with the data (e.g., floor and ceiling effects leading to a "bunching" up of the data) as well as issues due to the way that the SGP function fits the data. The results in Table 3 are close to perfect, with almost all values equal to 50.

The results are coarse in that they are aggregated across tens of thousands of students. More refined fit analyses are presented in the Goodness-of-Fit section that follows. Depending upon feedback from Georgia DOE, it may be desirable to tweak with some operational parameters and attempt to improve fit even further. The impact upon the operational results based on better fit is expected to be extremely minor.

It is important to note how, at the entire state level, the *norm-referenced* growth information returns little information on annual trends due to its norm-reference nature. What the results indicate is that a typical (or average) student in the state demonstrates 50th percentile growth. That is, "typical students" demonstrate "typical growth". One benefit of the norm-referenced results follows when subgroups are examined (e.g., schools, district, demographic groups, etc.) Examining subgroups in terms of the median of their student growth percentiles, it is then possible to investigate why some subgroups display lower/higher student growth than others. Moreover, because the subgroup summary statistic (i.e., the median) is composed of many individual student growth percentiles, one can break out the result and further examine the distribution of individual results. 

## Baseline Referenced Median SGPs
Baseline SGPs allow one to look at norm-referenced growth through another lens.  Rather than considering a single year's cohort, baseline SGPs are referenced against a "super-cohort" of several years of "baseline" students linked by common course/grade progressions.  This allows for the examination of whether or not the system as a whole might be improving (or declining) in terms of growth over time relative to the established baseline.  That is, if the system is improving in terms of higher rates of growth over time (i.e., higher levels of effectiveness), we would see those higher levels of effectiveness in the form of median SGPs that are greater than 50 (what *was* a higher rate of growth in the past is now typical growth).  An assumption required for the use of baseline referenced SGPs is that the scale scores are well anchored.  If this assumption is violated, then any deviation from "typical" growth may be purely an artifact of the test scaling procedure. States transitioning from old test to new tests, for example, must reset their baseline growth because a new scale is in effect. Table 4 provides the median and mean baseline referenced results from Georgia's CRCT assessments and Table 5 provides the EOCT results.



\begin{table}[H]
\caption*{\textbf{Table 4:} CRCT Median (Mean) \emph{Baseline} Student Growth Percentile by Grade and Content Area for 2013\label{}} 
\begin{center}
\begin{tabular}{lclllll}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{5}{c}{\bfseries Grades}\tabularnewline
\cline{1-7}
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{4}&\multicolumn{1}{c}{5}&\multicolumn{1}{c}{6}&\multicolumn{1}{c}{7}&\multicolumn{1}{c}{8}\tabularnewline
\hline
Reading&&59 (56)&47 (47.4)&61 (57.5)&58 (54.9)&53 (51.7)\tabularnewline
ELA&&47 (48.3)&44 (46)&45 (46.3)&58 (55.4)&42 (43.6)\tabularnewline
Social Studies&&51 (50.2)&50 (49.9)&50 (49.9)&51 (50.3)&48 (48.6)\tabularnewline
Science&&53 (52.5)&49 (48.7)&49 (49.7)&57 (54.5)&51 (50.3)\tabularnewline
Mathematics&&51 (50.8)&50 (49.6)&58 (55.7)&44 (45.4)&50 (49.3)\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}





\begin{table}[H]
\caption*{\textbf{Table 5:} EOCT Median and Mean \emph{Baseline} Referenced Student Growth Percentile by Content Area for 2013\label{}} 
\begin{center}
\begin{tabular}{lll}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}\tabularnewline
\hline
Grade 9 Lit&50&49.9\tabularnewline
American Lit&41&43.7\tabularnewline
Economics&54&52.4\tabularnewline
Us History&47&48.3\tabularnewline
Biology&50&49.7\tabularnewline
Physical Science&51&50.8\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}



## SIMEX Adjusted Student Growth Percentiles
The use of error-prone standardized test scores in statistical models can lead to numerous problems.  Understanding the effects of measurement error and correcting it is particularly difficult in the SGP model given that it is based on non-parametric quantile regression.  Preliminary investigations suggest that the use of error-prone measures may lead SGP estimates to be inflated for students with high prior achievement and underestimated for students with lower prior achievement.  This bias at the individual student-level can translate to bias in aggregate measures (such as median and mean SGPs) when student sorting based on prior achievement exists at the level of aggregation (e.g. classrooms or schools).  As a result, growth and prior achievement are (positively) correlated, giving schools and teachers with higher achieving students an undue advantage and disadvantaging those with a preponderance of low achieving students.  

Simulation-extrapolation (SIMEX) methods of correcting for measurement error induced bias in the SGP estimation has been proposed and recently tested in Georgia.  Descriptive statistics from these analyses are provided here and in the *Goodness-of-Fit* section.  Additional technical information about the SIMEX procedure in general and its use in the calculation of cohort and baseline referenced SGPs is provided in *Appendix B* of this report.



\begin{table}[H]
\caption*{\textbf{Table 6:} SIMEX Corrected EOCT Median and Mean \emph{Cohort} Referenced Student Growth Percentile by Content Area for 2013\label{}} 
\begin{center}
\begin{tabular}{lll}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}\tabularnewline
\hline
Mathematics I&49&49.4\tabularnewline
Mathematics II&50&49.9\tabularnewline
Coordinate Algebra&50&50.1\tabularnewline
Geometry&51&50.3\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}






\begin{table}[H]
\caption*{\textbf{Table 7:} SIMEX Corrected CRCT Median (Mean) \emph{Baseline} Student Growth Percentile by Grade and Content Area for 2013\label{}} 
\begin{center}
\begin{tabular}{lclllll}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{5}{c}{\bfseries Grades}\tabularnewline
\cline{1-7}
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{4}&\multicolumn{1}{c}{5}&\multicolumn{1}{c}{6}&\multicolumn{1}{c}{7}&\multicolumn{1}{c}{8}\tabularnewline
\hline
Reading&&59 (55.2)&45 (46.6)&60 (57.1)&58 (54.5)&53 (51.4)\tabularnewline
ELA&&48 (48)&43 (45.5)&45 (46.1)&59 (55.7)&41 (43.2)\tabularnewline
Social Studies&&51 (50.2)&50 (50.1)&50 (50.3)&51 (50.3)&48 (48.7)\tabularnewline
Science&&53 (52.2)&48 (48.4)&49 (49.6)&57 (54.6)&50 (50)\tabularnewline
Mathematics&&52 (50.4)&50 (49.5)&59 (55.9)&43 (45.2)&49 (49)\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}





\begin{table}[H]
\caption*{\textbf{Table 8:} SIMEX Corrected EOCT Median and Mean \emph{Baseline} Referenced Student Growth Percentile by Content Area\label{}} 
\begin{center}
\begin{tabular}{lll}
\hline\hline
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}\tabularnewline
\hline
Grade 9 Lit&49&49.4\tabularnewline
American Lit&40&43.0\tabularnewline
Economics&54&52.2\tabularnewline
Us History&47&48.0\tabularnewline
Biology&50&49.5\tabularnewline
Physical Science&51&50.5\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}



A comparison of the unadjusted (Tables 3 to 5) and SIMEX corrected (Tables 6 through 8) shows very little difference in the medians and means.  This is not surprising as the majority of the growth percentiles for students in the middle of the prior score distributions change very little, and the larger changes that occur for students in the extremes of the prior score distributions tend to even out. 

# Goodness of Fit
Examination of goodness-of-fit was conducted by comparing the estimated conditional density with the theoretical uniform density of the SGPs. Despite the use of B-splines to accommodate heteroscedasticity and skewness of the conditional density, assumptions are made concerning the number and position of spline knots that impact the percentile curves that are fit. With an infinite population of test takers, at each prior scaled score, with perfect model fit, the expectation is to have 10 percent of the estimated growth percentiles between 1 and 9, 10 and 19, 20 and 29, ..., and 90 and 99. Deviations from 10 percent would be indicative of lack of model fit. 

## Model Fit Plots
Using all available CRCT and EOCT scores as the variables, estimation of student growth percentiles was conducted for each possible student (those with a current score and at least one prior score). Percentages of student growth percentiles between the 10th, 20th, 30th, 40th, 50th, 60th, 70th, 80th, and 90th percentiles were calculated based upon the decile of the prior year's scaled score (the total students in each for the analyses varies depending on grade and subject). Results for the B-spline parameterizations for all CRCT and EOCT analyses are given in *Appendix A*. 

###  Cohort referenced model fit
The results in all subjects are excellent with a few exceptions. Deviations from perfect fit are indicated by red and blue shading.  The further *above* 10 the darker the red, and the further *below* 10 the darker the blue. In instances where large deviations from 10 occur, the likely cause is that there is a mass point associated with certain scale scores that makes it impossible to "split" the score at a dividing point forcing a majority of the scores into an adjacent cell. This is the case with all large deviations observed in the Georgia data. 

Figure 1 shows the results for 8$^{th}$ grade ELA.  Although this CRCT subject is officially a baseline referenced subject, we provide the plot here as an exemplar of cohort referenced model fit with which to compare with baseline and SIMEX model fit using the same student data in subsequent sections.


![Goodness of Fit Plot for 2013 ***Cohort*** Referenced 8$^{th}$ Grade ELA.](../img/Examples/Goodness_of_Fit/ELA.2013/gofSGP_Grade_8.png)


###  Baseline referenced model fit

Assumptions regarding model fit are much different for baseline referenced models.  Perfect model fit is not expected, or even desired, in these analyses because the student data was not used to produce the baseline model parameter estimates.  As discussed above, these models may allow us to see whether or not the system as a whole might be improving (or declining) over time.  These changes would be indicated by model **misfit** in the goodness of fit plots.  A greater number of students with high growth (red cells on the right hand side of the first plots) would suggest system improvement.  Ideally we would see this for students in the entire range prior achievement.

Figure 2 shows how the baseline model fits the 2013 8$^{th}$ grade ELA student data.  Here we see that the model suggests student performance has declined relative to the established baseline.  This appears to be generally true for students from all prior achievement levels with the exception of students in the lowest decile of prior scores.

<p></p>


![Goodness of Fit Plot for 2013 ***Baseline*** Referenced 8$^{th}$ Grade ELA.](../img/Examples/Goodness_of_Fit/ELA.2013.BASELINE/gofSGP_Grade_8.png)


###  SIMEX model fit
SIMEX model fit is also assumed to be imperfect.  In this case we expect model misfit in the form of increased high SGPs for students with lower prior performance (and a complementary decrease in low SGPs for those students), and the reverse expectation for high achieving students.  This is visible in the goodness of fit plot in Figure 3 where the SIMEX correction method has been applied to the 8$^{th}$ grade ELA baseline model.

<p></p>


![Goodness of Fit Plot for 2013 ***SIMEX Corrected,*** Baseline Referenced 8$^{th}$ Grade ELA.](../img/Examples/Goodness_of_Fit/ELA.2013.BASELINE.SIMEX/gofSGP_Grade_8.png)


## Student Level Results
To investigate the possibility that individual level misfit might impact summary level results, student growth percentile analyses were run on all students and the results were examined relative to prior achievement. With perfect fit to data, the correlation between students' most recent prior achievement scores and their student growth percentiles is zero (i.e., the goodness of fit tables would have a uniform distribution of percentiles across all previous scale score levels). To investigate in another way, correlations between prior student scale scores and student growth percentiles were calculated.^[In addition to providing information about model fit, these student-level correlations can assess potential impact of test ceiling effects.] 

Student-level correlations between the various SGP versions (uncorrected and SIMEX corrected cohort and baseline referenced estimates) and prior achievement are presented here. The results are generally as expected.  With cohort referenced percentiles, when the model is perfectly fit to the data, the correlation between students' most recent prior achievement scores and their student growth percentiles is zero (i.e., there is a uniform distribution of percentiles across all previous scale score levels).  Correlations for Georgia cohort referenced SGPs are all essentially zero.  This provides assurance that the models have fit the data well, and indicate that students can demonstrate high (or low) growth regardless of prior achievement using cohort referenced SGPs.

Baseline referenced growth percentiles relax assumptions about correlations and the aspiration for a uniform distribution of percentiles.  Rather than considering a single year's cohort, baseline SGPs are referenced against a "super-cohort" of several years of students linked by common course/grade progressions.  This allows us to examine whether or not the system as a whole might be improving (or declining) over time relative to the established baseline.  That is, if the system is improving over time, we would see that improvement in median SGPs that are greater than 50 (more than half of students would have growth greater than what *was* typical growth in the past).  Furthermore, if students at different levels of prior achievement experience differential growth a correlation greater or less than zero may be observed.^[A major assumption required in producing baseline referenced SGPs is that the scale scores are well anchored.  If this assumption does not hold, then any deviation from "typical" growth may be purely and artifact of the test scaling procedure.  However, it would seem that this type of "scale drift" would be consistent across scale score levels.  Therefore it isn't clear that this would cause a differential impact on growth, and thereby a positive or negative correlation at the student level between growth and prior achievement.]  For example, if lower achieving students had consistently higher growth relative to the baseline cohort and higher achieving students had consistently lower growth, then a negative correlation would be expected at the student-level.  Although small, many correlations between baseline SGPs and prior achievement deviate from zero.

SIMEX corrected SGPs induce a negative correlation between growth and prior achievement (regardless of reference type) as shown in Table 1 below.  Rather than a uniform distribution, SIMEX produces a distribution in which growth for lower prior achieving students' growth is weighted upward and higher prior achieving students' growth is weighted down.  In theory this produces biased student-level SGPs but may decrease the bias in aggregate growth measures as has been documented previous SIMEX reports. This in turn decreases the observed correlations between "uncorrected" SGPs and prior achievement.^[Note that aggregate-level correlations that are initially negative also become increasingly negative rather than return to zero.  This has been noted in test results from other states not presented here.]


<p></p>

### CRCT


\begin{table}[H]
\caption*{\textbf{Table 9:} CRCT Correlations between Student-Level Prior Standardized Scale Score and SGP Versions\label{}} 
\begin{center}
\begin{tabular}{lclllcl}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{3}{c}{\bfseries Aggregate Group Type}&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }\tabularnewline
\cline{1-7}
\multicolumn{1}{c}{Grade}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Cohort SGP}&\multicolumn{1}{c}{Baseline SGP}&\multicolumn{1}{c}{Baseline SIMEX}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{N Size}\tabularnewline
\hline
&&&&&&\tabularnewline
4&&-0.05& 0.04&-0.11&&115,399\tabularnewline
5&&-0.01& 0.01&-0.10&&116,182\tabularnewline
6&& 0.00&-0.01&-0.11&&116,857\tabularnewline
7&& 0.00&-0.05&-0.15&&117,258\tabularnewline
8&& 0.00& 0.12& 0.05&&115,103\tabularnewline
\hline
&&&&&&\tabularnewline
4&&-0.02&-0.03&-0.14&&115,285\tabularnewline
5&&-0.01&-0.06&-0.14&&115,863\tabularnewline
6&& 0.00& 0.07&-0.01&&116,653\tabularnewline
7&& 0.00& 0.03&-0.06&&116,943\tabularnewline
8&& 0.00&-0.08&-0.18&&114,886\tabularnewline
\hline
&&&&&&\tabularnewline
4&&-0.02&-0.03&-0.14&&115,113\tabularnewline
5&& 0.00& 0.03&-0.04&&114,928\tabularnewline
6&& 0.00& 0.04&-0.03&&115,807\tabularnewline
7&& 0.01&-0.06&-0.14&&115,823\tabularnewline
8&& 0.01& 0.11& 0.04&&113,934\tabularnewline
\hline
&&&&&&\tabularnewline
4&&-0.01&-0.09&-0.21&&118,829\tabularnewline
5&& 0.00&-0.02&-0.10&&120,116\tabularnewline
6&& 0.00& 0.01&-0.08&&120,662\tabularnewline
7&& 0.00& 0.00&-0.08&&120,199\tabularnewline
8&& 0.00&-0.08&-0.14&&117,850\tabularnewline
\hline
&&&&&&\tabularnewline
4&&-0.01&-0.07&-0.17&&118,437\tabularnewline
5&& 0.00&-0.05&-0.12&&119,751\tabularnewline
6&& 0.00&-0.02&-0.08&&120,280\tabularnewline
7&& 0.00&-0.05&-0.12&&119,783\tabularnewline
8&& 0.00& 0.02&-0.05&&117,403\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}


<p></p>

### EOCT Baseline Referenced Subjects


\begin{table}[H]
\caption*{\textbf{Table 10:} Correlations between Student-Level Prior Standardized Scale Score and EOCT Baseline Referenced SGP Versions\label{}} 
\begin{center}
\begin{tabular}{lclllcl}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{3}{c}{\bfseries Aggregate Group Type}&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }\tabularnewline
\cline{1-7}
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Cohort SGP}&\multicolumn{1}{c}{Baseline SGP}&\multicolumn{1}{c}{Baseline SIMEX}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{N Size}\tabularnewline
\hline
Grade 9 Lit&& 0.00&-0.06&-0.14&&116,218\tabularnewline
American Lit&& 0.00&-0.13&-0.21&&98,319\tabularnewline
US History&&-0.01&-0.02&-0.10&&92,285\tabularnewline
Economics&& 0.00& 0.04&-0.02&&93,673\tabularnewline
Biology&& 0.00& 0.02&-0.06&&119,015\tabularnewline
Physical Science&& 0.00&-0.02&-0.09&&77,540\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}


<p></p>

### EOCT Cohort Referenced Subjects


\begin{table}[H]
\caption*{\textbf{Table 11:} Correlations between Student-Level Prior Standardized Scale Score and EOCT Cohort Referenced SGP Versions\label{}} 
\begin{center}
\begin{tabular}{lcllcl}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{2}{c}{\bfseries Aggregate Group Type}&\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }\tabularnewline
\cline{1-6}
\multicolumn{1}{c}{Content Area}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Cohort SGP}&\multicolumn{1}{c}{Cohort SIMEX}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{N Size}\tabularnewline
\hline
Coordinate Algebra&&0.00&-0.07&&121,024\tabularnewline
Geometry&&0.03&-0.06&&20,261\tabularnewline
Mathematics I&&0.01&-0.08&&6,005\tabularnewline
Mathematics II&&0.01&-0.08&&96,817\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}



## Group Level Results
Unlike when reporting SGPs at the individual level, when aggregating to the group level (e.g., school) the correlation between aggregate prior student achievement and aggregate growth is rarely zero. The correlation between prior student achievement and growth at the school level is a compelling descriptive statistic because it indicates whether students attending schools serving higher achieving students grow faster (on average) than those students attending schools serving lower achieving students. Results from previous state analyses show a correlation between prior achievement of students associated with a current school (quantified as percent at/above proficient) and the median SGP to be between 0.1 and 0.3. That is, these results indicate that on average, students attending schools serving lower achieving students tend to demonstrate less exemplary growth than those attending schools serving higher achieving students. Equivalently, based upon ordinary least squares (OLS) regression assumptions, the prior achievement level of students attending a school accounts for between 1 and 10 percent of the variability observed in student growth. There are no definitive numbers on what this correlation should be, but studies on value-added models show similar results [@MccaLock:2008].

### School Level Results

To illustrate these relationships visually, the bubble charts in Figures 4 through 8 depict growth as quantified by the median SGP of students at the school against achievement/status, quantified by percentage of student at/above proficient (advanced) at the school. The charts have been successful in helping to motivate the discussion of the two qualities: student achievement and student growth. Though the figures are not detailed enough to indicate strength of relationship between growth and achievement, they are suggestive and valuable for discussions with stakeholders who are being introduced to the growth model for the first time.


![School-level Bubble Plots for Georgia:  ELA, 2012-2013.](../img/Bubble_Plots/2013/Georgia_2013_ELA_State_Bubble_Plot_(Prior_Achievement).png)

<p></p>
<p></p>


![School-level Bubble Plots for Georgia:  Reading, 2012-2013.](../img/Bubble_Plots/2013/Georgia_2013_Reading_State_Bubble_Plot_(Prior_Achievement).png)

<p></p>
<p></p>


![School-level Bubble Plots for Georgia:  Mathematics, 2012-2013.](../img/Bubble_Plots/2013/Georgia_2013_Mathematics_State_Bubble_Plot_(Prior_Achievement).png)

<p></p>
<p></p>


![School-level Bubble Plots for Georgia:  Science, 2012-2013.](../img/Bubble_Plots/2013/Georgia_2013_Science_State_Bubble_Plot_(Prior_Achievement).png)

<p></p>
<p></p>


![School-level Bubble Plots for Georgia:  Social Studies, 2012-2013.](../img/Bubble_Plots/2013/Georgia_2013_Social Studies_State_Bubble_Plot_(Prior_Achievement).png)


The relationship between average prior student achievement and median SGP observed for Georgia is relatively strong compared to some other states for whom the Center has done SGP analyses. Table 12 shows correlations between prior achievement (measured as the mean prior standardized scale score as well as the percent at/above proficient at the school^[Percent Prior Proficient in this case is determined by the percent of student's that scored in the Proficient or Advanced range of all student's that received a score.  This measure does not reflect student's that did not receive a score but are included in the denominator of Percent Meeting Standard as displayed in the DOE Georgia Report Card.]). All results shown here are for schools with 15 or more students.

<p></p>




\begin{table}[H]
\caption*{\textbf{Table 12:} Correlations between Mean Prior Standardized Scale Score and Aggregate SGPs - (Combined Subjects)\label{}} 
\begin{center}
\begin{tabular}{lcllll}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{4}{c}{\bfseries SGP Aggregate Type}\tabularnewline
\cline{1-6}
\multicolumn{1}{c}{Year}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}&\multicolumn{1}{c}{Median SIMEX}&\multicolumn{1}{c}{Mean SIMEX}\tabularnewline
\hline
2011&&0.65&0.66&0.53&0.54\tabularnewline
2012&&0.60&0.61&0.45&0.47\tabularnewline
2013&&0.58&0.58&0.41&0.42\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}



<p></p>

Correlation tables describing the relationship between prior achievement (defined as mean prior standardized scale score) and aggregate growth percentiles are presented below in separate subsections for CRCT and EOCT subjects.  The school ratings discussed in the second subsection will be based on the grand median or mean SGP.  The first correlation table in the each subsection provides these overall SGP aggregates' relationships with mean prior standardized scale scores. The additional correlation tables are dis-aggregated by content area, and content area and grade to provide more detail.

<p></p>

#### CRCT 

\begin{table}[H]
\caption*{\textbf{Table 13:} CRCT Correlations between School-Level Mean Prior Standardized Scale Score and SGP Aggregations.\label{}} 
\begin{center}
\begin{tabular}{lcllll}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{4}{c}{\bfseries Aggregate SGP Type}\tabularnewline
\cline{1-6}
\multicolumn{1}{c}{Year}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}&\multicolumn{1}{c}{Median SIMEX}&\multicolumn{1}{c}{Mean SIMEX}\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.68&0.70&0.53&0.55\tabularnewline
2012&&0.58&0.60&0.34&0.37\tabularnewline
2013&&0.58&0.60&0.33&0.34\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.53&0.54&0.38&0.39\tabularnewline
2012&&0.48&0.50&0.3&0.32\tabularnewline
2013&&0.48&0.49&0.28&0.28\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.39&0.40&0.27&0.29\tabularnewline
2012&&0.45&0.46&0.34&0.35\tabularnewline
2013&&0.46&0.48&0.34&0.36\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.56&0.57&0.45&0.46\tabularnewline
2012&&0.46&0.47&0.33&0.34\tabularnewline
2013&&0.31&0.32&0.12&0.14\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.44&0.45&&\tabularnewline
2012&&0.37&0.39&&\tabularnewline
2013&&0.29&0.30&0.15&0.17\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}


<p></p>


\begin{table}[H]
\caption*{\textbf{Table 14:} 2013 CRCT Correlations between School-Level prior standardized scale score and Selected Aggregate SGPs by Grade.\label{}} 
\begin{center}
\begin{tabular}{lcllll}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{4}{c}{\bfseries Aggregate Group Type}\tabularnewline
\cline{1-6}
\multicolumn{1}{c}{Grade}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Median SIMEX}&\multicolumn{1}{c}{Mean SGP}&\multicolumn{1}{c}{Mean SIMEX}\tabularnewline
\hline
&&&&&\tabularnewline
4&& 0.52& 0.29&0.55& 0.28\tabularnewline
5&& 0.34& 0.10&0.38& 0.13\tabularnewline
6&& 0.39& 0.18&0.41& 0.18\tabularnewline
7&& 0.18&-0.07&0.19&-0.07\tabularnewline
8&& 0.60& 0.47&0.64& 0.52\tabularnewline
\hline
&&&&&\tabularnewline
4&& 0.38& 0.19&0.38& 0.18\tabularnewline
5&& 0.20& 0.05&0.21& 0.04\tabularnewline
6&& 0.49& 0.39&0.50& 0.38\tabularnewline
7&& 0.33& 0.14&0.35& 0.17\tabularnewline
8&& 0.21&-0.07&0.23&-0.06\tabularnewline
\hline
&&&&&\tabularnewline
4&& 0.31& 0.17&0.31& 0.17\tabularnewline
5&& 0.26& 0.18&0.28& 0.20\tabularnewline
6&& 0.27& 0.18&0.28& 0.19\tabularnewline
7&& 0.30& 0.18&0.32& 0.20\tabularnewline
8&& 0.43& 0.36&0.45& 0.38\tabularnewline
\hline
&&&&&\tabularnewline
4&& 0.14&-0.07&0.17&-0.03\tabularnewline
5&& 0.13& 0.00&0.14& 0.01\tabularnewline
6&& 0.21& 0.11&0.21& 0.12\tabularnewline
7&& 0.08&-0.06&0.10&-0.05\tabularnewline
8&& 0.05&-0.05&0.06&-0.04\tabularnewline
\hline
&&&&&\tabularnewline
4&& 0.15& 0.01&0.16& 0.03\tabularnewline
5&& 0.02&-0.07&0.03&-0.07\tabularnewline
6&& 0.14& 0.08&0.15& 0.09\tabularnewline
7&& 0.14& 0.04&0.16& 0.06\tabularnewline
8&&-0.02&-0.11&0.00&-0.10\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}


<p></p>

#### EOCT

\begin{table}[H]
\caption*{\textbf{Table 15:} 2011 to 2013 Correlations between Mean Prior Standardized Scale Score and Baseline SGPs.\label{}} 
\begin{center}
\begin{tabular}{lcllll}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{4}{c}{\bfseries Aggregate SGP Type}\tabularnewline
\cline{1-6}
\multicolumn{1}{c}{Year}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}&\multicolumn{1}{c}{Median SIMEX}&\multicolumn{1}{c}{Mean SIMEX}\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.59&0.61&0.49&0.51\tabularnewline
2012&&0.50&0.53&0.37&0.4\tabularnewline
2013&&0.36&0.37&0.2&0.2\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.52&0.56&0.4&0.43\tabularnewline
2012&&0.48&0.50&0.32&0.35\tabularnewline
2013&&0.22&0.21&0.01&-0.01\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.23&0.25&&\tabularnewline
2012&&0.14&0.17&&\tabularnewline
2013&&0.07&0.08&-0.02&-0.01\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.31&0.33&0.22&0.25\tabularnewline
2012&&0.06&0.07&-0.04&-0.03\tabularnewline
2013&&0.19&0.21&0.11&0.12\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.28&0.29&0.16&0.17\tabularnewline
2012&&0.16&0.17&0.03&0.05\tabularnewline
2013&&0.17&0.18&0.05&0.07\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.30&0.31&0.21&0.22\tabularnewline
2012&&0.23&0.24&0.13&0.14\tabularnewline
2013&&0.34&0.36&0.26&0.27\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}


<p></p>


\begin{table}[H]
\caption*{\textbf{Table 16:} 2011 to 2013 Correlations between Mean Prior Standardized Scale Score and Cohort SGPs.\label{}} 
\begin{center}
\begin{tabular}{lcllll}
\hline\hline
\multicolumn{1}{c}{\bfseries }&\multicolumn{1}{c}{\bfseries }&\multicolumn{4}{c}{\bfseries Aggregate SGP Type}\tabularnewline
\cline{1-6}
\multicolumn{1}{c}{Year}&\multicolumn{1}{c}{}&\multicolumn{1}{c}{Median SGP}&\multicolumn{1}{c}{Mean SGP}&\multicolumn{1}{c}{Median SIMEX}&\multicolumn{1}{c}{Mean SIMEX}\tabularnewline
\hline
&&&&&\tabularnewline
2013&&0.38&0.37&0.24&0.24\tabularnewline
\hline
&&&&&\tabularnewline
2012&&0.52&0.54&&\tabularnewline
2013&&0.43&0.44&0.29&0.3\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.38&0.39&&\tabularnewline
2012&&0.39&0.40&&\tabularnewline
2013&&0.29&0.31&0.19&0.21\tabularnewline
\hline
&&&&&\tabularnewline
2011&&0.53&0.54&&\tabularnewline
2012&&0.39&0.40&&\tabularnewline
2013&&0.41&0.41&0.3&0.3\tabularnewline
\hline
\end{tabular}\end{center}

\end{table}


<p></p>


# References
