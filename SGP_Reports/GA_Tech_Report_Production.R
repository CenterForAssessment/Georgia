
#######
# 2018
#######

require(SGP)
require(data.table)

# load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_SGP_LONG_Data_2018.Rdata")
vars.to.keep <- c("VALID_CASE", "SUBJECT_CODE", "GRADE", "SCHOOL_YEAR", "YEAR_WITHIN", "GTID", "SCHOOL_NUMBER", "SR_SYSTEM_ID",
									"SGP", "SGP_Final", "SGP_NORM_GROUP", "SGP_PROJECTION_GROUP_CURRENT",
									"DEVELOPING_SGP_TARGET_YEAR_1_CURRENT", "PROFICIENT_SGP_TARGET_YEAR_1_CURRENT", "DISTINGUISHED_SGP_TARGET_YEAR_1_CURRENT",
									"SCALE_SCORE", "SCALE_SCORE_PRIOR_1", "SCALE_SCORE_PRIOR_STANDARDIZED", "PERFORMANCE_LEVEL", "PERFORMANCE_LEVEL_PRIOR_1")

load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_SGP_Data_LONG_2018_FORMATTED-EOG.Rdata")
EOG_2018 <- Georgia_SGP_Data_LONG_2018_FORMATTED[, vars.to.keep, with=FALSE]
load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_SGP_Data_LONG_2018_FORMATTED-EOC.Rdata")
EOC_2018 <- Georgia_SGP_Data_LONG_2018_FORMATTED[, vars.to.keep, with=FALSE]

Georgia_SGP_Data_LONG_2018 <- rbindlist(list(EOG_2018, EOC_2018))
Georgia_SGP_Data_LONG_2018 <- Georgia_SGP_Data_LONG_2018[!SGP_PROJECTION_GROUP_CURRENT %in% c("G7_MATH_EOC", "MATH_COORD_ALG"),] # 1 YEAR targets for MATH_COORD_ALG, G7_MATH_EOC and MATH_ALG_I are same for grades 3-7
# Georgia_SGP_Data_LONG_2018 <- Georgia_SGP_Data_LONG_2018[!(SGP_PROJECTION_GROUP_CURRENT == "G7_MATH_EOC" & GRADE %in% c(3:6)),] # Keep only G7_MATH_EOC for Grade 7

Georgia_SGP_Data_LONG_2018[SGP_PROJECTION_GROUP_CURRENT == "COORDINATE_ALGEBRA", VALID_CASE := "INVALID_CASE"] # %in% c("G7_MATH_EOC", "COORDINATE_ALGEBRA") # INVALIDate temporarily for prepareSGP
table(Georgia_SGP_Data_LONG_2018[, VALID_CASE, SGP_PROJECTION_GROUP_CURRENT])

setnames(Georgia_SGP_Data_LONG_2018, c("SGP_Final", "SCALE_SCORE_PRIOR_1", "PERFORMANCE_LEVEL_PRIOR_1"), c("SGP_SIMEX_RANKED", "SCALE_SCORE_PRIOR", "ACHIEVEMENT_LEVEL_PRIOR"))

setwd("/Users/avi/Dropbox (SGP)/Github_Repos/Documentation/Georgia/SGP_Reports/2018")

Georgia_SGP <- prepareSGP(unique(Georgia_SGP_Data_LONG_2018), create.additional.variables = FALSE) #  Creates DUPLICATED Cases - needed for 8th Grade Math dual projections

Georgia_SGP@Data$SCHOOL_NAME <- as.character(NA); gc()
Georgia_SGP@Data$DISTRICT_NAME <- as.character(NA); gc()

Georgia_SGP@Data$Most_Recent_Prior <- as.character(NA)
Georgia_SGP@Data[, Most_Recent_Prior := sapply(strsplit(as.character(Georgia_SGP@Data$SGP_NORM_GROUP), "; "), function(x) rev(x)[2])]

load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_Summary_2018.Rdata")
Georgia_SGP@Summary <- Georgia_Summary_2018

save(Georgia_SGP, file="../Data/Georgia_SGP.Rdata")

###

setwd("/Users/avi/Dropbox (SGP)/Github_Repos/Documentation/Georgia/SGP_Reports/2018")
load("../Data/Georgia_SGP.Rdata")
require(Literasee)

renderMultiDocument(rmd_input = "Georgia_SGP_Report_2018.Rmd",
										report_format = c("HTML", "PDF"), #, "DOCX"
										# docx_self_contained=TRUE,
										# cleanup_aux_files = FALSE,
										pandoc_args = "--webtex")

renderMultiDocument(rmd_input = "Appendix_A_2018.Rmd",
										report_format = c("HTML", "PDF"), #, "EPUB", "DOCX"
										# cleanup_aux_files = FALSE,
										add_cover_title=TRUE)

load("../Data/GA_Agg_Data_Long_v3-Ranked_SIMEX_w_EOCT.Rdata")
renderMultiDocument(rmd_input = "Appendix_B.Rmd",
									report_format = c("HTML", "PDF"),
									pandoc_args = "--webtex")

renderMultiDocument(rmd_input = "Appendix_C_2018.Rmd",
										report_format = c("HTML", "PDF"), #, "EPUB", "DOCX"
										# cleanup_aux_files = FALSE,
										add_cover_title=TRUE)



#######
# 2017
#######

load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_SGP_LONG_Data_2017.Rdata")
load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_Summary_2017.Rdata")
setwd("/Users/avi/Dropbox (SGP)/Github_Repos/Documentation/Georgia/SGP_Reports/2017")

require(SGP)
require(data.table)
require(Literasee)

# name.index <- which(SGPstateData[["GA"]][["Variable_Name_Lookup"]][["names.provided"]] %in% names(Georgia_SGP_LONG_Data_2017))
# setnames(Georgia_SGP_LONG_Data_2017, name.index, SGPstateData[["GA"]][["Variable_Name_Lookup"]][["names.sgp"]][name.index])

Georgia_SGP <- prepareSGP(Georgia_SGP_LONG_Data_2017[, 
														c("VALID_CASE", "SUBJECT_CODE", "GRADE", "SCHOOL_YEAR", "YEAR_WITHIN", "GTID", "SGP", "SGP_SIMEX", "SGP_SIMEX_RANKED", 
															"SGP_NORM_GROUP","SCALE_SCORE", "SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED", "Most_Recent_Prior",
															"SCHOOL_NUMBER", "SR_SYSTEM_ID"), with=FALSE],
													state= "GA", create.additional.variables = FALSE)

Georgia_SGP@Data$SCHOOL_NAME <- as.character(NA); gc()
Georgia_SGP@Data$DISTRICT_NAME <- as.character(NA); gc()

Georgia_SGP@Data$Most_Recent_Prior <- as.character(NA)
Georgia_SGP@Data[, Most_Recent_Prior := sapply(strsplit(as.character(Georgia_SGP@Data$SGP_NORM_GROUP), "; "), function(x) rev(x)[2])]

Georgia_SGP@Summary <- Georgia_Summary_2017

save(Georgia_SGP, file="../Data/Georgia_SGP.Rdata")


renderMultiDocument(rmd_input = "Georgia_SGP_Report_2017.Rmd",
										report_format = c("HTML", "PDF"), #, "DOCX" 
										# cover_img="../img/cover.jpg",
										# add_cover_title=TRUE, 
										# cleanup_aux_files = FALSE,
										pandoc_args = "--webtex")

renderMultiDocument(rmd_input = "Appendix_A_2017.Rmd",
										# report_format = c("HTML"),
										report_format = c("HTML", "PDF"), #, "EPUB", "DOCX"
										cover_img="../img/cover.jpg",
										# cleanup_aux_files = FALSE,
										add_cover_title=TRUE)

renderMultiDocument(rmd_input = "Appendix_C_2017.Rmd",
										# report_format = c("HTML"),
										report_format = c("HTML", "PDF"), #, "EPUB", "DOCX"
										cover_img="../img/cover.jpg",
										# cleanup_aux_files = FALSE,
										add_cover_title=TRUE)


#######
# 2016
#######

load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_SGP_LONG_Data_2016.Rdata")
load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_Summary_2016.Rdata")
setwd("/Users/avi/Dropbox (SGP)/Github_Repos/Documentation/Georgia/SGP_Reports/2016")

require(SGP)
require(data.table)

setnames(Georgia_SGP_LONG_Data_2016, 
				 SGPstateData[["GA"]][["Variable_Name_Lookup"]][["names.provided"]],
				 SGPstateData[["GA"]][["Variable_Name_Lookup"]][["names.sgp"]])

Georgia_SGP <- prepareSGP(Georgia_SGP_LONG_Data_2016[, 
														c("VALID_CASE", "CONTENT_AREA", "GRADE", "YEAR", "YEAR_WITHIN", "ID", "SGP", "SGP_SIMEX", 
														  "SGP_NORM_GROUP","SCALE_SCORE", "SCALE_SCORE_PRIOR", "SCALE_SCORE_PRIOR_STANDARDIZED",
															"SCHOOL_NUMBER", "DISTRICT_NUMBER"), with=FALSE],
													state= "GA", create.additional.variables = FALSE)

Georgia_SGP@Data$SCHOOL_NAME <- as.character(NA); gc()
Georgia_SGP@Data$DISTRICT_NAME <- as.character(NA); gc()

Georgia_SGP@Data$Most_Recent_Prior <- as.character(NA)
Georgia_SGP@Data[, Most_Recent_Prior := sapply(strsplit(as.character(Georgia_SGP@Data$SGP_NORM_GROUP), "; "), function(x) rev(x)[2])]

Georgia_SGP@Summary <- Georgia_Summary_2016

library(SGPreports)
use.data.table()

renderMultiDocument(rmd_input = "Georgia_SGP_Report_2016.Rmd",
										report_format = c("HTML", "PDF"), #, "DOCX" 
										cover_img="../img/cover.jpg",
										add_cover_title=TRUE, 
										# cleanup_aux_files = FALSE,
										pandoc_args = "--webtex")

renderMultiDocument(rmd_input = "Appendix_A_2016.Rmd",
										# report_format = c("HTML"),
										report_format = c("HTML", "PDF"), #, "EPUB", "DOCX"
										cover_img="../img/cover.jpg",
										# cleanup_aux_files = FALSE,
										add_cover_title=TRUE)

renderMultiDocument(rmd_input = "Appendix_C_2016.Rmd",
										# report_format = c("HTML"),
										report_format = c("HTML", "PDF"), #, "EPUB", "DOCX"
										cover_img="../img/cover.jpg",
										add_cover_title=TRUE)


system("/Applications/RStudio.app/Contents/MacOS/pandoc/pandoc PDF/markdown/Appendix_A_2016-pdf.md --to latex --from markdown+autolink_bare_uris+ascii_identifiers --output  PDF/Appendix_A_2016.tex --filter /Applications/RStudio.app/Contents/MacOS/pandoc/pandoc-citeproc --bibliography /Library/Frameworks/R.framework/Versions/3.3/Resources/library/SGPreports/rmarkdown/templates/multi_document/resources/educ.bib   --csl /Library/Frameworks/R.framework/Versions/3.3/Resources/library/SGPreports/rmarkdown/templates/multi_document/resources/apa-5th-edition.csl --template  /Library/Frameworks/R.framework/Versions/3.3/Resources/library/SGPreports/rmarkdown/templates/multi_document/resources/damian.tex --number-sections --highlight-style tango --latex-engine pdflatex")

#######
# 2015
#######

#load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_SGP.Rdata")
load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_SGP.Rdata")
load("/Users/avi/Dropbox (SGP)/SGP/Georgia/Data/Georgia_Summary_2015.Rdata")
setwd("/Users/avi/Dropbox (SGP)/Github_Repos/Documentation/Georgia/SGP_Reports/2015")

Georgia_SGP@Summary <- Georgia_Summary

Georgia_SGP@Data$SCHOOL_NAME <- as.character(NA); gc()
Georgia_SGP@Data$DISTRICT_NAME <- as.character(NA); gc()

Georgia_SGP@Data$Most_Recent_Prior <- as.character(NA)
Georgia_SGP@Data[, Most_Recent_Prior := sapply(strsplit(as.character(Georgia_SGP@Data$SGP_NORM_GROUP), "; "), function(x) rev(x)[2])]

SGPstateData[["GA"]][["Achievement"]][["Levels"]] <-
	SGPstateData[["GA"]][["Assessment_Program_Information"]][["Assessment_Transition"]]$Achievement_Levels.2015 <- 	list(
		Labels=c("Beginning Learner", "Developing Learner", "Proficient Learner", "Distinguished Learner"),
		Proficient=c("Not Proficient", "Not Proficient", "Proficient", "Proficient"))

SGPstateData[["GA"]][["Assessment_Program_Information"]][["Assessment_Transition"]]$Achievement_Level_Labels.2015 <- list(
	"Beginning Learner"="Beginning Learner",
	"Developing Learner"="Developing Learner",
	"Proficient Learner"="Proficient Learner",
	"Distinguished Learner"="Distinguished Learner")


library(SGPreports)
use.data.table()


renderMultiDocument(rmd_input = "Georgia_SGP_Report_2015.Rmd",
										report_format = c("HTML", "PDF"), #, "DOCX" 
										cover_img="../img/cover.jpg",
										add_cover_title=TRUE, 
										# cleanup_aux_files = FALSE,
										pandoc_args = "--webtex")

renderMultiDocument(rmd_input = "Appendix_A_2015.Rmd",
										# report_format = c("HTML"),
										report_format = c("HTML", "PDF"), #, "EPUB", "DOCX"
										cover_img="../img/cover.jpg",
										add_cover_title=TRUE)

renderMultiDocument(rmd_input = "Appendix_C_2015.Rmd",
										# report_format = c("HTML"),
										report_format = c("HTML", "PDF"), #, "EPUB", "DOCX"
										cover_img="../img/cover.jpg",
										add_cover_title=TRUE)



Georgia_SGP_LONG_Data_2015$Most_Recent_Prior <- as.character(NA)
Georgia_SGP_LONG_Data_2015[, Most_Recent_Prior := sapply(strsplit(as.character(Georgia_SGP_LONG_Data_2015$SGP_NORM_GROUP), "; "), function(x) rev(x)[2])]
# z <- Georgia_SGP_LONG_Data_2015[GRADE=="EOCT" & !is.na(Most_Recent_Prior)][, as.list(summary(as.numeric(SCALE_SCORE_PRIOR)), N=.N), keyby=list(SUBJECT_CODE, Most_Recent_Prior, ACHIEVEMENT_LEVEL_PRIOR)]
z <- Georgia_SGP_LONG_Data_2015[!is.na(ACHIEVEMENT_LEVEL_PRIOR) & !is.na(Most_Recent_Prior)][, as.list(summary(as.numeric(SCALE_SCORE_PRIOR)), N=.N), keyby=list(SUBJECT_CODE, GRADE, ACHIEVEMENT_LEVEL_PRIOR)]
z[SUBJECT_CODE=="ELA"]


ACHIEVEMENT_LEVEL_PRIOR

Georgia_SGP_Data_LONG_2015_FORMATTED[GRADE_PRIOR_1=="EOCT"][, as.list(summary(as.numeric(SCALE_SCORE_PRIOR_1))), by=list(SUBJECT_CODE_PRIOR_1, Most_Recent_Prior, PERFORMANCE_LEVEL_PRIOR_1)]


#######
# 2014
#######

#load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_SGP.Rdata")
load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_Summary_2014.Rdata")
setwd("/media/Data/Dropbox/Github_Repos/Documentation/Georgia/SGP_Reports/2014")

renderMultiDocument(rmd_input = "Georgia_SGP_Report_2014.Rmd",
										report_format = c("HTML", "EPUB", "PDF"), #, "DOCX"
										cover_img="../img/cover.jpg",
										add_cover_title=TRUE, 
										cleanup_aux_files = FALSE,
										pandoc_args = "--webtex")

renderMultiDocument(rmd_input = "Appendix_A_2014.Rmd",
										# report_format = c("HTML"),
										report_format = c("HTML", "EPUB", "PDF"), #, "PDF", "DOCX"
										cover_img="../img/cover.jpg",
										add_cover_title=TRUE,
										cleanup_aux_files = FALSE)
##  The PDF ain't perfect.  Need to add a \pagebreak for first section and then 
##  add ' [width=0.XX\textwidth] ' to the first img in each \section (0.7) &/or \subsection (0.75)
system('/usr/lib/rstudio-server/bin/pandoc/pandoc PDF/markdown/Appendix_A_2014-pdf.md --to latex --from markdown+autolink_bare_uris+ascii_identifiers --output  Appendix_A_2014.tex --filter /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc --bibliography /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/educ.bib   --csl /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/apa-5th-edition.csl --template  /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/damian.tex --number-sections --highlight-style tango --latex-engine pdflatex')

renderMultiDocument(rmd_input = "Appendix_B.Rmd",
										report_format = c("HTML", "EPUB"), # , "PDF", "DOCX"
										html_template = "simple",
										cover_img="../img/cover.jpg",
										add_cover_title=TRUE, 
										cleanup_aux_files = FALSE,
										pandoc_args = "--webtex")


#######
# 2013
#######

load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_Summary_2013.Rdata")
load("/media/Data/Dropbox/SGP/Georgia/Data/Georgia_SGP.Rdata")
setwd("/media/Data/Dropbox/Github_Repos/Documentation/Georgia/SGP_Reports/2013")

library(SGPreports)
use.data.table()

renderMultiDocument(rmd_input = "Appendix_A_2013.Rmd",
                    # report_format = c("HTML"),
                    report_format = c("HTML", "EPUB", "PDF"), #, "DOCX"
                    cover_img="../img/cover.jpg",
                    add_cover_title=TRUE,
                    cleanup_aux_files = FALSE)
system('/usr/lib/rstudio-server/bin/pandoc/pandoc PDF/markdown/Appendix_A_2013-pdf.md --to latex --from markdown+autolink_bare_uris+ascii_identifiers --output  Appendix_A_2013.tex --filter /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc --bibliography /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/educ.bib   --csl /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/apa-5th-edition.csl --template  /home/avi/R/x86_64-pc-linux-gnu-library/3.2/SGPreports/rmarkdown/templates/multi_document/resources/damian.tex --number-sections --highlight-style tango --latex-engine pdflatex')

renderMultiDocument(rmd_input = "Georgia_SGP_Report_2013.Rmd",
                    report_format = c("HTML", "EPUB", "PDF"), #, "DOCX"
                    cover_img="../img/cover.jpg",
                    add_cover_title=TRUE, 
                    cleanup_aux_files = FALSE,
                    pandoc_args = "--webtex")


renderMultiDocument(rmd_input = "Appendix_B.Rmd",
                    report_format = c("HTML", "EPUB"), # , "PDF", "DOCX"
                    html_template = "simple",
                    cover_img="../img/cover.jpg",
                    add_cover_title=TRUE, 
                    cleanup_aux_files = FALSE,
                    pandoc_args = "--webtex")
